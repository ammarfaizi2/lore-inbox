Return-Path: <linux-kernel-owner+w=401wt.eu-S1752703AbWLRDqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbWLRDqY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbWLRDqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4280 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752703AbWLRDqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:23 -0500
Date: Mon, 18 Dec 2006 04:46:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/hisax/: proper prototypes
Message-ID: <20061218034623.GX10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
- adds functions protutypes for some global functions to header files
- removes unneeded "extern"s from some function prototypes

You might note that this patch results in a new warning - that's due to 
the fact that with a proper prototype gcc is able to discover a broken 
work_struct conversion.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/hisax/isar.c   |    1 -
 drivers/isdn/hisax/isdnl1.h |   17 ++++++++---------
 drivers/isdn/hisax/isdnl3.c |   12 ------------
 drivers/isdn/hisax/isdnl3.h |   26 ++++++++++++++++----------
 4 files changed, 24 insertions(+), 32 deletions(-)

--- linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl1.h.old	2006-12-18 01:33:36.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl1.h	2006-12-18 01:37:57.000000000 +0100
@@ -21,12 +21,11 @@
 #define B_XMTBUFREADY	1
 #define B_ACKPENDING	2
 
-extern void debugl1(struct IsdnCardState *cs, char *fmt, ...);
-extern void DChannel_proc_xmt(struct IsdnCardState *cs);
-extern void DChannel_proc_rcv(struct IsdnCardState *cs);
-extern void l1_msg(struct IsdnCardState *cs, int pr, void *arg);
-extern void l1_msg_b(struct PStack *st, int pr, void *arg);
-
-#ifdef L2FRAME_DEBUG
-extern void Logl2Frame(struct IsdnCardState *cs, struct sk_buff *skb, char *buf, int dir);
-#endif
+void debugl1(struct IsdnCardState *cs, char *fmt, ...);
+void DChannel_proc_xmt(struct IsdnCardState *cs);
+void DChannel_proc_rcv(struct IsdnCardState *cs);
+void l1_msg(struct IsdnCardState *cs, int pr, void *arg);
+void l1_msg_b(struct PStack *st, int pr, void *arg);
+void Logl2Frame(struct IsdnCardState *cs, struct sk_buff *skb, char *buf,
+		int dir);
+void BChannel_bh(struct work_struct *work);
--- linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isar.c.old	2006-12-18 01:36:35.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isar.c	2006-12-18 01:36:46.000000000 +0100
@@ -431,7 +431,6 @@
 	return(ret);
 }
 
-extern void BChannel_bh(struct BCState *);
 #define B_LL_NOCARRIER	8
 #define B_LL_CONNECT	9
 #define B_LL_OK		10
--- linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl3.h.old	2006-12-18 01:48:05.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl3.h	2006-12-18 01:48:58.000000000 +0100
@@ -25,13 +25,19 @@
 
 #define l3_debug(st, fmt, args...) HiSax_putstatus(st->l1.hardware, "l3 ", fmt, ## args)
 
-extern void newl3state(struct l3_process *pc, int state);
-extern void L3InitTimer(struct l3_process *pc, struct L3Timer *t);
-extern void L3DelTimer(struct L3Timer *t);
-extern int L3AddTimer(struct L3Timer *t, int millisec, int event);
-extern void StopAllL3Timer(struct l3_process *pc);
-extern struct sk_buff *l3_alloc_skb(int len);
-extern struct l3_process *new_l3_process(struct PStack *st, int cr);
-extern void release_l3_process(struct l3_process *p);
-extern struct l3_process *getl3proc(struct PStack *st, int cr);
-extern void l3_msg(struct PStack *st, int pr, void *arg);
+struct PStack;
+
+void newl3state(struct l3_process *pc, int state);
+void L3InitTimer(struct l3_process *pc, struct L3Timer *t);
+void L3DelTimer(struct L3Timer *t);
+int L3AddTimer(struct L3Timer *t, int millisec, int event);
+void StopAllL3Timer(struct l3_process *pc);
+struct sk_buff *l3_alloc_skb(int len);
+struct l3_process *new_l3_process(struct PStack *st, int cr);
+void release_l3_process(struct l3_process *p);
+struct l3_process *getl3proc(struct PStack *st, int cr);
+void l3_msg(struct PStack *st, int pr, void *arg);
+void setstack_dss1(struct PStack *st);
+void setstack_ni1(struct PStack *st);
+void setstack_1tr6(struct PStack *st);
+
--- linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl3.c.old	2006-12-18 01:40:08.000000000 +0100
+++ linux-2.6.20-rc1-mm1/drivers/isdn/hisax/isdnl3.c	2006-12-18 01:51:38.000000000 +0100
@@ -231,18 +231,6 @@
 	return(-1);
 }
 
-#ifdef	CONFIG_HISAX_EURO
-extern void setstack_dss1(struct PStack *st);
-#endif
-
-#ifdef  CONFIG_HISAX_NI1
-extern void setstack_ni1(struct PStack *st);
-#endif
-
-#ifdef	CONFIG_HISAX_1TR6
-extern void setstack_1tr6(struct PStack *st);
-#endif
-
 struct l3_process
 *getl3proc(struct PStack *st, int cr)
 {

