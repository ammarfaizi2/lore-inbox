Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267910AbTAHUCP>; Wed, 8 Jan 2003 15:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTAHUCL>; Wed, 8 Jan 2003 15:02:11 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:22190 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S267906AbTAHUCI>; Wed, 8 Jan 2003 15:02:08 -0500
Date: Wed, 8 Jan 2003 15:10:44 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: scottm@rancor.yyz.somanetworks.com
To: Rusty Lynch <rusty@linux.co.intel.com>
cc: greg@kroah.com, <harold.yang@intel.com>, <linux-kernel@vger.kernel.org>,
       <pcihpd-discuss@lists.sourceforge.net>
Subject: Re:[BUG] cpci patch for kernel 2.4.19 bug
In-Reply-To: <200301081946.h08Jksh06332@linux.intel.com>
Message-ID: <Pine.LNX.4.44.0301081453520.15466-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, Rusty Lynch wrote:

> From: "Yang, Harold" <harold.yang@intel.com>
> > 
> > Hi, Scott & Greg:
> > 
> > I have applied the cpci patch for kernel 2.4.19, and test it
> > thoroughly on ZT5084 platform. Two bugs are found:
> > 
> > 1. In my ZT5084, the driver can't correctly detect the cPCI
> >    Hot Swap bridge device. Two DEC21154 exist on ZT5084,
> >    however, only one is the right bridge. The driver can't 
> >    distinguish them correctly.
> 
> I just got a couple of ZT5541 peripheral master boards
> and can finally see what happens when an enumerable board
> is plugged into a ZT5084 chassis using a ZT5550 system master 
> board.
> 
> As of yet I have only tried a 2.5.54 kernel, but I see the 
> same problems along with some other wacky behavior that I 
> am trying to isolate.
> 
> Now about the multiple DEC21154 devices ==>  on my ZT5550 that
> is in system master mode, the first DEC21154 device is a bridge
> for the slots to the left of the system slots, and the second
> DEC21154 is a bridge for the right of the system slots.

Okay, that's what I originally wanted to determine from the lspci
output I requested when Harold mentioned this problem at the end
of November.

> So if I boot the system master (I'll talk about problems with 
> hotswaping in another email) with a peripheral board plugged
> into one of the slots on the right of the master using the
> current 2.5.54 kernel then I run into problems the first time 
> cpci_hotplug_core.c::check_slots() runs because it only looks
> at the first bus when trying to find the card that caused the
> #ENUM.

I assume by problems you mean that the cPCI event thread gets
shut down (which is what I'd expect), or do you mean something more 
severe?

> The following patch will register each of the cpci busses instead
> of just the first one detected.

Your patch is better than Harold's hack, but I'm probably going to
try and think of some other alternative, as the while loop idea
doesn't handle the possibility of someone having a 21154 bridge
on a PMC card or actually as a bridge on a cPCI card.  The original
code doesn't really handle that possiblity either, so I'll need to
cook up something better anyway.

> NOTE: I'm a little worried that the right way to do this is to
>       properly initialize the RSS bits, or at least see how the
>       chassis is configured via the RSS bits to determine which 
>       cpci bus to register.  The ZT5084 doesn't have near as many
>       configurations as newer designs like the ZT5088.
[snip]

I will investigate reading the active bus(es) out of the HC, as I've
gotten the documentation for the HC from Performance Tech, I was just
too busy before Christmas to dig into it then.  I'll try and have
something that attempts to handle your ZT5084 chassis done in a few
days.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com




