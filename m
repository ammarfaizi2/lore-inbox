Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTBGRF4>; Fri, 7 Feb 2003 12:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTBGRF4>; Fri, 7 Feb 2003 12:05:56 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.222]:31117 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266233AbTBGRFu>; Fri, 7 Feb 2003 12:05:50 -0500
Date: Fri, 7 Feb 2003 12:24:54 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@master
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <trivial@rustcorp.com.au>
Subject: [PATCH] 2.5.59 : drivers/scsi/advansys.c
Message-ID: <Pine.LNX.4.44.0302071223250.6917-100000@master>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   The following patch addresses buzilla bug # 324, and removes a double 
logical issue. Please review for inclusion.

Regards,
Frank

--- linux/drivers/scsi/advansys.c.old	2003-01-16 21:21:49.000000000 -0500
+++ linux/drivers/scsi/advansys.c	2003-02-07 02:09:58.000000000 -0500
@@ -7100,7 +7100,7 @@
          * then return the number of underrun bytes.
          */
         if (scp->request_bufflen != 0 && qdonep->remain_bytes != 0 &&
-            qdonep->remain_bytes <= scp->request_bufflen != 0) {
+            qdonep->remain_bytes <= scp->request_bufflen && scp->request_bufflen!= 0) {
             ASC_DBG1(1, "asc_isr_callback: underrun condition %u bytes\n",
             (unsigned) qdonep->remain_bytes);
             scp->resid = qdonep->remain_bytes;

