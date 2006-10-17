Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751347AbWJQRaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWJQRaI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJQRaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 13:30:08 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:59088 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751347AbWJQRaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 13:30:01 -0400
Date: Tue, 17 Oct 2006 19:29:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: akpm@osdl.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Remove double cast to same type
Message-ID: <Pine.LNX.4.61.0610171926280.23609@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As the subject says, a simple patch to remove double-casts to the same 
type, such as (void *)(void *)foobar (which becomes just
(void *)foobar).
Also remove the (int) cast in fs/cifs/connect.c at the same go.


Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
---

 drivers/isdn/hisax/amd7930_fn.c   |    2 +-
 drivers/isdn/hisax/config.c       |    2 +-
 drivers/isdn/hisax/hfc_2bds0.c    |    2 +-
 drivers/isdn/hisax/hfc_pci.c      |    2 +-
 drivers/isdn/hisax/hfc_sx.c       |    2 +-
 drivers/isdn/hisax/icc.c          |    2 +-
 drivers/isdn/hisax/isac.c         |    2 +-
 drivers/isdn/hisax/isar.c         |    2 +-
 drivers/isdn/hisax/isdnl1.c       |    2 +-
 drivers/isdn/hisax/w6692.c        |    2 +-
 drivers/isdn/i4l/isdn_net.c       |    2 +-
 drivers/net/hamradio/baycom_epp.c |    2 +-
 fs/cifs/connect.c                 |    2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

---
Index: linux-2.6.19-rc2/drivers/isdn/hisax/amd7930_fn.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/amd7930_fn.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/amd7930_fn.c
@@ -789,7 +789,7 @@ Amd7930_init(struct IsdnCardState *cs)
 void __devinit
 setup_Amd7930(struct IsdnCardState *cs)
 {
-        INIT_WORK(&cs->tqueue, (void *)(void *) Amd7930_bh, cs);
+        INIT_WORK(&cs->tqueue, (void *)Amd7930_bh, cs);
 	cs->dbusytimer.function = (void *) dbusy_timer_handler;
 	cs->dbusytimer.data = (long) cs;
 	init_timer(&cs->dbusytimer);
Index: linux-2.6.19-rc2/drivers/isdn/hisax/config.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/config.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/config.c
@@ -1584,7 +1584,7 @@ int hisax_register(struct hisax_d_if *hi
 	hisax_d_if->cs = cs;
 	cs->hw.hisax_d_if = hisax_d_if;
 	cs->cardmsg = hisax_cardmsg;
-	INIT_WORK(&cs->tqueue, (void *)(void *)hisax_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)hisax_bh, cs);
 	cs->channel[0].d_st->l2.l2l1 = hisax_d_l2l1;
 	for (i = 0; i < 2; i++) {
 		cs->bcs[i].BC_SetStack = hisax_bc_setstack;
Index: linux-2.6.19-rc2/drivers/isdn/hisax/hfc_2bds0.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/hfc_2bds0.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/hfc_2bds0.c
@@ -1072,5 +1072,5 @@ set_cs_func(struct IsdnCardState *cs)
 	cs->dbusytimer.function = (void *) hfc_dbusy_timer;
 	cs->dbusytimer.data = (long) cs;
 	init_timer(&cs->dbusytimer);
-	INIT_WORK(&cs->tqueue, (void *)(void *) hfcd_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)hfcd_bh, cs);
 }
Index: linux-2.6.19-rc2/drivers/isdn/hisax/hfc_pci.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/hfc_pci.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/hfc_pci.c
@@ -1722,7 +1722,7 @@ setup_hfcpci(struct IsdnCard *card)
 		Write_hfc(cs, HFCPCI_INT_M2, cs->hw.hfcpci.int_m2);
 		/* At this point the needed PCI config is done */
 		/* fifos are still not enabled */
-		INIT_WORK(&cs->tqueue, (void *)(void *) hfcpci_bh, cs);
+		INIT_WORK(&cs->tqueue, (void *)hfcpci_bh, cs);
 		cs->setstack_d = setstack_hfcpci;
 		cs->BC_Send_Data = &hfcpci_send_data;
 		cs->readisac = NULL;
Index: linux-2.6.19-rc2/drivers/isdn/hisax/hfc_sx.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/hfc_sx.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/hfc_sx.c
@@ -1499,7 +1499,7 @@ setup_hfcsx(struct IsdnCard *card)
 	cs->dbusytimer.function = (void *) hfcsx_dbusy_timer;
 	cs->dbusytimer.data = (long) cs;
 	init_timer(&cs->dbusytimer);
-	INIT_WORK(&cs->tqueue, (void *)(void *) hfcsx_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)hfcsx_bh, cs);
 	cs->readisac = NULL;
 	cs->writeisac = NULL;
 	cs->readisacfifo = NULL;
