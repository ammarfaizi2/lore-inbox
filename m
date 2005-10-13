Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751635AbVJMTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbVJMTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbVJMTYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:24:25 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:23162 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751635AbVJMTYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:24:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=qgkcDaiHdu9mTgEUTNtVKUsUfIoqO4/VbqY/igCN9eObKcqx7InYAnI7h+5HTs1nyYQEEqd2ao4/LvGlN3fh1BsbbGx0PjZvx96dNf3e9wHwItW8uw4vYxF2fwYXtjLf+RfTio7Z+8v6xa8VOGfbZ7PH2jc6TiMr204b7eKzcwg=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 05/14] Big kfree NULL check cleanup - drivers/isdn
Date: Thu, 13 Oct 2005 21:27:13 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Karsten Keil <keil@isdn4linux.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>,
       isdn4linux@listserv.isdn4linux.de, Carsten Paeth <calle@calle.de>,
       Roland Klabunde <R.Klabunde@berkom.de>,
       Frode Isaksen <fisaksen@bewan.com>, Petr Novak <petr.novak@i.cz>,
       Werner Cornelius <werner@titro.de>,
       Michael Hipp <Michael.Hipp@student.uni-tuebingen.de>,
       Fritz Elfert <fritz@isdn4linux.de>,
       "Pedro Roque Marques" <roque@di.fc.ul.pt>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200510132127.13778.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the drivers/isdn/ part of the big kfree cleanup patch.

Remove pointless checks for NULL prior to calling kfree() in drivers/isdn/.


Sorry about the long Cc: list, but I wanted to make sure I included everyone
who's code I've changed with this patch.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

Please see the initial announcement mail on LKML with subject
"[PATCH 00/14] Big kfree NULL check cleanup"
for additional details.

 drivers/isdn/hardware/avm/avm_cs.c  |    5 +----
 drivers/isdn/hisax/avm_pci.c        |   12 ++++--------
 drivers/isdn/hisax/avma1_cs.c       |    4 +---
 drivers/isdn/hisax/config.c         |    9 +++------
 drivers/isdn/hisax/hfc_2bds0.c      |   18 ++++++------------
 drivers/isdn/hisax/hfc_2bs0.c       |   12 ++++--------
 drivers/isdn/hisax/hscx.c           |   12 ++++--------
 drivers/isdn/hisax/icc.c            |   12 ++++--------
 drivers/isdn/hisax/ipacx.c          |   12 ++++--------
 drivers/isdn/hisax/isac.c           |   15 ++++++---------
 drivers/isdn/hisax/isar.c           |    6 ++----
 drivers/isdn/hisax/jade.c           |   12 ++++--------
 drivers/isdn/hisax/netjet.c         |   32 ++++++++++----------------------
 drivers/isdn/hisax/st5481_usb.c     |   12 ++++--------
 drivers/isdn/hisax/w6692.c          |   12 ++++--------
 drivers/isdn/hysdn/hysdn_procconf.c |    3 +--
 drivers/isdn/i4l/isdn_ppp.c         |   21 +++++++--------------
 drivers/isdn/i4l/isdn_tty.c         |   24 ++++++++----------------
 drivers/isdn/pcbit/drv.c            |    6 ++----
 19 files changed, 79 insertions(+), 160 deletions(-)

--- linux-2.6.14-rc4-orig/drivers/isdn/i4l/isdn_ppp.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/i4l/isdn_ppp.c	2005-10-12 16:43:27.000000000 +0200
@@ -364,10 +364,8 @@ isdn_ppp_release(int min, struct file *f
 		isdn_net_hangup(&p->dev);
 	}
 	for (i = 0; i < NUM_RCV_BUFFS; i++) {
-		if (is->rq[i].buf) {
-			kfree(is->rq[i].buf);
-			is->rq[i].buf = NULL;
-		}
+		kfree(is->rq[i].buf);
+		is->rq[i].buf = NULL;
 	}
 	is->first = is->rq + NUM_RCV_BUFFS - 1;	/* receive queue */
 	is->last = is->rq;
