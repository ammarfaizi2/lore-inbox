Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313327AbSDOWp4>; Mon, 15 Apr 2002 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313328AbSDOWpz>; Mon, 15 Apr 2002 18:45:55 -0400
Received: from zero.tech9.net ([209.61.188.187]:28946 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313327AbSDOWpz>;
	Mon, 15 Apr 2002 18:45:55 -0400
Subject: Re: [Patch] Compilation error on 2.5.8
From: Robert Love <rml@tech9.net>
To: Bongani <bonganilinux@mweb.co.za>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018911190.2688.67.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 18:45:52 -0400
Message-Id: <1018910754.3402.33.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-15 at 18:53, Bongani wrote:
> I get the following error when I try to compile 2.5.8
> init/main.o: In function `start_kernel':
> init/main.o(.text.init+0x5e2): undefined reference to
> `setup_per_cpu_areas'
> 
> Looking at the code it looks like someone got confused ;)
> around the ifdefs.I'm  under the assumption that setup_per_cpu_areas()
> does nothing on a uniprocessor. The patch compile fine on 
> my PC. 

A better approach would probably be to define setup_per_cpu_areas to
nothing when CONFIG_SMP is not set so as not to have #ifdefs in the code
itself ...  for example,

diff -urN linux-2.5.8/init/main.c linux/init/main.c
--- linux-2.5.8/init/main.c	Sun Apr 14 15:18:46 2002
+++ linux/init/main.c	Mon Apr 15 18:41:54 2002
@@ -272,6 +272,8 @@
 #define smp_init()	do { } while (0)
 #endif
 
+#define setup_per_cpu_areas()	do { } while(0)
+
 #else
 
 #ifdef __GENERIC_PER_CPU

	Robert Love


