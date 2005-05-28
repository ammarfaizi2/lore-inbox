Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVE1XQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVE1XQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 19:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVE1XQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 19:16:37 -0400
Received: from coderock.org ([193.77.147.115]:22918 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261193AbVE1XQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 19:16:35 -0400
Message-Id: <20050528231627.776377000@nd47.coderock.org>
Date: Sun, 29 May 2005 01:16:28 +0200
From: domen@coderock.org
To: ysato@users.sourceforge.jp
Cc: linux-kernel@vger.kernel.org, domen@coderock.org
Subject: [patch 1/1] ptrace_h8300: condition bugfix
Content-Disposition: inline; filename=condition_assignment-arch_h8300_platform_h8300h_ptrace_h8300h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>


Assignment doesn't make much sense here as condition would always be
true.


Signed-off-by: Domen Puncer <domen@coderock.org>

---
 ptrace_h8300h.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/arch/h8300/platform/h8300h/ptrace_h8300h.c
===================================================================
--- quilt.orig/arch/h8300/platform/h8300h/ptrace_h8300h.c
+++ quilt/arch/h8300/platform/h8300h/ptrace_h8300h.c
@@ -245,12 +245,12 @@ static unsigned short *getnextpc(struct 
 						addr = h8300_get_reg(child, regno-1+PT_ER1);
 					return (unsigned short *)addr;
 				case relb:
-					if ((inst = 0x55) || isbranch(child,inst & 0x0f))
+					if (inst == 0x55 || isbranch(child,inst & 0x0f))
 						pc = (unsigned short *)((unsigned long)pc +
 								       ((signed char)(*fetch_p)));
 					return pc+1; /* skip myself */
 				case relw:
-					if ((inst = 0x5c) || isbranch(child,(*fetch_p & 0xf0) >> 4))
+					if (inst == 0x5c || isbranch(child,(*fetch_p & 0xf0) >> 4))
 						pc = (unsigned short *)((unsigned long)pc +
 								       ((signed short)(*(pc+1))));
 					return pc+2; /* skip myself */

--
