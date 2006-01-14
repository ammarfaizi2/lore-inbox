Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWANSSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWANSSh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 13:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWANSSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 13:18:37 -0500
Received: from mo00.po.2iij.Net ([210.130.202.204]:40385 "EHLO
	mo00.po.2iij.net") by vger.kernel.org with ESMTP id S1750744AbWANSSg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 13:18:36 -0500
Date: Sun, 15 Jan 2006 03:18:27 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [-mm PATCH] mips: add pm_power_off
Message-Id: <20060115031828.0b5fda9f.yoichi_yuasa@tripeaks.co.jp>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds pm_power_off() to MIPS.
This patch exists only for 2.6.15-mm4.

Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>

diff -Npru -X dontdiff mm4-orig/arch/mips/kernel/reset.c mm4/arch/mips/kernel/reset.c
--- mm4-orig/arch/mips/kernel/reset.c	2006-01-03 12:21:10.000000000 +0900
+++ mm4/arch/mips/kernel/reset.c	2006-01-15 02:44:26.000000000 +0900
@@ -12,6 +12,9 @@
 #include <linux/reboot.h>
 #include <asm/reboot.h>
 
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
 /*
  * Urgs ...  Too many MIPS machines to handle this in a generic way.
  * So handle all using function pointers to machine specific
@@ -33,6 +36,9 @@ void machine_halt(void)
 
 void machine_power_off(void)
 {
+	if (pm_power_off)
+		pm_power_off();
+
 	_machine_power_off();
 }
 




