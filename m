Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTJUPF7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTJUPF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:05:59 -0400
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:32924 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263117AbTJUPF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:05:56 -0400
Date: Tue, 21 Oct 2003 17:06:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/8): base fixes.
Message-ID: <20031021150617.GB1457@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add console_unblank in machine_{restart,halt,power_off} to get
   all messages on the screen.
 - Fix write_trylock for 64 bit.

diffstat:
 arch/s390/kernel/setup.c    |    3 +++
 include/asm-s390/spinlock.h |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-s390/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	Fri Oct 17 23:42:54 2003
+++ linux-2.6-s390/arch/s390/kernel/setup.c	Tue Oct 21 16:36:07 2003
@@ -287,6 +287,7 @@
 
 void machine_restart(char *command)
 {
+	console_unblank();
 	_machine_restart(command);
 }
 
@@ -294,6 +295,7 @@
 
 void machine_halt(void)
 {
+	console_unblank();
 	_machine_halt();
 }
 
@@ -301,6 +303,7 @@
 
 void machine_power_off(void)
 {
+	console_unblank();
 	_machine_power_off();
 }
 
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-s390/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	Fri Oct 17 23:43:47 2003
+++ linux-2.6-s390/include/asm-s390/spinlock.h	Tue Oct 21 16:36:07 2003
@@ -217,7 +217,7 @@
 
 extern inline int _raw_write_trylock(rwlock_t *rw)
 {
-	unsigned int result, reg;
+	unsigned long result, reg;
 	
 	__asm__ __volatile__(
 #ifndef __s390x__
