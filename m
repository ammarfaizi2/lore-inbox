Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132756AbRBRLXk>; Sun, 18 Feb 2001 06:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132757AbRBRLXa>; Sun, 18 Feb 2001 06:23:30 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:1580 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132756AbRBRLXS>; Sun, 18 Feb 2001 06:23:18 -0500
Date: Sun, 18 Feb 2001 12:33:42 +0100 (CET)
From: Francis Galiegue <fg@mandrakesoft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.1-ac16, arch/i386/kernel/irq.c: spurious #if CONFIG_SMP
 .. #endif
Message-ID: <Pine.LNX.4.21.0102181230410.884-100000@toy.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In irq_affinity_write_proc:

--- arch/i386/kernel/irq.c.old  Sun Feb 18 12:22:06 2001
+++ arch/i386/kernel/irq.c      Sun Feb 18 12:22:31 2001
@@ -1080,7 +1080,6 @@

        err = parse_hex_value(buffer, count, &new_value);

-#if CONFIG_SMP
        /*
         * Do not allow disabling IRQs completely - it's a too easy
         * way to make the system unusable accidentally :-) At least
@@ -1088,7 +1087,6 @@
         */
        if (!(new_value & cpu_online_map))
                return -EINVAL;
-#endif

        irq_affinity[irq] = new_value;
        irq_desc[irq].handler->set_affinity(irq, new_value);


-- 
Francis Galiegue, fg@mandrakesoft.com - Normand et fier de l'être
"Programming is a race between programmers, who try and make more and more
idiot-proof software, and universe, which produces more and more remarkable
idiots. Until now, universe leads the race"  -- R. Cook

