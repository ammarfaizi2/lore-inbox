Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVHWMuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVHWMuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVHWMuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:50:22 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30881 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751277AbVHWMuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:50:21 -0400
Date: Tue, 23 Aug 2005 14:50:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050823125017.GB3664@elf.ucw.cz>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124753566.5093.8.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > + * If you have unsupported (*) devices using DMA, you may have some
> > + * problems. If your disk driver does not support suspend... (IDE does),
> > + * it may cause some problems, too. If you change kernel command line 
> > + * between suspend and resume, it may do something wrong. If you change 
> > + * your hardware while system is suspended... well, it was not good idea;
> > + * but it wil probably only crash.
> 
> The most common driver issues I see involve:
> - USB being built in or as modules that are still loaded while
> suspending (getting better, but not there yet)
> - DRI being used in X where the drivers don't properly support
> suspend/resume (NVidia esp)
> - Firewire
> - CPU Freq  (improving too)
> 
> It might be good to mention these areas too.

Well, right; but those 'only' cause system to crash during suspend. I
was talking about really dangerous stuff.

Both usb and cpufreq seems to work okay here.

I've added FAQ entry at the end:

Q: What information is usefull for debugging suspend-to-disk problems?

A: Well, last messages on the screen are always useful. If something
is broken, it is usually some kernel driver, therefore trying with as
little as possible modules loaded helps a lot. I also prefer people to
suspend from console, preferably without X running. Booting with
init=/bin/bash, then swapon and starting suspend sequence manually
usually does the trick. Then it is good idea to try with latest
vanilla kernel.

"Known problematic" modules are; be sure to unload them before
suspend:
- DRI being used in X where the drivers don't properly support
suspend/resume (NVidia esp)
- Firewire
- SCSI


> Perhaps the 'changing your hardware' could mention that replacing faulty
> hardware may be safe.

I do not want to encourage people to do that. Yep, its probably safe,
no, I do not want them to know.

									Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
