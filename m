Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263237AbTJBEmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 00:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTJBEmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 00:42:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:40404 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263237AbTJBEmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 00:42:20 -0400
Date: Wed, 1 Oct 2003 21:41:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] export [__]set_special_pids()
Message-Id: <20031001214132.5070b6b5.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply to 2.6.0-test6.

Fixes http://bugme.osdl.org/show_bug.cgi?id=1231

--
~Randy


patch_name:	set_spec_pids.patch
patch_version:	2003-10-01.21:36:33
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	EXPORT [__]set_special_pids(); Ingo added these
		in include/linux/sched.h but didn't export them;
		jffs uses set_special_pids();
		(kills bug #1231)
product:	Linux
product_versions: 2.6.0-test6
diffstat:	=
 kernel/exit.c |    4 ++++
 1 files changed, 4 insertions(+)


diff -Naur ./kernel/exit.c~sspids ./kernel/exit.c
--- ./kernel/exit.c~sspids	2003-09-27 17:50:54.000000000 -0700
+++ ./kernel/exit.c	2003-10-01 21:32:45.000000000 -0700
@@ -254,6 +254,8 @@
 	}
 }
 
+EXPORT_SYMBOL(__set_special_pids);
+
 void set_special_pids(pid_t session, pid_t pgrp)
 {
 	write_lock_irq(&tasklist_lock);
@@ -261,6 +263,8 @@
 	write_unlock_irq(&tasklist_lock);
 }
 
+EXPORT_SYMBOL(set_special_pids);
+
 /*
  * Let kernel threads use this to say that they
  * allow a certain signal (since daemonize() will
