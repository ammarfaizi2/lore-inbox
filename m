Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUDQFiT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 01:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263721AbUDQFiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 01:38:18 -0400
Received: from holomorphy.com ([207.189.100.168]:30601 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263709AbUDQFiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 01:38:14 -0400
Date: Fri, 16 Apr 2004 22:38:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [2/5] m68k stack bounds checking
Message-ID: <20040417053805.GX743@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040417053538.GA20534@holomorphy.com> <20040417053712.GW743@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417053712.GW743@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: wli-2.6.5-mm6/arch/m68k/kernel/process.c
===================================================================
--- wli-2.6.5-mm6.orig/arch/m68k/kernel/process.c	2004-04-14 23:21:02.000000000 -0700
+++ wli-2.6.5-mm6/arch/m68k/kernel/process.c	2004-04-16 10:41:07.000000000 -0700
@@ -392,7 +392,7 @@
 	stack_page = (unsigned long)(p->thread_info);
 	fp = ((struct switch_stack *)p->thread.ksp)->a6;
 	do {
-		if (fp < stack_page+sizeof(struct task_struct) ||
+		if (fp < stack_page+sizeof(struct thread_info) ||
 		    fp >= 8184+stack_page)
 			return 0;
 		pc = ((unsigned long *)fp)[1];
