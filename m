Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132590AbRC1Vrp>; Wed, 28 Mar 2001 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132592AbRC1VrJ>; Wed, 28 Mar 2001 16:47:09 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:18962 "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP id <S132600AbRC1Vqc>; Wed, 28 Mar 2001 16:46:32 -0500
Date: Wed, 28 Mar 2001 13:44:50 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@transmeta.com>, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org, tytso@MIT.EDU
Subject: Re: Larger dev_t
In-Reply-To: <3AC25657.6CC01DFB@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10103281343270.17821-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2001, Martin Dalecki wrote:

> Then please please please demangle other cases as well!
> IDE is the one which is badging my head most. SCSI as well...
> 
> Granted I wouldn't mind a rebot with new /dev/* once!

diff -urN linux-2.4.3-p8-pristine/include/linux/major.h linux-2.4.3-p8/include/linux/major.h
--- linux-2.4.3-p8-pristine/include/linux/major.h       Sat Dec 30
11:23:14 2000+++ linux-2.4.3-p8/include/linux/major.h        Sun Mar 25
22:16:42 2001
@@ -171,4 +171,18 @@
        return SCSI_BLK_MAJOR(m);
 }

+/*
+ * Tests for IDE devices
+ */
+#define IDE_DISK_MAJOR(M)      ((M) == IDE0_MAJOR || (M) == IDE1_MAJOR || \
+                               (M) == IDE2_MAJOR || (M) == IDE3_MAJOR || \
+                               (M) == IDE4_MAJOR || (M) == IDE5_MAJOR || \
+                               (M) == IDE6_MAJOR || (M) == IDE7_MAJOR || \
+                               (M) == IDE8_MAJOR || (M) == IDE9_MAJOR)
+
+static __inline__ int ide_blk_major(int m)
+{
+       return IDE_DISK_MAJOR(m);
+}
+
 #endif

Well I banged my head and learned a scsi-trick....
 
Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

