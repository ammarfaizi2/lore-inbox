Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132411AbRACQ2c>; Wed, 3 Jan 2001 11:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132474AbRACQ2W>; Wed, 3 Jan 2001 11:28:22 -0500
Received: from aeon.tvd.be ([195.162.196.20]:15923 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S132411AbRACQ2J>;
	Wed, 3 Jan 2001 11:28:09 -0500
Date: Wed, 3 Jan 2001 16:57:13 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] loops_per_sec
Message-ID: <Pine.LNX.4.05.10101031654520.611-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Two small fixes:
  - fix the comments in include/linux/delay.h
  - someone changed the actual calculation for s390 (added /HZ), but forgot to
    replace loops_per_sec by loops_per_jiffy

--- linux-2.4.0-prerelease-ac4/include/linux/delay.h	Mon Jan  1 23:30:23 2001
+++ test/linux-merge20-2.4.0-prerelease-ac4/include/linux/delay.h	Wed Jan  3 16:45:28 2001
@@ -13,7 +13,7 @@
 
 /*
  * Using udelay() for intervals greater than a few milliseconds can
- * risk overflow for high loops_per_sec (high bogomips) machines. The
+ * risk overflow for high loops_per_jiffy (high bogomips) machines. The
  * mdelay() provides a wrapper to prevent this.  For delays greater
  * than MAX_UDELAY_MS milliseconds, the wrapper is used.  Architecture
  * specific values can be defined in asm-???/delay.h as an override.
--- linux-2.4.0-prerelease-ac4/arch/s390/kernel/setup.c	Wed Jan  3 14:23:49 2001
+++ test/linux-merge20-2.4.0-prerelease-ac4/arch/s390/kernel/setup.c	Wed Jan  3 16:46:17 2001
@@ -369,7 +369,7 @@
                        "# processors    : %i\n"
                        "bogomips per cpu: %lu.%02lu\n",
                        smp_num_cpus, loops_per_jiffy/(500000/HZ),
-                       (loops_per_sec/(5000/HZ))%100);
+                       (loops_per_jiffy/(5000/HZ))%100);
         for (i = 0; i < smp_num_cpus; i++) {
                 cpuinfo = &safe_get_cpu_lowcore(i).cpu_data;
                 p += sprintf(p,"processor %i: "

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
