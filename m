Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbTIOGJs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 02:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTIOGJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 02:09:48 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35065 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262424AbTIOGJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 02:09:47 -0400
Date: Mon, 15 Sep 2003 08:09:42 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Mikael Pettersson <mikpe@csd.uu.se>, Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: remove __ALIGN from pnpbios/bioscalls.c?
Message-ID: <20030915060941.GA126@fs.tum.de>
References: <200309131104.h8DB4WqV021726@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309131104.h8DB4WqV021726@harpo.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 13, 2003 at 01:04:32PM +0200, Mikael Pettersson wrote:
> On Sat, 13 Sep 2003 00:51:39 +0200, Adrian Bunk <bunk@fs.tum.de> wrote:
> >> > > - Which CPUs exactly need X86_ALIGNMENT_16?
> >> >
> >> >Unsure. This could use testing on a few systems.
> >> 
> >> K7s and P5s (and 486s too if I remember correctly) strongly prefer
> >> code entry points and loop labels to be 16-byte aligned. This is
> >> due to the way code is fetched from L1.
> >>...
> >
> >Hm, that's pretty different from the definition in -test5:
> >
> >config X86_ALIGNMENT_16
> >        bool
> >        depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || 
> >          MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
> >        default y
> 
> My comment referred to data from Intel and AMD code optimisation
> guides.
> 
> The kernel only uses X86_ALIGNMENT_16 to derive two __ALIGN macros
> for assembly code, but it doesn't use them except in one place in
> the pnpbios code.

It seems thoe only architecture really using the __ALIGN macros is m68k. 
This is irrelevant in this case since X86_ALIGNMENT_16 only affects 
i386.

> gcc -march=<cpu type> should generate appropriate alignment for
> function entries and loop labels.
> 
> I suspect X86_ALIGNMENT_16 is a left-over from old code.
> Perhaps its time to retire it.

Thomas, what exactly do you need __ALIGN_STR in the function 
pnp_bios_callfunc in drivers/pnp/pnpbios/bioscalls.c for?

> /Mikael

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

