Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUDPU5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUDPU4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:56:16 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:10910 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263731AbUDPUz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:55:26 -0400
Date: Fri, 16 Apr 2004 21:54:30 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix mprotect bogus check.
Message-ID: <20040416205430.GI20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to trap NULL vma's, we'd better be sure
that we don't dereference it first..

		Dave

--- linux-2.6.5/mm/mprotect.c~	2004-04-16 21:52:47.000000000 +0100
+++ linux-2.6.5/mm/mprotect.c	2004-04-16 21:53:12.000000000 +0100
@@ -114,10 +114,11 @@
 mprotect_attempt_merge(struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long end, int newflags)
 {
-	struct mm_struct * mm = vma->vm_mm;
+	struct mm_struct * mm;
 
 	if (!prev || !vma)
 		return 0;
+	mm = vma->vm_mm;
 	if (prev->vm_end != vma->vm_start)
 		return 0;
 	if (!can_vma_merge(prev, newflags))
