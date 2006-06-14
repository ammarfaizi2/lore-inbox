Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbWFNOWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWFNOWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWFNOWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:22:19 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:40801 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S964968AbWFNOWS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:22:18 -0400
Date: Wed, 14 Jun 2006 16:22:04 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch 6/8] lock validator: __local_bh_enable -> _local_bh_enable
Message-ID: <20060614142204.GG1241@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Add EXPORT_SYMBOL for _local_bh_enable and convert s390 usages of
__local_bh_enable() to _local_bh_enable().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/irq.c   |    2 +-
 drivers/s390/char/sclp.c |    2 +-
 drivers/s390/cio/cio.c   |    2 +-
 kernel/softirq.c         |    2 ++
 4 files changed, 5 insertions(+), 3 deletions(-)

diff -purN a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
--- a/arch/s390/kernel/irq.c	2006-06-06 02:57:02.000000000 +0200
+++ b/arch/s390/kernel/irq.c	2006-06-14 13:38:26.000000000 +0200
@@ -97,7 +97,7 @@ asmlinkage void do_softirq(void)
 
 	account_system_vtime(current);
 
-	__local_bh_enable();
+	_local_bh_enable();
 
 	local_irq_restore(flags);
 }
diff -purN a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
--- a/drivers/s390/char/sclp.c	2006-06-14 13:27:15.000000000 +0200
+++ b/drivers/s390/char/sclp.c	2006-06-14 13:38:43.000000000 +0200
@@ -420,7 +420,7 @@ sclp_sync_wait(void)
 	}
 	local_irq_disable();
 	__ctl_load(cr0, 0, 0);
-	__local_bh_enable();
+	_local_bh_enable();
 	local_irq_restore(flags);
 }
 
diff -purN a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
--- a/drivers/s390/cio/cio.c	2006-06-06 02:57:02.000000000 +0200
+++ b/drivers/s390/cio/cio.c	2006-06-14 13:38:26.000000000 +0200
@@ -148,7 +148,7 @@ cio_tpi(void)
 		sch->driver->irq(&sch->dev);
 	spin_unlock(&sch->lock);
 	irq_exit ();
-	__local_bh_enable();
+	_local_bh_enable();
 	return 1;
 }
 
diff -purN a/kernel/softirq.c b/kernel/softirq.c
--- a/kernel/softirq.c	2006-06-14 13:41:30.000000000 +0200
+++ b/kernel/softirq.c	2006-06-14 13:38:26.000000000 +0200
@@ -118,6 +118,8 @@ void _local_bh_enable(void)
 	sub_preempt_count(SOFTIRQ_OFFSET);
 }
 
+EXPORT_SYMBOL(_local_bh_enable);
+
 void local_bh_enable(void)
 {
 	unsigned long flags;
