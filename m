Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTANHqs>; Tue, 14 Jan 2003 02:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTANHqs>; Tue, 14 Jan 2003 02:46:48 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44768 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261451AbTANHqr>; Tue, 14 Jan 2003 02:46:47 -0500
Date: Tue, 14 Jan 2003 08:55:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <linux@brodo.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.58
Message-ID: <20030114075535.GL21826@fs.tum.de>
References: <Pine.LNX.4.44.0301132205550.6784-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301132205550.6784-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 10:14:29PM -0800, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.57 to v2.5.58
> ============================================
>...
> Dominik Brodowski <linux@brodo.de>:
>...
>   o cpufreq: per-CPU initialization
>...


This change broke the compilation of several cpufreq drivers:


<--  snip  -->

...
  gcc -Wp,-MD,arch/i386/kernel/cpu/cpufreq/.powernow-k6.o.d -D__KERNEL__ 
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=powernow_k6 -DKBUILD_MODNAME=powernow_k6   -c -o 
arch/i386/kernel/cpu/cpufreq/powernow-k6.o 
arch/i386/kernel/cpu/cpufreq/powernow-k6.c
arch/i386/kernel/cpu/cpufreq/powernow-k6.c:230: macro 
`cpufreq_unregister' used without args
make[3]: *** [arch/i386/kernel/cpu/cpufreq/powernow-k6.o] Error 1

<--  snip  -->


It seems the following was intended:

--- linux-2.5.58/include/linux/cpufreq.h.old	2003-01-14 08:53:27.000000000 +0100
+++ linux-2.5.58/include/linux/cpufreq.h	2003-01-14 08:53:56.000000000 +0100
@@ -130,7 +130,7 @@
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 /* deprecated */
 #define cpufreq_register(x)   cpufreq_register_driver(x)
-#define cpufreq_unregister(x) cpufreq_unregister_driver(NULL)
+#define cpufreq_unregister() cpufreq_unregister_driver(NULL)
 
 
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

