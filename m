Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbTFEG2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 02:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTFEG2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 02:28:48 -0400
Received: from palrel11.hp.com ([156.153.255.246]:9965 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264430AbTFEG2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 02:28:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16094.58952.941468.221985@napali.hpl.hp.com>
Date: Wed, 4 Jun 2003 23:42:16 -0700
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: problem with blk_queue_bounce_limit()
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms with I/O MMU hardware, memory above 4GB, and IDE hard disks,
this check:

		BUG_ON(dma_addr < BLK_BOUNCE_ISA);

causes an instant panic.  The reason is quite obvious: since there is
an I/O MMU, BLK_BOUNCE_ISA is effectively unlimited, and most IDE
controllers can of course DMA only to <4GB.

So, the check is wrong.  I think the proper way to fix this is to pass
a "struct dev" into the routine and then to use dma_supported() to
check whether bounce buffers will be needed.  Do you agree?  If so,
can you fix it?

Thanks,

	--david
