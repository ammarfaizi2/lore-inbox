Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266139AbUHFUHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUHFUHW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUHFUHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:07:16 -0400
Received: from gprs214-146.eurotel.cz ([160.218.214.146]:47488 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S266139AbUHFUFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:05:01 -0400
Date: Fri, 6 Aug 2004 22:04:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Solving suspend-level confusion
Message-ID: <20040806200442.GC30518@elf.ucw.cz>
References: <20040730164413.GB4672@elf.ucw.cz> <200407302102.12554.david-b@pacbell.net> <1091252962.7387.14.camel@gaston> <200407310723.12137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407310723.12137.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Disks in general are an example (IDE beeing the one that is currently
> > implemented, but we'll probably have to do the same for SATA and SCSI
> > at one point), you want to spin them off (with proper cache flush
> > etc...) when suspending to RAM, while you don't when suspending to
> > disk, as you really don't want them to be spun up again right away to
> > write the suspend image.
> 
> So suspend-to-RAM more or less matches PCI D3hot, and
> suspend-to-DISK matches PCI D3cold.  If those power states
> were passed to the device suspend(), the disk driver could act
> appropriately.  In my observation, D3cold was never passed
> down, it was always D3hot.
> 
> These look to me like "wrong device-level suspend state" cases.

Actually, suspend-to-disk has to suspend all devices *twices*. Once it
wants them in "D0 but DMA/interrupts stopped", and once in "D3cold but
I do not really care power is going to be cut anyway". I do not think
this can be expressed with PCI states.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
