Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVHAV42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVHAV42 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAVyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:54:04 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53001 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261310AbVHAVxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:53:52 -0400
Date: Mon, 1 Aug 2005 23:53:48 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386: fix incorrect TSS entry for LDT
Message-ID: <20050801215348.GE4268@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

noticed by Chuck Ebbert: the .ldt entry of the TSS was set up
incorrectly. It never mattered since this was a leftover from
old times, so remove it.


From: Ingo Molnar <mingo@elte.hu>

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was sent by Ingo Molnar on:
- 1 Jul 2005

--- linux.orig/include/asm-i386/processor.h
+++ linux/include/asm-i386/processor.h
@@ -474,7 +474,6 @@ struct thread_struct {
 	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
 	.ss0		= __KERNEL_DS,					\
 	.ss1		= __KERNEL_CS,					\
-	.ldt		= GDT_ENTRY_LDT,				\
 	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
 	.io_bitmap	= { [ 0 ... IO_BITMAP_LONGS] = ~0 },		\
 }
k
