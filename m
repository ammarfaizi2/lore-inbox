Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318132AbSIEUwy>; Thu, 5 Sep 2002 16:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318145AbSIEUwy>; Thu, 5 Sep 2002 16:52:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:11222 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318132AbSIEUww> convert rfc822-to-8bit; Thu, 5 Sep 2002 16:52:52 -0400
Date: Thu, 5 Sep 2002 22:57:23 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Gregoire Favre <greg@ulima.unil.ch>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       Dominik Brodowski <devel@brodo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre5-ac3 (p4-clockmod.c don't compil)
In-Reply-To: <20020905203749.GB3847@ulima.unil.ch>
Message-ID: <Pine.NEB.4.44.0209052250280.7218-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Gregoire Favre wrote:

> Hello,

Hi Grégoire,

> I got:
>...
> gcc -D__KERNEL__ -I/usr/src/linux-2.4/include -Wall -Wstrict-prototypes
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=p4_clockmod  -c -o p4-clockmod.o p4-clockmod.c
> p4-clockmod.c: In function `cpufreq_p4_validatedc':
> p4-clockmod.c:84: `i' undeclared (first use in this function)
> p4-clockmod.c:84: (Each undeclared identifier is reported only once
> p4-clockmod.c:84: for each function it appears in.)
> p4-clockmod.c: In function `cpufreq_p4_init':
> p4-clockmod.c:146: warning: unused variable `l'
> p4-clockmod.c:146: warning: unused variable `h'
> make[1]: *** [p4-clockmod.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2


It seems Dominik's update in 2.4.20-pre5-ac2 broke it. The following
(untested) should fix it:


--- arch/i386/kernel/p4-clockmod.c.old	2002-09-05 22:48:51.000000000 +0200
+++ arch/i386/kernel/p4-clockmod.c	2002-09-05 22:53:29.000000000 +0200
@@ -69,6 +69,7 @@
 {
 	u32 l, h;
 	int dc = DC_DISABLE;
+	int i;

 	/*
 	 * ... if we want to set the percentage LOWER than the thermal throttle
@@ -143,7 +144,6 @@

 int __init cpufreq_p4_init(void)
 {
-	u32 l, h;
 	struct cpuinfo_x86 *c = cpu_data;
 	int cpu = smp_processor_id();
 	int cpuid;

> 	Grégoire

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



