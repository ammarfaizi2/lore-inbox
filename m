Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263785AbSKCWVd>; Sun, 3 Nov 2002 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKCWVd>; Sun, 3 Nov 2002 17:21:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:17668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S263785AbSKCWVX>; Sun, 3 Nov 2002 17:21:23 -0500
Date: Sun, 3 Nov 2002 23:27:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021103222755.GL28704@atrey.karlin.mff.cuni.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021103145735.14872@smtp.wanadoo.fr> <1036340733.29642.41.camel@irongate.swansea.linux.org.uk> <20021103201251.GE27271@elf.ucw.cz> <1036359207.30629.31.camel@irongate.swansea.linux.org.uk> <20021103220904.GE28704@atrey.karlin.mff.cuni.cz> <1036363284.30679.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036363284.30679.33.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You are probably right that for ide disk quiescing a queue is enough,
> > but nothing prevents block device to do some DMA just for fun. Also I
> > want to spindown on suspend (andre wanted that, to flush caches), so I
> > guess that the patch is quite good as-is....
> 
> That will get done by the power down part of the process as its needed
> in both cases

At least in suspend-to-ram (S3), power down part is not even
called. [Its suspend, we are not powering off, after all.]
On S3 resume you should wait for disks to spin up, so you need resume
handler.

I used same stuff for S3 and S4, which means I do need to spin them
down even for S4. I believe same handlers for S3 and S4 suspend/resume
is right thing to do...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
