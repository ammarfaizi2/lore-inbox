Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268261AbVBFBPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268261AbVBFBPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 20:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270170AbVBFBPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 20:15:34 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268261AbVBFAry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:47:54 -0500
Date: Sun, 6 Feb 2005 01:47:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/hisax/: possible cleanups
Message-ID: <20050206004751.GM3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global code static
- remove the compiled but unused st5481_hdlc.{c,h}
- kill enternow.h
- enternow_pci.c: kill InByte/OutByte/BYTE
- isdnl2.c: kill FreeSkb
- remove or #if 0 the following unused functions:
  - config.c: IsdnCardState
  - ipacx.c: ipacx_new_ph
  - ipacx.c: dch_bh
  - ipacx.c: setup_ipacx
  - isdnl2.c: IsRR

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/hisax/Makefile       |    2 
 drivers/isdn/hisax/amd7930_fn.c   |    8 
 drivers/isdn/hisax/asuscom.c      |    4 
 drivers/isdn/hisax/avm_pci.c      |   18 
 drivers/isdn/hisax/bkm_a4t.c      |    4 
 drivers/isdn/hisax/bkm_a8.c       |    6 
 drivers/isdn/hisax/callc.c        |    6 
 drivers/isdn/hisax/config.c       |   14 
 drivers/isdn/hisax/diva.c         |    4 
 drivers/isdn/hisax/elsa.c         |    8 
 drivers/isdn/hisax/elsa_ser.c     |   20 -
 drivers/isdn/hisax/enternow.h     |   51 --
 drivers/isdn/hisax/enternow_pci.c |   91 ++--
 drivers/isdn/hisax/gazel.c        |    5 
 drivers/isdn/hisax/hfc4s8s_l1.c   |    2 
 drivers/isdn/hisax/hfc_2bds0.c    |   12 
 drivers/isdn/hisax/hfc_2bs0.c     |   12 
 drivers/isdn/hisax/hfc_pci.c      |   12 
 drivers/isdn/hisax/hfc_pci.h      |    1 
 drivers/isdn/hisax/hfc_sx.c       |   10 
 drivers/isdn/hisax/hfc_sx.h       |    1 
 drivers/isdn/hisax/hfc_usb.c      |    6 
 drivers/isdn/hisax/hfc_usb.h      |    4 
 drivers/isdn/hisax/hfcscard.c     |    2 
 drivers/isdn/hisax/hisax.h        |    5 
 drivers/isdn/hisax/hscx.c         |    4 
 drivers/isdn/hisax/icc.c          |    6 
 drivers/isdn/hisax/ipacx.c        |   86 ----
 drivers/isdn/hisax/isac.c         |    6 
 drivers/isdn/hisax/isar.c         |   46 +-
 drivers/isdn/hisax/isdnl1.c       |    8 
 drivers/isdn/hisax/isdnl2.c       |  100 ++---
 drivers/isdn/hisax/isdnl3.c       |    2 
 drivers/isdn/hisax/isurf.c        |    2 
 drivers/isdn/hisax/ix1_micro.c    |    4 
 drivers/isdn/hisax/jade.c         |    6 
 drivers/isdn/hisax/jade.h         |    1 
 drivers/isdn/hisax/l3_1tr6.c      |    2 
 drivers/isdn/hisax/l3dss1.c       |    2 
 drivers/isdn/hisax/l3ni1.c        |    4 
 drivers/isdn/hisax/mic.c          |    4 
 drivers/isdn/hisax/netjet.c       |   12 
 drivers/isdn/hisax/niccy.c        |    4 
 drivers/isdn/hisax/nj_s.c         |    2 
 drivers/isdn/hisax/nj_u.c         |    2 
 drivers/isdn/hisax/q931.c         |    4 
 drivers/isdn/hisax/s0box.c        |    4 
 drivers/isdn/hisax/saphir.c       |    2 
 drivers/isdn/hisax/sedlbauer.c    |    6 
 drivers/isdn/hisax/sportster.c    |    6 
 drivers/isdn/hisax/st5481.h       |    4 
 drivers/isdn/hisax/st5481_hdlc.c  |  580 ------------------------------
 drivers/isdn/hisax/st5481_hdlc.h  |   62 ---
 drivers/isdn/hisax/st5481_usb.c   |   10 
 drivers/isdn/hisax/tei.c          |    2 
 drivers/isdn/hisax/teleint.c      |    4 
 drivers/isdn/hisax/teles0.c       |    4 
 drivers/isdn/hisax/teles3.c       |    4 
 drivers/isdn/hisax/telespci.c     |    4 
 drivers/isdn/hisax/w6692.c        |    6 
 60 files changed, 263 insertions(+), 1050 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/Makefile.old	2005-02-05 22:34:30.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/Makefile	2005-02-05 22:34:43.000000000 +0100
@@ -23,7 +23,7 @@
 # Multipart objects.
 
 hisax_st5481-y 				:= st5481_init.o st5481_usb.o st5481_d.o \
-					   st5481_b.o st5481_hdlc.o
+					   st5481_b.o
 
 hisax-y	  				:= config.o isdnl1.o tei.o isdnl2.o isdnl3.o \
 		     			   lmgr.o q931.o callc.o fsm.o
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/amd7930_fn.c.old	2005-02-05 20:42:15.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/amd7930_fn.c	2005-02-05 20:43:40.000000000 +0100
@@ -97,7 +97,7 @@
 };
 
 
-void /* macro wWordAMD */
+static void /* macro wWordAMD */
 WriteWordAmd7930(struct IsdnCardState *cs, BYTE reg, WORD val)
 {
         wByteAMD(cs, 0x00, reg);
@@ -105,7 +105,7 @@
         wByteAMD(cs, 0x01, HIBYTE(val));
 }
 
-WORD /* macro rWordAMD */
+static WORD /* macro rWordAMD */
 ReadWordAmd7930(struct IsdnCardState *cs, BYTE reg)
 {
         WORD res;
@@ -665,7 +665,7 @@
 	}
 }
 
-void
+static void
 setstack_Amd7930(struct PStack *st, struct IsdnCardState *cs)
 {
 
@@ -676,7 +676,7 @@
 }
 
 
-void
+static void
 DC_Close_Amd7930(struct IsdnCardState *cs) {
         if (cs->debug & L1_DEB_ISAC)
 		debugl1(cs, "Amd7930: DC_Close called");
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/asuscom.c.old	2005-02-05 20:44:34.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/asuscom.c	2005-02-05 20:53:53.000000000 +0100
@@ -22,7 +22,7 @@
 
 extern const char *CardType[];
 
-const char *Asuscom_revision = "$Revision: 1.14.2.4 $";
+static const char *Asuscom_revision = "$Revision: 1.14.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -239,7 +239,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_asuscom(struct IsdnCardState *cs)
 {
 	int bytecnt = 8;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/avm_pci.c.old	2005-02-05 21:13:17.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/avm_pci.c	2005-02-05 22:50:32.000000000 +0100
@@ -172,7 +172,7 @@
 		return(NULL);
 }
 
-void
+static void
 write_ctrl(struct BCState *bcs, int which) {
 
 	if (bcs->cs->debug & L1_DEB_HSCX)
@@ -193,7 +193,7 @@
 	}
 }
 
-void
+static void
 modehdlc(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -451,7 +451,7 @@
 	}
 }
 
-inline void
+static inline void
 HDLC_irq_main(struct IsdnCardState *cs)
 {
 	u_int stat;
@@ -487,7 +487,7 @@
 	}
 }
 
-void
+static void
 hdlc_l2l1(struct PStack *st, int pr, void *arg)
 {
 	struct BCState *bcs = st->l1.bcs;
@@ -547,7 +547,7 @@
 	}
 }
 
-void
+static void
 close_hdlcstate(struct BCState *bcs)
 {
 	modehdlc(bcs, 0, 0);
@@ -570,7 +570,7 @@
 	}
 }
 
-int
+static int
 open_hdlcstate(struct IsdnCardState *cs, struct BCState *bcs)
 {
 	if (!test_and_set_bit(BC_FLG_INIT, &bcs->Flag)) {
@@ -598,7 +598,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_hdlc(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
@@ -612,6 +612,7 @@
 	return (0);
 }
 
+#if 0
 void __init
 clear_pending_hdlc_ints(struct IsdnCardState *cs)
 {
@@ -641,8 +642,9 @@
 		debugl1(cs, "HDLC 2 VIN %x", val);
 	}
 }
+#endif  /*  0  */
 
-void __init
+static void __init
 inithdlc(struct IsdnCardState *cs)
 {
 	cs->bcs[0].BC_SetStack = setstack_hdlc;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/bkm_a4t.c.old	2005-02-05 21:15:23.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/bkm_a4t.c	2005-02-05 21:15:44.000000000 +0100
@@ -23,7 +23,7 @@
 
 extern const char *CardType[];
 
-const char *bkm_a4t_revision = "$Revision: 1.22.2.4 $";
+static const char *bkm_a4t_revision = "$Revision: 1.22.2.4 $";
 
 
 static inline u_char
@@ -167,7 +167,7 @@
 	}
 }
 
-void
+static void
 release_io_bkm(struct IsdnCardState *cs)
 {
 	if (cs->hw.ax.base) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/bkm_a8.c.old	2005-02-05 21:15:55.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/bkm_a8.c	2005-02-05 21:16:41.000000000 +0100
@@ -27,7 +27,7 @@
 
 extern const char *CardType[];
 
-const char sct_quadro_revision[] = "$Revision: 1.22.2.4 $";
+static const char sct_quadro_revision[] = "$Revision: 1.22.2.4 $";
 
 static const char *sct_quadro_subtypes[] =
 {
@@ -193,7 +193,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_sct_quadro(struct IsdnCardState *cs)
 {
 	release_region(cs->hw.ax.base & 0xffffffc0, 128);
@@ -261,7 +261,7 @@
 	return (0);
 }
 
-int __init
+static int __init
 sct_alloc_io(u_int adr, u_int len)
 {
 	if (!request_region(adr, len, "scitel")) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/callc.c.old	2005-02-05 21:32:25.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/callc.c	2005-02-05 21:32:57.000000000 +0100
@@ -874,7 +874,7 @@
 	} 
 }
 
-struct Channel
+static struct Channel
 *selectfreechannel(struct PStack *st, int bch)
 {
 	struct IsdnCardState *cs = st->l1.hardware;
@@ -1429,7 +1429,7 @@
 	HiSax_putstatus(chanp->cs, "Ch", "%d CAPIMSG %s", chanp->chan, tmpbuf);
 }
 
-void
+static void
 lli_got_fac_req(struct Channel *chanp, capi_msg *cm) {
 	if ((cm->para[0] != 3) || (cm->para[1] != 0))
 		return;
@@ -1454,7 +1454,7 @@
 	}
 }
 
-void
+static void
 lli_got_manufacturer(struct Channel *chanp, struct IsdnCardState *cs, capi_msg *cm) {
 	if ((cs->typ == ISDN_CTYPE_ELSA) || (cs->typ == ISDN_CTYPE_ELSA_PNP) ||
 		(cs->typ == ISDN_CTYPE_ELSA_PCI)) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hisax.h.old	2005-02-05 21:35:04.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hisax.h	2005-02-05 22:36:22.000000000 +0100
@@ -1271,7 +1271,6 @@
 void init_bcstate(struct IsdnCardState *cs, int bc);
 
 void setstack_HiSax(struct PStack *st, struct IsdnCardState *cs);
-unsigned int random_ri(void);
 void HiSax_addlist(struct IsdnCardState *sp, struct PStack *st);
 void HiSax_rmlist(struct IsdnCardState *sp, struct PStack *st);
 
@@ -1315,15 +1314,11 @@
 void LogFrame(struct IsdnCardState *cs, u_char * p, int size);
 void dlogframe(struct IsdnCardState *cs, struct sk_buff *skb, int dir);
 void iecpy(u_char * dest, u_char * iestart, int ieoffset);
-#ifdef ISDN_CHIP_ISAC
-void setstack_isac(struct PStack *st, struct IsdnCardState *cs);
-#endif	/* ISDN_CHIP_ISAC */
 #endif	/* __KERNEL__ */
 
 #define HZDELAY(jiffs) {int tout = jiffs; while (tout--) udelay(1000000/HZ);}
 
 int ll_run(struct IsdnCardState *cs, int addfeatures);
-void ll_stop(struct IsdnCardState *cs);
 int CallcNew(void);
 void CallcFree(void);
 int CallcNewChan(struct IsdnCardState *cs);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/config.c.old	2005-02-05 21:33:11.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/config.c	2005-02-05 21:34:53.000000000 +0100
@@ -332,7 +332,7 @@
 #define HISAX_IDSIZE (HISAX_MAX_CARDS*8)
 static char HiSaxID[HISAX_IDSIZE] = { 0, };
 
-char *HiSax_id = HiSaxID;
+static char *HiSax_id = HiSaxID;
 #ifdef MODULE
 /* Variables for insmod */
 static int type[HISAX_MAX_CARDS] = { 0, };
@@ -391,7 +391,7 @@
 	return rev;
 }
 
