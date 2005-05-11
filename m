Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVEKUJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVEKUJN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbVEKUJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:09:13 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47071 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261277AbVEKUJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:09:09 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200505112009.j4BK9546178598@fsgi900.americas.sgi.com>
Subject: [PATCH] 2.6 Altix : shut off xmit intr if done xmitting
To: akpm@osdl.org
Date: Wed, 11 May 2005 15:09:04 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small mod to shut off the xmit interrupt if we have nothing to transmit.

Signed-off-by: Patrick Gefre <pfg@sgi.com>

--

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054





Index: linux-2.6/drivers/serial/sn_console.c
===================================================================
--- linux-2.6.orig/drivers/serial/sn_console.c	2005-05-04 16:50:17.574221234 -0500
+++ linux-2.6/drivers/serial/sn_console.c	2005-05-11 14:37:07.817008412 -0500
@@ -572,6 +572,7 @@
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&port->sc_port)) {
 		/* Nothing to do. */
+		ia64_sn_console_intr_disable(SAL_CONSOLE_INTR_XMIT);
 		return;
 	}
 
