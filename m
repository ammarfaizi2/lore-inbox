Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280452AbRKODlc>; Wed, 14 Nov 2001 22:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280606AbRKODlX>; Wed, 14 Nov 2001 22:41:23 -0500
Received: from thumper.research.telcordia.com ([128.96.41.1]:5510 "EHLO
	thumper.research.telcordia.com") by vger.kernel.org with ESMTP
	id <S280452AbRKODlP>; Wed, 14 Nov 2001 22:41:15 -0500
From: Allen Mcintosh <mcintosh@research.telcordia.com>
Message-Id: <200111150339.WAA04775@science.research.telcordia.com>
Subject: [PATCH] Re: Promise PDC20262 in kernel 2.4.x
To: linux-kernel@vger.kernel.org, andre@linux-ide.org
Date: Wed, 14 Nov 2001 22:39:19 -0500 (EST)
Cc: whitney@math.berkeley.edu, magamo@ranka.2y.net
In-Reply-To: <200111140323.WAA18909@mc-pc.research.telcordia.com> from "Allen McIntosh" at Nov 13, 2001 10:23:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> [Can't get Linux to boot with PDC20262 controller.  One of disks is a
> Quantum Fireball Plus.]

Malcom Mallardi posted a note around the same time describing the same
problem.  Wayne Whitney suggested that Malcom add his disk to the "problem
disk" list in pdc202xx.c, and Malcom reports that it worked.  I did the
same thing for my disk, with the same results.

I enclose two patches against the 2.4.14 kernel.  The first patch just adds
both problem disks to the list.  The second assumes that all disks in the
appropriate Quantum families are a problem.  My vote is for the second one.

Patch 1:
--- drivers/ide/pdc202xx.c.ori	Wed Nov 14 18:22:27 2001
+++ drivers/ide/pdc202xx.c	Wed Nov 14 20:57:13 2001
@@ -230,7 +230,9 @@
 	"QUANTUM FIREBALLP KA6.4",
 	"QUANTUM FIREBALLP LM20.4",
 	"QUANTUM FIREBALLP KX20.5",
+	"QUANTUM FIREBALLP KX27.3",
 	"QUANTUM FIREBALLP LM20.5",
+	"QUANTUM FIREBALLP LM30.0",
 	NULL
 };
 
Patch 2:
--- drivers/ide/pdc202xx.c.ori	Wed Nov 14 18:22:27 2001
+++ drivers/ide/pdc202xx.c	Wed Nov 14 21:20:09 2001
@@ -225,12 +225,18 @@
 
 byte pdc202xx_proc = 0;
 
+/*
+ * Problems have been reported with the following Quantum Fireball Plus drives:
+ * KA 6.4GB, KX 20.5GB, 27.3GB, LM 20.4GB, 20.5GB and 30.0GB.  Quantum's
+ * datasheets suggest that all drives in a series (KA, KX and LM) have the
+ * same design.  It seems prudent to identify them all here.
+ */
+ 
 const char *pdc_quirk_drives[] = {
 	"QUANTUM FIREBALLlct08 08",
-	"QUANTUM FIREBALLP KA6.4",
-	"QUANTUM FIREBALLP LM20.4",
-	"QUANTUM FIREBALLP KX20.5",
-	"QUANTUM FIREBALLP LM20.5",
+	"QUANTUM FIREBALLP KA",
+	"QUANTUM FIREBALLP KX",
+	"QUANTUM FIREBALLP LM",
 	NULL
 };
 