Index: linux-2.6.19-rc2/drivers/isdn/hisax/icc.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/icc.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/icc.c
@@ -674,7 +674,7 @@ clear_pending_icc_ints(struct IsdnCardSt
 void __devinit
 setup_icc(struct IsdnCardState *cs)
 {
-	INIT_WORK(&cs->tqueue, (void *)(void *) icc_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)icc_bh, cs);
 	cs->dbusytimer.function = (void *) dbusy_timer_handler;
 	cs->dbusytimer.data = (long) cs;
 	init_timer(&cs->dbusytimer);
Index: linux-2.6.19-rc2/drivers/isdn/hisax/isac.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/isac.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/isac.c
@@ -674,7 +674,7 @@ clear_pending_isac_ints(struct IsdnCardS
 void __devinit
 setup_isac(struct IsdnCardState *cs)
 {
-	INIT_WORK(&cs->tqueue, (void *)(void *) isac_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)isac_bh, cs);
 	cs->dbusytimer.function = (void *) dbusy_timer_handler;
 	cs->dbusytimer.data = (long) cs;
 	init_timer(&cs->dbusytimer);
Index: linux-2.6.19-rc2/drivers/isdn/hisax/isar.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/isar.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/isar.c
@@ -1580,7 +1580,7 @@ isar_setup(struct IsdnCardState *cs)
 		cs->bcs[i].mode = 0;
 		cs->bcs[i].hw.isar.dpath = i + 1;
 		modeisar(&cs->bcs[i], 0, 0);
-		INIT_WORK(&cs->bcs[i].tqueue, (void *)(void *) isar_bh, &cs->bcs[i]);
+		INIT_WORK(&cs->bcs[i].tqueue, (void *)isar_bh, &cs->bcs[i]);
 	}
 }
 
Index: linux-2.6.19-rc2/drivers/isdn/hisax/isdnl1.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/isdnl1.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/isdnl1.c
@@ -362,7 +362,7 @@ init_bcstate(struct IsdnCardState *cs, i
 
 	bcs->cs = cs;
 	bcs->channel = bc;
-	INIT_WORK(&bcs->tqueue, (void *)(void *) BChannel_bh, bcs);
+	INIT_WORK(&bcs->tqueue, (void *)BChannel_bh, bcs);
 	spin_lock_init(&bcs->aclock);
 	bcs->BC_SetStack = NULL;
 	bcs->BC_Close = NULL;
Index: linux-2.6.19-rc2/drivers/isdn/hisax/w6692.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/hisax/w6692.c
+++ linux-2.6.19-rc2/drivers/isdn/hisax/w6692.c
@@ -1070,7 +1070,7 @@ setup_w6692(struct IsdnCard *card)
 	       id_list[cs->subtyp].card_name, cs->irq,
 	       cs->hw.w6692.iobase);
 
-	INIT_WORK(&cs->tqueue, (void *)(void *) W6692_bh, cs);
+	INIT_WORK(&cs->tqueue, (void *)W6692_bh, cs);
 	cs->readW6692 = &ReadW6692;
 	cs->writeW6692 = &WriteW6692;
 	cs->readisacfifo = &ReadISACfifo;
Index: linux-2.6.19-rc2/drivers/isdn/i4l/isdn_net.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/isdn/i4l/isdn_net.c
+++ linux-2.6.19-rc2/drivers/isdn/i4l/isdn_net.c
@@ -2596,7 +2596,7 @@ isdn_net_new(char *name, struct net_devi
 	netdev->local->netdev = netdev;
 	netdev->local->next = netdev->local;
 
-	INIT_WORK(&netdev->local->tqueue, (void *)(void *) isdn_net_softint, netdev->local);
+	INIT_WORK(&netdev->local->tqueue, (void *)isdn_net_softint, netdev->local);
 	spin_lock_init(&netdev->local->xmit_lock);
 
 	netdev->local->isdn_device = -1;
Index: linux-2.6.19-rc2/drivers/net/hamradio/baycom_epp.c
===================================================================
--- linux-2.6.19-rc2.orig/drivers/net/hamradio/baycom_epp.c
+++ linux-2.6.19-rc2/drivers/net/hamradio/baycom_epp.c
@@ -889,7 +889,7 @@ static int epp_open(struct net_device *d
                 return -EBUSY;
         }
         dev->irq = /*pp->irq*/ 0;
-	INIT_WORK(&bc->run_work, (void *)(void *)epp_bh, dev);
+	INIT_WORK(&bc->run_work, (void *)epp_bh, dev);
 	bc->work_running = 1;
 	bc->modem = EPP_CONVENTIONAL;
 	if (eppconfig(bc))
Index: linux-2.6.19-rc2/fs/cifs/connect.c
===================================================================
--- linux-2.6.19-rc2.orig/fs/cifs/connect.c
+++ linux-2.6.19-rc2/fs/cifs/connect.c
@@ -1774,7 +1774,7 @@ cifs_mount(struct super_block *sb, struc
 			so no need to spinlock this init of tcpStatus */
 			srvTcp->tcpStatus = CifsNew;
 			init_MUTEX(&srvTcp->tcpSem);
-			rc = (int)kernel_thread((void *)(void *)cifs_demultiplex_thread, srvTcp,
+			rc = kernel_thread((void *)cifs_demultiplex_thread, srvTcp,
 				      CLONE_FS | CLONE_FILES | CLONE_VM);
 			if(rc < 0) {
 				rc = -ENOMEM;
#<EOF>

quilt is good stuff..

	-`J'
-- 
