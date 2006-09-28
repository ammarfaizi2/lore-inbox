Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWI1NHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWI1NHU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWI1NHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:07:20 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:19530 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751881AbWI1NHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:07:18 -0400
Date: Thu, 28 Sep 2006 15:07:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Avoid static struct initializations in appldata.
Message-ID: <20060928130715.GA1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Avoid static struct initializations in appldata.

Don't use static initialization for struct members containing
variables because gcc would generate more code and use double space
on stack.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-09-28 14:58:39.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-09-28 14:58:50.000000000 +0200
@@ -157,12 +157,12 @@ int appldata_diag(char record_nr, u16 fu
 		.prod_nr    = {0xD3, 0xC9, 0xD5, 0xE4,
 			       0xE7, 0xD2, 0xD9},	/* "LINUXKR" */
 		.prod_fn    = 0xD5D3,			/* "NL" */
-		.record_nr  = record_nr,
 		.version_nr = 0xF2F6,			/* "26" */
 		.release_nr = 0xF0F1,			/* "01" */
-		.mod_lvl    = (mod_lvl[0]) << 8 | mod_lvl[1],
 	};
 
+	id.record_nr = record_nr;
+	id.mod_lvl = (mod_lvl[0]) << 8 | mod_lvl[1];
 	return appldata_asm(&id, function, (void *) buffer, length);
 }
 /************************ timer, work, DIAG <END> ****************************/
