Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTAJSzA>; Fri, 10 Jan 2003 13:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266257AbTAJSyC>; Fri, 10 Jan 2003 13:54:02 -0500
Received: from palrel10.hp.com ([156.153.255.245]:57269 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S266353AbTAJSxN>;
	Fri, 10 Jan 2003 13:53:13 -0500
Date: Fri, 10 Jan 2003 11:00:30 -0800
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Paul Mackerras <paulus@samba.org>,
       davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110190030.GA23108@cup.hp.com>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com> <20030110010906.GC18141@cup.hp.com> <m1y95tzbdq.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y95tzbdq.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
From: grundler@cup.hp.com (Grant Grundler)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 12:56:17AM -0700, Eric W. Biederman wrote:
> For what it is worth these cards exist though.

yes.

> Quadris cards have a 256MB bar, and dolphin cards default to having a 512MB bar.
> Both are high performance I/O adapters.

I'm not familiar with "dolphin" cards.
I'm aware of "Quadrics" but I've not heard anyone try those with parisc-linux.
Quadrics cards do work on ia64 (for some definition of "work").

> If someone leaves a big enough hole for hotplug cards I guess it can work...

Or dynamically assigns windows to PCI Bus controllers as PCI devices
are brought on-line. For PCI Hotplug, the role of managing MMIO/IRQ
resources has moved to the OS since these services are needed
after the OS has taken control of the box.

> How you define a potential boot device, and what it saves you to not assign
> it resources I don't know.  

You have it backwards. firmware only assigns resources to boot devices
and "console" devices. ie firmware does minimal configuration.
Why? An OS with hotplug support can do it anyway.

A "potential boot device" has firmware support which the primary boot
loader can use to load the OS or a secondary boot loader. But firmware
only needs to configure a single boot/console device that is
actually being used.


> I am still recovering from putting a 256MB bar and 4GB of ram in a 4GB hole,
> with minimal loss on x86, so my imagination of what can be sanely done
> on a 64bit arch may be a little stunted..

both ia64 and later parisc boxes from HP reserve GB's of LMMIO address space
for IO uses (LMMIO == MMIO < 4GB). AFAIK, physical memory behind that address
space gets remapped to higher "physical" addresses by the memory controller.
But making 256MB still fit in that space can still be a challenge.
One 256MB BAR isn't so bad. It's when the customer wants to have a central
server that has 2 or more such cards...64-bit BARs on 64-bit architecture
make life alot easier.

grant
