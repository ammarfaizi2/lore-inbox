Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIAQVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIAQVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIAP5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 11:57:09 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:65458 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S267335AbUIAPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 11:51:45 -0400
Date: Wed, 1 Sep 2004 16:51:22 +0100
Message-Id: <200409011551.i81FpMhd000665@delerium.codemonkey.org.uk>
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Check find_vma return code in make_pages_present()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It can return NULL, so check for it.

Spotted with the source checker from Coverity.com.

Signed-off-by: Dave Jones <davej@redhat.com>


diff -urpN --exclude-from=/home/davej/.exclude bk-linus/mm/memory.c linux-2.6/mm/memory.c
--- bk-linus/mm/memory.c	2004-08-24 00:02:41.000000000 +0100
+++ linux-2.6/mm/memory.c	2004-09-01 13:31:18.000000000 +0100
@@ -1744,6 +1744,8 @@ int make_pages_present(unsigned long add
 	struct vm_area_struct * vma;
 
 	vma = find_vma(current->mm, addr);
+	if (!vma)
+		return -1;
 	write = (vma->vm_flags & VM_WRITE) != 0;
 	if (addr >= end)
 		BUG();
