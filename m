Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291251AbSCHXsp>; Fri, 8 Mar 2002 18:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCHXsf>; Fri, 8 Mar 2002 18:48:35 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:50438 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S291251AbSCHXsV>;
	Fri, 8 Mar 2002 18:48:21 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: davej@suse.de
Cc: gone@us.ibm.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <20020308223330.A15106@suse.de> (message from Dave Jones on Fri,
	8 Mar 2002 22:33:30 +0100)
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com> <20020308223330.A15106@suse.de>
Message-Id: <20020308234811.3F003F5B@acolyte.hack.org>
Date: Sat,  9 Mar 2002 00:48:11 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> wrote:
>  As a sidenote (sort of related topic) :
>  An idea being kicked around a little right now is x86 subarch
>  support for 2.5. With so many of the niche x86 spin-offs appearing
>  lately, all fighting for their own piece of various files in
>  arch/i386/kernel/, it may be time to do the same as the ARM folks did,
>  and have..
> 
>   arch/i386/generic/
>   arch/i386/numaq/
>   arch/i386/visws
>   arch/i386/voyager/
>   etc..

Yes please.  I've been working with at least 4 different National
Semiconductor Geode based designs so far, and they will get more and
more common I belive.  It'd be nice not having to crap in the rest of
the i386 tree just because one system has its own bootloader or
special motherboard.

I just got my SC2200 based board booting with LinuxBIOS, so I'll
probably have to do a special kernel initialization that does some
board-specific setup since there is no BIOS to do that.

>  The downsides to this:
>  - Code duplication.
>    Some routines will likely be very similar if not identical.
>  - Bug propagation.
>    If something is fixed in one subarch, theres a high possibility
>    it needs fixing in other subarchs

Couldn't this be done with a common subroutine library, such as
arch/i386/common that contains code to set up the interrupt controller
and such.  The PC platform code just includes everything, other
platforms could be a bit more choosy, have its own bootloader and
memory detection code and just skip the BIOS calls.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
