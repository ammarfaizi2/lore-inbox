Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263956AbSKCXbo>; Sun, 3 Nov 2002 18:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSKCXbo>; Sun, 3 Nov 2002 18:31:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24330 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263956AbSKCXbn>; Sun, 3 Nov 2002 18:31:43 -0500
Date: Sun, 3 Nov 2002 15:38:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: don't eat ide disks
In-Reply-To: <20021103225656.GR28704@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0211031535540.23444-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Nov 2002, Pavel Machek wrote:
> 
> Is that really the right way to prepare disks for suspend? 

It probably is, although I suspect it should just be a default action, and 
drivers can choose to implement their own "suspend()" functionality if 
they want to.

> I sleep all devices by telling driverfs to sleep them. Should I tell
> all block devices, then tell driverfs? Seems hacky to me. Or should
> idedisk_suspend generate request for itself, then pass it through
> queues?

I would strongly encourage letting the device hierarchy suspend() (now
called sysfs, not driverfs) call be the _only_ call the disk controller
ever gets. Having two different suspend mechanisms is just too confusing
for words, and there's no point.

			Linus

