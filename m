Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSAUABT>; Sun, 20 Jan 2002 19:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288974AbSAUABJ>; Sun, 20 Jan 2002 19:01:09 -0500
Received: from zero.tech9.net ([209.61.188.187]:15882 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288973AbSAUAA5>;
	Sun, 20 Jan 2002 19:00:57 -0500
Subject: [PATCH] O(1) scheduler: asm offset changed
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 20 Jan 2002 19:05:11 -0500
Message-Id: <1011571512.17096.371.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo's O(1) scheduler moved the location of the processor entry in
task_struct (and also renamed it cpu).  The hard coded offsets in
entry.S, however, were not updated.

This patch, against 2.5.3-pre2 + J2, sets the correct offset and renames
processor to cpu.

Note that nothing actually uses these offsets :-) at the moment but code
used to and may again.  Most importantly, preempt-kernel does!

Thanks,

	Robert Love

--- linux-2.5.3-pre2-ingo-J2/arch/i386/kernel/entry.S	Sun Jan 20 18:50:45 2002
+++ linux/arch/i386/kernel/entry.S	Sun Jan 20 18:50:48 2002@@ -77,7 +77,7 @@
 exec_domain	= 16
 need_resched	= 20
 tsk_ptrace	= 24
-processor	= 52
+cpu		= 32
 
 ENOSYS = 38

