Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932675AbWHJUEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbWHJUEO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWHJUD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:03:57 -0400
Received: from ns2.suse.de ([195.135.220.15]:60651 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932639AbWHJTgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:45 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [87/145] x86_64: remove lock prefix from is_at_popf() tests
Message-Id: <20060810193644.54A7A13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:44 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Chuck Ebbert <76306.1226@compuserve.com>
The lock prefix will cause an exception when used with the
popf instruction, so no need to continue searching after it's
found.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/ptrace.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/ptrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/ptrace.c
+++ linux/arch/x86_64/kernel/ptrace.c
@@ -138,7 +138,7 @@ static int is_at_popf(struct task_struct
 		case 0x26: case 0x2e:
 		case 0x36: case 0x3e:
 		case 0x64: case 0x65:
-		case 0xf0: case 0xf2: case 0xf3:
+		case 0xf2: case 0xf3:
 			continue;
 
 		case 0x40 ... 0x4f:
@@ -148,7 +148,7 @@ static int is_at_popf(struct task_struct
 			/* 64-bit mode: REX prefix */
 			continue;
 
-			/* CHECKME: f0, f2, f3 */
+			/* CHECKME: f2, f3 */
 
 		/*
 		 * pushf: NOTE! We should probably not let
