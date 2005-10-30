Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932730AbVJ3BCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932730AbVJ3BCG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbVJ3BCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:02:06 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21770 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932730AbVJ3BCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:02:01 -0400
Date: Sun, 30 Oct 2005 02:02:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dwmw2@infradead.org,
       linux-audit@redhat.com, faith@redhat.com, george@mvista.com,
       netdev@vger.kernel.org
Subject: [2.6 patch] kernel/: small cleanups
Message-ID: <20051030010200.GT4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- every file should include the headers containing the prototypes for
  it's global functions


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/audit.c      |    2 +-
 kernel/irq/proc.c   |    2 ++
 kernel/rcutorture.c |    2 +-
 kernel/timer.c      |    1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc5-mm1-full/kernel/timer.c.old	2005-10-30 02:27:36.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/kernel/timer.c	2005-10-30 02:27:56.000000000 +0200
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/delay.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
--- linux-2.6.14-rc5-mm1-full/kernel/irq/proc.c.old	2005-10-30 02:31:31.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/kernel/irq/proc.c	2005-10-30 02:31:48.000000000 +0200
@@ -10,6 +10,8 @@
 #include <linux/proc_fs.h>
 #include <linux/interrupt.h>
 
+#include "internals.h"
+
 static struct proc_dir_entry *root_irq_dir, *irq_dir[NR_IRQS];
 
 #ifdef CONFIG_SMP
--- linux-2.6.14-rc5-mm1-full/kernel/audit.c.old	2005-10-30 02:33:08.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/kernel/audit.c	2005-10-30 02:33:15.000000000 +0200
@@ -272,7 +272,7 @@
 	return old;
 }
 
-int kauditd_thread(void *dummy)
+static int kauditd_thread(void *dummy)
 {
 	struct sk_buff *skb;
 
--- linux-2.6.14-rc5-mm1-full/kernel/rcutorture.c.old	2005-10-30 02:33:35.000000000 +0200
+++ linux-2.6.14-rc5-mm1-full/kernel/rcutorture.c	2005-10-30 02:33:53.000000000 +0200
@@ -99,7 +99,7 @@
 /*
  * Allocate an element from the rcu_tortures pool.
  */
-struct rcu_torture *
+static struct rcu_torture *
 rcu_torture_alloc(void)
 {
 	struct list_head *p;

