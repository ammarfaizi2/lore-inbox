Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLHPgh>; Fri, 8 Dec 2000 10:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbQLHPga>; Fri, 8 Dec 2000 10:36:30 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:13582 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129408AbQLHPgO>;
	Fri, 8 Dec 2000 10:36:14 -0500
Message-ID: <3A30F8BA.16CB96F7@mandrakesoft.com>
Date: Fri, 08 Dec 2000 10:05:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Clayton Weaver <cgweav@eskimo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question about tulip patch to set CSR0 for pci 2.0 bus
In-Reply-To: <Pine.SUN.3.96.1001208011441.4248A-100000@eskimo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clayton Weaver wrote:
> 
> Shouldn't the setting of the CSR0 value for x86 switch between normal
> (0x01A08000) and cautious (0x01A04800) based on some notion of
> what generation of pci bus is installed rather than what cpu the kernel
> is compiled for?
> 
> That's one thing that bothered me about the method that the .90 driver
> used. It worked for me, of course, cool, but when I thought about putting
> a real general purpose patch into later versions of tulip.c to solve the
> same problem, it bothered me that the old method assumes an association
> between pci bus and cpu that may not be valid. I don't know that
> there are any 386/486/5x86 systems that can use the 0x01A08000 setting
> (that apparently works on most x86 pci 2.1 busses), but then again I don't
> know that there aren't, either.
> 
> If the pci bus level is 2.0, it makes sense to use the cautious CSR0
> setting, for the same reasons that the .90 tulip.c in 2.0.38 does, and if
> the pci level is 2.1, you aren't taking any chances with 0x01A08000 that
> the driver doesn't take now. The pci driver, initialized before any
> pci devices, appears to know whether you have a pci 2.0 or pci 2.1 bus, so
> why not use that information instead of cpu generation?

A good suggestion, too...   Some other hardware behaves differently
based on PCI bus version, it would be nice for the driver to notice that
and enable (or disable) advanced features.  To blindly assume is just a
PCI bus lockup waiting to happen... 

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
