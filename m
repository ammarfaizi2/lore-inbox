Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbTFQB6m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbTFQB5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:57:13 -0400
Received: from palrel12.hp.com ([156.153.255.237]:13765 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264537AbTFQBzj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:55:39 -0400
Date: Mon, 16 Jun 2003 19:09:32 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Mask C/R bit from connection address
Message-ID: <20030617020932.GI30944@bougret.hpl.hp.com>
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

ir241_caddr_mask.diff :
		<Patch from Jan Kiszka>
	o [CORRECT] ignore the C/R bit in the LAP connection address.


--- linux/net/irda/irlap_frame.d0.c	Fri Apr 11 18:38:03 2003
+++ linux/net/irda/irlap_frame.c	Fri Apr 11 18:38:15 2003
@@ -162,8 +162,8 @@ static void irlap_recv_snrm_cmd(struct i
 	frame = (struct snrm_frame *) skb->data;
 	
 	if (skb->len >= sizeof(struct snrm_frame)) {
-		/* Copy the new connection address */
-		info->caddr = frame->ncaddr;
+		/* Copy the new connection address ignoring the C/R bit */
+		info->caddr = frame->ncaddr & 0xFE;
 
 		/* Check if the new connection address is valid */
 		if ((info->caddr == 0x00) || (info->caddr == 0xfe)) {
