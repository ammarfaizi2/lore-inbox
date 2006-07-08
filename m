Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWGHUUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWGHUUm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030339AbWGHUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:20:42 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58631 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030333AbWGHUUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:20:30 -0400
Date: Sat, 8 Jul 2006 22:20:30 +0200
From: Adrian Bunk <bunk@stusta.de>
To: norsk5@xmission.com
Cc: bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/edac/edac_mc.h must #include <linux/platform_device.h>
Message-ID: <20060708202030.GG5020@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error with CONFIG_PCI=n:

<--  snip  -->

...
  CC      drivers/edac/edac_mc.o
drivers/edac/edac_mc.c: In function ‘add_mc_to_global_list’:
drivers/edac/edac_mc.c:1362: error: implicit declaration of function ‘to_platform_device’
drivers/edac/edac_mc.c:1362: error: invalid type argument of ‘->’
drivers/edac/edac_mc.c: In function ‘edac_mc_add_mc’:
drivers/edac/edac_mc.c:1467: error: invalid type argument of ‘->’
drivers/edac/edac_mc.c: In function ‘edac_mc_del_mc’:
drivers/edac/edac_mc.c:1504: error: invalid type argument of ‘->’
make[2]: *** [drivers/edac/edac_mc.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm6-full/drivers/edac/edac_mc.h.old	2006-07-08 18:06:48.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/edac/edac_mc.h	2006-07-08 18:07:04.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/rcupdate.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
+#include <linux/platform_device.h>
 
 #define EDAC_MC_LABEL_LEN	31
 #define MC_PROC_NAME_MAX_LEN 7

