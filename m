Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270432AbRHHJc2>; Wed, 8 Aug 2001 05:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270433AbRHHJcT>; Wed, 8 Aug 2001 05:32:19 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:56271 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270432AbRHHJcP>; Wed, 8 Aug 2001 05:32:15 -0400
From: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
Message-Id: <200108080930.LAA03334@sunrise.pg.gda.pl>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: rhw@MemAlpha.CX (Riley Williams)
Date: Wed, 8 Aug 2001 11:30:34 +0200 (MET DST)
Cc: mra@pobox.com (Mark Atwood), soruk@eridani.co.uk (Michael McConnell),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0108072359440.30936-100000@infradead.org> from "Riley Williams" at Aug 08, 2001 12:35:54 AM
Reply-To: ankry@green.mif.pg.gda.pl
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Riley Williams wrote:"

>  1. InitScripts points at Kernel ...
>  2. Kernel replies ...
>  3. InitScripts then tells Kernel ...

I believe this discussion leads to constructive conlusions.
Even if that are 2.5+ conclusions.

> So far, I've only seen the above scenario occur, and I have to admit
> to having very little sympathy with it. However, I'm always open to
> persuasion that the above is not the situation that is occurring.

[...]

> Let's deal with the various scenarios that I can see:
> 
>  1. Just one interface, either static or hotplug.
Nothing interesting.

>  2. Multiple identical static interfaces.
Nothing interesting.

>  3. Multiple different static interfaces.
I see some subcases here:

3a. All interfaces are initialized

3b. Not all interfaces are initialized 
    [ "interface physicaly exist" != "interface is connected/configured"

3c. Interfaces supported by single driver are identical

3d. Interfaces supported by single driver are significantly different

I thing one met some common problems with the hotplug case here in the above
subcases.

>     At the moment, you are required to group these by the driver that
>     controls them, simply because each driver will automatically map
>     all interfaces that it supports when it is loaded. Likewise, you
>     are required to initialise interfaces in ascending order of their
>     name in the modules.conf file.
> 
>  4. Multiple hotplug interfaces.

I thing this case and 3. case should be solved both: for the modular drivers
case and for the built-in drivers case.

>     I have to admit to never having dealt with hotplug interfaces, but
>     I understand some aspects of the interface are still being ironed
>     out by the kernel developers. As a result, I would not be at all
>     surprised to hear that problems still exist.
> 
>  5. Multiple static and hotplug interfaces.
> 
>     At the moment, you are required to group these by whether the
>     interface is static or hotplug, configuring all static interfaces
>     before any of the hotplug ones. This therefore reduces to being
>     either case (2) or (3) followed by case (4), and should be dealt
>     with accordingly.

Consider complex situation: you have two drivers, each of them supporting
static and built in and hotplug interfaces.
Yes, this is a theoretical problem, but solving it would probably also solve
all (or almost all) of the above cases.

I like the idea of assigning names by MAC addresses. It IMO should solve
all problems as:
- if more then one interface has the same MAC address, they are probably
  identical, and you can switch them in hardware (cabling). Or am I
  wrong here?
- If you want to change the MAC address you do it *AFTER* the interface
  is initialized (driver is loaded, interface name is assigned). Or am 
  I also wrong here?

This seem to be a good idea if there's also support for "ether=" like
global kernel parameter working for build-in drivers.

> As a result, the ONLY time I can see any problem occurring is when
> there are multiple hotplug interfaces to deal with (case (4) above),
> and this is acknowledged to be a case where some of the issues have
> not yet been fully ironed out.
> 
> Can you agree with this analysis, or have I overlooked something?

Andrzej
-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk

