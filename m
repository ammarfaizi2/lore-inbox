Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269382AbUI3R77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269382AbUI3R77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUI3R76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 13:59:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16849 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269382AbUI3R6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 13:58:23 -0400
Date: Thu, 30 Sep 2004 13:58:00 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: PATCH: Fix up tty patch problem with pc300 and clean up braces
Message-ID: <20040930175800.GA2037@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/net/wan/pc300_tty.c linux-2.6.9rc3/drivers/net/wan/pc300_tty.c
--- linux.vanilla-2.6.9rc3/drivers/net/wan/pc300_tty.c	2004-09-30 16:13:09.075305760 +0100
+++ linux-2.6.9rc3/drivers/net/wan/pc300_tty.c	2004-09-30 17:02:18.400940112 +0100
@@ -192,13 +192,14 @@
  */
 void cpc_tty_init(pc300dev_t *pc300dev)
 {
-	int port, aux;
+	unsigned long port;
+	int aux;
 	st_cpc_tty_area * cpc_tty;
 
 	/* hdlcX - X=interface number */
 	port = pc300dev->dev->name[4] - '0';
 	if (port >= CPC_TTY_NPORTS) {
-		printk("%s-tty: invalid interface selected (0-%i): %i", 
+		printk("%s-tty: invalid interface selected (0-%i): %li", 
 			pc300dev->dev->name,
 			CPC_TTY_NPORTS-1,port);
 		return;
@@ -682,7 +683,8 @@
  */
 static void cpc_tty_rx_work(void * data)
 {
-	int port, i, j;
+	unsigned long port;
+	int i, j;
 	st_cpc_tty_area *cpc_tty; 
 	volatile st_cpc_rx_buf * buf;
 	char flags=0,flg_rx=1; 
@@ -693,18 +695,15 @@
 	
 	for (i=0; (i < 4) && flg_rx ; i++) {
 		flg_rx = 0;
-		port = (int) data;
+		port = (unsigned long) data;
 		for (j=0; j < CPC_TTY_NPORTS; j++) {
 			cpc_tty = &cpc_tty_area[port];
 		
 			if ((buf=cpc_tty->buf_rx.first) != 0) {
-				
-				if(cpc_tty->tty)
-				{											
-					ld = tty_ldisc_ref(cpc_tty);
-					if(ld)
-					{
-						if (ld->receive_buf)) {
+				if(cpc_tty->tty) {
+					ld = tty_ldisc_ref(cpc_tty->tty);
+					if(ld) {
+						if (ld->receive_buf) {
 							CPC_TTY_DBG("%s: call line disc. receive_buf\n",cpc_tty->name);
 							ld->receive_buf(cpc_tty->tty, (char *)(buf->data), &flags, buf->size);
 						}
