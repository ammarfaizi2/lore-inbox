Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267594AbUHTSkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267594AbUHTSkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 14:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266925AbUHTSdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 14:33:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4002 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267594AbUHTSXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 14:23:37 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 13/14]: kexec: use_mm
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Aug 2004 12:22:19 -0600
Message-ID: <m1oel54qlg.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ppc port sets of init_mm ahead of time to hold an identity
mapped page.  This makes use_mm non-static so they don't
have to reinvent the wheel.

diff -uNr linux-2.6.8.1-mm2-kexec.i386/fs/aio.c linux-2.6.8.1-mm2-use_mm/fs/aio.c
--- linux-2.6.8.1-mm2-kexec.i386/fs/aio.c	Fri Aug 20 09:56:39 2004
+++ linux-2.6.8.1-mm2-use_mm/fs/aio.c	Fri Aug 20 11:22:01 2004
@@ -565,7 +565,7 @@
  *	(Note: this routine is intended to be called only
  *	from a kernel thread context)
  */
-static void use_mm(struct mm_struct *mm)
+void use_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
