Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTKVRKR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 12:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTKVRKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 12:10:17 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:37816 "EHLO
	mwinf0502.wanadoo.fr") by vger.kernel.org with ESMTP
	id S262407AbTKVRKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 12:10:07 -0500
Message-ID: <3FBF99E6.1070402@wanadoo.fr>
Date: Sat, 22 Nov 2003 18:16:22 +0100
From: Remi Colinet <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
References: <3FBF5C79.5050409@wanadoo.fr> <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:

>On Sat, 22 Nov 2003, Remi Colinet wrote:
>
>  
>
>>arch/i386/oprofile/built-in.o: In function `oprofile_reset_stats':
>>/usr/src/mm/include/asm/bitops.h:251: undefined reference to 
>>`cpu_possible_map'
>>arch/i386/oprofile/built-in.o: In function `oprofile_create_stats_files':
>>/usr/src/mm/include/asm/bitops.h:251: undefined reference to 
>>`cpu_possible_map'
>>make: *** [.tmp_vmlinux1] Error 1
>>    
>>
>
>Index: linux-2.6.0-test9-mm5/arch/i386/kernel/process.c
>===================================================================
>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/arch/i386/kernel/process.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 process.c
>--- linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 20:59:15 -0000	1.1.1.1
>+++ linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 22:20:00 -0000
>@@ -50,6 +50,7 @@
> #include <asm/desc.h>
> #include <asm/tlbflush.h>
> #include <asm/cpu.h>
>+#include <asm/atomic_kmap.h>
> #ifdef CONFIG_MATH_EMULATION
> #include <asm/math_emu.h>
> #endif
>Index: linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c
>===================================================================
>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 oprofile_stats.c
>--- linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 20:59:40 -0000	1.1.1.1
>+++ linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 21:27:44 -0000
>@@ -10,7 +10,8 @@
> #include <linux/oprofile.h>
> #include <linux/cpumask.h>
> #include <linux/threads.h>
>- 
>+#include <linux/smp.h>
>+
> #include "oprofile_stats.h"
> #include "cpu_buffer.h"
>  
>Index: linux-2.6.0-test9-mm5/include/linux/cpumask.h
>===================================================================
>RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/include/linux/cpumask.h,v
>retrieving revision 1.1.1.1
>diff -u -p -B -r1.1.1.1 cpumask.h
>--- linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 20:59:57 -0000	1.1.1.1
>+++ linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 21:52:39 -0000
>@@ -39,9 +39,8 @@ typedef unsigned long cpumask_t;
> 
> 
> #ifdef CONFIG_SMP
>-
>+#include <asm/smp.h>
> extern cpumask_t cpu_online_map;
>-extern cpumask_t cpu_possible_map;
> 
> #define num_online_cpus()		cpus_weight(cpu_online_map)
> #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
>
>  
>
It compiles completely. :-)

Just a point : in the file arch/i383/process.c, I added the  following 
lines.

#include <asm/tlbflush.h>
#include <asm/cpu.h>

My original processs.c file seems to be a little be bit different from 
yours (?).
The following line was already in the process.c file.

+#include <asm/atomic_kmap.h>

Thanks
Rémi


