Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSKCWCe>; Sun, 3 Nov 2002 17:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263571AbSKCWCe>; Sun, 3 Nov 2002 17:02:34 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:47378 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263544AbSKCWCd>; Sun, 3 Nov 2002 17:02:33 -0500
Date: Sun, 3 Nov 2002 23:09:04 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021103220904.GE28704@atrey.karlin.mff.cuni.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> <20021103201251.GE27271@elf.ucw.cz> <1036359207.30629.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036359207.30629.31.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 		Throw out the pages we can evict
> > 
> > ...DMA from disk may be still running here...
> 
> Only if a request is still active and therfore the queue is not
> quiesced
> 


How do I quiesce a queue? Is it ll_rw_blk stuff?

> 
> > ...and at resume you find out that your memory is not consistent
> > because DMA was still running when you were doing copy.
> 
> I can see how that can be a problem for some other things but not block
> devices.

You are probably right that for ide disk quiescing a queue is enough,
but nothing prevents block device to do some DMA just for fun. Also I
want to spindown on suspend (andre wanted that, to flush caches), so I
guess that the patch is quite good as-is....

						Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
