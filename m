Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266979AbSKUT1I>; Thu, 21 Nov 2002 14:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266980AbSKUT1I>; Thu, 21 Nov 2002 14:27:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40970 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266979AbSKUT1H>; Thu, 21 Nov 2002 14:27:07 -0500
Date: Thu, 21 Nov 2002 19:34:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
       "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] subarch cleanup
Message-ID: <20021121193407.A13944@flint.arm.linux.org.uk>
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	Sam Ravnborg <sam@ravnborg.org>, john stultz <johnstul@us.ibm.com>,
	"J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <1037750429.4463.71.camel@w-jstultz2.beaverton.ibm.com> <20021121183304.GA1144@mars.ravnborg.org> <228760000.1037903743@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <228760000.1037903743@flay>; from mbligh@aracnet.com on Thu, Nov 21, 2002 at 10:35:43AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 10:35:43AM -0800, Martin J. Bligh wrote:
> > Why do you need to move the .h files?
> 
> Because they're in a silly place now. They should be whereever all
> the other include files are.
> 
> > CFLAGS += -Iarch/i386/$(MACHINE_H) -Iarch/i386/mach-generic
> > That should achieve the same effect?
> 
> Header files go under include ....

In this instance I'd disagree.  Think about UML.  UML has:

	include/asm-um/*.h
	include/asm-um/arch -> include/asm-i386

When building for UML, what happens if you need to get to a machine
specific file for something, and the i386 include files do:

	#include <asm/mach-generic/foo.h>

Yep, it fails.

Now guess why we in the ARM community haven't even bothered to look at
UML yet?  There's over 1MB of include files that would need to be moved,
along with countless #include statements needing to be fixed up.

For something that would be nice to have, and probably run quite well on
the ARM architecture (due to some nice features ARM has, especially for
UML's jail mode) there isn't enough interest in it to warrant such a
painful reorganisation.

I'd therefore strongly recommend NOT going down the path of adding
subdirectories to include/asm-*.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

