Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266354AbTAJVhM>; Fri, 10 Jan 2003 16:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbTAJVhM>; Fri, 10 Jan 2003 16:37:12 -0500
Received: from [195.208.223.245] ([195.208.223.245]:20096 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266354AbTAJVg7>; Fri, 10 Jan 2003 16:36:59 -0500
Date: Sat, 11 Jan 2003 00:42:39 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Grant Grundler <grundler@cup.hp.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030111004239.A757@localhost.park.msu.ru>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com> <20030110010906.GC18141@cup.hp.com> <m1y95tzbdq.fsf@frodo.biederman.org> <20030110190030.GA23108@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030110190030.GA23108@cup.hp.com>; from grundler@cup.hp.com on Fri, Jan 10, 2003 at 11:00:30AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 11:00:30AM -0800, Grant Grundler wrote:
> Or dynamically assigns windows to PCI Bus controllers as PCI devices
> are brought on-line.

Eh? In general case, to make room for newly added device, you have
to shutdown the whole PCI bus starting from level 0, reassign _all_
BARs and bridge windows and then restart...
The "hotplug resource reservation" is the only viable approach, it has
been discussed numerous times.

> For PCI Hotplug, the role of managing MMIO/IRQ
> resources has moved to the OS since these services are needed
> after the OS has taken control of the box.

100% agree. :-)

> One 256MB BAR isn't so bad. It's when the customer wants to have a central
> server that has 2 or more such cards...64-bit BARs on 64-bit architecture
> make life alot easier.

I believe 1GB is a theoretical maximum for a 32-bit BAR. Everything above
that has to be 64-bit.

Ivan.
