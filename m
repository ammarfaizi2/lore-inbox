Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUDQFmT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbUDQFmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:42:18 -0400
Received: from holomorphy.com ([207.189.100.168]:32137 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262794AbUDQFk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:40:58 -0400
Date: Fri, 16 Apr 2004 22:40:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [5/5] sparc32 stack bounds checking
Message-ID: <20040417054057.GA743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040417053538.GA20534@holomorphy.com> <20040417053712.GW743@holomorphy.com> <20040417053805.GX743@holomorphy.com> <20040417053905.GY743@holomorphy.com> <20040417053957.GZ743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417053957.GZ743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: wli-2.6.5-mm6/arch/sparc/kernel/process.c
===================================================================
--- wli-2.6.5-mm6.orig/arch/sparc/kernel/process.c	2004-04-14 23:21:03.000000000 -0700
+++ wli-2.6.5-mm6/arch/sparc/kernel/process.c	2004-04-16 10:38:51.000000000 -0700
@@ -318,7 +318,7 @@
 	fp = (unsigned long) _ksp;
 	do {
 		/* Bogus frame pointer? */
-		if (fp < (task_base + sizeof(struct task_struct)) ||
+		if (fp < (task_base + sizeof(struct thread_info)) ||
 		    fp >= (task_base + (PAGE_SIZE << 1)))
 			break;
 		rw = (struct reg_window *) fp;
@@ -710,7 +710,7 @@
 	fp = task->thread_info->ksp + bias;
 	do {
 		/* Bogus frame pointer? */
-		if (fp < (task_base + sizeof(struct task_struct)) ||
+		if (fp < (task_base + sizeof(struct thread_info)) ||
 		    fp >= (task_base + (2 * PAGE_SIZE)))
 			break;
 		rw = (struct reg_window *) fp;
