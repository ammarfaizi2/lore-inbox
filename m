Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313358AbSDOXUj>; Mon, 15 Apr 2002 19:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313365AbSDOXUi>; Mon, 15 Apr 2002 19:20:38 -0400
Received: from pacman.mweb.co.za ([196.2.45.77]:27802 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S313358AbSDOXUh>;
	Mon, 15 Apr 2002 19:20:37 -0400
Subject: Re: [Patch] Compilation error on 2.5.8
From: Bongani <bonganilinux@mweb.co.za>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1018910754.3402.33.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 16 Apr 2002 01:34:14 +0200
Message-Id: <1018913727.2688.118.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-04-16 at 00:45, Robert Love wrote:
> On Mon, 2002-04-15 at 18:53, Bongani wrote:
> > I get the following error when I try to compile 2.5.8
> > init/main.o: In function `start_kernel':
> > init/main.o(.text.init+0x5e2): undefined reference to
> > `setup_per_cpu_areas'
> > 
> > Looking at the code it looks like someone got confused ;)
> > around the ifdefs.I'm  under the assumption that setup_per_cpu_areas()
> > does nothing on a uniprocessor. The patch compile fine on 
> > my PC. 
> 
> A better approach would probably be to define setup_per_cpu_areas to
> nothing when CONFIG_SMP is not set so as not to have #ifdefs in the code
> itself ...  for example,
> 
> diff -urN linux-2.5.8/init/main.c linux/init/main.c
> --- linux-2.5.8/init/main.c	Sun Apr 14 15:18:46 2002
> +++ linux/init/main.c	Mon Apr 15 18:41:54 2002
> @@ -272,6 +272,8 @@
>  #define smp_init()	do { } while (0)
>  #endif
>  
> +#define setup_per_cpu_areas()	do { } while(0)
> +
>  #else
>  
>  #ifdef __GENERIC_PER_CPU
> 

Does this also look cleaner ?

--- init/main.c Tue Apr 16 01:31:29 2002
+++ init/main.c_new     Tue Apr 16 01:30:13 2002
@@ -272,6 +272,8 @@
 #define smp_init()     do { } while (0)
 #endif

+#define setup_per_cpu_areas()  do { } while(0)
+
 #else

 #ifdef __GENERIC_PER_CPU
@@ -297,9 +299,9 @@
        }
 }
 #else
-static inline void setup_per_cpu_areas(void)
-{
-}
+
+#define setup_per_cpu_areas()  do { } while(0)
+
 #endif /* !__GENERIC_PER_CPU */

 /* Called by boot processor to activate the rest. */



