Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbTEMWLC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 18:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTEMWJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 18:09:50 -0400
Received: from palrel10.hp.com ([156.153.255.245]:4049 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263623AbTEMWIu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 18:08:50 -0400
Date: Tue, 13 May 2003 15:21:36 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] IrLAP address fix
Message-ID: <20030513222136.GD2634@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir257_caddr_mask.diff :
		<Patch from Jan Kiszka>
	o [CORRECT] ignore the C/R bit in the LAP connection address.


diff -u -p linux/net/irda/irlap_frame.d0.c linux/net/irda/irlap_frame.c
--- linux/net/irda/irlap_frame.d0.c	Mon Apr  7 17:35:46 2003
+++ linux/net/irda/irlap_frame.c	Mon Apr  7 17:36:42 2003
@@ -162,8 +162,8 @@ static void irlap_recv_snrm_cmd(struct i
 	frame = (struct snrm_frame *) skb->data;
 
 	if (skb->len >= sizeof(struct snrm_frame)) {
-		/* Copy the new connection address */
-		info->caddr = frame->ncaddr;
+		/* Copy the new connection address ignoring the C/R bit */
+		info->caddr = frame->ncaddr & 0xFE;
 
 		/* Check if the new connection address is valid */
 		if ((info->caddr == 0x00) || (info->caddr == 0xfe)) {
