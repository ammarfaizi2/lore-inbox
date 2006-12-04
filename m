Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936935AbWLDOvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936935AbWLDOvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936934AbWLDOvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:51:45 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:60438 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S936935AbWLDOvm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:51:42 -0500
Date: Mon, 4 Dec 2006 15:51:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] No panic for failed reboot
Message-ID: <20061204145138.GH32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] No panic for failed reboot

If reboot fails (e.g. because wrong devno has been specified by the user),
we should just stop all cpus, but should not trigger a kernel panic.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2006-12-04 14:50:35.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2006-12-04 14:50:37.000000000 +0100
@@ -697,7 +697,8 @@ void do_reipl(void)
 		diag308(DIAG308_IPL, NULL);
 		break;
 	}
-	panic("reipl failed!\n");
+	printk(KERN_EMERG "reboot failed!\n");
+	signal_processor(smp_processor_id(), sigp_stop_and_store_status);
 }
 
 static void do_dump(void)
