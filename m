Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267279AbSLEKrR>; Thu, 5 Dec 2002 05:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbSLEKqK>; Thu, 5 Dec 2002 05:46:10 -0500
Received: from holomorphy.com ([66.224.33.161]:43145 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267274AbSLEKqD>;
	Thu, 5 Dec 2002 05:46:03 -0500
Date: Thu, 05 Dec 2002 02:52:59 -0800
From: wli@holomorphy.com
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net,
       rmk@arm.linux.org.uk, jgarzik@pobox.com, miura@da-cha.org,
       alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, pavel@ucw.cz
Subject: [warnings] [3/8] fix duplicate decls in swsusp
Message-ID: <0212050252.uaQcrdGaYaObsdBcOaucHaoa5dScKaTa20143@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212050252.AaCdAbid6d9cabJbEbmaTdZb7daa.c5a20143@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the reboot.h declaration of swsusp functions that clash
with the no-op inline. Already acked by pavel.

===== include/linux/reboot.h 1.2 vs edited =====
--- 1.2/include/linux/reboot.h	Thu May  2 17:21:36 2002
+++ edited/include/linux/reboot.h	Thu Dec  5 01:05:34 2002
@@ -48,13 +48,6 @@
 extern void machine_halt(void);
 extern void machine_power_off(void);
 
-/*
- * Architecture-independent suspend facility
- */
-
-extern void software_suspend(void);
-extern unsigned char software_suspend_enabled;
-
 #endif
 
 #endif /* _LINUX_REBOOT_H */
===== kernel/sys.c 1.36 vs edited =====
--- 1.36/kernel/sys.c	Wed Nov 27 15:13:29 2002
+++ edited/kernel/sys.c	Thu Dec  5 01:06:10 2002
@@ -21,6 +21,7 @@
 #include <linux/times.h>
 #include <linux/security.h>
 #include <linux/dcookies.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
