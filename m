Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271648AbRHQNM5>; Fri, 17 Aug 2001 09:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271650AbRHQNMs>; Fri, 17 Aug 2001 09:12:48 -0400
Received: from mail.teraport.de ([195.143.8.72]:46979 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S271648AbRHQNMb>;
	Fri, 17 Aug 2001 09:12:31 -0400
Message-ID: <3B7D1846.BEB929DE@TeraPort.de>
Date: Fri, 17 Aug 2001 15:12:38 +0200
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: jason@topic.com.au,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 kernel
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/17/2001 03:12:38 PM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 08/17/2001 03:12:45 PM,
	Serialize complete at 08/17/2001 03:12:45 PM
Content-Type: multipart/mixed;
 boundary="------------4F82C30A0E45C7AB565E6B02"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4F82C30A0E45C7AB565E6B02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

> [PATCH] patch's for vmware 2.0.4 for use with linux-2.4.8 kernel
> 
> From: Jason Thomas (jason@topic.com.au)
> Date: Thu Aug 16 2001 - 03:49:38 EST
> 
> 
> attached are two very small patches for those that want them. they make
> vmware's kernel modules compile with 2.4.8. Its not all my work, its a
> combination of what was posted a while back and my work.
> 
Jason,

 a small gotcha in your vmmon patch. You moved up hostif.h in driver.c,
but you forgot to remove the original include. See my attached new
version of the patch.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
--------------4F82C30A0E45C7AB565E6B02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii;
 name="vmmon-248.patch"
Content-Disposition: inline;
 filename="vmmon-248.patch"

diff -ur vmmon-only.orig/linux/driver.c vmmon-only/linux/driver.c
--- vmmon-only.orig/linux/driver.c	Thu May 10 03:46:42 2001
+++ vmmon-only/linux/driver.c	Fri Aug 17 14:03:30 2001
@@ -9,6 +9,7 @@
 #endif 
 
 #include "driver-config.h"
+#include "hostif.h"
 
 #ifdef KERNEL_2_1
 #define EXPORT_SYMTAB
@@ -19,7 +20,7 @@
 #include <linux/module.h>
 #include <linux/version.h>
 #include <linux/sched.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #ifdef __SMP__
 #include <linux/smp.h>
@@ -54,7 +55,6 @@
 #include "vmx86.h"
 #include "initblock.h"
 #include "task.h"
-#include "hostif.h"
 #include "driver.h"
 #include "speaker_reg.h"
 #include "vtrace.h"
@@ -925,7 +925,7 @@
 	  current->fsuid == current->uid &&
           current->egid == current->gid &&
 	  current->fsgid == current->gid) {
-	 current->dumpable = 1;
+	 current->mm->dumpable = 1;
       }
       break;
 
diff -ur vmmon-only.orig/linux/hostif.c vmmon-only/linux/hostif.c
--- vmmon-only.orig/linux/hostif.c	Thu May 10 03:46:42 2001
+++ vmmon-only/linux/hostif.c	Fri Aug 17 11:11:00 2001
@@ -22,7 +22,7 @@
 #include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 
 #ifdef KERNEL_2_1
 #  ifdef KERNEL_2_3_25

--------------4F82C30A0E45C7AB565E6B02--

