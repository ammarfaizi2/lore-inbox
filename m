Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264182AbUDWTLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbUDWTLO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbUDWTLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:11:14 -0400
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:62184 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264182AbUDWTLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:11:12 -0400
Subject: [FIX 2.6.6-rc2-mm1] Use DOS_EXTENDED_PARTITION
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-cPKJbQ7gesKtKO3uRSdx"
Message-Id: <1082747725.6319.14.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Apr 2004 21:15:26 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx014.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cPKJbQ7gesKtKO3uRSdx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a fix in partition manager to use DOS_EXTENDED_PARTITION rather
than 'not often self-explanatory' 4 & 5. 

Regards,
Fabian

--=-cPKJbQ7gesKtKO3uRSdx
Content-Disposition: attachment; filename=dosextended1.diff
Content-Type: text/x-patch; name=dosextended1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/partitions/msdos.c edited/fs/partitions/msdos.c
--- orig/fs/partitions/msdos.c	2004-04-04 05:37:24.000000000 +0200
+++ edited/fs/partitions/msdos.c	2004-04-23 21:03:50.000000000 +0200
@@ -407,8 +407,8 @@
 	 * On the second pass look inside *BSD, Unixware and Solaris partitions.
 	 */
 
-	state->next = 5;
-	for (slot = 1 ; slot <= 4 ; slot++, p++) {
+	state->next = DOS_EXTENDED_PARTITION;
+	for (slot = 1 ; slot < DOS_EXTENDED_PARTITION ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
 		if (!size)
@@ -435,7 +435,7 @@
 
 	/* second pass - output for each on a separate line */
 	p = (struct partition *) (0x1be + data);
-	for (slot = 1 ; slot <= 4 ; slot++, p++) {
+	for (slot = 1 ; slot < DOS_EXTENDED_PARTITION ; slot++, p++) {
 		unsigned char id = SYS_IND(p);
 		int n;
 

--=-cPKJbQ7gesKtKO3uRSdx--

