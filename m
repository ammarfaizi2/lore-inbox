Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTIYKXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 06:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbTIYKXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 06:23:16 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43729 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261796AbTIYKXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 06:23:14 -0400
Date: Thu, 25 Sep 2003 12:23:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix non-modular ftape compile
Message-ID: <20030925102309.GI15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following link error in 2.60-test5-mm4 (but it doesn't seem 
to be specific to -mm):

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o(.exit.text+0xfe6): In function `ftape_exit':
: undefined reference to `ftape_proc_destroy'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

ftape_proc_destroy is only available #ifdef MODULE, the following patch 
fixes the link error:

--- linux-2.6.0-test5-mm4-no-smp-2.95/drivers/char/ftape/lowlevel/ftape-init.c.old	2003-09-23 00:58:02.000000000 +0200
+++ linux-2.6.0-test5-mm4-no-smp-2.95/drivers/char/ftape/lowlevel/ftape-init.c	2003-09-23 00:58:25.000000000 +0200
@@ -148,7 +148,7 @@
 {
 	TRACE_FUN(ft_t_flow);
 
-#if defined(CONFIG_PROC_FS) && defined(CONFIG_FT_PROC_FS)
+#if defined(CONFIG_PROC_FS) && defined(CONFIG_FT_PROC_FS) && defined(MODULE)
 	ftape_proc_destroy();
 #endif
 	(void)ftape_set_nr_buffers(0);


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

