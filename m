Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932629AbWHALJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbWHALJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932663AbWHALG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:59 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:5840 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932661AbWHALGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:47 -0400
Date: Tue, 1 Aug 2006 07:00:59 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: remove lock prefix from is_at_popf() tests
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608010703_MC3-1-C6B1-9266@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The lock prefix will cause an exception when used with the
popf instruction, so no need to continue searching after it's
found.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc3-64.orig/arch/x86_64/kernel/ptrace.c
+++ 2.6.18-rc3-64/arch/x86_64/kernel/ptrace.c
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
-- 
Chuck
