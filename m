Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVDAXjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVDAXjF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVDAXjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:39:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1298 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262801AbVDAXix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:38:53 -0500
Date: Sat, 2 Apr 2005 01:38:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Scott_Kilau@digi.com, wendyx@us.ltcfwd.linux.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch drivers/serial/jsm/: make 2 functions static
Message-ID: <20050401233851.GB5906@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/serial/jsm/jsm.h     |    1 -
 drivers/serial/jsm/jsm_neo.c |    2 +-
 drivers/serial/jsm/jsm_tty.c |    4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_neo.c.old	2005-04-02 00:20:17.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_neo.c	2005-04-02 00:20:34.000000000 +0200
@@ -688,7 +688,7 @@
 /*
  * No locks are assumed to be held when calling this function.
  */
-void neo_clear_break(struct jsm_channel *ch, int force)
+static void neo_clear_break(struct jsm_channel *ch, int force)
 {
 	u64 lock_flags;
 
--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm.h.old	2005-04-02 00:20:44.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm.h	2005-04-02 00:20:54.000000000 +0200
@@ -393,7 +393,6 @@
 int jsm_uart_port_init(struct jsm_board *);
 int jsm_remove_uart_port(struct jsm_board *);
 void jsm_input(struct jsm_channel *ch);
-void jsm_carrier(struct jsm_channel *ch);
 void jsm_check_queue_flow_control(struct jsm_channel *ch);
 
 #endif
--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_tty.c.old	2005-04-02 00:21:02.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_tty.c	2005-04-02 00:21:18.000000000 +0200
@@ -31,6 +31,8 @@
 
 #include "jsm.h"
 
+static void jsm_carrier(struct jsm_channel *ch);
+
 static inline int jsm_get_mstat(struct jsm_channel *ch)
 {
 	unsigned char mstat;
@@ -760,7 +762,7 @@
 	jsm_printk(IOCTL, INFO, &ch->ch_bd->pci_dev, "finish\n");
 }
 
-void jsm_carrier(struct jsm_channel *ch)
+static void jsm_carrier(struct jsm_channel *ch)
 {
 	struct jsm_board *bd;
 

