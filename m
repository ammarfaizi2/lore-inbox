Return-Path: <linux-kernel-owner+w=401wt.eu-S1751508AbWLLQYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWLLQYZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 11:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWLLQYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 11:24:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3399 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751528AbWLLQYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 11:24:06 -0500
Date: Tue, 12 Dec 2006 17:24:16 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/pcbit/: proper prototypes
Message-ID: <20061212162416.GV28443@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds correct prototypes in header files for global functions 
and variables.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/pcbit/drv.c    |    4 ----
 drivers/isdn/pcbit/edss1.c  |    6 ------
 drivers/isdn/pcbit/edss1.h  |    7 +++++--
 drivers/isdn/pcbit/layer2.c |   16 ----------------
 drivers/isdn/pcbit/module.c |    3 ---
 drivers/isdn/pcbit/pcbit.h  |    8 +++++++-
 6 files changed, 12 insertions(+), 32 deletions(-)

--- linux-2.6.19-mm1/drivers/isdn/pcbit/edss1.h.old	2006-12-12 15:00:56.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/edss1.h	2006-12-12 15:09:07.000000000 +0100
@@ -90,9 +90,12 @@
 	unsigned long timeout;          /* in seconds */
 };
 
+extern char * isdn_state_table[];
+
+void pcbit_fsm_event(struct pcbit_dev *, struct pcbit_chan *,
+		     unsigned short event, struct callb_data *);
+char * strisdnevent(ushort ev);
 
-extern void pcbit_fsm_event(struct pcbit_dev *, struct pcbit_chan *,
-			    unsigned short event, struct callb_data *);
 #endif
 
 
--- linux-2.6.19-mm1/drivers/isdn/pcbit/pcbit.h.old	2006-12-12 15:03:03.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/pcbit.h	2006-12-12 15:07:40.000000000 +0100
@@ -166,6 +166,12 @@
 #define L2_RUNNING  5
 #define L2_ERROR    6
 
-extern void pcbit_deliver(struct work_struct *work);
+void pcbit_deliver(struct work_struct *work);
+int pcbit_init_dev(int board, int mem_base, int irq);
+void pcbit_terminate(int board);
+void pcbit_l3_receive(struct pcbit_dev * dev, ulong msg, struct sk_buff * skb,
+		      ushort hdr_len, ushort refnum);
+void pcbit_state_change(struct pcbit_dev * dev, struct pcbit_chan * chan, 
+			unsigned short i, unsigned short ev, unsigned short f);
 
 #endif
--- linux-2.6.19-mm1/drivers/isdn/pcbit/drv.c.old	2006-12-12 15:01:38.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/drv.c	2006-12-12 15:01:53.000000000 +0100
@@ -774,10 +774,6 @@
 	dev->dev_if->statcallb(&ictl);
 }
 	
-extern char * isdn_state_table[];
-extern char * strisdnevent(unsigned short);
-
-
 void pcbit_state_change(struct pcbit_dev * dev, struct pcbit_chan * chan, 
 			unsigned short i, unsigned short ev, unsigned short f)
 {
--- linux-2.6.19-mm1/drivers/isdn/pcbit/module.c.old	2006-12-12 15:03:34.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/module.c	2006-12-12 15:03:45.000000000 +0100
@@ -32,9 +32,6 @@
 static int num_boards;
 struct pcbit_dev * dev_pcbit[MAX_PCBIT_CARDS];
 
-extern void pcbit_terminate(int board);
-extern int pcbit_init_dev(int board, int mem_base, int irq);
-
 static int __init pcbit_init(void)
 {
 	int board;
--- linux-2.6.19-mm1/drivers/isdn/pcbit/layer2.c.old	2006-12-12 15:06:48.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/layer2.c	2006-12-12 15:07:01.000000000 +0100
@@ -47,22 +47,6 @@
 #undef DEBUG_FRAG
 
 
-
-/*
- *  task queue struct
- */
-
-
-
-/*
- *  Layer 3 packet demultiplexer
- *  drv.c
- */
-
-extern void pcbit_l3_receive(struct pcbit_dev *dev, ulong msg,
-			     struct sk_buff *skb,
-			     ushort hdr_len, ushort refnum);
-
 /*
  *  Prototypes
  */
--- linux-2.6.19-mm1/drivers/isdn/pcbit/edss1.c.old	2006-12-12 15:07:50.000000000 +0100
+++ linux-2.6.19-mm1/drivers/isdn/pcbit/edss1.c	2006-12-12 15:07:59.000000000 +0100
@@ -35,12 +35,6 @@
 #include "callbacks.h"
 
 
-extern void pcbit_state_change(struct pcbit_dev *, struct pcbit_chan *, 
-                               unsigned short i, unsigned short ev, 
-                               unsigned short f);
-
-extern struct pcbit_dev * dev_pcbit[MAX_PCBIT_CARDS];
-
 char * isdn_state_table[] = {
   "Closed",
   "Call initiated",

