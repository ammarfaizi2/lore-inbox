Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317666AbSFLIC0>; Wed, 12 Jun 2002 04:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317667AbSFLICZ>; Wed, 12 Jun 2002 04:02:25 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:18310 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317666AbSFLICX>; Wed, 12 Jun 2002 04:02:23 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Anton Altaparmakov <aia21@cantab.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "Wed, 12 Jun 2002 08:54:01 +0100."
             <5.1.0.14.2.20020612084157.041970e0@pop.cus.cam.ac.uk> 
Date: Wed, 12 Jun 2002 18:06:47 +1000
Message-Id: <E17I39U-00054u-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <5.1.0.14.2.20020612084157.041970e0@pop.cus.cam.ac.uk> you write:
> >Now, you *could* only allocate buffers for cpus where cpu_possible(i)
> >is true, once the rest of the patch goes in.  That would be a valid
> >optimization.
> 
> Please explain. What is cpu_possible()?

>From Hotcpu/hotcpu-boot-i386.patch.gz:

--- working-2.5.19-pre-hotcpu/include/asm-i386/smp.h	Tue Jun  4 15:37:09 2002
+++ working-2.5.19-hotcpu/include/asm-i386/smp.h	Mon Jun  3 18:00:09 2002
@@ -93,6 +94,8 @@
 #define smp_processor_id() (current_thread_info()->cpu)
 
 #define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
+#define cpu_possible(cpu) (phys_cpu_present_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
 {

ie. "Can this CPU number *ever* exist?", for exactly this kind of
optimization.  It looks like it was a mistake to leave that to a later
patch, but I didn't appreciate the 64k-per-cpu buffer for NTFS (what
is it for, by the way?  per-cpu buffering for a filesystem seems, um,
wierd).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
