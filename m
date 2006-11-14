Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965888AbWKNQIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965888AbWKNQIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933449AbWKNQIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:08:54 -0500
Received: from ns2.suse.de ([195.135.220.15]:25485 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933448AbWKNQIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:08:54 -0500
From: Andi Kleen <ak@suse.de>
References: <20061114508.445749000@suse.de>
In-Reply-To: <20061114508.445749000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH for 2.6.19] [2/9] x86_64: Fix PTRACE_[SG]ET_THREAD_AREA regression with ia32 emulation.
Message-Id: <20061114160852.9074E13C98@wotan.suse.de>
Date: Tue, 14 Nov 2006 17:08:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ptrace(PTRACE_[SG]ET_THREAD_AREA) calls from ia32 code
should be passed onto the x86_64 implementation.

The default case in sys32_ptrace used to call to sys_ptrace(), but is 
now EINVAL.  This patch fixes a regression caused by that changed.

Signed-off-by: Mike McCormack <mike@codeweavers.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/ia32/ptrace32.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux/arch/x86_64/ia32/ptrace32.c
===================================================================
--- linux.orig/arch/x86_64/ia32/ptrace32.c
+++ linux/arch/x86_64/ia32/ptrace32.c
@@ -244,6 +244,8 @@ asmlinkage long sys32_ptrace(long reques
 	case PTRACE_DETACH:
 	case PTRACE_SYSCALL:
 	case PTRACE_SETOPTIONS:
+	case PTRACE_SET_THREAD_AREA:
+	case PTRACE_GET_THREAD_AREA:
 		return sys_ptrace(request, pid, addr, data); 
 
 	default:
