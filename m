Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVAPUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVAPUhE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262593AbVAPUhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:37:03 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:20538 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262585AbVAPUgp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:36:45 -0500
Date: Sun, 16 Jan 2005 21:36:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] arch/i386/kernel/signal.o: sparse: cast remove address space ...
Message-ID: <20050116203642.GA13016@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning: cast removes address space of expression
Fixed by declaring relevant pointers in sigframe and rt_sigframe as
__user.
This fixes several sparse warnings in arch/i386/kernel/signal.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

===== arch/i386/kernel/sigframe.h 1.1 vs edited =====
--- 1.1/arch/i386/kernel/sigframe.h	2003-05-04 07:45:16 +02:00
+++ edited/arch/i386/kernel/sigframe.h	2005-01-16 21:29:47 +01:00
@@ -1,6 +1,6 @@
 struct sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
 	struct sigcontext sc;
 	struct _fpstate fpstate;
@@ -10,10 +10,10 @@
 
 struct rt_sigframe
 {
-	char *pretcode;
+	char __user *pretcode;
 	int sig;
-	struct siginfo *pinfo;
-	void *puc;
+	struct siginfo __user *pinfo;
+	void __user *puc;
 	struct siginfo info;
 	struct ucontext uc;
 	struct _fpstate fpstate;

