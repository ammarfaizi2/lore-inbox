Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVDJAFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVDJAFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 20:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261419AbVDJAFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 20:05:38 -0400
Received: from mtk-sms-mail01.digi.com ([66.77.174.18]:42816 "EHLO
	mtk-sms-mail01.digi.com") by vger.kernel.org with ESMTP
	id S261418AbVDJAFY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 20:05:24 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] drivers/serial/jsm/: make 2 functions static
Date: Sat, 9 Apr 2005 19:03:33 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F01F92D@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/serial/jsm/: make 2 functions static
Thread-Index: AcU9LozwUl3eoQZrTHCc6iFrvDUloQAMi8UZ
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Adrian for helping clean up the driver.
 
Wendy will integrate your patch into our source tree.
 
Scott

________________________________

From: Adrian Bunk [mailto:bunk@stusta.de]
Sent: Sat 4/9/2005 1:04 PM
To: Andrew Morton
Cc: Kilau, Scott; linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/serial/jsm/: make 2 functions static



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:   Sat, 2 Apr 2005 01:38:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Scott_Kilau@digi.com, wendyx@us.ltcfwd.linux.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch drivers/serial/jsm/: make 2 functions static

This patch makes two needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Apr 2005

 drivers/serial/jsm/jsm.h     |    1 -
 drivers/serial/jsm/jsm_neo.c |    2 +-
 drivers/serial/jsm/jsm_tty.c |    4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_neo.c.old  2005-04-02 00:20:17.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_neo.c      2005-04-02 00:20:34.000000000 +0200
@@ -688,7 +688,7 @@
 /*
  * No locks are assumed to be held when calling this function.
  */
-void neo_clear_break(struct jsm_channel *ch, int force)
+static void neo_clear_break(struct jsm_channel *ch, int force)
 {
        u64 lock_flags;

--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm.h.old      2005-04-02 00:20:44.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm.h  2005-04-02 00:20:54.000000000 +0200
@@ -393,7 +393,6 @@
 int jsm_uart_port_init(struct jsm_board *);
 int jsm_remove_uart_port(struct jsm_board *);
 void jsm_input(struct jsm_channel *ch);
-void jsm_carrier(struct jsm_channel *ch);
 void jsm_check_queue_flow_control(struct jsm_channel *ch);

 #endif
--- linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_tty.c.old  2005-04-02 00:21:02.000000000 +0200
+++ linux-2.6.12-rc1-mm4-full/drivers/serial/jsm/jsm_tty.c      2005-04-02 00:21:18.000000000 +0200
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




