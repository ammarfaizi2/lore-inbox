Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVCON40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVCON40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVCON40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:56:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:17381 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261240AbVCON4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:56:19 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16950.59776.558798.85852@alkaid.it.uu.se>
Date: Tue, 15 Mar 2005 14:56:16 +0100
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] drivers/char/isicom.c gcc4 fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two array-of-incomplete-type errors from gcc4 in isicom.c.

/Mikael

--- linux-2.6.11/drivers/char/isicom.c.~1~	2005-03-02 19:24:15.000000000 +0100
+++ linux-2.6.11/drivers/char/isicom.c	2005-03-15 11:37:03.000000000 +0100
@@ -151,9 +151,6 @@ MODULE_DEVICE_TABLE(pci, isicom_pci_tbl)
 static int prev_card = 3;	/*	start servicing isi_card[0]	*/
 static struct tty_driver *isicom_normal;
 
-static struct isi_board isi_card[BOARD_COUNT];
-static struct isi_port  isi_ports[PORT_COUNT];
-
 static struct timer_list tx;
 static char re_schedule = 1;
 #ifdef ISICOM_DEBUG
@@ -210,6 +207,9 @@ struct	isi_port {
 	int			xmit_cnt;
 };
 
+static struct isi_board isi_card[BOARD_COUNT];
+static struct isi_port  isi_ports[PORT_COUNT];
+
 /*
  *	Locking functions for card level locking. We need to own both
  *	the kernel lock for the card and have the card in a position that
