Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWEEQow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWEEQow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWEEQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:52 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:31876 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751642AbWEEQou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:50 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, yokota@netlab.is.tsukuba.ac.jp
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <3.420169009@selenic.com>
Subject: [PATCH 2/14] random: Remove redundant SA_SAMPLE_RANDOM from NinjaSCSI
Date: Fri, 05 May 2006 11:42:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant SA_SAMPLE_RANDOM from NinjaSCSI

The scsi layer is already calling add_disk_randomness in scsi_end_request.

ps: ninjas rule!

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/scsi/nsp32.c
===================================================================
--- 2.6.orig/drivers/scsi/nsp32.c	2006-05-02 17:28:45.000000000 -0500
+++ 2.6/drivers/scsi/nsp32.c	2006-05-03 11:40:26.000000000 -0500
@@ -2866,8 +2866,7 @@ static int nsp32_detect(struct scsi_host
 	 */
 	nsp32_do_bus_reset(data);
 
-	ret = request_irq(host->irq, do_nsp32_isr,
-			  SA_SHIRQ | SA_SAMPLE_RANDOM, "nsp32", data);
+	ret = request_irq(host->irq, do_nsp32_isr, SA_SHIRQ, "nsp32", data);
 	if (ret < 0) {
 		nsp32_msg(KERN_ERR, "Unable to allocate IRQ for NinjaSCSI32 "
 			  "SCSI PCI controller. Interrupt: %d", host->irq);
Index: 2.6/drivers/scsi/pcmcia/nsp_cs.c
===================================================================
--- 2.6.orig/drivers/scsi/pcmcia/nsp_cs.c	2006-05-02 17:28:45.000000000 -0500
+++ 2.6/drivers/scsi/pcmcia/nsp_cs.c	2006-05-03 11:39:43.000000000 -0500
@@ -1623,7 +1623,7 @@ static int nsp_cs_probe(struct pcmcia_de
 	/* Interrupt handler */
 	link->irq.Handler	 = &nspintr;
 	link->irq.Instance       = info;
-	link->irq.Attributes     |= (SA_SHIRQ | SA_SAMPLE_RANDOM);
+	link->irq.Attributes     |= SA_SHIRQ;
 
 	/* General socket configuration */
 	link->conf.Attributes	 = CONF_ENABLE_IRQ;
