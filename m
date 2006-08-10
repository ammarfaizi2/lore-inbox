Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWHJUOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWHJUOd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbWHJTgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:06 -0400
Received: from mx1.suse.de ([195.135.220.2]:14736 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932343AbWHJTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:34 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [20/145] x86_64: make functions static
Message-Id: <20060810193533.25CF013B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:33 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Adrian Bunk <bunk@stusta.de>

This patch makes the following needlessly global functions static:
- nmi_int.c: profile_exceptions_notify()
- nmi_timer_int.c: profile_timer_exceptions_notify()

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/i386/oprofile/nmi_int.c       |    4 ++--
 arch/i386/oprofile/nmi_timer_int.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: linux/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux.orig/arch/i386/oprofile/nmi_int.c
+++ linux/arch/i386/oprofile/nmi_int.c
@@ -83,8 +83,8 @@ static void exit_driverfs(void)
 #define exit_driverfs() do { } while (0)
 #endif /* CONFIG_PM */
 
-int profile_exceptions_notify(struct notifier_block *self,
-				unsigned long val, void *data)
+static int profile_exceptions_notify(struct notifier_block *self,
+				     unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;
Index: linux/arch/i386/oprofile/nmi_timer_int.c
===================================================================
--- linux.orig/arch/i386/oprofile/nmi_timer_int.c
+++ linux/arch/i386/oprofile/nmi_timer_int.c
@@ -19,8 +19,8 @@
 #include <asm/ptrace.h>
 #include <asm/kdebug.h>
  
-int profile_timer_exceptions_notify(struct notifier_block *self,
-				unsigned long val, void *data)
+static int profile_timer_exceptions_notify(struct notifier_block *self,
+					   unsigned long val, void *data)
 {
 	struct die_args *args = (struct die_args *)data;
 	int ret = NOTIFY_DONE;
