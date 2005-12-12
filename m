Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVLLPxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVLLPxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 10:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVLLPxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 10:53:05 -0500
Received: from adsl-80.mirage.euroweb.hu ([193.226.228.80]:528 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932067AbVLLPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 10:53:04 -0500
To: akpm@osdl.org
CC: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml: fix pm_power_off link failure
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1ElpZn-0005pw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 Dec 2005 16:26:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

please scrap my the previous pm_power_off fix, it didn't work out.
This just fixes UML:

  LD      .tmp_vmlinux1
kernel/built-in.o(.text+0x148e1): In function `sys_reboot':
kernel/sys.c:535: undefined reference to `pm_power_off'

On uml machine_halt() just calls machine_power_off() so it's safe to
leave pm_power_off as NULL.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/arch/um/kernel/reboot.c
===================================================================
--- linux.orig/arch/um/kernel/reboot.c	2005-10-28 02:02:08.000000000 +0200
+++ linux/arch/um/kernel/reboot.c	2005-12-12 16:10:16.000000000 +0100
@@ -12,6 +12,8 @@
 #include "mode.h"
 #include "choose-mode.h"
 
+void (*pm_power_off)(void);
+
 #ifdef CONFIG_SMP
 static void kill_idlers(int me)
 {

