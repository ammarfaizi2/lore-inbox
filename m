Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266081AbTBLDuF>; Tue, 11 Feb 2003 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266116AbTBLDuF>; Tue, 11 Feb 2003 22:50:05 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:63417 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S266081AbTBLDuE>;
	Tue, 11 Feb 2003 22:50:04 -0500
Date: Wed, 12 Feb 2003 14:59:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] apm daemonize
Message-Id: <20030212145930.631416b9.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Since daemonize now blocks all signals, this should be trivially
correct.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.60-200302121204/arch/i386/kernel/apm.c 2.5.60-200302121204-apm.1/arch/i386/kernel/apm.c
--- 2.5.60-200302121204/arch/i386/kernel/apm.c	2003-02-12 14:11:04.000000000 +1100
+++ 2.5.60-200302121204-apm.1/arch/i386/kernel/apm.c	2003-02-12 14:57:15.000000000 +1100
@@ -1745,7 +1745,6 @@
 	daemonize("kapmd");
 
 	current->flags |= PF_IOTHREAD;
-	sigfillset(&current->blocked);
 
 #ifdef CONFIG_SMP
 	/* 2002/08/01 - WT
