Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265554AbTFWW7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265557AbTFWW5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:57:07 -0400
Received: from palrel11.hp.com ([156.153.255.246]:669 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265558AbTFWW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:56:41 -0400
Date: Mon, 23 Jun 2003 16:10:45 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4 IrDA] Mask C/R bit from connection
Message-ID: <20030623231045.GI12593@bougret.hpl.hp.com>
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

	Hi Marcelo,

	Some devices add bits where they should not. Let's not get
ourselves confused by it.
	Please apply ;-)

	Jean


ir241_caddr_mask.diff :
---------------------
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
