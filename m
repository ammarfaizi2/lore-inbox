Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSLCSc5>; Tue, 3 Dec 2002 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbSLCSc5>; Tue, 3 Dec 2002 13:32:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:3000 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265378AbSLCSc4>;
	Tue, 3 Dec 2002 13:32:56 -0500
Date: Tue, 3 Dec 2002 18:37:57 GMT
Message-Id: <200212031837.gB3IbvQT008482@noodles.internal>
To: linux-kernel@vger.kernel.org
From: davej@codemonkey.org.uk
Subject: [CFT][2.5] AGPGART reworking.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per private discussion with Linus over the last few days,
I've reworked the AGPGART driver considerably.  There's likely
some gotchas left here, so I'd appreciate testers/code-review
of this quite large change (>200KB worth of diff, but several
files get moved about a bit).

- Introduces a new 'agp_register_driver' function, which is used
  to seperate the chipset drivers completely from the backend.

- chipset drivers become modules in their own right.
  This seems to work when everything is compiled in. Built as modules
  is untested yet, but it means right now you have to insmod via-agp.o
  or whatever chipset vendor you need before starting X.
  agp_try_supported() is now a param to the chipset modules, not the
  agpgart.o module.

- i8x0.c & i810.c have become intel-agp.c
  CONFIG_AGP_I810 is currently broken, I'll fix this up soon.

- agp.c becomes backend.c

- split out generic routines into generic.c

- version number bump to 1.0
  This is a pretty major change IMO, and it's been stuck at 0.99 forever.

- Cast fixes (Alan)

- x86-64 fixes (Andi)

- Add recognition for several new devices.

- list myself as maintainer of 1.0+
  Jeff Hartmann hasn't done any considerable work on agpgart since `99
  to my knowledge. Attempts to contact him in the past have failed.

You can get this from bk://linux-dj.bkbits.net/agpgart or for the
bk-challenged, you can get the gnu diff at ..
 ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.50/agpgart-recore-2.diff.gz

		Dave

