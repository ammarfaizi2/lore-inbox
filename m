Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTFGHCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 03:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTFGHCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 03:02:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25475 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262601AbTFGHCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 03:02:49 -0400
Date: Sat, 07 Jun 2003 00:11:40 -0700 (PDT)
Message-Id: <20030607.001140.08328499.davem@redhat.com>
To: davidm@hpl.hp.com, davidm@napali.hpl.hp.com
Cc: manfred@colorfullife.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: problem with blk_queue_bounce_limit()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16097.36514.763047.738847@napali.hpl.hp.com>
References: <200306062013.h56KDcLe026713@napali.hpl.hp.com>
	<20030606.234401.104035537.davem@redhat.com>
	<16097.36514.763047.738847@napali.hpl.hp.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@napali.hpl.hp.com>
   Date: Sat, 7 Jun 2003 00:05:06 -0700

   But you're creating a new mapping for the old buffer.  What if you had
   a DMA API implementation which consolidates multiple mapping attempts
   of the same buffer into a single mapping entry (along with a reference
   count)?  That would break the workaround.
   
I hope nobody is doing this, it would probably break other things
we haven't considered yet.

You can't support all the BIO_MERGE_BOUNDARY stuff properly in
such a scheme. And you _WANT_ to support that when you have an
IOMMU, it shrinks the DMA descriptor addr/len entries a chip
has to DMA for each block I/O considerably.

   Isn't the proper fix to (a) get a new buffer, (b) create a mapping for
   the new buffer, (c) destroy the mapping for the old buffer.  That
   should guarantee a different bus address, no matter what the
   DMA-mapping implementation.
   
I suppose this would work, fell free to code this up for the
tg3 driver for me because I certainly lack the time to do this.
