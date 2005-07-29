Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262662AbVG2RQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbVG2RQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 13:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVG2RO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 13:14:29 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:14490 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262672AbVG2RMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 13:12:49 -0400
Date: Fri, 29 Jul 2005 19:12:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/4] s390: fix inline assembly in appldata.
Message-ID: <20050729171249.GB5720@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

Fix inline assembly that gets miscompiled by gcc 4.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/appldata/appldata_base.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2005-07-29 18:43:40.000000000 +0200
@@ -232,7 +232,11 @@ static int appldata_diag(char record_nr,
 	ry = -1;
 	asm volatile(
 			"diag %1,%0,0xDC\n\t"
-			: "=d" (ry) : "d" (&(appldata_parameter_list)) : "cc");
+			: "=d" (ry)
+			: "d" (&appldata_parameter_list),
+			  "m" (appldata_parameter_list),
+			  "m" (appldata_product_id)
+			: "cc");
 	return (int) ry;
 }
 /************************ timer, work, DIAG <END> ****************************/
