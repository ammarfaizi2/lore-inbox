Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbTAICq6>; Wed, 8 Jan 2003 21:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbTAICq5>; Wed, 8 Jan 2003 21:46:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:50403 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261463AbTAICpw>;
	Wed, 8 Jan 2003 21:45:52 -0500
Date: Wed, 8 Jan 2003 18:54:33 -0800
To: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Secondary nack fixes
Message-ID: <20030109025433.GE19178@bougret.hpl.hp.com>
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

ir254_secondary_rr.diff :
-----------------------
	o [CORRECT] fix the secondary function to send RR and frames without
		the poll bit when it detect packet losses


diff -u -p linux/net/irda/irlap_event.d8.c linux/net/irda/irlap_event.c
--- linux/net/irda/irlap_event.d8.c	Fri Nov  8 18:52:27 2002
+++ linux/net/irda/irlap_event.c	Fri Nov  8 18:56:31 2002
@@ -1870,7 +1870,7 @@ static int irlap_state_nrm_s(struct irla
 				irlap_update_nr_received(self, info->nr);
 
 				irlap_wait_min_turn_around(self, &self->qos_tx);
-				irlap_send_rr_frame(self, CMD_FRAME);
+				irlap_send_rr_frame(self, RSP_FRAME);
 
 				irlap_start_wd_timer(self, self->wd_timeout);
 			}
@@ -2035,18 +2035,18 @@ static int irlap_state_nrm_s(struct irla
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
