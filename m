Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288793AbSAEM1R>; Sat, 5 Jan 2002 07:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSAEM1J>; Sat, 5 Jan 2002 07:27:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64563 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288793AbSAEM1C>; Sat, 5 Jan 2002 07:27:02 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wingel@t1.ctrl-c.liu.se, hpa@zytor.com, robert@schwebel.de,
        linux-kernel@vger.kernel.org, jason@mugwump.taiga.com,
        anders@alarsen.net, rkaiser@sysgo.de
Subject: Re: [RFC] Embedded X86 systems Was: [PATCH][RFC] AMD Elan patch
In-Reply-To: <E16Lh1Z-0003Go-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Jan 2002 05:23:58 -0700
In-Reply-To: <E16Lh1Z-0003Go-00@the-village.bc.nu>
Message-ID: <m1sn9lt28x.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > There is the basic Cx5530 chipset, which could have support in the
> > Linux kernel (IDE, graphics and sound).
> 
> It already does. Has done for ages. The non SB emulation mode of the audio
> is not supported but that I don't think matters.
> 
> > for all chips, some are specific for a variant, such as the video
> > input port and graphics overlay/genlock.
> 
> X11
> 
> In general if we want to support lots of weird crap then the ARM folks have
> a very nice model and a lot of weird crap to have developed their ideas
> against. Personal preference
> 
> 	Type of system	(PC, Embedded)
> 
> then for PC leave as is, for embedded
> 	
> 	Board type (blah, blah , blah)
> 	Firmware (PC BIOS, LinuxBIOS, RedBoot)

A couple of thoughts on this. 

With LinuxBIOS it is one of my design goals that you not need to know
the board type.  Plus I frequently run kernels that allow me to boot
with either LinuxBIOS or a PC BIOS, as that makes reverse engineering
easier.

Further in cases where we actually control the firmware (LinuxBIOS,
RedBoot?) it makes sense to have the firmware pass us configuration
values for places where it deviates from the norm.  This doesn't incur
any extra firmware overhead as firmware is already board specific, and
with flash chips it is easy enough to update.  The linux kernel then
would just need to handle a new configuration option.

For the truly weird, horrible or expedient cases we probably want to
have the choice be 
       Type of system (PC, Dedicated).  
I believe dedicated describes the category better.  Embedded refers to
computers in small hidden places.  Where dedicated just means a
computer setup that doesn't need to handle the general case.  That
plus I have trouble seeing a SGI workstation, or a 512 node cluster
running LinuxBIOS as an embedded system :)

Having Board type under dedicated/embedded sounds quite reasonable.
And for weird things like LinuxBIOS it probably makes sense to at
least develop their support under something like dedicated.  And only
if it becomes more general purpose move it out of there.

I'm thinking this through carefully as I'm getting close to doing
figuring out what I need to do to get LinuxBIOS support into the
kernel.  The structure is finally starting to look good enough that
this is reasonable. 

Eric
