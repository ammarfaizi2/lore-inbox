Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292882AbSCJHdO>; Sun, 10 Mar 2002 02:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292885AbSCJHdF>; Sun, 10 Mar 2002 02:33:05 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13369 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292882AbSCJHc5>; Sun, 10 Mar 2002 02:32:57 -0500
To: Christer Weinigel <wingel@acolyte.hack.org>
Cc: davej@suse.de, gone@us.ibm.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
	<20020308223330.A15106@suse.de>
	<20020308234811.3F003F5B@acolyte.hack.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Mar 2002 00:27:14 -0700
In-Reply-To: <20020308234811.3F003F5B@acolyte.hack.org>
Message-ID: <m14rjo288d.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel <wingel@acolyte.hack.org> writes:

> Dave Jones <davej@suse.de> wrote:
> >  As a sidenote (sort of related topic) :
> >  An idea being kicked around a little right now is x86 subarch
> >  support for 2.5. With so many of the niche x86 spin-offs appearing
> >  lately, all fighting for their own piece of various files in
> >  arch/i386/kernel/, it may be time to do the same as the ARM folks did,
> >  and have..
> > 
> >   arch/i386/generic/
> >   arch/i386/numaq/
> >   arch/i386/visws
> >   arch/i386/voyager/
> >   etc..
> 
> Yes please.  I've been working with at least 4 different National
> Semiconductor Geode based designs so far, and they will get more and
> more common I belive.  It'd be nice not having to crap in the rest of
> the i386 tree just because one system has its own bootloader or
> special motherboard.
> 
> I just got my SC2200 based board booting with LinuxBIOS, so I'll
> probably have to do a special kernel initialization that does some
> board-specific setup since there is no BIOS to do that.

O.k. On the LinuxBIOS front it will take a little more work but we should
be able to have the LinuxBIOS table report the presence of the devices
that need to be configured, and possibly some motherboard specific configuration
for those devices (Think of irq routing).   All of which should reduce
strange motherboard configuration to the general device driver problem.

> >  The downsides to this:
> >  - Code duplication.
> >    Some routines will likely be very similar if not identical.
> >  - Bug propagation.
> >    If something is fixed in one subarch, theres a high possibility
> >    it needs fixing in other subarchs
> 
> Couldn't this be done with a common subroutine library, such as
> arch/i386/common that contains code to set up the interrupt controller
> and such.  The PC platform code just includes everything, other
> platforms could be a bit more choosy, have its own bootloader and
> memory detection code and just skip the BIOS calls.

I have just posted a patch that does the heavy lifting needed to make
using a 32bit entry point possible.  It allows skipping of the 16bit
bios calls.  With that patch in place it becomes trivial to query
the data from LinuxBIOS instead of the PCBIOS.

Eric

