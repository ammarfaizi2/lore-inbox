Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268040AbTAIX0o>; Thu, 9 Jan 2003 18:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268067AbTAIX0o>; Thu, 9 Jan 2003 18:26:44 -0500
Received: from [198.92.195.114] ([198.92.195.114]:22791 "EHLO meetpoint.home")
	by vger.kernel.org with ESMTP id <S268040AbTAIX0m>;
	Thu, 9 Jan 2003 18:26:42 -0500
Date: Thu, 9 Jan 2003 18:35:30 -0500 (EST)
From: Ken Ryan <newsryan@leesburg-geeks.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Hardware IP [was: Re: Why is Nvidia given GPL'd code ...]
Message-ID: <Pine.LNX.4.21.0301091805420.4923-100000@meetpoint.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Helge Hafting (helgehaf@aitel.hist.no) wrote:
>Perhaps their driver contains some IP. But I seriously doubt the
>programming specs for their chips contains such secrets. It is
>not as if we need the entire chip layout - it is basically
>things like:
>
>"To achieve effect X, write command code 0x3477 into register 5
>and the new coordinates into registers 75-78. Then wait 2.03ms before
>attempting to access the chip again..."
>
>Something is very wrong if they _can't_ release that sort of
>information.
>Several other manufacturers have no problem with this. 

Note I have absolutely no knowledge of the internals of NVidia chips,
though I have had exposure to others (and designed two).

First, there is lots of closed IP blocks available for ASICs.  Things
like PCI interfaces, memory controllers, embedded processors, etc.
Generally they have very strict NDAs.  Generally it is possible to design
a clean-room equivalent to substitute for something licensed, but with the
pace of development required to stay competitive in the graphics business
it's unlikely NVidia can spare the dozens of engineers necessary to design
and validate an IP block just so they can opensource drivers.  They might
save some royalties, but with royalties spread over a bazillion shipped
chips it's unlikely to be significant.

Second, a device like a GPU is extremely complex. Write-wait-write
works fine for a printer port, but a GPU amounts to an entire 
processing subsystem in its own right, with all that implies (see
SMP, distributed processing, etc. and all the joy associated with those).
Especially modern high-performance GPUs which have on-chip resources for
coordinate transforms and programmable shaders, the complexity far exceeds
that of the entire rest of the computer.

Third, even if it weren't for IP licensing, the programming information
for a chip can be very sensitive.

For example: one aspect of a GPU which is extremely sensitive to any 
graphics vendor is framebuffer architecture.  How are the color components
stored, how is data read for texture mapping vs. video vs. Z buffer, 
how does it make effective use of DRAM devices (which have extremely
different behavior when accessed linearly vs. randomly), how is data
cached, how is arbitration done among multiple accesses, the list goes on.
It is nearly impossible to write a high performance OpenGL driver without
knowing at least some of that information, and these architecture choices 
can make or break the performance of a GPU.  So to me it's entirely
understandable that NVidia doesn't want anyone to know how they do
it.  [Note that for console stuff or basic graphics all GPUs I've heard 
of can be put into a VGA compatibility mode which may or may not have some
degree of accelleration].

To some extent these details can be buried; I imagine this is how ATI
can consider releasing open-source drivers for their chips (I have no
knowledge of ATI chips either).  The notion that their closed-source
drivers will be higher performance tells me that the real juicy stuff
is still being kept under wraps.  Perhaps that same strategy isn't
possible with NVidia's architecture.  Or perhaps ATI  simply figures they
can release driver source but not chip information itself, and assume by
the time a competitor can puzzle out their code they'll be selling the
next generation parts!

Just my 2-cent attempt to add some information into the flamewar...

		Ken Ryan


