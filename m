Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279407AbRKMV2f>; Tue, 13 Nov 2001 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279412AbRKMV21>; Tue, 13 Nov 2001 16:28:27 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:39791 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279407AbRKMV2T>; Tue, 13 Nov 2001 16:28:19 -0500
Date: Tue, 13 Nov 2001 16:28:18 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ben Ryan <ben@bssc.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Uniprocessor Compile error: 2.4.15-pre4 (-tr) in kernel.o (cpu_init()) - Works with SMP
Message-ID: <20011113162814.A28319@redhat.com>
In-Reply-To: <2482591359.20011114043702@bssc.edu.au> <187493868425.20011114074459@bssc.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <187493868425.20011114074459@bssc.edu.au>; from ben@bssc.edu.au on Wed, Nov 14, 2001 at 07:44:59AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 07:44:59AM +1100, Ben Ryan wrote:
...
> SMP compile succeeded. (albeit with lots of warnings on 'pure')

Which version of gcc?  2.95?  I guess the pure attribute needs to be 
made a compiler.h thing.

> It seems cpucount is only defined when SMP is compiled in, I guess cpucount
> hasn't been set to 1 in uniprocessor build, breaking non-smp builds?
> How can I hardcode that into setup.c? I know little of C, so if someone could
> point out a line of code to set this (diff even?) :)

This will fix the link error by moving cpucount into setup.c.  Cheers,

		-ben


diff -ur tr-2.4.15-pre4/arch/i386/kernel/setup.c tr.prev/arch/i386/kernel/setup.c
--- tr-2.4.15-pre4/arch/i386/kernel/setup.c	Tue Nov 13 16:25:33 2001
+++ tr.prev/arch/i386/kernel/setup.c	Tue Nov 13 15:00:40 2001
@@ -2807,7 +2807,7 @@
 };
 
 unsigned long cpu_initialized __initdata = 0;
-int cpucount;
+extern int cpucount;
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
diff -ur tr-2.4.15-pre4/arch/i386/kernel/smpboot.c tr.prev/arch/i386/kernel/smpboot.c
--- tr-2.4.15-pre4/arch/i386/kernel/smpboot.c	Tue Nov 13 16:25:46 2001
+++ tr.prev/arch/i386/kernel/smpboot.c	Tue Nov 13 15:00:40 2001
@@ -443,7 +443,7 @@
 		synchronize_tsc_ap();
 }
 
-extern int cpucount;
+int cpucount;
 
 extern int cpu_idle(void);
 
