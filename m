Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVGKAMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVGKAMk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 20:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVGKAKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 20:10:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:55442 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261195AbVGJTfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:35:15 -0400
Date: Sun, 10 Jul 2005 19:35:14 +0000
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/82] remove linux/version.h include from arch/ppc
Message-ID: <20050710193514.6.ltcoQv2417.2247.olh@nectarine.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
In-Reply-To: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


changing CONFIG_LOCALVERSION rebuilds too much, for no appearent reason.

use system_utsname for CONFIG_BOOTX_TEXT welcome message

Signed-off-by: Olaf Hering <olh@suse.de>

arch/ppc/syslib/btext.c     |    6 ++++--
arch/ppc/syslib/prom.c      |    1 -
arch/ppc/syslib/prom_init.c |    1 -
3 files changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/btext.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/btext.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/btext.c
@@ -7,7 +7,7 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
+#include <linux/utsname.h>

#include <asm/sections.h>
#include <asm/bootx.h>
@@ -81,7 +81,9 @@ btext_welcome(void)
unsigned long pvr;
boot_infos_t* bi = &disp_bi;

-	btext_drawstring("Welcome to Linux, kernel " UTS_RELEASE "n");
+	btext_drawstring("Welcome to Linux, kernel ");
+	btext_drawstring(system_utsname.version);
+	btext_drawstring("n");
btext_drawstring("nlinked at        : 0x");
btext_drawhex(KERNELBASE);
btext_drawstring("nframe buffer at  : 0x");
Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/prom.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom.c
@@ -13,7 +13,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/ioport.h>
Index: linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom_init.c
===================================================================
--- linux-2.6.13-rc2-mm1.orig/arch/ppc/syslib/prom_init.c
+++ linux-2.6.13-rc2-mm1/arch/ppc/syslib/prom_init.c
@@ -9,7 +9,6 @@
#include <linux/kernel.h>
#include <linux/string.h>
#include <linux/init.h>
-#include <linux/version.h>
#include <linux/threads.h>
#include <linux/spinlock.h>
#include <linux/ioport.h>
