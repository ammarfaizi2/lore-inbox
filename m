Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRKNEMZ>; Tue, 13 Nov 2001 23:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280104AbRKNEMQ>; Tue, 13 Nov 2001 23:12:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:19972 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S280101AbRKNEMG>;
	Tue, 13 Nov 2001 23:12:06 -0500
Subject: Re: Uniprocessor Compile error: 2.4.15-pre4 (-tr) in kernel.o
	(cpu_init()) - Works with SMP
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Ben Ryan <ben@bssc.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20011113162814.A28319@redhat.com>
In-Reply-To: <2482591359.20011114043702@bssc.edu.au>
	<187493868425.20011114074459@bssc.edu.au> 
	<20011113162814.A28319@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 13 Nov 2001 23:11:54 -0500
Message-Id: <1005711128.810.6.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-13 at 16:28, Benjamin LaHaise wrote:
> This will fix the link error by moving cpucount into setup.c.

Looks like the patch is reversed.  Attached is a reversed version of the
aforementioned reversed patch.

--- linux-2.4.15-pre4/arch/i386/kernel/setup.c	Mon Nov 12 17:39:00 2001
+++ linux/arch/i386/kernel/setup.c	Tue Nov 13 23:08:53 2001
@@ -2806,6 +2807,7 @@
 };
 
 unsigned long cpu_initialized __initdata = 0;
+int cpucount;
 
 /*
  * cpu_init() initializes state that is per-CPU. Some data is already
--- linux-2.4.15-pre4/arch/i386/kernel/smpboot.c	Mon Nov 12 17:39:00 2001
+++ linux/arch/i386/kernel/smpboot.c	Tue Nov 13 23:08:53 2001
@@ -443,7 +443,7 @@
 		synchronize_tsc_ap();
 }
 
-int cpucount;
+extern int cpucount;
 
 extern int cpu_idle(void);
 
	Robert Love

