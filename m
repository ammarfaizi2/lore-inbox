Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261450AbSKMOHF>; Wed, 13 Nov 2002 09:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbSKMOHF>; Wed, 13 Nov 2002 09:07:05 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3088 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261450AbSKMOHE>; Wed, 13 Nov 2002 09:07:04 -0500
Date: Wed, 13 Nov 2002 15:13:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alan@redhat.com
Subject: Re: Kill obsolete and  unused suspend/resume code from IDE
Message-ID: <20021113141353.GI10168@atrey.karlin.mff.cuni.cz>
References: <20021112175154.GA6881@elf.ucw.cz> <1037126927.9383.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1037126927.9383.5.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> With the shutdown/cleanup split so the locking works out you might
> actually be able to do what you want (although I dont think you can get
> all the locking logic right yet because some of it is still hosed in the
> ide core). Also take a glance at the SC1200 driver with regards to the
> sysfs based power management handling.

SC1200 power managment looks sane. Questions:

Don't you need to wait for current operation to complete before
calling sc1200_spindown_drive?

I noticed you are not playing any tricks with inserting requests to
queues... This is basically what I was doing, so I like it.

Is sc1200_spindown_drive really sc1200 specific? Is there some problem
with doing suspend at ide.c layer, and resume (which is controller
specific) in each driver?

...Ugh. You are doing it as pci device, not as generic device. I
believe you should use sysfs directly.

Anyway I can live with this, and its way better than whats in there
just now.
								Pavel

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
