Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVCOWkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVCOWkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 17:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVCOWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 17:37:17 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:23054 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261961AbVCOWfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 17:35:54 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][alpha] "pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!
Date: Tue, 15 Mar 2005 23:35:48 +0100
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EN2NCyKmQ47i/az"
Message-Id: <200503152335.48995.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_EN2NCyKmQ47i/az
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



--Boundary-00=_EN2NCyKmQ47i/az
Content-Type: text/x-diff;
  charset="utf-8";
  name="alpha-pm_power_off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alpha-pm_power_off.patch"

Fix for modpost warning:
"pm_power_off" [drivers/char/ipmi/ipmi_poweroff.ko] undefined!

--- linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c.orig	2005-03-13 07:44:05.000000000 +0100
+++ linux-2.6.11.3/arch/alpha/kernel/alpha_ksyms.c	2005-03-15 23:20:00.405832368 +0100
@@ -67,6 +67,9 @@
 EXPORT_SYMBOL(alpha_using_srm);
 #endif /* CONFIG_ALPHA_GENERIC */
 
+#include <linux/pm.h>
+EXPORT_SYMBOL(pm_power_off);
+
 /* platform dependent support */
 EXPORT_SYMBOL(strcat);
 EXPORT_SYMBOL(strcmp);
--- linux-2.6.11.3/arch/alpha/kernel/process.c.orig	2005-03-13 07:44:40.000000000 +0100
+++ linux-2.6.11.3/arch/alpha/kernel/process.c	2005-03-15 23:28:15.687538104 +0100
@@ -183,6 +183,8 @@
 
 EXPORT_SYMBOL(machine_power_off);
 
+void (*pm_power_off)(void) = machine_power_off;
+
 /* Used by sysrq-p, among others.  I don't believe r9-r15 are ever
    saved in the context it's used.  */
 

--Boundary-00=_EN2NCyKmQ47i/az--
