Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbTCFK20>; Thu, 6 Mar 2003 05:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268005AbTCFK20>; Thu, 6 Mar 2003 05:28:26 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:41732 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268004AbTCFK2Y>; Thu, 6 Mar 2003 05:28:24 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303061040.h26AeZSm000556@81-2-122-30.bradfords.org.uk>
Subject: Re: Kernel Boot Speedup
To: helgehaf@aitel.hist.no (Helge Hafting)
Date: Thu, 6 Mar 2003 10:40:35 +0000 (GMT)
Cc: lkml@ro0tsiege.org, linux-kernel@vger.kernel.org
In-Reply-To: <3E671C64.2040600@aitel.hist.no> from "Helge Hafting" at Mar 06, 2003 11:01:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Ro0tSiEgE LKML wrote:
> > What are some things I can change/disable/etc. to cut down the boot time
> > of the kernel (i386) ? I would like to get one to boot in a couple
> > seconds, tops. Is this possible, and how?
> 
> As a first step, compile the kernel yourself.
> Include only drivers for stuff you actually have and use, drop
> everything else.  That should give you a kernel that boots in a
> few seconds, unless you have some really slow piece of hardware.
> 
> Of course the kernel boot time is only part of what we perceive
> as "boot time", i.e. time from power-on till you can use the machine.
> 
> A normal pc boot goes like this:
> 1. The bios does its stuff.  No amount of kernel tweaking can help
> you with this, because this happens before the kernel is loaded.
> You can tweak bios options or get a better bios or motherboard though.
> Many bioses are really slow - I'm lucky and have one that gets to the
> kernel loading stage so fast that the flat panel screen don't
> have time to keep up.  (The bios starts briefly with some graphichs 
> mode, then turns to 80x25 text for compatibility reasons.  I don't
> get to see that transition unless I pause it at the lilo stage)
> 
> 2. The bios loads a linux loader, typically lilo.  Lilo then loads the 
> kernel of choice. Lilo may be configured with a keypress timeout of 
> several seconds - I have shortened that to 0.2 seconds, you may remove 
> it entirely. You may also want to configure lilo with the compact 
> option, it loads a little faster that way.
> 
> 3. The kernel boots.  This is what you may shorten by being clever.
> Leave out everything you don't need, compile into the kernel
> anything needed during boot. (I.e. don't use modules unnecessarily,
> they cause extra disk accesses)
> You know the kernel boot has started when it print something like
> "Linux hh 2.5.63-mm2" or similiar.
> The kernel boot has ended when it prints
> 
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 320k freed
> 
> or something like that.  This is usually pretty quick.  The machine
> isn't ready for use yet though.
> 
> 4. Various init scripts run - depending a lot on your distribution.
> This typically involves lots of disk access and may be slow.  You can
> trim down the init scripts a lot if you know what you're doing - they're
> general-purpose but you may have something more specific in mind.

Agreed - you can save a *lot* of boot time like this - my main box
runs just three init scripts, (I use a BSD-style init script layout,
and the main script calls two others).  The main script is 2095 bytes,
and the others are 5144 and 2713 bytes.  Most of that is taken up with
comments.

I've booted a 486, 4Mb laptop in to 2.2.13 in around 30 seconds, (from
power on), by cutting the init scripts down to almost nothing.

> And if you want to get into X fast - use a lightweight
> window manager!  Something like icewm, twm or similiar.

FVWM2 is good, too.

John.