-void __init HiSaxVersion(void)
+static void __init HiSaxVersion(void)
 {
 	char tmp[64];
 
@@ -608,6 +608,7 @@
 /*
  * Find card with given card number
  */
+#if 0
 struct IsdnCardState *hisax_get_card(int cardnr)
 {
 	if ((cardnr <= nrcards) && (cardnr > 0))
@@ -615,8 +616,9 @@
 			return cards[cardnr - 1].cs;
 	return NULL;
 }
+#endif  /*  0  */
 
-int HiSax_readstatus(u_char __user *buf, int len, int id, int channel)
+static int HiSax_readstatus(u_char __user *buf, int len, int id, int channel)
 {
 	int count, cnt;
 	u_char __user *p = buf;
@@ -768,7 +770,7 @@
 	return 0;
 }
 
-void ll_stop(struct IsdnCardState *cs)
+static void ll_stop(struct IsdnCardState *cs)
 {
 	isdn_ctrl ic;
 
@@ -1184,7 +1186,7 @@
 	return ret;
 }
 
-void HiSax_shiftcards(int idx)
+static void HiSax_shiftcards(int idx)
 {
 	int i;
 
@@ -1192,7 +1194,7 @@
 		memcpy(&cards[i], &cards[i + 1], sizeof(cards[i]));
 }
 
-int HiSax_inithardware(int *busy_flag)
+static int HiSax_inithardware(int *busy_flag)
 {
 	int foundcards = 0;
 	int i = 0;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/diva.c.old	2005-02-05 21:35:58.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/diva.c	2005-02-05 21:36:14.000000000 +0100
@@ -28,7 +28,7 @@
 
 extern const char *CardType[];
 
-const char *Diva_revision = "$Revision: 1.33.2.6 $";
+static const char *Diva_revision = "$Revision: 1.33.2.6 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -706,7 +706,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_diva(struct IsdnCardState *cs)
 {
 	int bytecnt;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/elsa.c.old	2005-02-05 21:37:08.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/elsa.c	2005-02-05 21:39:37.000000000 +0100
@@ -33,13 +33,13 @@
 
 extern const char *CardType[];
 
-const char *Elsa_revision = "$Revision: 2.32.2.4 $";
-const char *Elsa_Types[] =
+static const char *Elsa_revision = "$Revision: 2.32.2.4 $";
+static const char *Elsa_Types[] =
 {"None", "PC", "PCC-8", "PCC-16", "PCF", "PCF-Pro",
  "PCMCIA", "QS 1000", "QS 3000", "Microlink PCI", "QS 3000 PCI", 
  "PCMCIA-IPAC" };
 
-const char *ITACVer[] =
+static const char *ITACVer[] =
 {"?0?", "?1?", "?2?", "?3?", "?4?", "V2.2",
  "B1", "A1"};
 
@@ -425,7 +425,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_elsa(struct IsdnCardState *cs)
 {
 	int bytecnt = 8;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/elsa_ser.c.old	2005-02-05 21:37:58.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/elsa_ser.c	2005-02-05 21:40:12.000000000 +0100
@@ -237,7 +237,7 @@
 #endif
 }
 
-inline int
+static inline int
 write_modem(struct BCState *bcs) {
 	int ret=0;
 	struct IsdnCardState *cs = bcs->cs;
@@ -275,7 +275,7 @@
 	return(ret);
 }
 
-inline void
+static inline void
 modem_fill(struct BCState *bcs) {
 		
 	if (bcs->tx_skb) {
@@ -422,7 +422,7 @@
 extern void modehscx(struct BCState *bcs, int mode, int bc);
 extern void hscx_l2l1(struct PStack *st, int pr, void *arg);
 
-void
+static void
 close_elsastate(struct BCState *bcs)
 {
 	modehscx(bcs, 0, bcs->channel);
@@ -442,7 +442,7 @@
 	}
 }
 
-void
+static void
 modem_write_cmd(struct IsdnCardState *cs, u_char *buf, int len) {
 	int count, fp;
 	u_char *msg = buf;
@@ -472,7 +472,7 @@
 	}
 }
 
-void
+static void
 modem_set_init(struct IsdnCardState *cs) {
 	int timeout;
 
@@ -521,7 +521,7 @@
 	udelay(RCV_DELAY);
 }
 
-void
+static void
 modem_set_dial(struct IsdnCardState *cs, int outgoing) {
 	int timeout;
 #define RCV_DELAY 20000	
@@ -543,7 +543,7 @@
 	udelay(RCV_DELAY);
 }
 
-void
+static void
 modem_l2l1(struct PStack *st, int pr, void *arg)
 {
 	struct BCState *bcs = st->l1.bcs;
@@ -579,7 +579,7 @@
 	}
 }
 
-int
+static int
 setstack_elsa(struct PStack *st, struct BCState *bcs)
 {
 
@@ -614,7 +614,7 @@
 	return (0);
 }
 
-void
+static void
 init_modem(struct IsdnCardState *cs) {
 
 	cs->bcs[0].BC_SetStack = setstack_elsa;
@@ -641,7 +641,7 @@
 	modem_set_init(cs);
 }
 
-void
+static void
 release_modem(struct IsdnCardState *cs) {
 
 	cs->hw.elsa.MFlag = 0;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/enternow_pci.c.old	2005-02-05 21:40:50.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/enternow_pci.c	2005-02-05 22:50:49.000000000 +0100
@@ -65,7 +65,6 @@
 #include "isac.h"
 #include "isdnl1.h"
 #include "amd7930_fn.h"
-#include "enternow.h"
 #include <linux/interrupt.h>
 #include <linux/ppp_defs.h>
 #include <linux/pci.h>
@@ -74,58 +73,72 @@
 
 
 
-const char *enternow_pci_rev = "$Revision: 1.1.4.5 $";
+static const char *enternow_pci_rev = "$Revision: 1.1.4.5 $";
+
+
+/* für PowerISDN PCI */
+#define TJ_AMD_IRQ                                              0x20
+#define TJ_LED1                                                 0x40
+#define TJ_LED2                                                 0x80
+
+
+/* Das Fenster zum AMD...
+ * Ab Adresse hw.njet.base + TJ_AMD_PORT werden vom AMD jeweils 8 Bit in
+ * den TigerJet i/o-Raum gemappt
+ * -> 0x01 des AMD bei hw.njet.base + 0C4 */
+#define TJ_AMD_PORT                                             0xC0
+
 
 
 /* *************************** I/O-Interface functions ************************************* */
 
 
 /* cs->readisac, macro rByteAMD */
-BYTE
-ReadByteAmd7930(struct IsdnCardState *cs, BYTE offset)
+static unsigned char
+ReadByteAmd7930(struct IsdnCardState *cs, unsigned char offset)
 {
 	/* direktes Register */
 	if(offset < 8)
-		return (InByte(cs->hw.njet.isac + 4*offset));
+		return (inb(cs->hw.njet.isac + 4*offset));
 
 	/* indirektes Register */
 	else {
-		OutByte(cs->hw.njet.isac + 4*AMD_CR, offset);
-		return(InByte(cs->hw.njet.isac + 4*AMD_DR));
+		outb(offset, cs->hw.njet.isac + 4*AMD_CR);
+		return(inb(cs->hw.njet.isac + 4*AMD_DR));
 	}
 }
 
 /* cs->writeisac, macro wByteAMD */
-void
-WriteByteAmd7930(struct IsdnCardState *cs, BYTE offset, BYTE value)
+static void
+WriteByteAmd7930(struct IsdnCardState *cs, unsigned char offset, unsigned char value)
 {
 	/* direktes Register */
 	if(offset < 8)
-		OutByte(cs->hw.njet.isac + 4*offset, value);
+		outb(value, cs->hw.njet.isac + 4*offset);
 
 	/* indirektes Register */
 	else {
-		OutByte(cs->hw.njet.isac + 4*AMD_CR, offset);
-		OutByte(cs->hw.njet.isac + 4*AMD_DR, value);
+		outb(offset, cs->hw.njet.isac + 4*AMD_CR);
+		outb(value, cs->hw.njet.isac + 4*AMD_DR);
 	}
 }
 
 
-void
-enpci_setIrqMask(struct IsdnCardState *cs, BYTE val) {
+static void
+enpci_setIrqMask(struct IsdnCardState *cs, unsigned char val) {
         if (!val)
-	        OutByte(cs->hw.njet.base+NETJET_IRQMASK1, 0x00);
+	        outb(0x00, cs->hw.njet.base+NETJET_IRQMASK1);
         else
-	        OutByte(cs->hw.njet.base+NETJET_IRQMASK1, TJ_AMD_IRQ);
+	        outb(TJ_AMD_IRQ, cs->hw.njet.base+NETJET_IRQMASK1);
 }
 
 
-static BYTE dummyrr(struct IsdnCardState *cs, int chan, BYTE off)
+static unsigned char dummyrr(struct IsdnCardState *cs, int chan, unsigned char off)
 {
         return(5);
 }
 
-static void dummywr(struct IsdnCardState *cs, int chan, BYTE off, BYTE value)
+static void dummywr(struct IsdnCardState *cs, int chan, unsigned char off, unsigned char value)
 {
 
 }
@@ -142,18 +155,18 @@
 
 	/* Reset on, (also for AMD) */
 	cs->hw.njet.ctrl_reg = 0x07;
-	OutByte(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
+	outb(cs->hw.njet.ctrl_reg, cs->hw.njet.base + NETJET_CTRL);
 	mdelay(20);
 	/* Reset off */
 	cs->hw.njet.ctrl_reg = 0x30;
-	OutByte(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
+	outb(cs->hw.njet.ctrl_reg, cs->hw.njet.base + NETJET_CTRL);
 	/* 20ms delay */
 	mdelay(20);
 	cs->hw.njet.auxd = 0;  // LED-status
 	cs->hw.njet.dmactrl = 0;
-	OutByte(cs->hw.njet.base + NETJET_AUXCTRL, ~TJ_AMD_IRQ);
-	OutByte(cs->hw.njet.base + NETJET_IRQMASK1, TJ_AMD_IRQ);
-	OutByte(cs->hw.njet.auxa, cs->hw.njet.auxd); // LED off
+	outb(~TJ_AMD_IRQ, cs->hw.njet.base + NETJET_AUXCTRL);
+	outb(TJ_AMD_IRQ, cs->hw.njet.base + NETJET_IRQMASK1);
+	outb(cs->hw.njet.auxd, cs->hw.njet.auxa); // LED off
 }
 
 
@@ -161,7 +174,7 @@
 enpci_card_msg(struct IsdnCardState *cs, int mt, void *arg)
 {
 	u_long flags;
-        BYTE *chan;
+        unsigned char *chan;
 
 	if (cs->debug & L1_DEB_ISAC)
 		debugl1(cs, "enter:now PCI: card_msg: 0x%04X", mt);
@@ -187,16 +200,16 @@
                 case MDL_ASSIGN:
                         /* TEI assigned, LED1 on */
                         cs->hw.njet.auxd = TJ_AMD_IRQ << 1;
-                        OutByte(cs->hw.njet.base + NETJET_AUXDATA, cs->hw.njet.auxd);
+                        outb(cs->hw.njet.auxd, cs->hw.njet.base + NETJET_AUXDATA);
                         break;
                 case MDL_REMOVE:
                         /* TEI removed, LEDs off */
 	                cs->hw.njet.auxd = 0;
-                        OutByte(cs->hw.njet.base + NETJET_AUXDATA, 0x00);
+                        outb(0x00, cs->hw.njet.base + NETJET_AUXDATA);
                         break;
                 case MDL_BC_ASSIGN:
                         /* activate B-channel */
-                        chan = (BYTE *)arg;
+                        chan = (unsigned char *)arg;
 
                         if (cs->debug & L1_DEB_ISAC)
 		                debugl1(cs, "enter:now PCI: assign phys. BC %d in AMD LMR1", *chan);
@@ -204,11 +217,11 @@
                         cs->dc.amd7930.ph_command(cs, (cs->dc.amd7930.lmr1 | (*chan + 1)), "MDL_BC_ASSIGN");
                         /* at least one b-channel in use, LED 2 on */
                         cs->hw.njet.auxd |= TJ_AMD_IRQ << 2;
-                        OutByte(cs->hw.njet.base + NETJET_AUXDATA, cs->hw.njet.auxd);
+                        outb(cs->hw.njet.auxd, cs->hw.njet.base + NETJET_AUXDATA);
                         break;
                 case MDL_BC_RELEASE:
                         /* deactivate B-channel */
-                        chan = (BYTE *)arg;
+                        chan = (unsigned char *)arg;
 
                         if (cs->debug & L1_DEB_ISAC)
 		                debugl1(cs, "enter:now PCI: release phys. BC %d in Amd LMR1", *chan);
@@ -217,7 +230,7 @@
                         /* no b-channel active -> LED2 off */
                         if (!(cs->dc.amd7930.lmr1 & 3)) {
                                 cs->hw.njet.auxd &= ~(TJ_AMD_IRQ << 2);
-                                OutByte(cs->hw.njet.base + NETJET_AUXDATA, cs->hw.njet.auxd);
+                                outb(cs->hw.njet.auxd, cs->hw.njet.base + NETJET_AUXDATA);
                         }
                         break;
                 default:
@@ -231,11 +244,11 @@
 enpci_interrupt(int intno, void *dev_id, struct pt_regs *regs)
 {
 	struct IsdnCardState *cs = dev_id;
-	BYTE s0val, s1val, ir;
+	unsigned char s0val, s1val, ir;
 	u_long flags;
 
 	spin_lock_irqsave(&cs->lock, flags);
-	s1val = InByte(cs->hw.njet.base + NETJET_IRQSTAT1);
+	s1val = inb(cs->hw.njet.base + NETJET_IRQSTAT1);
 
         /* AMD threw an interrupt */
 	if (!(s1val & TJ_AMD_IRQ)) {
@@ -245,13 +258,13 @@
 		s1val = 1;
 	} else
 		s1val = 0;
-	s0val = InByte(cs->hw.njet.base + NETJET_IRQSTAT0);
+	s0val = inb(cs->hw.njet.base + NETJET_IRQSTAT0);
 	if ((s0val | s1val)==0) { // shared IRQ
 		spin_unlock_irqrestore(&cs->lock, flags);
 		return IRQ_NONE;
 	} 
 	if (s0val)
-		OutByte(cs->hw.njet.base + NETJET_IRQSTAT0, s0val);
+		outb(s0val, cs->hw.njet.base + NETJET_IRQSTAT0);
 
 	/* DMA-Interrupt: B-channel-stuff */
 	/* set bits in sval to indicate which page is free */
@@ -342,20 +355,20 @@
 
 		/* Reset an */
 		cs->hw.njet.ctrl_reg = 0x07;  // geändert von 0xff
-		OutByte(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
+		outb(cs->hw.njet.ctrl_reg, cs->hw.njet.base + NETJET_CTRL);
 		/* 20 ms Pause */
 		mdelay(20);
 
 		cs->hw.njet.ctrl_reg = 0x30;  /* Reset Off and status read clear */
-		OutByte(cs->hw.njet.base + NETJET_CTRL, cs->hw.njet.ctrl_reg);
+		outb(cs->hw.njet.ctrl_reg, cs->hw.njet.base + NETJET_CTRL);
 		mdelay(10);
 
 		cs->hw.njet.auxd = 0x00; // war 0xc0
 		cs->hw.njet.dmactrl = 0;
 
-		OutByte(cs->hw.njet.base + NETJET_AUXCTRL, ~TJ_AMD_IRQ);
-		OutByte(cs->hw.njet.base + NETJET_IRQMASK1, TJ_AMD_IRQ);
-		OutByte(cs->hw.njet.auxa, cs->hw.njet.auxd);
+		outb(~TJ_AMD_IRQ, cs->hw.njet.base + NETJET_AUXCTRL);
+		outb(TJ_AMD_IRQ, cs->hw.njet.base + NETJET_IRQMASK1);
+		outb(cs->hw.njet.auxd, cs->hw.njet.auxa);
 
 		break;
 	}
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/gazel.c.old	2005-02-05 21:50:38.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/gazel.c	2005-02-05 21:51:01.000000000 +0100
@@ -21,7 +21,7 @@
 #include <linux/pci.h>
 
 extern const char *CardType[];
-const char *gazel_revision = "$Revision: 2.19.2.4 $";
+static const char *gazel_revision = "$Revision: 2.19.2.4 $";
 
 #define R647      1
 #define R685      2
@@ -317,7 +317,8 @@
 	spin_unlock_irqrestore(&cs->lock, flags);
 	return IRQ_HANDLED;
 }
-void
+
+static void
 release_io_gazel(struct IsdnCardState *cs)
 {
 	unsigned int i;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc4s8s_l1.c.old	2005-02-05 21:51:13.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc4s8s_l1.c	2005-02-05 21:51:24.000000000 +0100
@@ -1005,7 +1005,7 @@
 /********************************************/
 /* disable/enable hardware in nt or te mode */
 /********************************************/
-void hfc_hardware_enable(struct hfc8s_hw *hw, int enable, int nt_mode)
+static void hfc_hardware_enable(struct hfc8s_hw *hw, int enable, int nt_mode)
 {
   u_long flags;
   char if_name[40];
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_2bds0.c.old	2005-02-05 21:51:39.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_2bds0.c	2005-02-05 21:53:02.000000000 +0100
@@ -345,7 +345,7 @@
 		debugl1(cs,"send_data %d blocked", bcs->channel);
 }
 
-void
+static void
 main_rec_2bds0(struct BCState *bcs)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -399,7 +399,7 @@
 	return;
 }
 
-void
+static void
 mode_2bs0(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -505,7 +505,7 @@
 	}
 }
 
-void
+static void
 close_2bs0(struct BCState *bcs)
 {
 	mode_2bs0(bcs, 0, bcs->channel);
@@ -534,7 +534,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_2b(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
@@ -1004,7 +1004,7 @@
 	}
 }
 
-void
+static void
 setstack_hfcd(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = HFCD_l1hw;
@@ -1015,7 +1015,7 @@
 {
 }
 
-unsigned int __init
+static unsigned int __init
 *init_send_hfcd(int cnt)
 {
 	int i, *send;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_2bs0.c.old	2005-02-05 21:54:14.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_2bs0.c	2005-02-05 21:55:24.000000000 +0100
@@ -52,7 +52,7 @@
 		return (to);
 }
 
-int
+static int
 GetFreeFifoBytes(struct BCState *bcs)
 {
 	int s;
@@ -66,7 +66,7 @@
 	return (s);
 }
 
-int
+static int
 ReadZReg(struct BCState *bcs, u_char reg)
 {
 	int val;
@@ -394,7 +394,7 @@
 	return;
 }
 
-void
+static void
 mode_hfc(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -507,7 +507,7 @@
 }
 
 
-void
+static void
 close_hfcstate(struct BCState *bcs)
 {
 	mode_hfc(bcs, 0, bcs->channel);
@@ -537,7 +537,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_hfc(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
@@ -551,7 +551,7 @@
 	return (0);
 }
 
-void __init
+static void __init
 init_send(struct BCState *bcs)
 {
 	int i;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_pci.h.old	2005-02-05 21:56:12.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_pci.h	2005-02-05 21:56:16.000000000 +0100
@@ -232,5 +232,4 @@
 #define Read_hfc(a,b) (*(((u_char *)a->hw.hfcpci.pci_io)+b))
 
 extern void main_irq_hcpci(struct BCState *bcs);
-extern void inithfcpci(struct IsdnCardState *cs);
 extern void releasehfcpci(struct IsdnCardState *cs);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_pci.c.old	2005-02-05 21:55:43.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_pci.c	2005-02-05 21:57:20.000000000 +0100
@@ -70,7 +70,7 @@
 /******************************************/
 /* free hardware resources used by driver */
 /******************************************/
-void
+static void
 release_io_hfcpci(struct IsdnCardState *cs)
 {
 	printk(KERN_INFO "HiSax: release hfcpci at %p\n",
@@ -394,7 +394,7 @@
 /*******************************************************************************/
 /* check for transparent receive data and read max one threshold size if avail */
 /*******************************************************************************/
-int
+static int
 hfcpci_empty_fifo_trans(struct BCState *bcs, bzfifo_type * bz, u_char * bdata)
 {
 	unsigned short *z1r, *z2r;
@@ -446,7 +446,7 @@
 /**********************************/
 /* B-channel main receive routine */
 /**********************************/
-void
+static void
 main_rec_hfcpci(struct BCState *bcs)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -1244,7 +1244,7 @@
 /***********************************************/
 /* called during init setting l1 stack pointer */
 /***********************************************/
-void
+static void
 setstack_hfcpci(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = HFCPCI_l1hw;
@@ -1268,7 +1268,7 @@
 /***************************************************************/
 /* activate/deactivate hardware for selected channels and mode */
 /***************************************************************/
-void
+static void
 mode_hfcpci(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -1579,7 +1579,7 @@
 /********************************/
 /* called for card init message */
 /********************************/
-void __init
+static void __init
 inithfcpci(struct IsdnCardState *cs)
 {
 	cs->bcs[0].BC_SetStack = setstack_2b;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_sx.h.old	2005-02-05 21:57:34.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_sx.h	2005-02-05 21:57:40.000000000 +0100
@@ -193,5 +193,4 @@
 };
 
 extern void main_irq_hfcsx(struct BCState *bcs);
-extern void inithfcsx(struct IsdnCardState *cs);
 extern void releasehfcsx(struct IsdnCardState *cs);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_sx.c.old	2005-02-05 21:57:47.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_sx.c	2005-02-05 21:58:28.000000000 +0100
@@ -308,7 +308,7 @@
 /******************************************/
 /* free hardware resources used by driver */
 /******************************************/
-void
+static void
 release_io_hfcsx(struct IsdnCardState *cs)
 {
 	cs->hw.hfcsx.int_m2 = 0;	/* interrupt output off ! */
@@ -472,7 +472,7 @@
 /**********************************/
 /* B-channel main receive routine */
 /**********************************/
-void
+static void
 main_rec_hfcsx(struct BCState *bcs)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -1003,7 +1003,7 @@
 /***********************************************/
 /* called during init setting l1 stack pointer */
 /***********************************************/
-void
+static void
 setstack_hfcsx(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = HFCSX_l1hw;
@@ -1027,7 +1027,7 @@
 /***************************************************************/
 /* activate/deactivate hardware for selected channels and mode */
 /***************************************************************/
-void
+static void
 mode_hfcsx(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -1328,7 +1328,7 @@
 /********************************/
 /* called for card init message */
 /********************************/
-void __devinit
+static void __devinit
 inithfcsx(struct IsdnCardState *cs)
 {
 	cs->setstack_d = setstack_hfcsx;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_usb.h.old	2005-02-05 21:59:36.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_usb.h	2005-02-05 22:00:18.000000000 +0100
@@ -168,7 +168,7 @@
 * 3 entries are the configuration number, the minimum interval for
 * Interrupt endpoints & boolean if E-channel logging possible
 */
-int validconf[][19] = {
+static int validconf[][19] = {
 	// INT in, ISO out config
 	{EP_NUL, EP_INT, EP_NUL, EP_INT, EP_NUL, EP_INT, EP_NOP, EP_INT,
 	 EP_ISO, EP_NUL, EP_ISO, EP_NUL, EP_ISO, EP_NUL, EP_NUL, EP_NUL,
@@ -187,7 +187,7 @@
 };
 
 // string description of chosen config
-char *conf_str[] = {
+static char *conf_str[] = {
 	"4 Interrupt IN + 3 Isochron OUT",
 	"3 Interrupt IN + 3 Isochron OUT",
 	"4 Isochron IN + 3 Isochron OUT",
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_usb.c.old	2005-02-05 21:58:44.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfc_usb.c	2005-02-05 22:00:37.000000000 +0100
@@ -60,7 +60,7 @@
 #include "hisax_debug.h"
 static u_int debug;
 module_param(debug, uint, 0);
-int hfc_debug;
+static int hfc_debug;
 #endif
 
 
@@ -85,7 +85,7 @@
 *   VendorID, ProductID, Devicename, LED_SCHEME,
 *   LED's BitMask in HFCUSB_P_DATA Register : LED_USB, LED_S0, LED_B1, LED_B2
 */
-vendor_data vdata[] = {
+static vendor_data vdata[] = {
 	/* CologneChip Eval TA */
 	{0x0959, 0x2bd0, "ISDN USB TA (Cologne Chip HFC-S USB based)",
 	 LED_OFF, {4, 0, 2, 1}
@@ -1137,7 +1137,7 @@
 	}
 }
 
-void
+static void
 hfc_usb_l2l1(struct hisax_if *my_hisax_if, int pr, void *arg)
 {
 	usb_fifo *fifo = my_hisax_if->priv;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfcscard.c.old	2005-02-05 22:00:52.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hfcscard.c	2005-02-05 22:00:59.000000000 +0100
@@ -52,7 +52,7 @@
 */
 }
 
-void
+static void
 release_io_hfcs(struct IsdnCardState *cs)
 {
 	release2bds0(cs);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hscx.c.old	2005-02-05 22:01:15.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/hscx.c	2005-02-05 22:01:33.000000000 +0100
@@ -151,7 +151,7 @@
 	}
 }
 
-void
+static void
 close_hscxstate(struct BCState *bcs)
 {
 	modehscx(bcs, 0, bcs->channel);
@@ -203,7 +203,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_hscx(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/icc.c.old	2005-02-05 22:01:45.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/icc.c	2005-02-05 22:02:15.000000000 +0100
@@ -108,7 +108,7 @@
 #endif
 }
 
-void
+static void
 icc_empty_fifo(struct IsdnCardState *cs, int count)
 {
 	u_char *ptr;
@@ -563,13 +563,13 @@
 	}
 }
 
-void
+static void
 setstack_icc(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = ICC_l1hw;
 }
 
-void 
+static void 
 DC_Close_icc(struct IsdnCardState *cs) {
 	if (cs->dc.icc.mon_rx) {
 		kfree(cs->dc.icc.mon_rx);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/ipacx.c.old	2005-02-05 22:02:34.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/ipacx.c	2005-02-05 22:42:37.000000000 +0100
@@ -36,8 +36,6 @@
 static inline void cic_int(struct IsdnCardState *cs);
 static void dch_l2l1(struct PStack *st, int pr, void *arg);
 static void dbusy_timer_handler(struct IsdnCardState *cs);
-static void ipacx_new_ph(struct IsdnCardState *cs);
-static void dch_bh(struct IsdnCardState *cs);
 static void dch_empty_fifo(struct IsdnCardState *cs, int count);
 static void dch_fill_fifo(struct IsdnCardState *cs);
 static inline void dch_int(struct IsdnCardState *cs);
@@ -232,81 +230,6 @@
 }
 
 //----------------------------------------------------------
-// L1 state machine intermediate layer to isdnl1 module
-//----------------------------------------------------------
-static void
-ipacx_new_ph(struct IsdnCardState *cs)
-{
-	switch (cs->dc.isac.ph_state) {
-		case (IPACX_IND_RES):
-			ph_command(cs, IPACX_CMD_DI);
-			l1_msg(cs, HW_RESET | INDICATION, NULL);
-			break;
-      
-		case (IPACX_IND_DC):
-			l1_msg(cs, HW_DEACTIVATE | CONFIRM, NULL);
-			break;
-      
-		case (IPACX_IND_DR):
-			l1_msg(cs, HW_DEACTIVATE | INDICATION, NULL);
-			break;
-      
-		case (IPACX_IND_PU):
-			l1_msg(cs, HW_POWERUP | CONFIRM, NULL);
-			break;
-
-		case (IPACX_IND_RSY):
-			l1_msg(cs, HW_RSYNC | INDICATION, NULL);
-			break;
-
-		case (IPACX_IND_AR):
-			l1_msg(cs, HW_INFO2 | INDICATION, NULL);
-			break;
-      
-		case (IPACX_IND_AI8):
-			l1_msg(cs, HW_INFO4_P8 | INDICATION, NULL);
-			break;
-      
-		case (IPACX_IND_AI10):
-			l1_msg(cs, HW_INFO4_P10 | INDICATION, NULL);
-			break;
-      
-		default:
-			break;
-	}
-}
-
-//----------------------------------------------------------
-// bottom half handler for D channel
-//----------------------------------------------------------
-static void
-dch_bh(struct IsdnCardState *cs)
-{
-	struct PStack *st;
-	
-	if (!cs) return;
-  
-	if (test_and_clear_bit(D_CLEARBUSY, &cs->event)) {
-		if (cs->debug) debugl1(cs, "D-Channel Busy cleared");
-		for (st = cs->stlist; st; st = st->next) {
-			st->l1.l1l2(st, PH_PAUSE | CONFIRM, NULL);
-		}
-	}
-  
-	if (test_and_clear_bit(D_RCVBUFREADY, &cs->event)) {
-		DChannel_proc_rcv(cs);
-  }  
-  
-	if (test_and_clear_bit(D_XMTBUFREADY, &cs->event)) {
-		DChannel_proc_xmt(cs);
-  }  
-  
-	if (test_and_clear_bit(D_L1STATECHANGE, &cs->event)) {
-    ipacx_new_ph(cs);
-  }  
-}
-
-//----------------------------------------------------------
 // Fill buffer from receive FIFO
 //----------------------------------------------------------
 static void 
@@ -991,14 +914,5 @@
 	}
 }
 
-
-void __devinit
-setup_ipacx(struct IsdnCardState *cs)
-{
-	INIT_WORK(&cs->tqueue, (void *)(void *) dch_bh, cs);
-	cs->dbusytimer.function = (void *) dbusy_timer_handler;
-	cs->dbusytimer.data = (long) cs;
-	init_timer(&cs->dbusytimer);
-}
 //----------------- end of file -----------------------
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isac.c.old	2005-02-05 22:03:21.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isac.c	2005-02-05 22:04:07.000000000 +0100
@@ -112,7 +112,7 @@
 #endif
 }
 
-void
+static void
 isac_empty_fifo(struct IsdnCardState *cs, int count)
 {
 	u_char *ptr;
@@ -563,13 +563,13 @@
 	}
 }
 
-void
+static void
 setstack_isac(struct PStack *st, struct IsdnCardState *cs)
 {
 	st->l1.l1hw = ISAC_l1hw;
 }
 
-void 
+static void 
 DC_Close_isac(struct IsdnCardState *cs) {
 	if (cs->dc.isac.mon_rx) {
 		kfree(cs->dc.isac.mon_rx);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isar.c.old	2005-02-05 22:04:29.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isar.c	2005-02-05 22:09:03.000000000 +0100
@@ -21,13 +21,13 @@
 #define ETX	0x03
 
 #define FAXMODCNT	13
-const	u_char	faxmodulation[] = {3,24,48,72,73,74,96,97,98,121,122,145,146};
+static const	u_char	faxmodulation[] = {3,24,48,72,73,74,96,97,98,121,122,145,146};
 static	u_int	modmask = 0x1fff;
 static	int	frm_extra_delay = 2;
 static	int	para_TOA = 6;
-const   u_char  *FC1_CMD[] = {"FAE", "FTS", "FRS", "FTM", "FRM", "FTH", "FRH", "CTRL" };
+static const   u_char  *FC1_CMD[] = {"FAE", "FTS", "FRS", "FTM", "FRM", "FTH", "FRH", "CTRL" };
 
-void isar_setup(struct IsdnCardState *cs);
+static void isar_setup(struct IsdnCardState *cs);
 static void isar_pump_cmd(struct BCState *bcs, u_char cmd, u_char para);
 static void ll_deliver_faxstat(struct BCState *bcs, u_char status);
 
@@ -45,7 +45,7 @@
 }
 
 
-int
+static int
 sendmsg(struct IsdnCardState *cs, u_char his, u_char creg, u_char len,
 	u_char *msg)
 {
@@ -85,7 +85,7 @@
 }
 
 /* Call only with IRQ disabled !!! */
-inline void
+static inline void
 rcv_mbox(struct IsdnCardState *cs, struct isar_reg *ireg, u_char *msg)
 {
 	int i;
@@ -114,7 +114,7 @@
 }
 
 /* Call only with IRQ disabled !!! */
-inline void
+static inline void
 get_irq_infos(struct IsdnCardState *cs, struct isar_reg *ireg)
 {
 	ireg->iis = cs->BC_Read_Reg(cs, 1, ISAR_IIS);
@@ -127,7 +127,7 @@
 #endif
 }
 
-int
+static int
 waitrecmsg(struct IsdnCardState *cs, u_char *len,
 	u_char *msg, int maxdelay)
 {
@@ -185,7 +185,7 @@
 	return(ver);
 }
 
-int
+static int
 isar_load_firmware(struct IsdnCardState *cs, u_char __user *buf)
 {
 	int ret, size, cnt, debug;
@@ -739,7 +739,7 @@
 	}
 }
 
-inline
+static inline
 struct BCState *sel_bcs_isar(struct IsdnCardState *cs, u_char dpath)
 {
 	if ((!dpath) || (dpath == 3))
@@ -751,7 +751,7 @@
 	return(NULL);
 }
 
-void
+static void
 send_frames(struct BCState *bcs)
 {
 	if (bcs->tx_skb) {
@@ -806,7 +806,7 @@
 	}
 }
 
-inline void
+static inline void
 check_send(struct IsdnCardState *cs, u_char rdm)
 {
 	struct BCState *bcs;
@@ -828,11 +828,13 @@
 	
 }
 
-const char *dmril[] = {"NO SPEED", "1200/75", "NODEF2", "75/1200", "NODEF4",
-			"300", "600", "1200", "2400", "4800", "7200",
-			"9600nt", "9600t", "12000", "14400", "WRONG"};
-const char *dmrim[] = {"NO MOD", "NO DEF", "V32/V32b", "V22", "V21",
-			"Bell103", "V23", "Bell202", "V17", "V29", "V27ter"};
+static const char *dmril[] = {"NO SPEED", "1200/75", "NODEF2", "75/1200",
+				"NODEF4", "300", "600", "1200", "2400",
+				"4800", "7200", "9600nt", "9600t", "12000",
+				"14400", "WRONG"};
+static const char *dmrim[] = {"NO MOD", "NO DEF", "V32/V32b", "V22", "V21",
+				"Bell103", "V23", "Bell202", "V17", "V29",
+				"V27ter"};
 
 static void
 isar_pump_status_rsp(struct BCState *bcs, struct isar_reg *ireg) {
@@ -1388,7 +1390,7 @@
 	udelay(1000);
 }
 
-int
+static int
 modeisar(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -1562,7 +1564,7 @@
 		sendmsg(cs, dps | ISAR_HIS_PUMPCTRL, ctrl, nom, &p1);
 }
 
-void
+static void
 isar_setup(struct IsdnCardState *cs)
 {
 	u_char msg;
@@ -1582,7 +1584,7 @@
 	}
 }
 
-void
+static void
 isar_l2l1(struct PStack *st, int pr, void *arg)
 {
 	struct BCState *bcs = st->l1.bcs;
@@ -1681,7 +1683,7 @@
 	}
 }
 
-void
+static void
 close_isarstate(struct BCState *bcs)
 {
 	modeisar(bcs, 0, bcs->channel);
@@ -1703,7 +1705,7 @@
 	del_timer(&bcs->hw.isar.ftimer);
 }
 
-int
+static int
 open_isarstate(struct IsdnCardState *cs, struct BCState *bcs)
 {
 	if (!test_and_set_bit(BC_FLG_INIT, &bcs->Flag)) {
@@ -1725,7 +1727,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_isar(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl1.c.old	2005-02-05 22:09:19.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl1.c	2005-02-05 22:11:47.000000000 +0100
@@ -151,7 +151,7 @@
 	va_end(args);
 }
 
-void
+static void
 L1activated(struct IsdnCardState *cs)
 {
 	struct PStack *st;
@@ -166,7 +166,7 @@
 	}
 }
 
-void
+static void
 L1deactivated(struct IsdnCardState *cs)
 {
 	struct PStack *st;
@@ -370,7 +370,7 @@
 
 #ifdef L2FRAME_DEBUG		/* psa */
 
-char *
+static char *
 l2cmd(u_char cmd)
 {
 	switch (cmd & ~0x10) {
@@ -404,7 +404,7 @@
 
 static char tmpdeb[32];
 
-char *
+static char *
 l2frames(u_char * ptr)
 {
 	switch (ptr[2] & ~0x10) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl2.c.old	2005-02-05 22:12:01.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl2.c	2005-02-05 22:19:27.000000000 +0100
@@ -142,7 +142,7 @@
 	return cnt;
 }
 
-inline void
+static inline void
 freewin(struct PStack *st)
 {
 	freewin1(&st->l2);
@@ -157,7 +157,7 @@
 		printk(KERN_WARNING "isdl2 freed %d skbuffs in release\n", cnt);
 }
 
-inline unsigned int
+static inline unsigned int
 cansend(struct PStack *st)
 {
 	unsigned int p1;
@@ -169,7 +169,7 @@
 	return ((p1 < st->l2.window) && !test_bit(FLG_PEER_BUSY, &st->l2.flag));
 }
 
-inline void
+static inline void
 clear_exception(struct Layer2 *l2)
 {
 	test_and_clear_bit(FLG_ACK_PEND, &l2->flag);
@@ -178,7 +178,7 @@
 	clear_peer_busy(l2);
 }
 
-inline int
+static inline int
 l2headersize(struct Layer2 *l2, int ui)
 {
 	return (((test_bit(FLG_MOD128, &l2->flag) && (!ui)) ? 2 : 1) +
@@ -223,40 +223,31 @@
 
 #define enqueue_ui(a, b) enqueue_super(a, b)
 
-inline int
+static inline int
 IsUI(u_char * data)
 {
 	return ((data[0] & 0xef) == UI);
 }
 
-inline int
+static inline int
 IsUA(u_char * data)
 {
 	return ((data[0] & 0xef) == UA);
 }
 
-inline int
+static inline int
 IsDM(u_char * data)
 {
 	return ((data[0] & 0xef) == DM);
 }
 
-inline int
+static inline int
 IsDISC(u_char * data)
 {
 	return ((data[0] & 0xef) == DISC);
 }
 
-inline int
-IsRR(u_char * data, struct PStack *st)
-{
-	if (test_bit(FLG_MOD128, &st->l2.flag))
-		return (data[0] == RR);
-	else
-		return ((data[0] & 0xf) == 1);
-}
-
-inline int
+static inline int
 IsSFrame(u_char * data, struct PStack *st)
 {
 	register u_char d = *data;
@@ -266,7 +257,7 @@
 	return(((d & 0xf3) == 1) && ((d & 0x0c) != 0x0c));
 }
 
-inline int
+static inline int
 IsSABME(u_char * data, struct PStack *st)
 {
 	u_char d = data[0] & ~0x10;
@@ -274,25 +265,25 @@
 	return (test_bit(FLG_MOD128, &st->l2.flag) ? d == SABME : d == SABM);
 }
 
-inline int
+static inline int
 IsREJ(u_char * data, struct PStack *st)
 {
 	return (test_bit(FLG_MOD128, &st->l2.flag) ? data[0] == REJ : (data[0] & 0xf) == REJ);
 }
 
-inline int
+static inline int
 IsFRMR(u_char * data)
 {
 	return ((data[0] & 0xef) == FRMR);
 }
 
-inline int
+static inline int
 IsRNR(u_char * data, struct PStack *st)
 {
 	return (test_bit(FLG_MOD128, &st->l2.flag) ? data[0] == RNR : (data[0] & 0xf) == RNR);
 }
 
-int
+static int
 iframe_error(struct PStack *st, struct sk_buff *skb)
 {
 	int i = l2addrsize(&st->l2) + (test_bit(FLG_MOD128, &st->l2.flag) ? 2 : 1);
@@ -315,7 +306,7 @@
 	return 0;
 }
 
-int
+static int
 super_error(struct PStack *st, struct sk_buff *skb)
 {
 	if (skb->len != l2addrsize(&st->l2) +
@@ -325,7 +316,7 @@
 	return 0;
 }
 
-int
+static int
 unnum_error(struct PStack *st, struct sk_buff *skb, int wantrsp)
 {
 	int rsp = (*skb->data & 0x2) >> 1;
@@ -341,7 +332,7 @@
 	return 0;
 }
 
-int
+static int
 UI_error(struct PStack *st, struct sk_buff *skb)
 {
 	int rsp = *skb->data & 0x2;
@@ -357,7 +348,7 @@
 	return 0;
 }
 
-int
+static int
 FRMR_error(struct PStack *st, struct sk_buff *skb)
 {
 	int headers = l2addrsize(&st->l2) + 1;
@@ -444,51 +435,44 @@
 	enqueue_super(st, skb);
 }
 
-inline u_char
+static inline u_char
 get_PollFlag(struct PStack * st, struct sk_buff * skb)
 {
 	return (skb->data[l2addrsize(&(st->l2))] & 0x10);
 }
 
-inline void
-FreeSkb(struct sk_buff *skb)
-{
-	dev_kfree_skb(skb);
-}
-
-
-inline u_char
+static inline u_char
 get_PollFlagFree(struct PStack *st, struct sk_buff *skb)
 {
 	u_char PF;
 
 	PF = get_PollFlag(st, skb);
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 	return (PF);
 }
 
-inline void
+static inline void
 start_t200(struct PStack *st, int i)
 {
 	FsmAddTimer(&st->l2.t200, st->l2.T200, EV_L2_T200, NULL, i);
 	test_and_set_bit(FLG_T200_RUN, &st->l2.flag);
 }
 
-inline void
+static inline void
 restart_t200(struct PStack *st, int i)
 {
 	FsmRestartTimer(&st->l2.t200, st->l2.T200, EV_L2_T200, NULL, i);
 	test_and_set_bit(FLG_T200_RUN, &st->l2.flag);
 }
 
-inline void
+static inline void
 stop_t200(struct PStack *st, int i)
 {
 	if(test_and_clear_bit(FLG_T200_RUN, &st->l2.flag))
 		FsmDelTimer(&st->l2.t200, i);
 }
 
-inline void
+static inline void
 st5_dl_release_l2l3(struct PStack *st)
 {
 		int pr;
@@ -501,7 +485,7 @@
 		st->l2.l2l3(st, pr, NULL);
 }
 
-inline void
+static inline void
 lapb_dl_release_l2l3(struct PStack *st, int f)
 {
 		if (test_bit(FLG_LAPB, &st->l2.flag))
@@ -802,7 +786,7 @@
 		l2_mdl_error_ua(fi, event, arg);
 		return;
 	}
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 
 	if (test_and_clear_bit(FLG_PEND_REL, &st->l2.flag))
 		l2_disconnect(fi, event, arg);
@@ -840,7 +824,7 @@
 		l2_mdl_error_ua(fi, event, arg);
 		return;
 	}
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 
 	stop_t200(st, 6);
 	lapb_dl_release_l2l3(st, CONFIRM);
@@ -889,7 +873,7 @@
 	}
 }
 
-inline void
+static inline void
 enquiry_cr(struct PStack *st, u_char typ, u_char cr, u_char pf)
 {
 	struct sk_buff *skb;
@@ -912,7 +896,7 @@
 	enqueue_super(st, skb);
 }
 
-inline void
+static inline void
 enquiry_response(struct PStack *st)
 {
 	if (test_bit(FLG_OWN_BUSY, &st->l2.flag))
@@ -922,7 +906,7 @@
 	test_and_clear_bit(FLG_ACK_PEND, &st->l2.flag);
 }
 
-inline void
+static inline void
 transmit_enquiry(struct PStack *st)
 {
 	if (test_bit(FLG_OWN_BUSY, &st->l2.flag))
@@ -1004,7 +988,7 @@
 		PollFlag = (skb->data[0] & 0x10);
 		nr = (skb->data[0] >> 5) & 0x7;
 	}
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 
 	if (PollFlag) {
 		if (rsp)
@@ -1047,7 +1031,7 @@
 	if (!test_bit(FLG_L3_INIT, &st->l2.flag))
 		skb_queue_tail(&st->l2.i_queue, skb);
 	else
-		FreeSkb(skb);
+		dev_kfree_skb(skb);
 }
 
 static void
@@ -1093,7 +1077,7 @@
 		nr = (skb->data[i] >> 5) & 0x7;
 	}
 	if (test_bit(FLG_OWN_BUSY, &l2->flag)) {
-		FreeSkb(skb);
+		dev_kfree_skb(skb);
 		if(PollFlag) enquiry_response(st);
 	} else if (l2->vr == ns) {
 		(l2->vr)++;
@@ -1111,7 +1095,7 @@
 		st->l2.l2l3(st, DL_DATA | INDICATION, skb);
 	} else {
 		/* n(s)!=v(r) */
-		FreeSkb(skb);
+		dev_kfree_skb(skb);
 		if (test_and_set_bit(FLG_REJEXC, &l2->flag)) {
 			if (PollFlag)
 				enquiry_response(st);
@@ -1309,7 +1293,7 @@
 		skb = alloc_skb(oskb->len + i, GFP_ATOMIC);
 		memcpy(skb_put(skb, i), header, i);
 		memcpy(skb_put(skb, oskb->len), oskb->data, oskb->len);
-		FreeSkb(oskb);
+		dev_kfree_skb(oskb);
 	}
 	st->l2.l2l1(st, PH_PULL | INDICATION, skb);
 	test_and_clear_bit(FLG_ACK_PEND, &st->l2.flag);
@@ -1349,7 +1333,7 @@
 		PollFlag = (skb->data[0] & 0x10);
 		nr = (skb->data[0] >> 5) & 0x7;
 	}
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 
 	if (rsp && PollFlag) {
 		if (legalnr(st, nr)) {
@@ -1391,7 +1375,7 @@
 		establishlink(fi);
 		test_and_clear_bit(FLG_L3_INIT, &st->l2.flag);
 	}
-	FreeSkb(skb);
+	dev_kfree_skb(skb);
 }
 
 static void
@@ -1655,7 +1639,7 @@
 				datap += len;
 			else {
 				FsmEvent(&st->l2.l2m, EV_L2_FRAME_ERROR, (void *) 'N');
-				FreeSkb(skb);
+				dev_kfree_skb(skb);
 				return;
 			}
 			if (!(*datap & 1)) {	/* I-Frame */
@@ -1684,16 +1668,16 @@
 					ret = FsmEvent(&st->l2.l2m, EV_L2_FRMR, skb);
 			} else {
 				FsmEvent(&st->l2.l2m, EV_L2_FRAME_ERROR, (void *) 'L');
-				FreeSkb(skb);
+				dev_kfree_skb(skb);
 				ret = 0;
 			}
 			if(c) {
-				FreeSkb(skb);
+				dev_kfree_skb(skb);
 				FsmEvent(&st->l2.l2m, EV_L2_FRAME_ERROR, (void *)(long)c);
 				ret = 0;
 			}
 			if (ret)
-				FreeSkb(skb);
+				dev_kfree_skb(skb);
 			break;
 		case (PH_PULL | CONFIRM):
 			FsmEvent(&st->l2.l2m, EV_L2_ACK_PULL, arg);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl3.c.old	2005-02-05 22:19:46.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isdnl3.c	2005-02-05 22:19:53.000000000 +0100
@@ -390,7 +390,7 @@
 	}
 }
 
-void
+static void
 isdnl3_trans(struct PStack *st, int pr, void *arg) {
 	st->l3.l3l2(st, pr, arg);
 }
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isurf.c.old	2005-02-05 22:20:08.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/isurf.c	2005-02-05 22:20:15.000000000 +0100
@@ -122,7 +122,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_isurf(struct IsdnCardState *cs)
 {
 	release_region(cs->hw.isurf.reset, 1);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/ix1_micro.c.old	2005-02-05 22:20:32.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/ix1_micro.c	2005-02-05 22:20:58.000000000 +0100
@@ -25,7 +25,7 @@
 #include "isdnl1.h"
 
 extern const char *CardType[];
-const char *ix1_revision = "$Revision: 2.12.2.4 $";
+static const char *ix1_revision = "$Revision: 2.12.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -162,7 +162,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_ix1micro(struct IsdnCardState *cs)
 {
 	if (cs->hw.ix1.cfg_reg)
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/jade.h.old	2005-02-05 22:21:36.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/jade.h	2005-02-05 22:21:39.000000000 +0100
@@ -128,7 +128,6 @@
 #define	jade_TXAUDIOCH2CFG				0x1A
 
 extern int JadeVersion(struct IsdnCardState *cs, char *s);
-extern void modejade(struct BCState *bcs, int mode, int bc);
 extern void clear_pending_jade_ints(struct IsdnCardState *cs);
 extern void initjade(struct IsdnCardState *cs);
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/jade.c.old	2005-02-05 22:21:09.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/jade.c	2005-02-05 22:21:50.000000000 +0100
@@ -74,7 +74,7 @@
 
 
 
-void
+static void
 modejade(struct BCState *bcs, int mode, int bc)
 {
     struct IsdnCardState *cs = bcs->cs;
@@ -190,7 +190,7 @@
     }
 }
 
-void
+static void
 close_jadestate(struct BCState *bcs)
 {
     modejade(bcs, 0, bcs->channel);
@@ -243,7 +243,7 @@
 }
 
 
-int
+static int
 setstack_jade(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3_1tr6.c.old	2005-02-05 22:22:02.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3_1tr6.c	2005-02-05 22:22:17.000000000 +0100
@@ -19,7 +19,7 @@
 #include <linux/ctype.h>
 
 extern char *HiSax_getrev(const char *revision);
-const char *l3_1tr6_revision = "$Revision: 2.15.2.3 $";
+static const char *l3_1tr6_revision = "$Revision: 2.15.2.3 $";
 
 #define MsgHead(ptr, cref, mty, dis) \
 	*ptr++ = dis; \
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3dss1.c.old	2005-02-05 22:22:31.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3dss1.c	2005-02-05 22:22:41.000000000 +0100
@@ -26,7 +26,7 @@
 #include <linux/config.h>
 
 extern char *HiSax_getrev(const char *revision);
-const char *dss1_revision = "$Revision: 2.32.2.3 $";
+static const char *dss1_revision = "$Revision: 2.32.2.3 $";
 
 #define EXT_BEARER_CAPS 1
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3ni1.c.old	2005-02-05 22:22:55.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/l3ni1.c	2005-02-05 22:23:19.000000000 +0100
@@ -24,7 +24,7 @@
 #include <linux/ctype.h>
 
 extern char *HiSax_getrev(const char *revision);
-const char *ni1_revision = "$Revision: 2.8.2.3 $";
+static const char *ni1_revision = "$Revision: 2.8.2.3 $";
 
 #define EXT_BEARER_CAPS 1
 
@@ -2665,7 +2665,7 @@
 	l3ni1_SendSpid( pc, pr, arg, 20 );
 }
 
-void l3ni1_spid_epid( struct l3_process *pc, u_char pr, void *arg )
+static void l3ni1_spid_epid( struct l3_process *pc, u_char pr, void *arg )
 {
 	struct sk_buff *skb = arg;
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/mic.c.old	2005-02-05 22:23:34.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/mic.c	2005-02-05 22:23:51.000000000 +0100
@@ -18,7 +18,7 @@
 
 extern const char *CardType[];
 
-const char *mic_revision = "$Revision: 1.12.2.4 $";
+static const char *mic_revision = "$Revision: 1.12.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -157,7 +157,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_mic(struct IsdnCardState *cs)
 {
 	int bytecnt = 8;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/netjet.c.old	2005-02-05 22:24:03.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/netjet.c	2005-02-05 22:25:09.000000000 +0100
@@ -25,8 +25,6 @@
 #include <asm/io.h>
 #include "netjet.h"
 
-const char *NETjet_revision = "$Revision: 1.29.2.4 $";
-
 /* Interface functions */
 
 u_char
@@ -66,7 +64,7 @@
 	outsb(cs->hw.njet.isac, data, size);
 }
 
-void fill_mem(struct BCState *bcs, u_int *pos, u_int cnt, int chan, u_char fill)
+static void fill_mem(struct BCState *bcs, u_int *pos, u_int cnt, int chan, u_char fill)
 {
 	u_int mask=0x000000ff, val = 0, *p=pos;
 	u_int i;
@@ -85,7 +83,7 @@
 	}
 }
 
-void
+static void
 mode_tiger(struct BCState *bcs, int mode, int bc)
 {
 	struct IsdnCardState *cs = bcs->cs;
@@ -852,7 +850,7 @@
 }
 
 
-void
+static void
 close_tigerstate(struct BCState *bcs)
 {
 	mode_tiger(bcs, 0, bcs->channel);
@@ -900,7 +898,7 @@
 	return (0);
 }
 
-int
+static int
 setstack_tiger(struct PStack *st, struct BCState *bcs)
 {
 	bcs->channel = st->l1.bc;
@@ -966,7 +964,7 @@
 	cs->bcs[1].BC_Close = close_tigerstate;
 }
 
-void
+static void
 releasetiger(struct IsdnCardState *cs)
 {
 	if (cs->bcs[0].hw.tiger.send) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/niccy.c.old	2005-02-05 22:25:21.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/niccy.c	2005-02-05 22:25:41.000000000 +0100
@@ -24,7 +24,7 @@
 #include <linux/isapnp.h>
 
 extern const char *CardType[];
-const char *niccy_revision = "$Revision: 1.21.2.4 $";
+static const char *niccy_revision = "$Revision: 1.21.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -178,7 +178,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_niccy(struct IsdnCardState *cs)
 {
 	if (cs->subtyp == NICCY_PCI) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/nj_s.c.old	2005-02-05 22:25:56.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/nj_s.c	2005-02-05 22:26:07.000000000 +0100
@@ -15,7 +15,7 @@
 #include <linux/ppp_defs.h>
 #include "netjet.h"
 
-const char *NETjet_S_revision = "$Revision: 2.13.2.4 $";
+static const char *NETjet_S_revision = "$Revision: 2.13.2.4 $";
 
 static u_char dummyrr(struct IsdnCardState *cs, int chan, u_char off)
 {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/nj_u.c.old	2005-02-05 22:26:19.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/nj_u.c	2005-02-05 22:26:27.000000000 +0100
@@ -15,7 +15,7 @@
 #include <linux/ppp_defs.h>
 #include "netjet.h"
 
-const char *NETjet_U_revision = "$Revision: 2.14.2.3 $";
+static const char *NETjet_U_revision = "$Revision: 2.14.2.3 $";
 
 static u_char dummyrr(struct IsdnCardState *cs, int chan, u_char off)
 {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/q931.c.old	2005-02-05 22:26:43.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/q931.c	2005-02-05 22:27:10.000000000 +0100
@@ -516,7 +516,7 @@
 	{CAUSE_UserInfoDiscarded, "User Info Discarded"}
 };
 
-int cause_1tr6_len = (sizeof(cause_1tr6) / sizeof(struct MessageType));
+static int cause_1tr6_len = (sizeof(cause_1tr6) / sizeof(struct MessageType));
 
 static int
 prcause_1tr6(char *dest, u_char * p)
@@ -935,7 +935,7 @@
 	return (dp - dest);
 }
 
-int
+static int
 prfacility(char *dest, u_char * p)
 {
 	char *dp = dest;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/s0box.c.old	2005-02-05 22:27:24.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/s0box.c	2005-02-05 22:27:42.000000000 +0100
@@ -17,7 +17,7 @@
 #include "isdnl1.h"
 
 extern const char *CardType[];
-const char *s0box_revision = "$Revision: 2.6.2.4 $";
+static const char *s0box_revision = "$Revision: 2.6.2.4 $";
 
 static inline void
 writereg(unsigned int padr, signed int addr, u_char off, u_char val) {
@@ -183,7 +183,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_s0box(struct IsdnCardState *cs)
 {
 	release_region(cs->hw.teles3.cfg_reg, 8);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/saphir.c.old	2005-02-05 22:28:00.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/saphir.c	2005-02-05 22:28:20.000000000 +0100
@@ -171,7 +171,7 @@
 	mod_timer(&cs->hw.saphir.timer, jiffies+1*HZ);
 }
 
-void
+static void
 release_io_saphir(struct IsdnCardState *cs)
 {
 	byteout(cs->hw.saphir.cfg_reg + IRQ_REG, 0xff);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/sedlbauer.c.old	2005-02-05 22:28:59.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/sedlbauer.c	2005-02-05 22:29:28.000000000 +0100
@@ -51,9 +51,9 @@
 
 extern const char *CardType[];
 
-const char *Sedlbauer_revision = "$Revision: 1.34.2.6 $";
+static const char *Sedlbauer_revision = "$Revision: 1.34.2.6 $";
 
-const char *Sedlbauer_Types[] =
+static const char *Sedlbauer_Types[] =
 	{"None", "speed card/win", "speed star", "speed fax+",
 	"speed win II / ISDN PC/104", "speed star II", "speed pci",
 	"speed fax+ pyramid", "speed fax+ pci", "HST Saphir III"};
@@ -394,7 +394,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_sedlbauer(struct IsdnCardState *cs)
 {
 	int bytecnt = 8;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/sportster.c.old	2005-02-05 22:29:44.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/sportster.c	2005-02-05 22:30:15.000000000 +0100
@@ -19,7 +19,7 @@
 #include "isdnl1.h"
 
 extern const char *CardType[];
-const char *sportster_revision = "$Revision: 1.16.2.4 $";
+static const char *sportster_revision = "$Revision: 1.16.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -132,7 +132,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_sportster(struct IsdnCardState *cs)
 {
 	int i, adr;
@@ -144,7 +144,7 @@
 	}
 }
 
-void
+static void
 reset_sportster(struct IsdnCardState *cs)
 {
 	cs->hw.spt.res_irq |= SPORTSTER_RESET; /* Reset On */
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481.h.old	2005-02-05 22:35:04.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481.h	2005-02-05 22:35:48.000000000 +0100
@@ -450,12 +450,8 @@
 			   usb_complete_t complete, void *context);
 void st5481_release_isocpipes(struct urb* urb[2]);
 
-int  st5481_isoc_flatten(struct urb *urb);
 void st5481_usb_pipe_reset(struct st5481_adapter *adapter,
 		    u_char pipe, ctrl_complete_t complete, void *context);
-void st5481_usb_ctrl_msg(struct st5481_adapter *adapter,
-		  u8 request, u8 requesttype, u16 value, u16 index,
-		  ctrl_complete_t complete, void *context);
 void st5481_usb_device_ctrl_msg(struct st5481_adapter *adapter,
 			 u8 request, u16 value,
 			 ctrl_complete_t complete, void *context);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481_usb.c.old	2005-02-05 22:35:18.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481_usb.c	2005-02-05 22:36:06.000000000 +0100
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include "st5481.h"
 
+static int st5481_isoc_flatten(struct urb *urb);
+
 /* ======================================================================
  * control pipe
  */
@@ -55,9 +57,9 @@
  * Asynchronous endpoint 0 request (async version of usb_control_msg).
  * The request will be queued up in a FIFO if the endpoint is busy.
  */
-void usb_ctrl_msg(struct st5481_adapter *adapter,
-		  u8 request, u8 requesttype, u16 value, u16 index,
-		  ctrl_complete_t complete, void *context)
+static void usb_ctrl_msg(struct st5481_adapter *adapter,
+			 u8 request, u8 requesttype, u16 value, u16 index,
+			 ctrl_complete_t complete, void *context)
 {
 	struct st5481_ctrl *ctrl = &adapter->ctrl;
 	int w_index;
@@ -571,7 +573,7 @@
  * Make the transfer_buffer contiguous by
  * copying from the iso descriptors if necessary. 
  */
-int st5481_isoc_flatten(struct urb *urb)
+static int st5481_isoc_flatten(struct urb *urb)
 {
 	struct usb_iso_packet_descriptor *pipd,*pend;
 	unsigned char *src,*dst;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/tei.c.old	2005-02-05 22:36:29.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/tei.c	2005-02-05 22:36:35.000000000 +0100
@@ -74,7 +74,7 @@
 	"EV_T202",
 };
 
-unsigned int
+static unsigned int
 random_ri(void)
 {
 	unsigned int x;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teleint.c.old	2005-02-05 22:36:46.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teleint.c	2005-02-05 22:37:05.000000000 +0100
@@ -18,7 +18,7 @@
 
 extern const char *CardType[];
 
-const char *TeleInt_revision = "$Revision: 1.16.2.5 $";
+static const char *TeleInt_revision = "$Revision: 1.16.2.5 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -203,7 +203,7 @@
 	add_timer(&cs->hw.hfc.timer);
 }
 
-void
+static void
 release_io_TeleInt(struct IsdnCardState *cs)
 {
 	del_timer(&cs->hw.hfc.timer);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teles0.c.old	2005-02-05 22:37:18.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teles0.c	2005-02-05 22:37:40.000000000 +0100
@@ -23,7 +23,7 @@
 
 extern const char *CardType[];
 
-const char *teles0_revision = "$Revision: 2.15.2.4 $";
+static const char *teles0_revision = "$Revision: 2.15.2.4 $";
 
 #define TELES_IOMEM_SIZE	0x400
 #define byteout(addr,val) outb(val,addr)
@@ -183,7 +183,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_teles0(struct IsdnCardState *cs)
 {
 	if (cs->hw.teles0.cfg_reg)
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teles3.c.old	2005-02-05 22:37:54.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/teles3.c	2005-02-05 22:38:21.000000000 +0100
@@ -21,7 +21,7 @@
 #include "isdnl1.h"
 
 extern const char *CardType[];
-const char *teles3_revision = "$Revision: 2.19.2.4 $";
+static const char *teles3_revision = "$Revision: 2.19.2.4 $";
 
 #define byteout(addr,val) outb(val,addr)
 #define bytein(addr) inb(addr)
@@ -154,7 +154,7 @@
 		release_region(cs->hw.teles3.hscx[1] + 32, 32);
 }
 
-void
+static void
 release_io_teles3(struct IsdnCardState *cs)
 {
 	if (cs->typ == ISDN_CTYPE_TELESPCMCIA) {
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/telespci.c.old	2005-02-05 22:38:36.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/telespci.c	2005-02-05 22:39:08.000000000 +0100
@@ -21,7 +21,7 @@
 #include <linux/pci.h>
 
 extern const char *CardType[];
-const char *telespci_revision = "$Revision: 2.23.2.3 $";
+static const char *telespci_revision = "$Revision: 2.23.2.3 $";
 
 #define ZORAN_PO_RQ_PEN	0x02000000
 #define ZORAN_PO_WR	0x00800000
@@ -257,7 +257,7 @@
 	return IRQ_HANDLED;
 }
 
-void
+static void
 release_io_telespci(struct IsdnCardState *cs)
 {
 	iounmap(cs->hw.teles0.membase);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/w6692.c.old	2005-02-05 22:39:23.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/w6692.c	2005-02-05 22:39:56.000000000 +0100
@@ -41,7 +41,7 @@
 
 extern const char *CardType[];
 
-const char *w6692_revision = "$Revision: 1.18.2.4 $";
+static const char *w6692_revision = "$Revision: 1.18.2.4 $";
 
 #define DBUSY_TIMER_VALUE 80
 
@@ -880,7 +880,7 @@
 	return (0);
 }
 
-void resetW6692(struct IsdnCardState *cs)
+static void resetW6692(struct IsdnCardState *cs)
 {
 	cs->writeW6692(cs, W_D_CTL, W_D_CTL_SRST);
 	mdelay(10);
@@ -902,7 +902,7 @@
 	}
 }
 
-void __init initW6692(struct IsdnCardState *cs, int part)
+static void __init initW6692(struct IsdnCardState *cs, int part)
 {
 	if (part & 1) {
 		cs->setstack_d = setstack_W6692;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/enternow.h	2005-02-05 21:40:34.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,51 +0,0 @@
-/* 2001/10/02
- *
- * enternow.h   Header-file included by
- *              enternow_pci.c
- *
- * Author       Christoph Ersfeld <info@formula-n.de>
- *              Formula-n Europe AG (www.formula-n.com)
- *              previously Gerdes AG
- *
- *
- *              This file is (c) under GNU PUBLIC LICENSE
- */
-
-
-/* ***************************************************************************************** *
- * ****************************** datatypes and macros ************************************* *
- * ***************************************************************************************** */
-
-#define BYTE							unsigned char
-#define WORD							unsigned int
-#define HIBYTE(w)						((unsigned char)((w & 0xff00) / 256))
-#define LOBYTE(w)						((unsigned char)(w & 0x00ff))
-#define InByte(addr)						inb(addr)
-#define OutByte(addr,val)					outb(val,addr)
-
-
-
-/* ***************************************************************************************** *
- * *********************************** card-specific *************************************** *
- * ***************************************************************************************** */
-
-/* für PowerISDN PCI */
-#define TJ_AMD_IRQ 						0x20
-#define TJ_LED1 						0x40
-#define TJ_LED2 						0x80
-
-
-/* Das Fenster zum AMD...
- * Ab Adresse hw.njet.base + TJ_AMD_PORT werden vom AMD jeweils 8 Bit in
- * den TigerJet i/o-Raum gemappt
- * -> 0x01 des AMD bei hw.njet.base + 0C4 */
-#define TJ_AMD_PORT						0xC0
-
-
-
-/* ***************************************************************************************** *
- * *************************************** Prototypen ************************************** *
- * ***************************************************************************************** */
-
-BYTE ReadByteAmd7930(struct IsdnCardState *cs, BYTE offset);
-void WriteByteAmd7930(struct IsdnCardState *cs, BYTE offset, BYTE value);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481_hdlc.h	2005-02-05 22:31:04.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,62 +0,0 @@
-/*
- * Driver for ST5481 USB ISDN modem
- *
- * Author       Frode Isaksen
- * Copyright    2001 by Frode Isaksen      <fisaksen@bewan.com>
- *              2001 by Kai Germaschewski  <kai.germaschewski@gmx.de>
- * 
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
- */
-
-#ifndef __ST5481_HDLC_H__
-#define __ST5481_HDLC_H__
-
-struct hdlc_vars {
-  	int bit_shift; 
-	int hdlc_bits1;
-	int data_bits;
-	int ffbit_shift; // encoding only
-	int state;
-	int dstpos;
-
-	int data_received:1; // set if transferring data
-	int dchannel:1; // set if D channel (send idle instead of flags)
-	int do_adapt56:1; // set if 56K adaptation
-        int do_closing:1; // set if in closing phase (need to send CRC + flag
-
-	unsigned short crc;
-
-	unsigned char cbin; 
-	unsigned char shift_reg;
-	unsigned char ffvalue;
-	
-};
-
-
-/*
-  The return value from hdlc_decode is
-  the frame length, 0 if no complete frame was decoded,
-  or a negative error number
-*/
-
-#define HDLC_FRAMING_ERROR     1
-#define HDLC_CRC_ERROR         2
-#define HDLC_LENGTH_ERROR      3
-
-void 
-hdlc_rcv_init(struct hdlc_vars *hdlc, int do_adapt56);
-
-int
-hdlc_decode(struct hdlc_vars *hdlc, const unsigned char *src, int slen,int *count, 
-	    unsigned char *dst, int dsize);
-
-void 
-hdlc_out_init(struct hdlc_vars *hdlc,int is_d_channel,int do_adapt56);
-
-int 
-hdlc_encode(struct hdlc_vars *hdlc,const unsigned char *src,unsigned short slen,int *count,
-	    unsigned char *dst,int dsize);
-
-#endif
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hisax/st5481_hdlc.c	2005-02-05 22:31:30.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,580 +0,0 @@
-/*
- * Driver for ST5481 USB ISDN modem
- *
- * Author       Frode Isaksen
- * Copyright    2001 by Frode Isaksen      <fisaksen@bewan.com>
- *              2001 by Kai Germaschewski  <kai.germaschewski@gmx.de>
- * 
- * This software may be used and distributed according to the terms
- * of the GNU General Public License, incorporated herein by reference.
- *
- */
-
-#include <linux/crc-ccitt.h>
-#include "st5481_hdlc.h"
-
-
-enum {
-	HDLC_FAST_IDLE,HDLC_GET_FLAG_B0,HDLC_GETFLAG_B1A6,HDLC_GETFLAG_B7,
-	HDLC_GET_DATA,HDLC_FAST_FLAG
-};
-
-enum {
-	HDLC_SEND_DATA,HDLC_SEND_CRC1,HDLC_SEND_FAST_FLAG,
-	HDLC_SEND_FIRST_FLAG,HDLC_SEND_CRC2,HDLC_SEND_CLOSING_FLAG,
-	HDLC_SEND_IDLE1,HDLC_SEND_FAST_IDLE,HDLC_SENDFLAG_B0,
-	HDLC_SENDFLAG_B1A6,HDLC_SENDFLAG_B7,STOPPED
-};
-
-void 
-hdlc_rcv_init(struct hdlc_vars *hdlc, int do_adapt56)
-{
-   	hdlc->bit_shift = 0;
-	hdlc->hdlc_bits1 = 0;
-	hdlc->data_bits = 0;
-	hdlc->ffbit_shift = 0;
-	hdlc->data_received = 0;
-	hdlc->state = HDLC_GET_DATA;
-	hdlc->do_adapt56 = do_adapt56;
-	hdlc->dchannel = 0;
-	hdlc->crc = 0;
-	hdlc->cbin = 0;
-	hdlc->shift_reg = 0;
-	hdlc->ffvalue = 0;
-	hdlc->dstpos = 0;
-}
-
-void 
-hdlc_out_init(struct hdlc_vars *hdlc, int is_d_channel, int do_adapt56)
-{
-   	hdlc->bit_shift = 0;
-	hdlc->hdlc_bits1 = 0;
-	hdlc->data_bits = 0;
-	hdlc->ffbit_shift = 0;
-	hdlc->data_received = 0;
-	hdlc->do_closing = 0;
-	hdlc->ffvalue = 0;
-	if (is_d_channel) {
-		hdlc->dchannel = 1;
-		hdlc->state = HDLC_SEND_FIRST_FLAG;
-	} else {
-		hdlc->dchannel = 0;
-		hdlc->state = HDLC_SEND_FAST_FLAG;
-		hdlc->ffvalue = 0x7e;
-	} 
-	hdlc->cbin = 0x7e;
-	hdlc->bit_shift = 0;
-	if(do_adapt56){
-		hdlc->do_adapt56 = 1;		
-		hdlc->data_bits = 0;
-		hdlc->state = HDLC_SENDFLAG_B0;
-	} else {
-		hdlc->do_adapt56 = 0;		
-		hdlc->data_bits = 8;
-	}
-	hdlc->shift_reg = 0;
-}
-
-/*
-  hdlc_decode - decodes HDLC frames from a transparent bit stream.
-
-  The source buffer is scanned for valid HDLC frames looking for
-  flags (01111110) to indicate the start of a frame. If the start of
-  the frame is found, the bit stuffing is removed (0 after 5 1's).
-  When a new flag is found, the complete frame has been received
-  and the CRC is checked.
-  If a valid frame is found, the function returns the frame length 
-  excluding the CRC with the bit HDLC_END_OF_FRAME set.
-  If the beginning of a valid frame is found, the function returns
-  the length. 
-  If a framing error is found (too many 1s and not a flag) the function 
-  returns the length with the bit HDLC_FRAMING_ERROR set.
-  If a CRC error is found the function returns the length with the
-  bit HDLC_CRC_ERROR set.
-  If the frame length exceeds the destination buffer size, the function
-  returns the length with the bit HDLC_LENGTH_ERROR set.
-
-  src - source buffer
-  slen - source buffer length
-  count - number of bytes removed (decoded) from the source buffer
-  dst _ destination buffer
-  dsize - destination buffer size
-  returns - number of decoded bytes in the destination buffer and status
-  flag.
- */
-int hdlc_decode(struct hdlc_vars *hdlc, const unsigned char *src,
-		int slen, int *count, unsigned char *dst, int dsize)
-{
-	int status=0;
-
-	static const unsigned char fast_flag[]={
-		0x00,0x00,0x00,0x20,0x30,0x38,0x3c,0x3e,0x3f
-	};
-
-	static const unsigned char fast_flag_value[]={
-		0x00,0x7e,0xfc,0xf9,0xf3,0xe7,0xcf,0x9f,0x3f
-	};
-
-	static const unsigned char fast_abort[]={
-		0x00,0x00,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff
-	};
-
-	*count = slen;
-
-	while(slen > 0){
-		if(hdlc->bit_shift==0){
-			hdlc->cbin = *src++;
-			slen--;
-			hdlc->bit_shift = 8;
-			if(hdlc->do_adapt56){
-				hdlc->bit_shift --;
-			}
-		}
-
-		switch(hdlc->state){
-		case STOPPED:
-			return 0;
-		case HDLC_FAST_IDLE:
-			if(hdlc->cbin == 0xff){
-				hdlc->bit_shift = 0;
-				break;
-			}
-			hdlc->state = HDLC_GET_FLAG_B0;
-			hdlc->hdlc_bits1 = 0;
-			hdlc->bit_shift = 8;
-			break;
-		case HDLC_GET_FLAG_B0:
-			if(!(hdlc->cbin & 0x80)) {
-				hdlc->state = HDLC_GETFLAG_B1A6;
-				hdlc->hdlc_bits1 = 0;
-			} else {
-				if(!hdlc->do_adapt56){
-					if(++hdlc->hdlc_bits1 >=8 ) if(hdlc->bit_shift==1)
-						hdlc->state = HDLC_FAST_IDLE;
-				}
-			}
-			hdlc->cbin<<=1;
-			hdlc->bit_shift --;
-			break;
-		case HDLC_GETFLAG_B1A6:
-			if(hdlc->cbin & 0x80){
-				hdlc->hdlc_bits1++;
-				if(hdlc->hdlc_bits1==6){
-					hdlc->state = HDLC_GETFLAG_B7;
-				}
-			} else {
-				hdlc->hdlc_bits1 = 0;
-			}
-			hdlc->cbin<<=1;
-			hdlc->bit_shift --;
-			break;
-		case HDLC_GETFLAG_B7:
-			if(hdlc->cbin & 0x80) {
-				hdlc->state = HDLC_GET_FLAG_B0;
-			} else {
-				hdlc->state = HDLC_GET_DATA;
-				hdlc->crc = 0xffff;
-				hdlc->shift_reg = 0;
-				hdlc->hdlc_bits1 = 0;
-				hdlc->data_bits = 0;
-				hdlc->data_received = 0;
-			}
-			hdlc->cbin<<=1;
-			hdlc->bit_shift --;
-			break;
-		case HDLC_GET_DATA:
-			if(hdlc->cbin & 0x80){
-				hdlc->hdlc_bits1++;
-				switch(hdlc->hdlc_bits1){
-				case 6:
-					break;
-				case 7:
-					if(hdlc->data_received) {
-						// bad frame
-						status = -HDLC_FRAMING_ERROR;
-					}
-					if(!hdlc->do_adapt56){
-						if(hdlc->cbin==fast_abort[hdlc->bit_shift+1]){
-							hdlc->state = HDLC_FAST_IDLE;
-							hdlc->bit_shift=1;
-							break;
-						}
-					} else {
-						hdlc->state = HDLC_GET_FLAG_B0;
-					}
-					break;
-				default:
-					hdlc->shift_reg>>=1;
-					hdlc->shift_reg |= 0x80;
-					hdlc->data_bits++;
-					break;
-				}
-			} else {
-				switch(hdlc->hdlc_bits1){
-				case 5:
-					break;
-				case 6:
-					if(hdlc->data_received){
-						if (hdlc->dstpos < 2) {
-							status = -HDLC_FRAMING_ERROR;
-						} else if (hdlc->crc != 0xf0b8){
-							// crc error
-							status = -HDLC_CRC_ERROR;
-						} else {
-							// remove CRC
-							hdlc->dstpos -= 2;
-							// good frame
-							status = hdlc->dstpos;
-						}
-					}
-					hdlc->crc = 0xffff;
-					hdlc->shift_reg = 0;
-					hdlc->data_bits = 0;
-					if(!hdlc->do_adapt56){
-						if(hdlc->cbin==fast_flag[hdlc->bit_shift]){
-							hdlc->ffvalue = fast_flag_value[hdlc->bit_shift];
-							hdlc->state = HDLC_FAST_FLAG;
-							hdlc->ffbit_shift = hdlc->bit_shift;
-							hdlc->bit_shift = 1;
-						} else {
-							hdlc->state = HDLC_GET_DATA;
-							hdlc->data_received = 0;
-						}
-					} else {
-						hdlc->state = HDLC_GET_DATA;
-						hdlc->data_received = 0;
-					}
-					break;
-				default:
-					hdlc->shift_reg>>=1;
-					hdlc->data_bits++;
-					break;
-				}
-				hdlc->hdlc_bits1 = 0;
-			}
-			if (status) {
-				hdlc->dstpos = 0;
-				*count -= slen;
-				hdlc->cbin <<= 1;
-				hdlc->bit_shift--;
-				return status;
-			}
-			if(hdlc->data_bits==8){
-				hdlc->data_bits = 0;
-				hdlc->data_received = 1;
-				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
-
-				// good byte received
-				if (dsize--) {
-					dst[hdlc->dstpos++] = hdlc->shift_reg;
-				} else {
-					// frame too long
-					status = -HDLC_LENGTH_ERROR;
-					hdlc->dstpos = 0;
-				}
-			}
-			hdlc->cbin <<= 1;
-			hdlc->bit_shift--;
-			break;
-		case HDLC_FAST_FLAG:
-			if(hdlc->cbin==hdlc->ffvalue){
-				hdlc->bit_shift = 0;
-				break;
-			} else {
-				if(hdlc->cbin == 0xff){
-					hdlc->state = HDLC_FAST_IDLE;
-					hdlc->bit_shift=0;
-				} else if(hdlc->ffbit_shift==8){
-					hdlc->state = HDLC_GETFLAG_B7;
-					break;
-				} else {
-					hdlc->shift_reg = fast_abort[hdlc->ffbit_shift-1];
-					hdlc->hdlc_bits1 = hdlc->ffbit_shift-2;
-					if(hdlc->hdlc_bits1<0)hdlc->hdlc_bits1 = 0;
-					hdlc->data_bits = hdlc->ffbit_shift-1;
-					hdlc->state = HDLC_GET_DATA;
-					hdlc->data_received = 0;
-				}
-			}
-			break;
-		default:
-			break;
-		}
-	}
-	*count -= slen;
-	return 0;
-}
-
-/*
-  hdlc_encode - encodes HDLC frames to a transparent bit stream.
-
-  The bit stream starts with a beginning flag (01111110). After
-  that each byte is added to the bit stream with bit stuffing added
-  (0 after 5 1's).
-  When the last byte has been removed from the source buffer, the
-  CRC (2 bytes is added) and the frame terminates with the ending flag.
-  For the dchannel, the idle character (all 1's) is also added at the end.
-  If this function is called with empty source buffer (slen=0), flags or
-  idle character will be generated.
- 
-  src - source buffer
-  slen - source buffer length
-  count - number of bytes removed (encoded) from source buffer
-  dst _ destination buffer
-  dsize - destination buffer size
-  returns - number of encoded bytes in the destination buffer
-*/
-int hdlc_encode(struct hdlc_vars *hdlc, const unsigned char *src, 
-		unsigned short slen, int *count,
-		unsigned char *dst, int dsize)
-{
-	static const unsigned char xfast_flag_value[] = {
-		0x7e,0x3f,0x9f,0xcf,0xe7,0xf3,0xf9,0xfc,0x7e
-	};
-
-	int len = 0;
-
-	*count = slen;
-
-	while (dsize > 0) {
-		if(hdlc->bit_shift==0){	
-			if(slen && !hdlc->do_closing){
-				hdlc->shift_reg = *src++;
-				slen--;
-				if (slen == 0) 
-					hdlc->do_closing = 1;  /* closing sequence, CRC + flag(s) */
-				hdlc->bit_shift = 8;
-			} else {
-				if(hdlc->state == HDLC_SEND_DATA){
-					if(hdlc->data_received){
-						hdlc->state = HDLC_SEND_CRC1;
-						hdlc->crc ^= 0xffff;
-						hdlc->bit_shift = 8;
-						hdlc->shift_reg = hdlc->crc & 0xff;
-					} else if(!hdlc->do_adapt56){
-						hdlc->state = HDLC_SEND_FAST_FLAG;
-					} else {
-						hdlc->state = HDLC_SENDFLAG_B0;
-					}
-				}
-			  
-			}
-		}
-
-		switch(hdlc->state){
-		case STOPPED:
-			while (dsize--)
-				*dst++ = 0xff;
-		  
-			return dsize;
-		case HDLC_SEND_FAST_FLAG:
-			hdlc->do_closing = 0;
-			if(slen == 0){
-				*dst++ = hdlc->ffvalue;
-				len++;
-				dsize--;
-				break;
-			}
-			if(hdlc->bit_shift==8){
-				hdlc->cbin = hdlc->ffvalue>>(8-hdlc->data_bits);
-				hdlc->state = HDLC_SEND_DATA;
-				hdlc->crc = 0xffff;
-				hdlc->hdlc_bits1 = 0;
-				hdlc->data_received = 1;
-			}
-			break;
-		case HDLC_SENDFLAG_B0:
-			hdlc->do_closing = 0;
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			hdlc->hdlc_bits1 = 0;
-			hdlc->state = HDLC_SENDFLAG_B1A6;
-			break;
-		case HDLC_SENDFLAG_B1A6:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			hdlc->cbin++;
-			if(++hdlc->hdlc_bits1 == 6)
-				hdlc->state = HDLC_SENDFLAG_B7;
-			break;
-		case HDLC_SENDFLAG_B7:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(slen == 0){
-				hdlc->state = HDLC_SENDFLAG_B0;
-				break;
-			}
-			if(hdlc->bit_shift==8){
-				hdlc->state = HDLC_SEND_DATA;
-				hdlc->crc = 0xffff;
-				hdlc->hdlc_bits1 = 0;
-				hdlc->data_received = 1;
-			}
-			break;
-		case HDLC_SEND_FIRST_FLAG:
-			hdlc->data_received = 1;
-			if(hdlc->data_bits==8){
-				hdlc->state = HDLC_SEND_DATA;
-				hdlc->crc = 0xffff;
-				hdlc->hdlc_bits1 = 0;
-				break;
-			}
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(hdlc->shift_reg & 0x01)
-				hdlc->cbin++;
-			hdlc->shift_reg >>= 1;
-			hdlc->bit_shift--;
-			if(hdlc->bit_shift==0){
-				hdlc->state = HDLC_SEND_DATA;
-				hdlc->crc = 0xffff;
-				hdlc->hdlc_bits1 = 0;
-			}
-			break;
-		case HDLC_SEND_DATA:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(hdlc->hdlc_bits1 == 5){
-				hdlc->hdlc_bits1 = 0;
-				break;
-			}
-			if(hdlc->bit_shift==8){
-				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
-			}
-			if(hdlc->shift_reg & 0x01){
-				hdlc->hdlc_bits1++;
-				hdlc->cbin++;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			} else {
-				hdlc->hdlc_bits1 = 0;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			}
-			break;
-		case HDLC_SEND_CRC1:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(hdlc->hdlc_bits1 == 5){
-				hdlc->hdlc_bits1 = 0;
-				break;
-			}
-			if(hdlc->shift_reg & 0x01){
-				hdlc->hdlc_bits1++;
-				hdlc->cbin++;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			} else {
-				hdlc->hdlc_bits1 = 0;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			}
-			if(hdlc->bit_shift==0){
-				hdlc->shift_reg = (hdlc->crc >> 8);
-				hdlc->state = HDLC_SEND_CRC2;
-				hdlc->bit_shift = 8;
-			}
-			break;
-		case HDLC_SEND_CRC2:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(hdlc->hdlc_bits1 == 5){
-				hdlc->hdlc_bits1 = 0;
-				break;
-			}
-			if(hdlc->shift_reg & 0x01){
-				hdlc->hdlc_bits1++;
-				hdlc->cbin++;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			} else {
-				hdlc->hdlc_bits1 = 0;
-				hdlc->shift_reg >>= 1;
-				hdlc->bit_shift--;
-			}
-			if(hdlc->bit_shift==0){
-				hdlc->shift_reg = 0x7e;
-				hdlc->state = HDLC_SEND_CLOSING_FLAG;
-				hdlc->bit_shift = 8;
-			}
-			break;
-		case HDLC_SEND_CLOSING_FLAG:
-			hdlc->cbin <<= 1;
-			hdlc->data_bits++;
-			if(hdlc->hdlc_bits1 == 5){
-				hdlc->hdlc_bits1 = 0;
-				break;
-			}
-			if(hdlc->shift_reg & 0x01){
-				hdlc->cbin++;
-			}
-			hdlc->shift_reg >>= 1;
-			hdlc->bit_shift--;
-			if(hdlc->bit_shift==0){
-				hdlc->ffvalue = xfast_flag_value[hdlc->data_bits];
-				if(hdlc->dchannel){
-					hdlc->ffvalue = 0x7e;
-					hdlc->state = HDLC_SEND_IDLE1;
-					hdlc->bit_shift = 8-hdlc->data_bits;
-					if(hdlc->bit_shift==0)
-						hdlc->state = HDLC_SEND_FAST_IDLE;
-				} else {
-					if(!hdlc->do_adapt56){
-						hdlc->state = HDLC_SEND_FAST_FLAG;
-						hdlc->data_received = 0;
-					} else {
-						hdlc->state = HDLC_SENDFLAG_B0;
-						hdlc->data_received = 0;
-					}
-					// Finished with this frame, send flags
-					if (dsize > 1) dsize = 1; 
-				}
-			}
-			break;
-		case HDLC_SEND_IDLE1:
-			hdlc->do_closing = 0;
-			hdlc->cbin <<= 1;
-			hdlc->cbin++;
-			hdlc->data_bits++;
-			hdlc->bit_shift--;
-			if(hdlc->bit_shift==0){
-				hdlc->state = HDLC_SEND_FAST_IDLE;
-				hdlc->bit_shift = 0;
-			}
-			break;
-		case HDLC_SEND_FAST_IDLE:
-			hdlc->do_closing = 0;
-			hdlc->cbin = 0xff;
-			hdlc->data_bits = 8;
-			if(hdlc->bit_shift == 8){
-				hdlc->cbin = 0x7e;
-				hdlc->state = HDLC_SEND_FIRST_FLAG;
-			} else {
-				*dst++ = hdlc->cbin;
-				hdlc->bit_shift = hdlc->data_bits = 0;
-				len++;
-				dsize = 0;
-			}
-			break;
-		default:
-			break;
-		}
-		if(hdlc->do_adapt56){
-			if(hdlc->data_bits==7){
-				hdlc->cbin <<= 1;
-				hdlc->cbin++;
-				hdlc->data_bits++;
-			}
-		}
-		if(hdlc->data_bits==8){
-			*dst++ = hdlc->cbin;
-			hdlc->data_bits = 0;
-			len++;
-			dsize--;
-		}
-	}
-	*count -= slen;
-
-	return len;
-}
-

