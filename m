Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSCMV3t>; Wed, 13 Mar 2002 16:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292942AbSCMV3j>; Wed, 13 Mar 2002 16:29:39 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:33707 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S292918AbSCMV32>;
	Wed, 13 Mar 2002 16:29:28 -0500
Date: Wed, 13 Mar 2002 22:29:26 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203132129.WAA08883@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: boot_cpu_data.x86_vendor corruption on dual AMD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm involved with debugging a driver problem which only appears
on dual AMD systems. When the driver's module_init() is called,
boot_cpu_data.x86_vendor is 0 (Intel) instead of 2 (AMD), causing
incorrect code to be selected and eventually an oops.

We've so far traced it to the call to smp_init() in init/main.c.
Before this call, boot_cpu_data.x86_vendor is 2 (correct), but
after the call, the field is 0.

I've been looking through the code but haven't found any obvious
bug candidates, so we've resorted to debug printouts and binary
search. (I'm giving directions, another person is doing the tests
at a remote site, so progress is slow.)

The kernel in question is 2.4.18, but we've seen this in other
2.4 kernels too. Choice of compiler (gcc-2.96-98/egcs-2.91.66)
and CONFIG_MK7 on or off doesn't seem to make any difference.
The box (Tyan) is otherwise stable, and the CPUs are Athlon MPs.

/Mikael
