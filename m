Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVAMTnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVAMTnQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVAMTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:42:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.190]:13554 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261444AbVAMTmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:42:37 -0500
From: Christian Borntraeger <cborntra@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] reintroduce EXPORT_SYMBOL(task_nice) for binfmt_elf32
Date: Thu, 13 Jan 2005 20:42:30 +0100
User-Agent: KMail/1.7.1
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501132042.31215.cborntra@de.ibm.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building an s390x kernel with binfmt_elf32 as a module, I get the following 
errors: 
*** Warning: "task_nice" [arch/s390/kernel/binfmt_elf32.ko] undefined!
*** Warning: "arch_pick_mmap_layout" [arch/s390/kernel/binfmt_elf32.ko] 
undefined!


IIRC 2.6.8 did not show this problem. Therefore I suggest to revert the 
removal of the EXPORT_SYMBOL(task_nice). The rationale for removing the 
export was the fact, that binfmt_elf is no longer modular. Unfortunately 
that is not true in the emulation case on s390 and (untested) sparc64. 

If there are no objections, please apply. 

--- a/kernel/sched.c	2005-01-12 01:42:35 +01:00
+++ b/kernel/sched.c	2005-01-12 23:25:22 +01:00
@@ -3187,6 +3187,8 @@
 	return TASK_NICE(p);
 }
 
+EXPORT_SYMBOL(task_nice);
+
 /**
  * idle_cpu - is a given cpu idle currently?
  * @cpu: the processor in question.
