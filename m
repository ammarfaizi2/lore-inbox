Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTFQBzJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264534AbTFQBxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:53:32 -0400
Received: from palrel13.hp.com ([156.153.255.238]:64671 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264531AbTFQBxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:53:06 -0400
Date: Mon, 16 Jun 2003 19:06:59 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] Secondary nack code fixes
Message-ID: <20030617020659.GF30944@bougret.hpl.hp.com>
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

ir241_secondary_rr.diff :
	o [CORRECT] fix the secondary function to send RR and frames without
		the poll bit when it detect packet losses


diff -u -p linux/net/irda/irlap_event.d8.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d8.c	Mon Dec  2 16:12:36 2002
+++ linux/net/irda/irlap_event.c	Mon Dec  2 16:14:20 2002
@@ -1869,7 +1869,7 @@ static int irlap_state_nrm_s(struct irla
 				irlap_update_nr_received(self, info->nr);
 			
 				irlap_wait_min_turn_around(self, &self->qos_tx);
-				irlap_send_rr_frame(self, CMD_FRAME);
+				irlap_send_rr_frame(self, RSP_FRAME);
 			
 				irlap_start_wd_timer(self, self->wd_timeout);
 			}
@@ -2033,18 +2033,18 @@ static int irlap_state_nrm_s(struct irla
 		irlap_update_nr_received(self, info->nr);
 		if (self->remote_busy) {
 			irlap_wait_min_turn_around(self, &self->qos_tx);
-			irlap_send_rr_frame(self, CMD_FRAME);
+			irlap_send_rr_frame(self, RSP_FRAME);
 		} else
-			irlap_resend_rejected_frames(self, CMD_FRAME);
+			irlap_resend_rejected_frames(self, RSP_FRAME);
 		irlap_start_wd_timer(self, self->wd_timeout);
 		break;
 	case RECV_SREJ_CMD:
 		irlap_update_nr_received(self, info->nr);
 		if (self->remote_busy) {
 			irlap_wait_min_turn_around(self, &self->qos_tx);
-			irlap_send_rr_frame(self, CMD_FRAME);
+			irlap_send_rr_frame(self, RSP_FRAME);
 		} else
-			irlap_resend_rejected_frame(self, CMD_FRAME);
+			irlap_resend_rejected_frame(self, RSP_FRAME);
 		irlap_start_wd_timer(self, self->wd_timeout);
 		break;
 	case WD_TIMER_EXPIRED:
