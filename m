Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263571AbSKCX3D>; Sun, 3 Nov 2002 18:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263837AbSKCX3D>; Sun, 3 Nov 2002 18:29:03 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:29839 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263571AbSKCX3C>; Sun, 3 Nov 2002 18:29:02 -0500
Subject: Re: swsusp: don't eat ide disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021103222755.GL28704@atrey.karlin.mff.cuni.cz>
References: <200211022006.gA2K6XW08545@devserv.devel.redhat.com>
	<20021103145735.14872@smtp.wanadoo.fr>
	<1036340733.29642.41.camel@irongate.swansea.linux.org.uk>
	<20021103201251.GE27271@elf.ucw.cz>
	<1036359207.30629.31.camel@irongate.swansea.linux.org.uk>
	<20021103220904.GE28704@atrey.karlin.mff.cuni.cz>
	<1036363284.30679.33.camel@irongate.swansea.linux.org.uk> 
	<20021103222755.GL28704@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 23:56:53 +0000
Message-Id: <1036367813.30679.40.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 22:27, Pavel Machek wrote:
> Hi!
> 
> > > You are probably right that for ide disk quiescing a queue is enough,
> > > but nothing prevents block device to do some DMA just for fun. Also I
> > > want to spindown on suspend (andre wanted that, to flush caches), so I
> > > guess that the patch is quite good as-is....
> > 
> > That will get done by the power down part of the process as its needed
> > in both cases
> 
> At least in suspend-to-ram (S3), power down part is not even
> called. [Its suspend, we are not powering off, after all.]
> On S3 resume you should wait for disks to spin up, so you need resume
> handler.
> 
> I used same stuff for S3 and S4, which means I do need to spin them
> down even for S4. I believe same handlers for S3 and S4 suspend/resume
> is right thing to do...

S4 the bios has spun the disks back up, S3 we may need to let the disks
perform the IDE power on and diskware load. Ben has some possible code
for that

