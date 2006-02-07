Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWBGCXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWBGCXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWBGCWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:22:53 -0500
Received: from [198.99.130.12] ([198.99.130.12]:18923 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964941AbWBGCWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:22:48 -0500
Message-Id: <200602070224.k172O384009674@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 6/8] UML - Block SIGWINCH in ptrace tester child
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Feb 2006 21:24:03 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The process that UML uses to probe the host's ptrace capabilities can (rarely)
receive a SIGWINCH, confusing the parent.  This fixes that by blocking 
SIGWINCH.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/start_up.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/start_up.c	2006-02-06 17:36:29.000000000 -0500
@@ -49,6 +49,7 @@ static int ptrace_child(void *arg)
 	int pid = os_getpid(), ppid = getppid();
 	int sc_result;
 
+	change_sig(SIGWINCH, 0);
 	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
 		perror("ptrace");
 		os_kill_process(pid, 0);

