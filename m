Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVALTck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVALTck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 14:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVALTam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 14:30:42 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37044 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261351AbVALTZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 14:25:51 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: Remove mandatory single-step debugging diversion
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 12 Jan 2005 19:25:39 +0000
Message-ID: <16066.1105557939@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes the mandatory single-step diversion code from the
FRV syscall handler that was put there for debugging purposes now that it's no
longer needed.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 frv-trace-2611rc1.diff 
 arch/frv/kernel/entry.S |    2 --
 1 files changed, 2 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.11-rc1/arch/frv/kernel/entry.S linux-2.6.11-rc1-frv/arch/frv/kernel/entry.S
--- /warthog/kernels/linux-2.6.11-rc1/arch/frv/kernel/entry.S	2005-01-12 19:08:31.000000000 +0000
+++ linux-2.6.11-rc1-frv/arch/frv/kernel/entry.S	2005-01-12 19:12:00.125483158 +0000
@@ -821,7 +821,6 @@ system_call:
 	ori		gr4,#_TIF_SYSCALL_TRACE,gr4
 	andicc		gr4,#_TIF_SYSCALL_TRACE,gr0,icc0
 	bne		icc0,#0,__syscall_trace_entry
-	bra		__syscall_trace_entry
 
 __syscall_call:
 	slli.p		gr7,#2,gr7
@@ -858,7 +857,6 @@ __syscall_exit:
 	movgs		gr23,psr
 
 	ldi		@(gr15,#TI_FLAGS),gr4
-//	ori		gr4,#_TIF_SYSCALL_TRACE,gr4		/////////////////////////////////
 	sethi.p		%hi(_TIF_ALLWORK_MASK),gr5
 	setlo		%lo(_TIF_ALLWORK_MASK),gr5
 	andcc		gr4,gr5,gr0,icc0
