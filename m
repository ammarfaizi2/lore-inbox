Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263746AbUDPVJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUDPVJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:09:27 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:45470 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263746AbUDPVJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:09:26 -0400
Date: Fri, 16 Apr 2004 22:08:28 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       mingo@redhat.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix __exit_mm() dereference before check.
Message-ID: <20040416210828.GK20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a quick look, it appears passing NULL mm's down to mm_release()
isn't a good idea.

		Dave


--- linux-2.6.5/kernel/exit.c~	2004-04-16 22:06:00.000000000 +0100
+++ linux-2.6.5/kernel/exit.c	2004-04-16 22:06:51.000000000 +0100
@@ -482,9 +482,10 @@
 {
 	struct mm_struct *mm = tsk->mm;
 
-	mm_release(tsk, mm);
 	if (!mm)
 		return;
+	mm_release(tsk, mm);
+
 	/*
 	 * Serialize with any possible pending coredump.
 	 * We must hold mmap_sem around checking core_waiters
