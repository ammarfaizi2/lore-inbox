Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVINPyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVINPyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVINPyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:54:12 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:7674 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030207AbVINPyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:54:10 -0400
Date: Wed, 14 Sep 2005 17:54:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/7] s390: bl_dev array size.
Message-ID: <20050914155412.GB11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/7] s390: bl_dev array size.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Calculate correct size for bl_dev array. It should be 8KB
instead of 512KB for 2^16 bits.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/blacklist.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-09-14 16:48:15.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.34 $
+ *   $Revision: 1.35 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -35,7 +35,7 @@
  */
 
 /* 65536 bits to indicate if a devno is blacklisted or not */
-#define __BL_DEV_WORDS (__MAX_SUBCHANNELS + (8*sizeof(long) - 1) / \
+#define __BL_DEV_WORDS ((__MAX_SUBCHANNELS + (8*sizeof(long) - 1)) / \
 			 (8*sizeof(long)))
 static unsigned long bl_dev[__BL_DEV_WORDS];
 typedef enum {add, free} range_action;
