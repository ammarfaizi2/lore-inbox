Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264115AbTFJSm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTFJSlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 14:41:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:46511 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264054AbTFJShe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 14:37:34 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10552709691672@kroah.com>
Subject: Re: [PATCH] Yet more PCI fixes for 2.5.70
In-Reply-To: <1055270969511@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 10 Jun 2003 11:49:29 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1368, 2003/06/09 16:11:04-07:00, greg@kroah.com

PCI: remove pci_present() from drivers/telephony/ixj.c


 drivers/telephony/ixj.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)


diff -Nru a/drivers/telephony/ixj.c b/drivers/telephony/ixj.c
--- a/drivers/telephony/ixj.c	Tue Jun 10 11:18:19 2003
+++ b/drivers/telephony/ixj.c	Tue Jun 10 11:18:19 2003
@@ -7821,9 +7821,6 @@
 	IXJ *j = NULL;
 	int result;
 
-	if(!pci_present())
-		return 0;
-
 	for (i = 0; i < IXJMAX - *cnt; i++) {
 		pci = pci_find_device(0x15E2, 0x0500, pci);
 		if (!pci)
@@ -7869,10 +7866,8 @@
 	if ((probe = ixj_probe_isa(&cnt)) < 0) {
 		return probe;
 	}
-	if (pci_present()) {
-		if ((probe = ixj_probe_pci(&cnt)) < 0) {
-			return probe;
-		}
+	if ((probe = ixj_probe_pci(&cnt)) < 0) {
+		return probe;
 	}
 	printk("%s\n", ixj_c_rcsid);
 	create_proc_read_entry ("ixj", 0, NULL, ixj_read_proc, NULL);

