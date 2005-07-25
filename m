Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbVGYHOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbVGYHOQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 03:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVGYFyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 01:54:19 -0400
Received: from smtp102.sbc.mail.re2.yahoo.com ([68.142.229.103]:55133 "HELO
	smtp102.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261673AbVGYFxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 01:53:25 -0400
Message-Id: <20050725054533.912636000.dtor_core@ameritech.net>
References: <20050725053449.483098000.dtor_core@ameritech.net>
Date: Mon, 25 Jul 2005 00:35:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 24/24] Synaptics - fix setting packet size on passthrough port
Content-Disposition: inline; filename=synaptics-ptsize.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Vlasov <vsu@altlinux.ru>

Input: synaptics - fix setting packet size on passthrough port.

Synaptics driver used child->type to select either 3-byte or 4-byte
packet size for the pass-through port; this gives wrong results for
the newer protocols. Change the check to use child->pktsize instead.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/synaptics.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/mouse/synaptics.c
===================================================================
--- work.orig/drivers/input/mouse/synaptics.c
+++ work/drivers/input/mouse/synaptics.c
@@ -219,7 +219,7 @@ static void synaptics_pass_pt_packet(str
 		serio_interrupt(ptport, packet[1], 0, NULL);
 		serio_interrupt(ptport, packet[4], 0, NULL);
 		serio_interrupt(ptport, packet[5], 0, NULL);
-		if (child->type >= PSMOUSE_GENPS)
+		if (child->pktsize == 4)
 			serio_interrupt(ptport, packet[2], 0, NULL);
 	} else
 		serio_interrupt(ptport, packet[1], 0, NULL);
@@ -233,7 +233,7 @@ static void synaptics_pt_activate(struct
 
 	/* adjust the touchpad to child's choice of protocol */
 	if (child) {
-		if (child->type >= PSMOUSE_GENPS)
+		if (child->pktsize == 4)
 			priv->mode |= SYN_BIT_FOUR_BYTE_CLIENT;
 		else
 			priv->mode &= ~SYN_BIT_FOUR_BYTE_CLIENT;

