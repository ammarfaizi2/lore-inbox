Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263396AbREXH3O>; Thu, 24 May 2001 03:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263395AbREXH3E>; Thu, 24 May 2001 03:29:04 -0400
Received: from smtp2.Stanford.EDU ([171.64.14.116]:63471 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263396AbREXH2r>; Thu, 24 May 2001 03:28:47 -0400
Message-Id: <200105240728.f4O7SkH23099@smtp2.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] ftl.c - Null ptr fixes 2.4.4
Date: Thu, 24 May 2001 00:29:52 -0700
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, dwmw2@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Using the Stanford checker, we searched for null-pointer bugs in the linux
kernel code. This patch fixes an unchecked pointer in an MTD driver (ftl.c).

Praveen Srinivasan and Frederick Akalin

--- ../linux/./drivers/mtd/ftl.c	Fri Feb  9 11:30:23 2001
+++ ./drivers/mtd/ftl.c	Mon May  7 22:01:29 2001
@@ -375,6 +375,11 @@
     /* Set up virtual page map */
     blocks = le32_to_cpu(header.FormattedSize) >> header.BlockSize;
     part->VirtualBlockMap = vmalloc(blocks * sizeof(u_int32_t));
+
+    if(part->VirtualBlockMap==NULL) {
+      return -1;
+    }
+
     memset(part->VirtualBlockMap, 0xff, blocks * sizeof(u_int32_t));
     part->BlocksPerUnit = (1 << header.EraseUnitSize) >> header.BlockSize;