@@ -378,14 +376,10 @@ isdn_ppp_release(int min, struct file *f
 	is->slcomp = NULL;
 #endif
 #ifdef CONFIG_IPPP_FILTER
-	if (is->pass_filter) {
-		kfree(is->pass_filter);
-		is->pass_filter = NULL;
-	}
-	if (is->active_filter) {
-		kfree(is->active_filter);
-		is->active_filter = NULL;
-	}
+	kfree(is->pass_filter);
+	is->pass_filter = NULL;
+	kfree(is->active_filter);
+	is->active_filter = NULL;
 #endif
 
 /* TODO: if this was the previous master: link the stuff to the new master */
@@ -914,8 +908,7 @@ isdn_ppp_cleanup(void)
 		kfree(ippp_table[i]);
 
 #ifdef CONFIG_ISDN_MPP
-	if (isdn_ppp_bundle_arr)
-		kfree(isdn_ppp_bundle_arr);
+	kfree(isdn_ppp_bundle_arr);
 #endif /* CONFIG_ISDN_MPP */
 
 }
--- linux-2.6.14-rc4-orig/drivers/isdn/i4l/isdn_tty.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/i4l/isdn_tty.c	2005-10-12 16:44:00.000000000 +0200
@@ -712,22 +712,14 @@ isdn_tty_modem_hup(modem_info * info, in
 #endif
 	info->emu.vpar[4] = 0;
 	info->emu.vpar[5] = 8;
-	if (info->dtmf_state) {
-		kfree(info->dtmf_state);
-		info->dtmf_state = NULL;
-	}
-	if (info->silence_state) {
-		kfree(info->silence_state);
-		info->silence_state = NULL;
-	}
-	if (info->adpcms) {
-		kfree(info->adpcms);
-		info->adpcms = NULL;
-	}
-	if (info->adpcmr) {
-		kfree(info->adpcmr);
-		info->adpcmr = NULL;
-	}
+	kfree(info->dtmf_state);
+	info->dtmf_state = NULL;
+	kfree(info->silence_state);
+	info->silence_state = NULL;
+	kfree(info->adpcms);
+	info->adpcms = NULL;
+	kfree(info->adpcmr);
+	info->adpcmr = NULL;
 #endif
 	if ((info->msr & UART_MSR_RI) &&
 		(info->emu.mdmreg[REG_RUNG] & BIT_RUNG))
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/w6692.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/w6692.c	2005-10-12 16:46:46.000000000 +0200
@@ -819,14 +819,10 @@ close_w6692state(struct BCState *bcs)
 {
 	W6692Bmode(bcs, 0, bcs->channel);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.w6692.rcvbuf) {
-			kfree(bcs->hw.w6692.rcvbuf);
-			bcs->hw.w6692.rcvbuf = NULL;
-		}
-		if (bcs->blog) {
-			kfree(bcs->blog);
-			bcs->blog = NULL;
-		}
+		kfree(bcs->hw.w6692.rcvbuf);
+		bcs->hw.w6692.rcvbuf = NULL;
+		kfree(bcs->blog);
+		bcs->blog = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/avm_pci.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/avm_pci.c	2005-10-12 16:47:02.000000000 +0200
@@ -552,14 +552,10 @@ close_hdlcstate(struct BCState *bcs)
 {
 	modehdlc(bcs, 0, 0);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.hdlc.rcvbuf) {
-			kfree(bcs->hw.hdlc.rcvbuf);
-			bcs->hw.hdlc.rcvbuf = NULL;
-		}
-		if (bcs->blog) {
-			kfree(bcs->blog);
-			bcs->blog = NULL;
-		}
+		kfree(bcs->hw.hdlc.rcvbuf);
+		bcs->hw.hdlc.rcvbuf = NULL;
+		kfree(bcs->blog);
+		bcs->blog = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/icc.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/icc.c	2005-10-12 16:47:20.000000000 +0200
@@ -571,14 +571,10 @@ setstack_icc(struct PStack *st, struct I
 
 static void
 DC_Close_icc(struct IsdnCardState *cs) {
-	if (cs->dc.icc.mon_rx) {
-		kfree(cs->dc.icc.mon_rx);
-		cs->dc.icc.mon_rx = NULL;
-	}
-	if (cs->dc.icc.mon_tx) {
-		kfree(cs->dc.icc.mon_tx);
-		cs->dc.icc.mon_tx = NULL;
-	}
+	kfree(cs->dc.icc.mon_rx);
+	cs->dc.icc.mon_rx = NULL;
+	kfree(cs->dc.icc.mon_tx);
+	cs->dc.icc.mon_tx = NULL;
 }
 
 static void
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/hfc_2bs0.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/hfc_2bs0.c	2005-10-12 16:47:44.000000000 +0200
@@ -582,12 +582,8 @@ inithfc(struct IsdnCardState *cs)
 void
 releasehfc(struct IsdnCardState *cs)
 {
-	if (cs->bcs[0].hw.hfc.send) {
-		kfree(cs->bcs[0].hw.hfc.send);
-		cs->bcs[0].hw.hfc.send = NULL;
-	}
-	if (cs->bcs[1].hw.hfc.send) {
-		kfree(cs->bcs[1].hw.hfc.send);
-		cs->bcs[1].hw.hfc.send = NULL;
-	}
+	kfree(cs->bcs[0].hw.hfc.send);
+	cs->bcs[0].hw.hfc.send = NULL;
+	kfree(cs->bcs[1].hw.hfc.send);
+	cs->bcs[1].hw.hfc.send = NULL;
 }
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/st5481_usb.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/st5481_usb.c	2005-10-12 16:48:37.000000000 +0200
@@ -335,14 +335,12 @@ void st5481_release_usb(struct st5481_ad
 
 	// Stop and free Control and Interrupt URBs
 	usb_kill_urb(ctrl->urb);
-	if (ctrl->urb->transfer_buffer)
-		kfree(ctrl->urb->transfer_buffer);
+	kfree(ctrl->urb->transfer_buffer);
 	usb_free_urb(ctrl->urb);
 	ctrl->urb = NULL;
 
 	usb_kill_urb(intr->urb);
-	if (intr->urb->transfer_buffer)
-		kfree(intr->urb->transfer_buffer);
+	kfree(intr->urb->transfer_buffer);
 	usb_free_urb(intr->urb);
 	ctrl->urb = NULL;
 }
@@ -457,8 +455,7 @@ st5481_setup_isocpipes(struct urb* urb[2
  err:
 	for (j = 0; j < 2; j++) {
 		if (urb[j]) {
-			if (urb[j]->transfer_buffer)
-				kfree(urb[j]->transfer_buffer);
+			kfree(urb[j]->transfer_buffer);
 			urb[j]->transfer_buffer = NULL;
 			usb_free_urb(urb[j]);
 			urb[j] = NULL;
@@ -473,8 +470,7 @@ void st5481_release_isocpipes(struct urb
 
 	for (j = 0; j < 2; j++) {
 		usb_kill_urb(urb[j]);
-		if (urb[j]->transfer_buffer)
-			kfree(urb[j]->transfer_buffer);			
+		kfree(urb[j]->transfer_buffer);			
 		usb_free_urb(urb[j]);
 		urb[j] = NULL;
 	}
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/config.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/config.c	2005-10-12 16:49:02.000000000 +0200
@@ -787,8 +787,7 @@ static void ll_unload(struct IsdnCardSta
 	ic.command = ISDN_STAT_UNLOAD;
 	ic.driver = cs->myid;
 	cs->iif.statcallb(&ic);
-	if (cs->status_buf)
-		kfree(cs->status_buf);
+	kfree(cs->status_buf);
 	cs->status_read = NULL;
 	cs->status_write = NULL;
 	cs->status_end = NULL;
@@ -807,10 +806,8 @@ static void closecard(int cardnr)
 
 	skb_queue_purge(&csta->rq);
 	skb_queue_purge(&csta->sq);
-	if (csta->rcvbuf) {
-		kfree(csta->rcvbuf);
-		csta->rcvbuf = NULL;
-	}
+	kfree(csta->rcvbuf);
+	csta->rcvbuf = NULL;
 	if (csta->tx_skb) {
 		dev_kfree_skb(csta->tx_skb);
 		csta->tx_skb = NULL;
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/hfc_2bds0.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/hfc_2bds0.c	2005-10-12 16:49:35.000000000 +0200
@@ -1052,18 +1052,12 @@ init2bds0(struct IsdnCardState *cs)
 void
 release2bds0(struct IsdnCardState *cs)
 {
-	if (cs->bcs[0].hw.hfc.send) {
-		kfree(cs->bcs[0].hw.hfc.send);
-		cs->bcs[0].hw.hfc.send = NULL;
-	}
-	if (cs->bcs[1].hw.hfc.send) {
-		kfree(cs->bcs[1].hw.hfc.send);
-		cs->bcs[1].hw.hfc.send = NULL;
-	}
-	if (cs->hw.hfcD.send) {
-		kfree(cs->hw.hfcD.send);
-		cs->hw.hfcD.send = NULL;
-	}
+	kfree(cs->bcs[0].hw.hfc.send);
+	cs->bcs[0].hw.hfc.send = NULL;
+	kfree(cs->bcs[1].hw.hfc.send);
+	cs->bcs[1].hw.hfc.send = NULL;
+	kfree(cs->hw.hfcD.send);
+	cs->hw.hfcD.send = NULL;
 }
 
 void
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/hscx.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/hscx.c	2005-10-12 16:49:55.000000000 +0200
@@ -156,14 +156,10 @@ close_hscxstate(struct BCState *bcs)
 {
 	modehscx(bcs, 0, bcs->channel);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.hscx.rcvbuf) {
-			kfree(bcs->hw.hscx.rcvbuf);
-			bcs->hw.hscx.rcvbuf = NULL;
-		}
-		if (bcs->blog) {
-			kfree(bcs->blog);
-			bcs->blog = NULL;
-		}
+		kfree(bcs->hw.hscx.rcvbuf);
+		bcs->hw.hscx.rcvbuf = NULL;
+		kfree(bcs->blog);
+		bcs->blog = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/jade.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/jade.c	2005-10-12 16:50:08.000000000 +0200
@@ -195,14 +195,10 @@ close_jadestate(struct BCState *bcs)
 {
     modejade(bcs, 0, bcs->channel);
     if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-	if (bcs->hw.hscx.rcvbuf) {
-		kfree(bcs->hw.hscx.rcvbuf);
-		bcs->hw.hscx.rcvbuf = NULL;
-	}
-	if (bcs->blog) {
-		kfree(bcs->blog);
-		bcs->blog = NULL;
-	}
+	kfree(bcs->hw.hscx.rcvbuf);
+	bcs->hw.hscx.rcvbuf = NULL;
+	kfree(bcs->blog);
+	bcs->blog = NULL;
 	skb_queue_purge(&bcs->rqueue);
 	skb_queue_purge(&bcs->squeue);
 	if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/isac.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/isac.c	2005-10-12 16:50:39.000000000 +0200
@@ -570,15 +570,12 @@ setstack_isac(struct PStack *st, struct 
 }
 
 static void
-DC_Close_isac(struct IsdnCardState *cs) {
-	if (cs->dc.isac.mon_rx) {
-		kfree(cs->dc.isac.mon_rx);
-		cs->dc.isac.mon_rx = NULL;
-	}
-	if (cs->dc.isac.mon_tx) {
-		kfree(cs->dc.isac.mon_tx);
-		cs->dc.isac.mon_tx = NULL;
-	}
+DC_Close_isac(struct IsdnCardState *cs)
+{
+	kfree(cs->dc.isac.mon_rx);
+	cs->dc.isac.mon_rx = NULL;
+	kfree(cs->dc.isac.mon_tx);
+	cs->dc.isac.mon_tx = NULL;
 }
 
 static void
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/isar.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/isar.c	2005-10-12 16:50:55.000000000 +0200
@@ -1688,10 +1688,8 @@ close_isarstate(struct BCState *bcs)
 {
 	modeisar(bcs, 0, bcs->channel);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.isar.rcvbuf) {
-			kfree(bcs->hw.isar.rcvbuf);
-			bcs->hw.isar.rcvbuf = NULL;
-		}
+		kfree(bcs->hw.isar.rcvbuf);
+		bcs->hw.isar.rcvbuf = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/netjet.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/netjet.c	2005-10-12 16:51:58.000000000 +0200
@@ -855,14 +855,10 @@ close_tigerstate(struct BCState *bcs)
 {
 	mode_tiger(bcs, 0, bcs->channel);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.tiger.rcvbuf) {
-			kfree(bcs->hw.tiger.rcvbuf);
-			bcs->hw.tiger.rcvbuf = NULL;
-		}
-		if (bcs->hw.tiger.sendbuf) {
-			kfree(bcs->hw.tiger.sendbuf);
-			bcs->hw.tiger.sendbuf = NULL;
-		}
+		kfree(bcs->hw.tiger.rcvbuf);
+		bcs->hw.tiger.rcvbuf = NULL;
+		kfree(bcs->hw.tiger.sendbuf);
+		bcs->hw.tiger.sendbuf = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
@@ -967,20 +963,12 @@ inittiger(struct IsdnCardState *cs)
 static void
 releasetiger(struct IsdnCardState *cs)
 {
-	if (cs->bcs[0].hw.tiger.send) {
-		kfree(cs->bcs[0].hw.tiger.send);
-		cs->bcs[0].hw.tiger.send = NULL;
-	}
-	if (cs->bcs[1].hw.tiger.send) {
-		cs->bcs[1].hw.tiger.send = NULL;
-	}
-	if (cs->bcs[0].hw.tiger.rec) {
-		kfree(cs->bcs[0].hw.tiger.rec);
-		cs->bcs[0].hw.tiger.rec = NULL;
-	}
-	if (cs->bcs[1].hw.tiger.rec) {
-		cs->bcs[1].hw.tiger.rec = NULL;
-	}
+	kfree(cs->bcs[0].hw.tiger.send);
+	cs->bcs[0].hw.tiger.send = NULL;
+	cs->bcs[1].hw.tiger.send = NULL;
+	kfree(cs->bcs[0].hw.tiger.rec);
+	cs->bcs[0].hw.tiger.rec = NULL;
+	cs->bcs[1].hw.tiger.rec = NULL;
 }
 
 void
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/ipacx.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/ipacx.c	2005-10-12 16:52:17.000000000 +0200
@@ -762,14 +762,10 @@ bch_close_state(struct BCState *bcs)
 {
 	bch_mode(bcs, 0, bcs->channel);
 	if (test_and_clear_bit(BC_FLG_INIT, &bcs->Flag)) {
-		if (bcs->hw.hscx.rcvbuf) {
-			kfree(bcs->hw.hscx.rcvbuf);
-			bcs->hw.hscx.rcvbuf = NULL;
-		}
-		if (bcs->blog) {
-			kfree(bcs->blog);
-			bcs->blog = NULL;
-		}
+		kfree(bcs->hw.hscx.rcvbuf);
+		bcs->hw.hscx.rcvbuf = NULL;
+		kfree(bcs->blog);
+		bcs->blog = NULL;
 		skb_queue_purge(&bcs->rqueue);
 		skb_queue_purge(&bcs->squeue);
 		if (bcs->tx_skb) {
--- linux-2.6.14-rc4-orig/drivers/isdn/hisax/avma1_cs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hisax/avma1_cs.c	2005-10-12 16:52:48.000000000 +0200
@@ -236,9 +236,7 @@ static void avma1cs_detach(dev_link_t *l
     
     /* Unlink device structure, free pieces */
     *linkp = link->next;
-    if (link->priv) {
-	kfree(link->priv);
-    }
+    kfree(link->priv);
     kfree(link);
     
 } /* avma1cs_detach */
--- linux-2.6.14-rc4-orig/drivers/isdn/hysdn/hysdn_procconf.c	2005-10-11 22:41:09.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hysdn/hysdn_procconf.c	2005-10-12 16:53:53.000000000 +0200
@@ -359,8 +359,7 @@ hysdn_conf_close(struct inode *ino, stru
 	} else if ((filep->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
 		/* read access -> output card info data */
 
-		if (filep->private_data)
-			kfree(filep->private_data);	/* release memory */
+		kfree(filep->private_data);	/* release memory */
 	}
 	unlock_kernel();
 	return (retval);
--- linux-2.6.14-rc4-orig/drivers/isdn/pcbit/drv.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/pcbit/drv.c	2005-10-12 16:54:41.000000000 +0200
@@ -561,10 +561,8 @@ void pcbit_l3_receive(struct pcbit_dev *
 		else
 			pcbit_fsm_event(dev, chan, EV_USR_RELEASE_REQ, NULL);
 
-		if (cbdata.data.setup.CalledPN)
-			kfree(cbdata.data.setup.CalledPN);
-		if (cbdata.data.setup.CallingPN)
-			kfree(cbdata.data.setup.CallingPN);
+		kfree(cbdata.data.setup.CalledPN);
+		kfree(cbdata.data.setup.CallingPN);
 		break;
     
 	case MSG_CONN_CONF:
--- linux-2.6.14-rc4-orig/drivers/isdn/hardware/avm/avm_cs.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/drivers/isdn/hardware/avm/avm_cs.c	2005-10-12 16:55:21.000000000 +0200
@@ -212,11 +212,8 @@ static void avmcs_detach(dev_link_t *lin
     
     /* Unlink device structure, free pieces */
     *linkp = link->next;
-    if (link->priv) {
-	kfree(link->priv);
-    }
+    kfree(link->priv);
     kfree(link);
-    
 } /* avmcs_detach */
 
 /*======================================================================



