Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269558AbRHHVbc>; Wed, 8 Aug 2001 17:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269546AbRHHVbW>; Wed, 8 Aug 2001 17:31:22 -0400
Received: from imladris.infradead.org ([194.205.184.45]:51977 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269558AbRHHVbM>;
	Wed, 8 Aug 2001 17:31:12 -0400
Date: Wed, 8 Aug 2001 22:31:02 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Andrzej Krzysztofowicz <ankry@pg.gda.pl>
cc: Mark Atwood <mra@pobox.com>, Michael McConnell <soruk@eridani.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <200108080930.LAA03334@sunrise.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0108082211410.12565-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Andrzej.

 >>  1. InitScripts points at Kernel ...
 >>  2. Kernel replies ...
 >>  3. InitScripts then tells Kernel ...

 > I believe this discussion leads to constructive conlusions. Even
 > if that are 2.5+ conclusions.

So do I.

 >> So far, I've only seen the above scenario occur, and I have to
 >> admit to having very little sympathy with it. However, I'm
 >> always open to persuasion that the above is not the situation
 >> that is occurring.

 >> Let's deal with the various scenarios that I can see:
 >>
 >>  1. Just one interface, either static or hotplug.

 > Nothing interesting.

 >>  2. Multiple identical static interfaces.

 > Nothing interesting.

Agreed.

 >>  3. Multiple different static interfaces.

 > I see some subcases here:

 > 3a. All interfaces are initialized

This is the assumption used by all of the standard distributions (with
the possible exception of Slackware, but I'd be surprised if they
differ here).

 > 3b. Not all interfaces are initialized
 >     "interface physicaly exist" != "interface is connected/configured"

This is definitely a problem case, as it leads to all sorts of race
scenarios. Even Microsoft don't support this case with their operating
systems.

 > 3c. Interfaces supported by single driver are identical
 >
 > 3d. Interfaces supported by single driver are significantly different

With static interfaces, the difference between these two subcases is
in theory irrelevant.

 > I thing one met some common problems with the hotplug case here
 > in the above subcases.

Can I point out that this section specifically refers to STATIC (ie,
non-hotplug) interfaces. This comment is therefore irrelevant here.

 >>     At the moment, you are required to group these by the driver that
 >>     controls them, simply because each driver will automatically map
 >>     all interfaces that it supports when it is loaded. Likewise, you
 >>     are required to initialise interfaces in ascending order of their
 >>     name in the modules.conf file.

 >>  4. Multiple hotplug interfaces.

 > I thing this case and 3. case should be solved both: for the
 > modular drivers case and for the built-in drivers case.

Case (3) is already solved. Case (4) is the only one that needs
solving, and that's still under development with various other
problems to be solved as well.

 >>     I have to admit to never having dealt with hotplug interfaces, but
 >>     I understand some aspects of the interface are still being ironed
 >>     out by the kernel developers. As a result, I would not be at all
 >>     surprised to hear that problems still exist.
 >>
 >>  5. Multiple static and hotplug interfaces.
 >>
 >>     At the moment, you are required to group these by whether the
 >>     interface is static or hotplug, configuring all static interfaces
 >>     before any of the hotplug ones. This therefore reduces to being
 >>     either case (2) or (3) followed by case (4), and should be dealt
 >>     with accordingly.

 > Consider complex situation: you have two drivers, each of them
 > supporting static and built in and hotplug interfaces. Yes, this
 > is a theoretical problem, but solving it would probably also
 > solve all (or almost all) of the above cases.

All drivers already support both static (which is built-in) and
hotplug interfaces, so that gains us nothing. All that changes in the
hotplug case is that the hotplug bus controller signals the kernel to
say either...

 1. "The device that was in my slot N has been unplugged", in which
    case the kernel unmaps the driver for that device, or

 2. "A new device has been plugged into my slot N", in which case the
    kernel works out what sort of device it is, then waits for some
    sort of configuration information.

As a result, most of the problems I've seen mentioned just can't
occur.

 > I like the idea of assigning names by MAC addresses. It IMO
 > should solve all problems as:

 > - if more then one interface has the same MAC address, they are
 >   probably identical, and you can switch them in hardware
 >   (cabling). Or am I wrong here?

According to Alan Cox, it's only the ix86 architecture where the MAC
is per interface; on all other architectures, it's one MAC per system
that is shared by all the ethernet interfaces. As a result, there is
no guarantee that they are identical, or even similar.

 > - If you want to change the MAC address you do it *AFTER* the
 >   interface is initialized (driver is loaded, interface name is
 >   assigned). Or am I also wrong here?

I have no idea, and would not assume either way.

 > This seem to be a good idea if there's also support for "ether="
 > like global kernel parameter working for build-in drivers.

I have to agree that this may be a good idea for the ix86
architecture, but not for other architectures because of that
limitation. However, this may be something that has to be solved on a
per-architecture basis.

 >> As a result, the ONLY time I can see any problem occurring is when
 >> there are multiple hotplug interfaces to deal with (case (4) above),
 >> and this is acknowledged to be a case where some of the issues have
 >> not yet been fully ironed out.
 >>
 >> Can you agree with this analysis, or have I overlooked something?

Best wishes from Riley.

