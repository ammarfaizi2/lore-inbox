Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316192AbSFJUiP>; Mon, 10 Jun 2002 16:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSFJUgr>; Mon, 10 Jun 2002 16:36:47 -0400
Received: from psmtp1.dnsg.net ([193.168.128.41]:30634 "HELO psmtp1.dnsg.net")
	by vger.kernel.org with SMTP id <S316167AbSFJUgd>;
	Mon, 10 Jun 2002 16:36:33 -0400
Subject: 2.5.21 - s390 irq_stat.
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2002 00:28:41 +0200 (CEST)
CC: torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E17HXeT-0000Ye-00@skybase>
From: Martin Schwidefsky <martin.schwidefsky@debitel.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
since 2.5.21 s390 has an irq_stat array as well. We moved it out of the cpu
lowcore to simplify things. As long as irq_stat is cache aligned there is
no performance benefit in keeping it in the lowcore. Another thing we found
missing is an export for simple_strtoull.

blue skies,
  Martin.

diff -urN linux-2.5.21/kernel/ksyms.c linux-2.5.21-s390/kernel/ksyms.c
--- linux-2.5.21/kernel/ksyms.c	Sun Jun  9 07:26:33 2002
+++ linux-2.5.21-s390/kernel/ksyms.c	Mon Jun 10 11:30:35 2002
@@ -382,9 +382,7 @@
 EXPORT_SYMBOL(del_timer);
 EXPORT_SYMBOL(request_irq);
 EXPORT_SYMBOL(free_irq);
-#if !defined(CONFIG_ARCH_S390)
-EXPORT_SYMBOL(irq_stat);	/* No separate irq_stat for s390, it is part of PSA */
-#endif
+EXPORT_SYMBOL(irq_stat);
 
 /* waitqueue handling */
 EXPORT_SYMBOL(add_wait_queue);
@@ -500,6 +498,7 @@
 EXPORT_SYMBOL(__bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoul);
+EXPORT_SYMBOL(simple_strtoull);
 EXPORT_SYMBOL(system_utsname);	/* UTS data */
 EXPORT_SYMBOL(uts_sem);		/* UTS semaphore */
 #ifndef __mips__
