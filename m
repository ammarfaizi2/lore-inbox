Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267098AbUBSCZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 21:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUBSCZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 21:25:54 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:32896 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S267098AbUBSCZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 21:25:52 -0500
Date: Thu, 19 Feb 2004 03:25:46 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: uclinux-v850@lsi.nec.co.jp
Cc: linux-kernel@vger.kernel.org
Subject: v850 ptrace.c bug ...
Message-ID: <20040219022546.GA16742@MAIL.13thfloor.at>
Mail-Followup-To: uclinux-v850@lsi.nec.co.jp,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

stumbled over the following bug: 

sys_ptrace() for v850, if pid == 1, doesn't put the
struct task_struct (child), the following patch
should fix that ...

best,
Herbert

--- linux-2.6.3/arch/v850/kernel/ptrace.c.orig	2004-02-18 04:58:01.000000000 +0100
+++ linux-2.6.3/arch/v850/kernel/ptrace.c	2004-02-19 03:02:43.000000000 +0100
@@ -138,7 +138,7 @@ int sys_ptrace(long request, long pid, l
 
 	rval = -EPERM;
 	if (pid == 1)		/* you may not mess with init */
-		goto out;
+		goto out_tsk;
 
 	if (request == PTRACE_ATTACH) {
 		rval = ptrace_attach(child);

