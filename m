Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWIOL1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWIOL1e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWIOL1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:27:34 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:58457 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751272AbWIOL1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:27:31 -0400
Date: Fri, 15 Sep 2006 13:27:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, peter.oberparleiter@de.ibm.com
Subject: [S390] Replace nopav-message on VM.
Message-ID: <20060915112728.GC23134@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

[S390] Replace nopav-message on VM.

Specifying kernel parameter "dasd=nopav" on systems running under VM
has no function but results in message "disable PAV mode". Correct
message is "'nopav' not supported on VM".

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_devmap.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-09-15 12:18:24.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-09-15 12:18:44.000000000 +0200
@@ -258,8 +258,12 @@ dasd_parse_keyword( char *parsestring ) 
                 return residual_str;
         }
 	if (strncmp("nopav", parsestring, length) == 0) {
-		dasd_nopav = 1;
-		MESSAGE(KERN_INFO, "%s", "disable PAV mode");
+		if (MACHINE_IS_VM)
+			MESSAGE(KERN_INFO, "%s", "'nopav' not supported on VM");
+		else {
+			dasd_nopav = 1;
+			MESSAGE(KERN_INFO, "%s", "disable PAV mode");
+		}
 		return residual_str;
 	}
 	if (strncmp("fixedbuffers", parsestring, length) == 0) {
