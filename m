Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264856AbSKUVrI>; Thu, 21 Nov 2002 16:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSKUVrI>; Thu, 21 Nov 2002 16:47:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:6594 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264856AbSKUVrG>;
	Thu, 21 Nov 2002 16:47:06 -0500
Date: Thu, 21 Nov 2002 13:47:52 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <239070000.1037915272@flay>
In-Reply-To: <20021121193407.A13944@flint.arm.linux.org.uk>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com> <20021121183304.GA1144@mars.ravnborg.org> <228760000.1037903743@flay> <20021121193407.A13944@flint.arm.linux.org.uk>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Header files go under include ....
> 
> In this instance I'd disagree.  Think about UML.  UML has:
> 
> 	include/asm-um/*.h
> 	include/asm-um/arch -> include/asm-i386
> 
> When building for UML, what happens if you need to get to a machine
> specific file for something, and the i386 include files do:
> 
> 	#include <asm/mach-generic/foo.h>
> 
> Yep, it fails.

I don't understand what UML is trying to do here, but if it wants
the architecture specific stuff, it has to do it in the same way 
as the arch itself. That's UML's problem ... it sounds like it's
just making invalid assumptions. Maybe the include paths
need to be in a seperate makefile to avoid maintainance problems.
 
> Now guess why we in the ARM community haven't even bothered to look at
> UML yet?  There's over 1MB of include files that would need to be moved,
> along with countless #include statements needing to be fixed up.
> 
> For something that would be nice to have, and probably run quite well on
> the ARM architecture (due to some nice features ARM has, especially for
> UML's jail mode) there isn't enough interest in it to warrant such a
> painful reorganisation.
> 
> I'd therefore strongly recommend NOT going down the path of adding
> subdirectories to include/asm-*.

Another way to fix this (which might be simpler anyway) is to leave
the Makefiles alone and create:

include/asm-i386/mach_apic.h
	#ifdef CONFIG_XYZ_MACHINE
		#include <asm/mach-xyz/mach_apic.h>
	#else
		#include <asm/mach-generic/mach_apic.h>

Or something along those lines.

Whilst it's a nice idea in principle, the current subarch system does 
not scale to any real number of subarches beyond 1 or 2, and need some 
rejigging.

M.

