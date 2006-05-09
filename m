Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbWEITw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWEITw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWEITwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:52:24 -0400
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:30371
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751059AbWEITvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:51:49 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, yokota@netlab.is.tsukuba.ac.jp
In-Reply-To: <2.628477917@selenic.com>
Message-Id: <3.628477917@selenic.com>
Subject: [PATCH 2/6] random: Remove redundant SA_SAMPLE_RANDOM from NinjaSCSI
Date: Tue, 09 May 2006 14:50:25 -0500
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
