Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129468AbRBOOhA>; Thu, 15 Feb 2001 09:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbRBOOgv>; Thu, 15 Feb 2001 09:36:51 -0500
Received: from mailg.telia.com ([194.22.194.26]:4872 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S129468AbRBOOgh>;
	Thu, 15 Feb 2001 09:36:37 -0500
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_OWYSLVSP7YK356P9A2LT"
From: Roger Larsson <roger.larsson@norran.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [pre PATCH] freezes
Date: Thu, 15 Feb 2001 15:29:12 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01021515291200.01148@dox>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OWYSLVSP7YK356P9A2LT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I have had occasional freezes (complete NumLock won't work) for some time.
I blamed HW, irq conflicts, temperature problems, ...

But suddenly with 2.4.2-pre1 the problems disappeared!

Since 2.4.2-pre1 was rather short I took the time to try to find out what 
could be the fix.

I found one candidate, the setting of  TASK_RUNNING in handle_mm_fault.

Since the problem had appeared on both 2.4 and 2.2.18 I started to try to 
reproduce the problem in an unpatched 2.2 - it took some time, got the freeze
today.

During this time I have tried to collect information of the freezes on KDE 
mailing lists - I do now have three additional reports (one running 2.2.17)
Hardware has varied.

I have now compiled and installed this patch but since it can't be proven
to fix the problem I submit it now.

/RogerL

-- 
Home page:
  none currently

--------------Boundary-00=_OWYSLVSP7YK356P9A2LT
Content-Type: text/plain;
  charset="iso-8859-1";
  name="patch-2.2.18-handle_mm_fault"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-2.2.18-handle_mm_fault"

--- linux/mm/memory.c.orig	Wed Feb 14 00:58:59 2001
+++ linux/mm/memory.c	Wed Feb 14 00:59:16 2001
@@ -935,6 +935,7 @@
 	pte_t * pte;
 	int ret;
 
+	current->state = TASK_RUNNING;
 	pgd = pgd_offset(vma->vm_mm, address);
 	pmd = pmd_alloc(pgd, address);
 	if (!pmd)

--------------Boundary-00=_OWYSLVSP7YK356P9A2LT--
