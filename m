Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbQLHKFN>; Fri, 8 Dec 2000 05:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131501AbQLHKFD>; Fri, 8 Dec 2000 05:05:03 -0500
Received: from mx1.eskimo.com ([204.122.16.48]:57095 "EHLO mx1.eskimo.com")
	by vger.kernel.org with ESMTP id <S130127AbQLHKE4>;
	Fri, 8 Dec 2000 05:04:56 -0500
Date: Fri, 8 Dec 2000 01:34:28 -0800 (PST)
From: Clayton Weaver <cgweav@eskimo.com>
To: linux-kernel@vger.kernel.org
Subject: question about tulip patch to set CSR0 for pci 2.0 bus
Message-ID: <Pine.SUN.3.96.1001208011441.4248A-100000@eskimo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't the setting of the CSR0 value for x86 switch between normal
(0x01A08000) and cautious (0x01A04800) based on some notion of
what generation of pci bus is installed rather than what cpu the kernel
is compiled for?

That's one thing that bothered me about the method that the .90 driver
used. It worked for me, of course, cool, but when I thought about putting
a real general purpose patch into later versions of tulip.c to solve the
same problem, it bothered me that the old method assumes an association
between pci bus and cpu that may not be valid. I don't know that
there are any 386/486/5x86 systems that can use the 0x01A08000 setting
(that apparently works on most x86 pci 2.1 busses), but then again I don't
know that there aren't, either.

If the pci bus level is 2.0, it makes sense to use the cautious CSR0
setting, for the same reasons that the .90 tulip.c in 2.0.38 does, and if
the pci level is 2.1, you aren't taking any chances with 0x01A08000 that
the driver doesn't take now. The pci driver, initialized before any
pci devices, appears to know whether you have a pci 2.0 or pci 2.1 bus, so
why not use that information instead of cpu generation?

(Merely a suggestion)

Regards,

Clayton Weaver
<mailto:cgweav@eskimo.com>
(Seattle)

""




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
