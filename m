Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262391AbSKCUFw>; Sun, 3 Nov 2002 15:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSKCUFw>; Sun, 3 Nov 2002 15:05:52 -0500
Received: from [195.39.17.254] ([195.39.17.254]:16388 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262391AbSKCUFp>;
	Sun, 3 Nov 2002 15:05:45 -0500
Date: Sun, 3 Nov 2002 21:11:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
Message-ID: <20021103201105.GD27271@elf.ucw.cz>
References: <20021102184735.GA179@elf.ucw.cz> <200211022006.gA2K6XW08545@devserv.devel.redhat.com> <20021102202504.GD18576@atrey.karlin.mff.cuni.cz> <1036274673.16803.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036274673.16803.34.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Some disks are going to be settint their own power methods too.
> > 
> > Fine with me as long as they call idedisk_suspend() first ;-).
> 
> They may or may not do so depending upon other considerations. The new
> driver layer is supposed to handle suspend/power ordering. If it doesn't
> then it needs fixing. You can't go around hacking weird suspend shit
> into every single block driver for a final system, sure for a prototype
> but not the real thing. No way

Suspend *needs* to touch all drivers.

I do stopping at high levels already (all tasks are put into
refrigerator), but that can still me that DMA on particular driver is
in progress. Only driver itself knows if it is doing any DMA and how
to stop it. I do not see how to do it on upper layers.

[Take for example USB. It is not block device, still it does DMA which
means it has to be stopped.]
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
