Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTFFG2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbTFFG2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:28:54 -0400
Received: from palrel12.hp.com ([156.153.255.237]:55515 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S265342AbTFFG2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:28:53 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16096.14281.621282.67906@napali.hpl.hp.com>
Date: Thu, 5 Jun 2003 23:42:17 -0700
To: manfred@colorfullife.com
Cc: axboe@suse.de, davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
In-Reply-To: <1054797653.18294.1.camel@rth.ninka.net>
References: <16094.58952.941468.221985@napali.hpl.hp.com>
	<1054797653.18294.1.camel@rth.ninka.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 05 Jun 2003 00:20:53 -0700, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Wed, 2003-06-04 at 23:42, David Mosberger wrote:
  >> On platforms with I/O MMU hardware, memory above 4GB, and IDE hard disks,
  >> this check:

  >> BUG_ON(dma_addr < BLK_BOUNCE_ISA);

  DaveM> Doesn't panic on sparc64, let this be your guiding light :-)

I checked with Dave in private email and, like I suspected, this is a
(potential) problem on sparc64 as well.  Let me be try to be even more
clear: on many 64 bit platforms, BLK_BOUNCE_ISA will be bigger than
4GB, so the BUG_ON() will trigger for IDE controllers that can DMA
only to, say, 4GB (and it's probably not even an IDE-only problem, I
think we don't see it on SCSI because our machines have SCSI
controllers that can DMA >4GB).

Manfred, I'm readdressed this mail to you because according to google,
you're the original author of the patch
(http://www.cs.helsinki.fi/linux/linux-kernel/2002-02/0032.html).

Like I stated earlier, I think this code simply makes no sense on a
platform with I/O MMU.  Hence my suggestion to deal with this via
dma_supported().

	--david
