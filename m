Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135788AbRDYB12>; Tue, 24 Apr 2001 21:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135789AbRDYB1R>; Tue, 24 Apr 2001 21:27:17 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:22220 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S135788AbRDYB0z>;
	Tue, 24 Apr 2001 21:26:55 -0400
Date: Tue, 24 Apr 2001 18:26:38 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jt@hpl.hp.com, Linus Torvalds <torvalds@transmeta.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: orinoco_cs & IrDA
Message-ID: <20010424182638.B32286@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010424113920.B31666@bougret.hpl.hp.com> <E14s8mc-0002n9-00@the-village.bc.nu> <20010424151508.C31898@bougret.hpl.hp.com> <20010424155637.D31898@bougret.hpl.hp.com> <20010424182550.A32286@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424182550.A32286@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Apr 24, 2001 at 06:25:50PM -0700
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 24, 2001 at 06:25:50PM -0700, Jean Tourrilhes wrote:
> 
> 	Ok, now to the second chapter. These are all the changes
> accumulated since the patch I sent one month ago (cf previous e-mail).
> 	Changes :
> 		o more Prism2/Symbol compatibility goodies
> 		o Tested D-Link cards and Lucent firmware 7.28
> 		o Cleanup, bug fixes from David Gibson
> 	The whole is tested, as usual... 75% of the patch was on my
> web pages for the last month and people seem to have liked it.
> 
> 	I've made 2 patches, one for 2.4.4-pre6 and one for
> 2.4.3-ac13. The difference between the two is minor (one line).
> 
> 	Linus : please have a look at orinoco_v4b.diff (first
> attachement). Of course, this patch will apply and work only if you
> have applied the patch in my previous e-mail.
> 
> 	Alan : orinoco_v4b-alan.diff is for you (second attachement).
> 
> 	Have fun...
> 
> 	Jean

	File attached this time...

	Jean

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="orinoco_v4b.diff"

diff -u -p linux/drivers/net/pcmcia/wireless.25b/hermes.h linux/drivers/net/pcmcia/hermes.h
--- linux/drivers/net/pcmcia/wireless.25b/hermes.h	Tue Apr 24 15:57:48 2001
+++ linux/drivers/net/pcmcia/hermes.h	Tue Apr 24 16:04:34 2001
@@ -35,18 +35,18 @@
 /*
  * Limits and constants
  */
-#define		HERMES_ALLOC_LEN_MIN		((uint16_t)4)
-#define		HERMES_ALLOC_LEN_MAX		((uint16_t)2400)
+#define		HERMES_ALLOC_LEN_MIN		(4)
+#define		HERMES_ALLOC_LEN_MAX		(2400)
 #define		HERMES_LTV_LEN_MAX		(34)
-#define		HERMES_BAP_DATALEN_MAX		((uint16_t)4096)
-#define		HERMES_BAP_OFFSET_MAX		((uint16_t)4096)
-#define		HERMES_PORTID_MAX		((uint16_t)7)
-#define		HERMES_NUMPORTS_MAX		((uint16_t)(HERMES_PORTID_MAX+1))
-#define		HERMES_PDR_LEN_MAX		((uint16_t)260)	/* in bytes, from EK */
-#define		HERMES_PDA_RECS_MAX		((uint16_t)200)	/* a guess */
-#define		HERMES_PDA_LEN_MAX		((uint16_t)1024)	/* in bytes, from EK */
-#define		HERMES_SCANRESULT_MAX		((uint16_t)35)
-#define		HERMES_CHINFORESULT_MAX		((uint16_t)8)
+#define		HERMES_BAP_DATALEN_MAX		(4096)
+#define		HERMES_BAP_OFFSET_MAX		(4096)
+#define		HERMES_PORTID_MAX		(7)
+#define		HERMES_NUMPORTS_MAX		(HERMES_PORTID_MAX+1)
+#define		HERMES_PDR_LEN_MAX		(260)	/* in bytes, from EK */
+#define		HERMES_PDA_RECS_MAX		(200)	/* a guess */
+#define		HERMES_PDA_LEN_MAX		(1024)	/* in bytes, from EK */
+#define		HERMES_SCANRESULT_MAX		(35)
+#define		HERMES_CHINFORESULT_MAX		(8)
 #define		HERMES_FRAME_LEN_MAX		(2304)
 #define		HERMES_MAX_MULTICAST		(16)
 #define		HERMES_MAGIC			(0x7d1f)
@@ -86,122 +86,125 @@
 /*
  * CMD register bitmasks
  */
-#define		HERMES_CMD_BUSY			((uint16_t)0x8000)
-#define		HERMES_CMD_AINFO		((uint16_t)0x7f00)
-#define		HERMES_CMD_MACPORT		((uint16_t)0x0700)
-#define		HERMES_CMD_RECL			((uint16_t)0x0100)
-#define		HERMES_CMD_WRITE		((uint16_t)0x0100)
-#define		HERMES_CMD_PROGMODE		((uint16_t)0x0300)
-#define		HERMES_CMD_CMDCODE		((uint16_t)0x003f)
+#define		HERMES_CMD_BUSY			(0x8000)
+#define		HERMES_CMD_AINFO		(0x7f00)
+#define		HERMES_CMD_MACPORT		(0x0700)
+#define		HERMES_CMD_RECL			(0x0100)
+#define		HERMES_CMD_WRITE		(0x0100)
+#define		HERMES_CMD_PROGMODE		(0x0300)
+#define		HERMES_CMD_CMDCODE		(0x003f)
 
 /*
  * STATUS register bitmasks
  */
-#define		HERMES_STATUS_RESULT		((uint16_t)0x7f00)
-#define		HERMES_STATUS_CMDCODE		((uint16_t)0x003f)
+#define		HERMES_STATUS_RESULT		(0x7f00)
+#define		HERMES_STATUS_CMDCODE		(0x003f)
 
 /*
  * OFFSET refister bitmasks
  */
-#define		HERMES_OFFSET_BUSY		((uint16_t)0x8000)
-#define		HERMES_OFFSET_ERR		((uint16_t)0x4000)
-#define		HERMES_OFFSET_DATAOFF		((uint16_t)0x0ffe)
+#define		HERMES_OFFSET_BUSY		(0x8000)
+#define		HERMES_OFFSET_ERR		(0x4000)
+#define		HERMES_OFFSET_DATAOFF		(0x0ffe)
 
 /*
  * Event register bitmasks (INTEN, EVSTAT, EVACK)
  */
-#define		HERMES_EV_TICK			((uint16_t)0x8000)
-#define		HERMES_EV_WTERR			((uint16_t)0x4000)
-#define		HERMES_EV_INFDROP		((uint16_t)0x2000)
-#define		HERMES_EV_INFO			((uint16_t)0x0080)
-#define		HERMES_EV_DTIM			((uint16_t)0x0020)
-#define		HERMES_EV_CMD			((uint16_t)0x0010)
-#define		HERMES_EV_ALLOC			((uint16_t)0x0008)
-#define		HERMES_EV_TXEXC			((uint16_t)0x0004)
-#define		HERMES_EV_TX			((uint16_t)0x0002)
-#define		HERMES_EV_RX			((uint16_t)0x0001)
+#define		HERMES_EV_TICK			(0x8000)
+#define		HERMES_EV_WTERR			(0x4000)
+#define		HERMES_EV_INFDROP		(0x2000)
+#define		HERMES_EV_INFO			(0x0080)
+#define		HERMES_EV_DTIM			(0x0020)
+#define		HERMES_EV_CMD			(0x0010)
+#define		HERMES_EV_ALLOC			(0x0008)
+#define		HERMES_EV_TXEXC			(0x0004)
+#define		HERMES_EV_TX			(0x0002)
+#define		HERMES_EV_RX			(0x0001)
 
 /*
  * Command codes
  */
 /*--- Controller Commands --------------------------*/
-#define		HERMES_CMD_INIT			((uint16_t)0x00)
-#define		HERMES_CMD_ENABLE		((uint16_t)0x01)
-#define		HERMES_CMD_DISABLE		((uint16_t)0x02)
-#define		HERMES_CMD_DIAG			((uint16_t)0x03)
+#define		HERMES_CMD_INIT			(0x0000)
+#define		HERMES_CMD_ENABLE		(0x0001)
+#define		HERMES_CMD_DISABLE		(0x0002)
+#define		HERMES_CMD_DIAG			(0x0003)
 
 /*--- Buffer Mgmt Commands --------------------------*/
-#define		HERMES_CMD_ALLOC		((uint16_t)0x0A)
-#define		HERMES_CMD_TX			((uint16_t)0x0B)
-#define		HERMES_CMD_CLRPRST		((uint16_t)0x12)
+#define		HERMES_CMD_ALLOC		(0x000A)
+#define		HERMES_CMD_TX			(0x000B)
+#define		HERMES_CMD_CLRPRST		(0x0012)
 
 /*--- Regulate Commands --------------------------*/
-#define		HERMES_CMD_NOTIFY		((uint16_t)0x10)
-#define		HERMES_CMD_INQ			((uint16_t)0x11)
+#define		HERMES_CMD_NOTIFY		(0x0010)
+#define		HERMES_CMD_INQ			(0x0011)
 
 /*--- Configure Commands --------------------------*/
-#define		HERMES_CMD_ACCESS		((uint16_t)0x21)
-#define		HERMES_CMD_DOWNLD		((uint16_t)0x22)
+#define		HERMES_CMD_ACCESS		(0x0021)
+#define		HERMES_CMD_DOWNLD		(0x0022)
 
 /*--- Debugging Commands -----------------------------*/
-#define 	HERMES_CMD_MONITOR		((uint16_t)(0x38))
-#define		HERMES_MONITOR_ENABLE		((uint16_t)(0x0b))
-#define		HERMES_MONITOR_DISABLE		((uint16_t)(0x0f))
+#define 	HERMES_CMD_MONITOR		(0x0038)
+#define		HERMES_MONITOR_ENABLE		(0x000b)
+#define		HERMES_MONITOR_DISABLE		(0x000f)
 
 /*
  * Configuration RIDs
  */
 
-#define		HERMES_RID_CNF_PORTTYPE		((uint16_t)0xfc00)
-#define		HERMES_RID_CNF_MACADDR		((uint16_t)0xfc01)
-#define		HERMES_RID_CNF_DESIRED_SSID	((uint16_t)0xfc02)
-#define		HERMES_RID_CNF_CHANNEL		((uint16_t)0xfc03)
-#define		HERMES_RID_CNF_OWN_SSID		((uint16_t)0xfc04)
-#define		HERMES_RID_CNF_SYSTEM_SCALE	((uint16_t)0xfc06)
-#define		HERMES_RID_CNF_MAX_DATA_LEN	((uint16_t)0xfc07)
-#define		HERMES_RID_CNF_PM_ENABLE	((uint16_t)0xfc09)
-#define		HERMES_RID_CNF_PM_MCAST_RX	((uint16_t)0xfc0b)
-#define		HERMES_RID_CNF_PM_PERIOD	((uint16_t)0xfc0c)
-#define		HERMES_RID_CNF_PM_HOLDOVER	((uint16_t)0xfc0d)
-#define		HERMES_RID_CNF_NICKNAME		((uint16_t)0xfc0e)
-#define		HERMES_RID_CNF_WEP_ON		((uint16_t)0xfc20)
-#define		HERMES_RID_CNF_MWO_ROBUST	((uint16_t)0xfc25)
-#define		HERMES_RID_CNF_PRISM2_WEP_ON	((uint16_t)0xfc28)
-#define		HERMES_RID_CNF_MULTICAST_LIST	((uint16_t)0xfc80)
-#define		HERMES_RID_CNF_CREATEIBSS	((uint16_t)0xfc81)
-#define		HERMES_RID_CNF_FRAG_THRESH	((uint16_t)0xfc82)
-#define		HERMES_RID_CNF_RTS_THRESH	((uint16_t)0xfc83)
-#define		HERMES_RID_CNF_TX_RATE_CTRL	((uint16_t)0xfc84)
-#define		HERMES_RID_CNF_PROMISCUOUS	((uint16_t)0xfc85)
-#define		HERMES_RID_CNF_KEYS		((uint16_t)0xfcb0)
-#define		HERMES_RID_CNF_TX_KEY		((uint16_t)0xfcb1)
-#define		HERMES_RID_CNF_TICKTIME		((uint16_t)0xfce0)
-
-#define		HERMES_RID_CNF_PRISM2_TX_KEY	((uint16_t)0xfc23)
-#define		HERMES_RID_CNF_PRISM2_KEY0	((uint16_t)0xfc24)
-#define		HERMES_RID_CNF_PRISM2_KEY1	((uint16_t)0xfc25)
-#define		HERMES_RID_CNF_PRISM2_KEY2	((uint16_t)0xfc26)
-#define		HERMES_RID_CNF_PRISM2_KEY3	((uint16_t)0xfc27)
-#define		HERMES_RID_CNF_SYMBOL_AUTH_TYPE		((uint16_t)0xfc2A)
-/* This one is read only */
-#define		HERMES_RID_CNF_SYMBOL_KEY_LENGTH	((uint16_t)0xfc2B)
-#define		HERMES_RID_CNF_SYMBOL_BASIC_RATES	((uint16_t)0xfc8A)
+#define		HERMES_RID_CNF_PORTTYPE		(0xfc00)
+#define		HERMES_RID_CNF_MACADDR		(0xfc01)
+#define		HERMES_RID_CNF_DESIRED_SSID	(0xfc02)
+#define		HERMES_RID_CNF_CHANNEL		(0xfc03)
+#define		HERMES_RID_CNF_OWN_SSID		(0xfc04)
+#define		HERMES_RID_CNF_SYSTEM_SCALE	(0xfc06)
+#define		HERMES_RID_CNF_MAX_DATA_LEN	(0xfc07)
+#define		HERMES_RID_CNF_PM_ENABLE	(0xfc09)
+#define		HERMES_RID_CNF_PM_MCAST_RX	(0xfc0b)
+#define		HERMES_RID_CNF_PM_PERIOD	(0xfc0c)
+#define		HERMES_RID_CNF_PM_HOLDOVER	(0xfc0d)
+#define		HERMES_RID_CNF_NICKNAME		(0xfc0e)
+#define		HERMES_RID_CNF_WEP_ON		(0xfc20)
+#define		HERMES_RID_CNF_MWO_ROBUST	(0xfc25)
+#define		HERMES_RID_CNF_PRISM2_WEP_ON	(0xfc28)
+#define		HERMES_RID_CNF_MULTICAST_LIST	(0xfc80)
+#define		HERMES_RID_CNF_CREATEIBSS	(0xfc81)
+#define		HERMES_RID_CNF_FRAG_THRESH	(0xfc82)
+#define		HERMES_RID_CNF_RTS_THRESH	(0xfc83)
+#define		HERMES_RID_CNF_TX_RATE_CTRL	(0xfc84)
+#define		HERMES_RID_CNF_PROMISCUOUS	(0xfc85)
+#define		HERMES_RID_CNF_KEYS		(0xfcb0)
+#define		HERMES_RID_CNF_TX_KEY		(0xfcb1)
+#define		HERMES_RID_CNF_TICKTIME		(0xfce0)
+
+#define		HERMES_RID_CNF_PRISM2_TX_KEY	(0xfc23)
+#define		HERMES_RID_CNF_PRISM2_KEY0	(0xfc24)
+#define		HERMES_RID_CNF_PRISM2_KEY1	(0xfc25)
+#define		HERMES_RID_CNF_PRISM2_KEY2	(0xfc26)
+#define		HERMES_RID_CNF_PRISM2_KEY3	(0xfc27)
+#define		HERMES_RID_CNF_SYMBOL_MANDATORY_BSSID	(0xfc21)
+#define		HERMES_RID_CNF_SYMBOL_AUTH_TYPE		(0xfc2A)
+#define		HERMES_RID_CNF_SYMBOL_BASIC_RATES	(0xfc8A)
+#define		HERMES_RID_CNF_SYMBOL_PREAMBLE		(0xfc8C)
 
 /*
  * Information RIDs
  */
-#define		HERMES_RID_CHANNEL_LIST		((uint16_t)0xfd10)
-#define		HERMES_RID_STAIDENTITY		((uint16_t)0xfd20)
-#define		HERMES_RID_CURRENT_SSID		((uint16_t)0xfd41)
-#define		HERMES_RID_CURRENT_BSSID	((uint16_t)0xfd42)
-#define		HERMES_RID_COMMSQUALITY		((uint16_t)0xfd43)
-#define 	HERMES_RID_CURRENT_TX_RATE	((uint16_t)0xfd44)
-#define 	HERMES_RID_SHORT_RETRY_LIMIT	((uint16_t)0xfd48)
-#define 	HERMES_RID_LONG_RETRY_LIMIT	((uint16_t)0xfd49)
-#define 	HERMES_RID_MAX_TX_LIFETIME	((uint16_t)0xfd4A)
-#define		HERMES_RID_WEP_AVAIL		((uint16_t)0xfd4f)
-#define		HERMES_RID_CURRENT_CHANNEL	((uint16_t)0xfdc1)
-#define		HERMES_RID_DATARATES		((uint16_t)0xfdc6)
+#define		HERMES_RID_CHANNEL_LIST		(0xfd10)
+#define		HERMES_RID_STAIDENTITY		(0xfd20)
+#define		HERMES_RID_CURRENT_SSID		(0xfd41)
+#define		HERMES_RID_CURRENT_BSSID	(0xfd42)
+#define		HERMES_RID_COMMSQUALITY		(0xfd43)
+#define 	HERMES_RID_CURRENT_TX_RATE	(0xfd44)
+#define 	HERMES_RID_SHORT_RETRY_LIMIT	(0xfd48)
+#define 	HERMES_RID_LONG_RETRY_LIMIT	(0xfd49)
+#define 	HERMES_RID_MAX_TX_LIFETIME	(0xfd4A)
+#define		HERMES_RID_WEP_AVAIL		(0xfd4f)
+#define		HERMES_RID_CURRENT_CHANNEL	(0xfdc1)
+#define		HERMES_RID_DATARATES		(0xfdc6)
+#define		HERMES_RID_SYMBOL_PRIMARY_VER	(0xfd03)
+#define		HERMES_RID_SYMBOL_SECONDARY_VER	(0xfd21)
+#define		HERMES_RID_SYMBOL_KEY_LENGTH	(0xfc2B)
 
 /*
  * Frame structures and constants
@@ -216,19 +219,19 @@ typedef struct hermes_frame_desc {
 	uint16_t tx_ctl; /* 0xC */
 } __attribute__ ((packed)) hermes_frame_desc_t;
 
-#define		HERMES_RXSTAT_ERR		((uint16_t)0x0003)
-#define		HERMES_RXSTAT_MACPORT		((uint16_t)0x0700)
-#define		HERMES_RXSTAT_MSGTYPE		((uint16_t)0xE000)
+#define		HERMES_RXSTAT_ERR		(0x0003)
+#define		HERMES_RXSTAT_MACPORT		(0x0700)
+#define		HERMES_RXSTAT_MSGTYPE		(0xE000)
 
-#define		HERMES_RXSTAT_BADCRC		((uint16_t)0x0001)
-#define		HERMES_RXSTAT_UNDECRYPTABLE	((uint16_t)0x0002)
+#define		HERMES_RXSTAT_BADCRC		(0x0001)
+#define		HERMES_RXSTAT_UNDECRYPTABLE	(0x0002)
 
 /* RFC-1042 encoded frame */
-#define		HERMES_RXSTAT_1042		((uint16_t)0x2000)
+#define		HERMES_RXSTAT_1042		(0x2000)
 /* Bridge-tunnel encoded frame */
-#define		HERMES_RXSTAT_TUNNEL		((uint16_t)0x4000)
+#define		HERMES_RXSTAT_TUNNEL		(0x4000)
 /* Wavelan-II Management Protocol frame */
-#define		HERMES_RXSTAT_WMP		((uint16_t)0x6000)
+#define		HERMES_RXSTAT_WMP		(0x6000)
 
 #ifdef __KERNEL__
 
@@ -331,8 +334,6 @@ static inline int hermes_disable_port(he
 	(hermes_read_ltv((hw),(bap),(rid), sizeof(*buf), NULL, (buf)))
 #define HERMES_WRITE_RECORD(hw, bap, rid, buf) \
 	(hermes_write_ltv((hw),(bap),(rid),HERMES_BYTES_TO_RECLEN(sizeof(*buf)),(buf)))
-#define HERMES_WRITE_RECORD_LEN(hw, bap, rid, buf, len) \
-	(hermes_write_ltv((hw),(bap),(rid),HERMES_BYTES_TO_RECLEN(len),(buf)))
 
 static inline int hermes_read_wordrec(hermes_t *hw, int bap, uint16_t rid, uint16_t *word)
 {
diff -u -p linux/drivers/net/pcmcia/wireless.25b/hermes.c linux/drivers/net/pcmcia/hermes.c
--- linux/drivers/net/pcmcia/wireless.25b/hermes.c	Tue Apr 24 15:57:48 2001
+++ linux/drivers/net/pcmcia/hermes.c	Tue Apr 24 16:00:24 2001
@@ -21,6 +21,7 @@ static const char *version = "hermes.c: 
 
 #include <linux/module.h>
 #include <linux/types.h>
+#include <linux/threads.h>
 #include <linux/smp.h>
 #include <asm/io.h>
 #include <linux/ptrace.h>
diff -u -p linux/drivers/net/pcmcia/wireless.25b/orinoco_cs.c linux/drivers/net/pcmcia/orinoco_cs.c
--- linux/drivers/net/pcmcia/wireless.25b/orinoco_cs.c	Tue Apr 24 15:57:48 2001
+++ linux/drivers/net/pcmcia/orinoco_cs.c	Tue Apr 24 17:47:26 2001
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.03	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.04	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -97,6 +97,28 @@
  *	o Finish external renaming to orinoco...
  *	o Testing with various Wavelan firmwares
  *
+ * v0.03 -> v0.04 - 30/3/2001 - Jean II
+ *	o Update to Wireless 11 -> add retry limit/lifetime support
+ *	o Tested with a D-Link DWL 650 card, fill in firmware support
+ *	o Warning on Vcc mismatch (D-Link 3.3v card in Lucent 5v only slot)
+ *	o Fixed the Prims2 WEP bugs that I introduced in v0.03 :-(
+ *	  It work on D-Link *only* after a tcpdump. Weird...
+ *	  And still doesn't work on Intel card. Grrrr...
+ *	o Update the mode after a setport3
+ *	o Add preamble setting for Symbol cards (not yet enabled)
+ *	o Don't complain as much about Symbol cards...
+ *
+ * v0.04 -> v0.04b - 22/4/2001 - David Gibson
+ *      o Removed the 'eth' parameter - always use ethXX as the
+ *        interface name instead of dldwdXX.  The other was racy
+ *        anyway.
+ *	o Clean up RID definitions in hermes.h, other cleanups
+ *
+ * v0.04b -> v0.04c - 24/4/2001 - Jean II
+ *	o Tim Hurley <timster@seiki.bliztech.com> reported a D-Link card
+ *	  with vendor 02 and firmware 0.08. Added in the capabilities...
+ *	o Tested Lucent firmware 7.28, everything works...
+ *
  * TODO - Jean II
  *	o inline functions (lot's of candidate, need to reorder code)
  *	o Separate Pcmcia specific code to help Airport/Mini PCI driver
@@ -133,7 +155,7 @@
 
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
-static char *version = "orinoco_cs.c 0.03 (David Gibson <hermes@gibson.dropbear.id.au>)";
+static char *version = "orinoco_cs.c 0.04 (David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_PARM(pc_debug, "i");
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 #define DEBUGMORE(n, args...) do { if (pc_debug>(n)) printk(args); } while (0)
@@ -165,12 +187,12 @@ MODULE_PARM(pc_debug, "i");
 static uint irq_mask = 0xdeb8;
 /* Newer, simpler way of listing specific interrupts */
 static int irq_list[4] = { -1 };
-/* Control device name allocation. 0 -> dldwdX ; 1 -> ethX */
-static int eth = 1;
+/* Do a Pcmcia soft reset (may help some cards) */
+static int reset_cor = 0;
 
 MODULE_PARM(irq_mask, "i");
 MODULE_PARM(irq_list, "1-4i");
-MODULE_PARM(eth, "i");
+MODULE_PARM(reset_cor, "i");
 
 /*====================================================================*/
 
@@ -240,13 +262,14 @@ typedef struct dldwd_priv {
 	int has_mwo;
 	int has_pm;
 	int has_retry;
+	int has_preamble;
 	int broken_reset, broken_allocate;
 	uint16_t channel_mask;
 
 	/* Current configuration */
 	uint32_t iw_mode;
 	int port_type, allow_ibss;
-	uint16_t wep_on, wep_auth, tx_key;
+	uint16_t wep_on, wep_restrict, tx_key;
 	dldwd_keys_t keys;
  	char nick[IW_ESSID_MAX_SIZE+1];
 	char desired_essid[IW_ESSID_MAX_SIZE+1];
@@ -256,6 +279,7 @@ typedef struct dldwd_priv {
 	uint16_t tx_rate_ctrl;
 	uint16_t pm_on, pm_mcast, pm_period, pm_timeout;
 	uint16_t retry_short, retry_long, retry_time;
+	uint16_t preamble;
 
 	int promiscuous, allmulti, mc_count;
 
@@ -665,6 +689,16 @@ ESSID in IBSS-Ad-Hoc mode.\n", dev->name
 			goto out;
 	}
 
+	/* Set preamble - only for Symbol so far... */
+	if (priv->has_preamble) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_PREAMBLE,
+					   priv->preamble);
+		if (err) {
+			printk(KERN_WARNING "%s: Can't set preamble!\n", dev->name);
+			goto out;
+		}
+	}
+
 	/* Set promiscuity / multicast*/
 	priv->promiscuous = 0;
 	priv->allmulti = 0;
@@ -692,7 +726,8 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
-	
+	int	extra_wep_flag = 0;
+
 	switch (priv->firmware_type) {
 	case FIRMWARE_TYPE_LUCENT: /* Lucent style WEP */
 		if (priv->wep_on) {
@@ -716,33 +751,53 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 			int keylen;
 			int i;
 			
-			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_TX_KEY,
-						   priv->tx_key);
-			if (err)
-				return err;
-			
-			keybuf[LARGE_KEY_SIZE] = '\0';
-
 			/* Write all 4 keys */
 			for(i = 0; i < MAX_KEYS; i++) {
 				keylen = priv->keys[i].len;
-				keybuf[SMALL_KEY_SIZE] = '\0';
+				keybuf[keylen] = '\0';
 				memcpy(keybuf, priv->keys[i].data, keylen);
-				err = HERMES_WRITE_RECORD_LEN(hw, USER_BAP, HERMES_RID_CNF_PRISM2_KEY0, &keybuf, keylen);
+				err = hermes_write_ltv(hw, USER_BAP,
+						       HERMES_RID_CNF_PRISM2_KEY0 + i,
+						       HERMES_BYTES_TO_RECLEN(keylen + 1),
+						       &keybuf);
 				if (err)
 					return err;
 			}
-			/* Symbol cards : set the authentication :
-			 * 0 -> no encryption, 1 -> open,
-			 * 2 -> shared key, 3 -> shared key 128bit only */
+
+			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_TX_KEY,
+						   priv->tx_key);
+			if (err)
+				return err;
+
+			/* Authentication is where Prism2 and Symbol
+			 * firmware differ... */
 			if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL) {
-				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, priv->wep_auth);
+				/* Symbol cards : set the authentication :
+				 * 0 -> no encryption, 1 -> open,
+				 * 2 -> shared key, 3 -> shared key 128bit */
+				if(priv->wep_restrict) {
+					if(priv->keys[priv->tx_key].len >
+					   SMALL_KEY_SIZE)
+						extra_wep_flag = 3;
+					else
+						extra_wep_flag = 2;
+				} else
+					extra_wep_flag = 1;
+				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, priv->wep_restrict);
 				if (err)
 					return err;
+			} else {
+				/* Prism2 card : we need to modify master
+				 * WEP setting */
+				if(priv->wep_restrict)
+					extra_wep_flag = 2;
+				else
+					extra_wep_flag = 0;
 			}
 		}
 		
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, priv->wep_on);
+		/* Master WEP setting : on/off */
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, (priv->wep_on | extra_wep_flag));
 		if (err)
 			return err;	
 		break;
@@ -1266,6 +1321,7 @@ static int dldwd_init(struct net_device 
 	}
 
 	firmver = ((uint32_t)priv->firmware_info.major << 16) | priv->firmware_info.minor;
+	DEBUG(2, "%s: firmver = 0x%X\n", dev->name, firmver);
 
 	/* Determine capabilities from the firmware version */
 
@@ -1279,7 +1335,7 @@ static int dldwd_init(struct net_device 
 		priv->firmware_type = FIRMWARE_TYPE_LUCENT;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
-		priv->has_port3 = 1;
+		priv->has_port3 = 1;		/* Still works in 7.28 */
 		priv->has_ibss = (firmver >= 0x60006);
 		priv->has_ibss_any = (firmver >= 0x60010);
 		priv->has_wep = (firmver >= 0x40020);
@@ -1288,27 +1344,51 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = (firmver >= 0x60000);
 		priv->has_pm = (firmver >= 0x40020);
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 		/* Tested with Lucent firmware :
-		 *	1.16 ; 4.08 ; 4.52 ; 6.04 ; 6.16 => Jean II
+		 *	1.16 ; 4.08 ; 4.52 ; 6.04 ; 6.16 ; 7.28 => Jean II
 		 * Tested CableTron firmware : 4.32 => Anton */
 		break;
 	case 0x2:
 		vendor_str = "Generic Prism II";
-		/* Note : my Intel card report this value, but I can't do
-		 * much with it, so I guess it's broken - Jean II */
+		/* Some D-Link cards report vendor 0x02... */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
 		priv->broken_reset = 0;
-		priv->broken_allocate = (firmver <= 0x10001);
+		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: no idea if this is right */
-		priv->has_wep = (firmver >= 0x20000);
-		priv->has_big_wep = 1;
+		priv->has_ibss = (firmver >= 0x00007); /* FIXME */
+		priv->has_wep = (firmver >= 0x00007); /* FIXME */
+		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000);
+		priv->has_pm = (firmver >= 0x00007); /* FIXME */
 		priv->has_retry = 0;
-		/* Tested with Intel firmware : 1.01 => Jean II */
-		/* Note : firmware 1.01 is *seriously* broken */
+		priv->has_preamble = 0;
+
+		/* Tim Hurley -> D-Link card, vendor 02, firmware 0.08 */
+
+		/* Special case for Symbol cards */
+		if(firmver == 0x10001) {
+			/* Symbol , 3Com AirConnect, Intel, Ericsson WLAN */
+			vendor_str = "Symbol";
+			/* Intel MAC : 00:02:B3:* */
+			/* 3Com MAC : 00:50:DA:* */
+
+			/* FIXME : probably need to use SYMBOL_***ARY_VER
+			 * to get proper firmware version */
+			priv->firmware_type = FIRMWARE_TYPE_SYMBOL;
+			priv->broken_reset = 0;
+			priv->broken_allocate = 1;
+			priv->has_port3 = 1;
+			priv->has_ibss = 1; /* FIXME */
+			priv->has_wep = 1; /* FIXME */
+			priv->has_big_wep = 1;	/* RID_SYMBOL_KEY_LENGTH */
+			priv->has_mwo = 0;
+			priv->has_pm = 1; /* FIXME */
+			priv->has_retry = 0;
+			priv->has_preamble = 0; /* FIXME */
+			/* Tested with Intel firmware : v15 => Jean II */
+		}
 		break;
 	case 0x3:
 		vendor_str = "Samsung";
@@ -1324,39 +1404,27 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000); /* FIXME */
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 		break;
 	case 0x6:
+		/* D-Link DWL 650, ... */
 		vendor_str = "LinkSys/D-Link";
-		/* To check */
+		/* D-Link MAC : 00:40:05:* */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: available in later firmwares */
-		priv->has_wep = (firmver >= 0x20000); /* FIXME */
+		priv->has_ibss = (firmver >= 0x00007); /* FIXME */
+		priv->has_wep = (firmver >= 0x00007); /* FIXME */
 		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000); /* FIXME */
+		priv->has_pm = (firmver >= 0x00007); /* FIXME */
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
+		/* Tested with D-Link firmware 0.07 => Jean II */
+		/* Note : with 0.07, IBSS to a Lucent card seem flaky */
 		break;
-#if 0
-	case 0x???:		/* Could someone help here ??? */
-		vendor_str = "Symbol";
-		/* Symbol , 3Com AirConnect, Ericsson WLAN */
-
-		priv->firmware_type = FIRMWARE_TYPE_SYMBOL;
-		priv->broken_reset = 0;
-		priv->broken_allocate = 0;
-		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: available in later firmwares */
-		priv->has_wep = (firmver >= 0x20000); /* FIXME */
-		priv->has_big_wep = 1;	/* Probably RID_SYMBOL_KEY_LENGTH */
-		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000);
-		priv->has_retry = 0;
-		break;
-#endif
 	default:
 		vendor_str = "UNKNOWN";
 
@@ -1370,14 +1438,13 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = 0;
 		priv->has_pm = 0;
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 	}
 
 	printk(KERN_INFO "%s: Firmware ID %02X vendor 0x%x (%s) version %d.%02d\n",
 	       dev->name, priv->firmware_info.id, priv->firmware_info.vendor,
 	       vendor_str, priv->firmware_info.major, priv->firmware_info.minor);
 	
-	if ((priv->broken_reset) || (priv->broken_allocate))
-		printk(KERN_INFO "%s: Buggy firmware, please upgrade ASAP.\n", dev->name);
 	if (priv->has_port3)
 		printk(KERN_INFO "%s: Ad-hoc demo mode supported.\n", dev->name);
 	if (priv->has_ibss)
@@ -1388,7 +1455,7 @@ static int dldwd_init(struct net_device 
 		if (priv->has_big_wep)
 			printk("\"128\"-bit key.\n");
 		else
-			printk("40-bit key.");
+			printk("40-bit key.\n");
 	}
 
 	/* Get the MAC address */
@@ -1478,7 +1545,7 @@ static int dldwd_init(struct net_device 
 			goto out;
 		}
 	}
-		
+
 	/* Retry setup */
 	if (priv->has_retry) {
 		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORT_RETRY_LIMIT, &priv->retry_short);
@@ -1494,6 +1561,13 @@ static int dldwd_init(struct net_device 
 			goto out;
 	}
 		
+	/* Preamble setup */
+	if (priv->has_preamble) {
+		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_PREAMBLE, &priv->preamble);
+		if (err)
+			goto out;
+	}
+		
 	/* Set up the default configuration */
 	priv->iw_mode = IW_MODE_INFRA;
 	/* By default use IEEE/IBSS ad-hoc mode if we have it */
@@ -1951,7 +2025,7 @@ static int dldwd_ioctl_setiwencode(struc
 	int index = (erq->flags & IW_ENCODE_INDEX) - 1;
 	int setindex = priv->tx_key;
 	int enable = priv->wep_on;
-	int auth = priv->wep_auth;
+	int restricted = priv->wep_restrict;
 	uint16_t xlen = 0;
 	int err = 0;
 	char keybuf[MAX_KEY_SIZE];
@@ -2013,16 +2087,11 @@ static int dldwd_ioctl_setiwencode(struc
 	
 	if (erq->flags & IW_ENCODE_DISABLED)
 		enable = 0;
-	/* Only for symbol cards (so far) - Jean II */
+	/* Only for Prism2 & Symbol cards (so far) - Jean II */
 	if (erq->flags & IW_ENCODE_OPEN)
-		auth = 1;
+		restricted = 0;
 	if (erq->flags & IW_ENCODE_RESTRICTED)
-		auth = 2;	/* If all key are 128 -> should be 3 ??? */
-	/* Agree with master wep setting */
-	if (enable == 0)
-		auth = 0;
-	else if(auth == 0)
-		auth = 1;	/* Encryption require some authentication */
+		restricted = 1;
 
 	if (erq->pointer) {
 		priv->keys[index].len = cpu_to_le16(xlen);
@@ -2031,7 +2100,7 @@ static int dldwd_ioctl_setiwencode(struc
 	}
 	priv->tx_key = setindex;
 	priv->wep_on = enable;
-	priv->wep_auth = auth;
+	priv->wep_restrict = restricted;
 	
  out:
 	dldwd_unlock(priv);
@@ -2058,19 +2127,11 @@ static int dldwd_ioctl_getiwencode(struc
 	erq->flags |= index + 1;
 	
 	/* Only for symbol cards - Jean II */
-	if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL) {
-		switch(priv->wep_auth)	{
-		case 1:
-			erq->flags |= IW_ENCODE_OPEN;
-			break;
-		case 2:
-		case 3:
+	if (priv->firmware_type != FIRMWARE_TYPE_LUCENT) {
+		if(priv->wep_restrict)
 			erq->flags |= IW_ENCODE_RESTRICTED;
-			break;
-		case 0:
-		default:
-			break;
-		}
+		else
+			erq->flags |= IW_ENCODE_OPEN;
 	}
 
 	xlen = le16_to_cpu(priv->keys[index].len);
@@ -2691,6 +2752,10 @@ static int dldwd_ioctl_setport3(struct n
 		err = -EINVAL;
 	}
 
+	if (! err)
+		/* Actually update the mode we are using */
+		set_port_type(priv);
+
 	dldwd_unlock(priv);
 
 	return err;
@@ -3036,7 +3101,13 @@ static int dldwd_ioctl(struct net_device
 				  0, "set_port3" },
 				{ SIOCDEVPRIVATE + 0x3, 0,
 				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-				  "get_port3" }
+				  "get_port3" },
+				{ SIOCDEVPRIVATE + 0x4,
+				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+				  0, "set_preamble" },
+				{ SIOCDEVPRIVATE + 0x5, 0,
+				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+				  "get_preamble" }
 			};
 
 			err = verify_area(VERIFY_WRITE, wrq->u.data.pointer, sizeof(privtab));
@@ -3080,6 +3151,46 @@ static int dldwd_ioctl(struct net_device
 		err = dldwd_ioctl_getport3(dev, wrq);
 		break;
 
+	case SIOCDEVPRIVATE + 0x4: /* set_preamble */
+		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x4 (set_preamble)\n",
+		      dev->name);
+		if (! capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			break;
+		}
+
+		/* 802.11b has recently defined some short preamble.
+		 * Basically, the Phy header has been reduced in size.
+		 * This increase performance, especially at high rates
+		 * (the preamble is transmitted at 1Mb/s), unfortunately
+		 * this give compatibility troubles... - Jean II */
+		if(priv->has_preamble) {
+			int val = *( (int *) wrq->u.name );
+
+			dldwd_lock(priv);
+			if(val)
+				priv->preamble = 1;
+			else
+				priv->preamble = 0;
+			dldwd_unlock(priv);
+			changed = 1;
+		} else
+			err = -EOPNOTSUPP;
+		break;
+
+	case SIOCDEVPRIVATE + 0x5: /* get_preamble */
+		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x5 (get_preamble)\n",
+		      dev->name);
+		if(priv->has_preamble) {
+			int *val = (int *)wrq->u.name;
+
+			dldwd_lock(priv);
+			*val = priv->preamble;
+			dldwd_unlock(priv);
+		} else
+			err = -EOPNOTSUPP;
+		break;
+
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -3756,6 +3867,44 @@ static void dldwd_detach(dev_link_t * li
 	TRACE_EXIT("dldwd");
 }				/* dldwd_detach */
 
+/*
+ * Do a soft reset of the Pcmcia card using the Configuration Option Register
+ * Can't do any harm, and actually may do some good on some cards...
+ */
+static int dldwd_cor_reset(dev_link_t *link)
+{
+	conf_reg_t reg;
+	u_long default_cor; 
+
+	/* Save original COR value */
+	reg.Function = 0;
+	reg.Action = CS_READ;
+	reg.Offset = CISREG_COR;
+	reg.Value = 0;
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+	default_cor = reg.Value;
+
+	DEBUG(2, "dldwd : dldwd_cor_reset() : cor=0x%lX\n", default_cor);
+
+	/* Soft-Reset card */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_COR;
+	reg.Value = (default_cor | COR_SOFT_RESET);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has acknowledged our reset */
+	mdelay(1);
+
+	/* Restore original COR configuration index */
+	reg.Value = (default_cor & COR_CONFIG_MASK);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has finished restarting */
+	mdelay(1);
+
+	return(0);
+}
+
 /*======================================================================
   dldwd_config() is scheduled to run after a CARD_INSERTION event
   is received, to configure the PCMCIA socket, and to make the
@@ -3779,6 +3928,7 @@ static void dldwd_config(dev_link_t * li
 	int last_fn, last_ret;
 	u_char buf[64];
 	config_info_t conf;
+	cistpl_cftable_entry_t dflt = { 0 };
 	cisinfo_t info;
 
 	TRACE_ENTER("dldwd");
@@ -3825,7 +3975,6 @@ static void dldwd_config(dev_link_t * li
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	CS_CHECK(GetFirstTuple, handle, &tuple);
 	while (1) {
-		cistpl_cftable_entry_t dflt = { 0 };
 		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
 		CFG_CHECK(GetTupleData, handle, &tuple);
 		CFG_CHECK(ParseTuple, handle, &tuple, &parse);
@@ -3849,12 +3998,16 @@ static void dldwd_config(dev_link_t * li
 		/*  Note that the CIS values need to be rescaled */
 		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc !=
-			    cfg->vcc.param[CISTPL_POWER_VNOM] /
-			    10000) goto next_entry;
+			    cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "dldwd_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
+				goto next_entry;
+			}
 		} else if (dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc !=
-			    dflt.vcc.param[CISTPL_POWER_VNOM] /
-			    10000) goto next_entry;
+			    dflt.vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "dldwd_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, dflt.vcc.param[CISTPL_POWER_VNOM] / 10000);
+				goto next_entry;
+			}
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
@@ -3945,12 +4098,12 @@ static void dldwd_config(dev_link_t * li
 	ndev->base_addr = link->io.BasePort1;
 	ndev->irq = link->irq.AssignedIRQ;
 
-	/* Instance name : by default, use hermesX, on demand use the
-	 * regular ethX (less risky) - Jean II */
-	if(!eth)
-		sprintf(ndev->name, "hermes%d", priv->instance);
-	else
-		ndev->name[0] = '\0';
+	/* Do a Pcmcia soft reset of the card (optional) */
+	if(reset_cor)
+		dldwd_cor_reset(link);
+
+	/* register_netdev will give us an ethX name */
+	ndev->name[0] = '\0';
 	/* Tell the stack we exist */
 	if (register_netdev(ndev) != 0) {
 		printk(KERN_ERR "orinoco_cs: register_netdev() failed\n");

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="orinoco_v4b-alan.diff"

diff -u -p linux/drivers/net/pcmcia/wireless.25b/hermes.h linux/drivers/net/pcmcia/hermes.h
--- linux/drivers/net/pcmcia/wireless.25b/hermes.h	Tue Apr 24 15:57:48 2001
+++ linux/drivers/net/pcmcia/hermes.h	Tue Apr 24 16:04:34 2001
@@ -35,18 +35,18 @@
 /*
  * Limits and constants
  */
-#define		HERMES_ALLOC_LEN_MIN		((uint16_t)4)
-#define		HERMES_ALLOC_LEN_MAX		((uint16_t)2400)
+#define		HERMES_ALLOC_LEN_MIN		(4)
+#define		HERMES_ALLOC_LEN_MAX		(2400)
 #define		HERMES_LTV_LEN_MAX		(34)
-#define		HERMES_BAP_DATALEN_MAX		((uint16_t)4096)
-#define		HERMES_BAP_OFFSET_MAX		((uint16_t)4096)
-#define		HERMES_PORTID_MAX		((uint16_t)7)
-#define		HERMES_NUMPORTS_MAX		((uint16_t)(HERMES_PORTID_MAX+1))
-#define		HERMES_PDR_LEN_MAX		((uint16_t)260)	/* in bytes, from EK */
-#define		HERMES_PDA_RECS_MAX		((uint16_t)200)	/* a guess */
-#define		HERMES_PDA_LEN_MAX		((uint16_t)1024)	/* in bytes, from EK */
-#define		HERMES_SCANRESULT_MAX		((uint16_t)35)
-#define		HERMES_CHINFORESULT_MAX		((uint16_t)8)
+#define		HERMES_BAP_DATALEN_MAX		(4096)
+#define		HERMES_BAP_OFFSET_MAX		(4096)
+#define		HERMES_PORTID_MAX		(7)
+#define		HERMES_NUMPORTS_MAX		(HERMES_PORTID_MAX+1)
+#define		HERMES_PDR_LEN_MAX		(260)	/* in bytes, from EK */
+#define		HERMES_PDA_RECS_MAX		(200)	/* a guess */
+#define		HERMES_PDA_LEN_MAX		(1024)	/* in bytes, from EK */
+#define		HERMES_SCANRESULT_MAX		(35)
+#define		HERMES_CHINFORESULT_MAX		(8)
 #define		HERMES_FRAME_LEN_MAX		(2304)
 #define		HERMES_MAX_MULTICAST		(16)
 #define		HERMES_MAGIC			(0x7d1f)
@@ -86,122 +86,125 @@
 /*
  * CMD register bitmasks
  */
-#define		HERMES_CMD_BUSY			((uint16_t)0x8000)
-#define		HERMES_CMD_AINFO		((uint16_t)0x7f00)
-#define		HERMES_CMD_MACPORT		((uint16_t)0x0700)
-#define		HERMES_CMD_RECL			((uint16_t)0x0100)
-#define		HERMES_CMD_WRITE		((uint16_t)0x0100)
-#define		HERMES_CMD_PROGMODE		((uint16_t)0x0300)
-#define		HERMES_CMD_CMDCODE		((uint16_t)0x003f)
+#define		HERMES_CMD_BUSY			(0x8000)
+#define		HERMES_CMD_AINFO		(0x7f00)
+#define		HERMES_CMD_MACPORT		(0x0700)
+#define		HERMES_CMD_RECL			(0x0100)
+#define		HERMES_CMD_WRITE		(0x0100)
+#define		HERMES_CMD_PROGMODE		(0x0300)
+#define		HERMES_CMD_CMDCODE		(0x003f)
 
 /*
  * STATUS register bitmasks
  */
-#define		HERMES_STATUS_RESULT		((uint16_t)0x7f00)
-#define		HERMES_STATUS_CMDCODE		((uint16_t)0x003f)
+#define		HERMES_STATUS_RESULT		(0x7f00)
+#define		HERMES_STATUS_CMDCODE		(0x003f)
 
 /*
  * OFFSET refister bitmasks
  */
-#define		HERMES_OFFSET_BUSY		((uint16_t)0x8000)
-#define		HERMES_OFFSET_ERR		((uint16_t)0x4000)
-#define		HERMES_OFFSET_DATAOFF		((uint16_t)0x0ffe)
+#define		HERMES_OFFSET_BUSY		(0x8000)
+#define		HERMES_OFFSET_ERR		(0x4000)
+#define		HERMES_OFFSET_DATAOFF		(0x0ffe)
 
 /*
  * Event register bitmasks (INTEN, EVSTAT, EVACK)
  */
-#define		HERMES_EV_TICK			((uint16_t)0x8000)
-#define		HERMES_EV_WTERR			((uint16_t)0x4000)
-#define		HERMES_EV_INFDROP		((uint16_t)0x2000)
-#define		HERMES_EV_INFO			((uint16_t)0x0080)
-#define		HERMES_EV_DTIM			((uint16_t)0x0020)
-#define		HERMES_EV_CMD			((uint16_t)0x0010)
-#define		HERMES_EV_ALLOC			((uint16_t)0x0008)
-#define		HERMES_EV_TXEXC			((uint16_t)0x0004)
-#define		HERMES_EV_TX			((uint16_t)0x0002)
-#define		HERMES_EV_RX			((uint16_t)0x0001)
+#define		HERMES_EV_TICK			(0x8000)
+#define		HERMES_EV_WTERR			(0x4000)
+#define		HERMES_EV_INFDROP		(0x2000)
+#define		HERMES_EV_INFO			(0x0080)
+#define		HERMES_EV_DTIM			(0x0020)
+#define		HERMES_EV_CMD			(0x0010)
+#define		HERMES_EV_ALLOC			(0x0008)
+#define		HERMES_EV_TXEXC			(0x0004)
+#define		HERMES_EV_TX			(0x0002)
+#define		HERMES_EV_RX			(0x0001)
 
 /*
  * Command codes
  */
 /*--- Controller Commands --------------------------*/
-#define		HERMES_CMD_INIT			((uint16_t)0x00)
-#define		HERMES_CMD_ENABLE		((uint16_t)0x01)
-#define		HERMES_CMD_DISABLE		((uint16_t)0x02)
-#define		HERMES_CMD_DIAG			((uint16_t)0x03)
+#define		HERMES_CMD_INIT			(0x0000)
+#define		HERMES_CMD_ENABLE		(0x0001)
+#define		HERMES_CMD_DISABLE		(0x0002)
+#define		HERMES_CMD_DIAG			(0x0003)
 
 /*--- Buffer Mgmt Commands --------------------------*/
-#define		HERMES_CMD_ALLOC		((uint16_t)0x0A)
-#define		HERMES_CMD_TX			((uint16_t)0x0B)
-#define		HERMES_CMD_CLRPRST		((uint16_t)0x12)
+#define		HERMES_CMD_ALLOC		(0x000A)
+#define		HERMES_CMD_TX			(0x000B)
+#define		HERMES_CMD_CLRPRST		(0x0012)
 
 /*--- Regulate Commands --------------------------*/
-#define		HERMES_CMD_NOTIFY		((uint16_t)0x10)
-#define		HERMES_CMD_INQ			((uint16_t)0x11)
+#define		HERMES_CMD_NOTIFY		(0x0010)
+#define		HERMES_CMD_INQ			(0x0011)
 
 /*--- Configure Commands --------------------------*/
-#define		HERMES_CMD_ACCESS		((uint16_t)0x21)
-#define		HERMES_CMD_DOWNLD		((uint16_t)0x22)
+#define		HERMES_CMD_ACCESS		(0x0021)
+#define		HERMES_CMD_DOWNLD		(0x0022)
 
 /*--- Debugging Commands -----------------------------*/
-#define 	HERMES_CMD_MONITOR		((uint16_t)(0x38))
-#define		HERMES_MONITOR_ENABLE		((uint16_t)(0x0b))
-#define		HERMES_MONITOR_DISABLE		((uint16_t)(0x0f))
+#define 	HERMES_CMD_MONITOR		(0x0038)
+#define		HERMES_MONITOR_ENABLE		(0x000b)
+#define		HERMES_MONITOR_DISABLE		(0x000f)
 
 /*
  * Configuration RIDs
  */
 
-#define		HERMES_RID_CNF_PORTTYPE		((uint16_t)0xfc00)
-#define		HERMES_RID_CNF_MACADDR		((uint16_t)0xfc01)
-#define		HERMES_RID_CNF_DESIRED_SSID	((uint16_t)0xfc02)
-#define		HERMES_RID_CNF_CHANNEL		((uint16_t)0xfc03)
-#define		HERMES_RID_CNF_OWN_SSID		((uint16_t)0xfc04)
-#define		HERMES_RID_CNF_SYSTEM_SCALE	((uint16_t)0xfc06)
-#define		HERMES_RID_CNF_MAX_DATA_LEN	((uint16_t)0xfc07)
-#define		HERMES_RID_CNF_PM_ENABLE	((uint16_t)0xfc09)
-#define		HERMES_RID_CNF_PM_MCAST_RX	((uint16_t)0xfc0b)
-#define		HERMES_RID_CNF_PM_PERIOD	((uint16_t)0xfc0c)
-#define		HERMES_RID_CNF_PM_HOLDOVER	((uint16_t)0xfc0d)
-#define		HERMES_RID_CNF_NICKNAME		((uint16_t)0xfc0e)
-#define		HERMES_RID_CNF_WEP_ON		((uint16_t)0xfc20)
-#define		HERMES_RID_CNF_MWO_ROBUST	((uint16_t)0xfc25)
-#define		HERMES_RID_CNF_PRISM2_WEP_ON	((uint16_t)0xfc28)
-#define		HERMES_RID_CNF_MULTICAST_LIST	((uint16_t)0xfc80)
-#define		HERMES_RID_CNF_CREATEIBSS	((uint16_t)0xfc81)
-#define		HERMES_RID_CNF_FRAG_THRESH	((uint16_t)0xfc82)
-#define		HERMES_RID_CNF_RTS_THRESH	((uint16_t)0xfc83)
-#define		HERMES_RID_CNF_TX_RATE_CTRL	((uint16_t)0xfc84)
-#define		HERMES_RID_CNF_PROMISCUOUS	((uint16_t)0xfc85)
-#define		HERMES_RID_CNF_KEYS		((uint16_t)0xfcb0)
-#define		HERMES_RID_CNF_TX_KEY		((uint16_t)0xfcb1)
-#define		HERMES_RID_CNF_TICKTIME		((uint16_t)0xfce0)
-
-#define		HERMES_RID_CNF_PRISM2_TX_KEY	((uint16_t)0xfc23)
-#define		HERMES_RID_CNF_PRISM2_KEY0	((uint16_t)0xfc24)
-#define		HERMES_RID_CNF_PRISM2_KEY1	((uint16_t)0xfc25)
-#define		HERMES_RID_CNF_PRISM2_KEY2	((uint16_t)0xfc26)
-#define		HERMES_RID_CNF_PRISM2_KEY3	((uint16_t)0xfc27)
-#define		HERMES_RID_CNF_SYMBOL_AUTH_TYPE		((uint16_t)0xfc2A)
-/* This one is read only */
-#define		HERMES_RID_CNF_SYMBOL_KEY_LENGTH	((uint16_t)0xfc2B)
-#define		HERMES_RID_CNF_SYMBOL_BASIC_RATES	((uint16_t)0xfc8A)
+#define		HERMES_RID_CNF_PORTTYPE		(0xfc00)
+#define		HERMES_RID_CNF_MACADDR		(0xfc01)
+#define		HERMES_RID_CNF_DESIRED_SSID	(0xfc02)
+#define		HERMES_RID_CNF_CHANNEL		(0xfc03)
+#define		HERMES_RID_CNF_OWN_SSID		(0xfc04)
+#define		HERMES_RID_CNF_SYSTEM_SCALE	(0xfc06)
+#define		HERMES_RID_CNF_MAX_DATA_LEN	(0xfc07)
+#define		HERMES_RID_CNF_PM_ENABLE	(0xfc09)
+#define		HERMES_RID_CNF_PM_MCAST_RX	(0xfc0b)
+#define		HERMES_RID_CNF_PM_PERIOD	(0xfc0c)
+#define		HERMES_RID_CNF_PM_HOLDOVER	(0xfc0d)
+#define		HERMES_RID_CNF_NICKNAME		(0xfc0e)
+#define		HERMES_RID_CNF_WEP_ON		(0xfc20)
+#define		HERMES_RID_CNF_MWO_ROBUST	(0xfc25)
+#define		HERMES_RID_CNF_PRISM2_WEP_ON	(0xfc28)
+#define		HERMES_RID_CNF_MULTICAST_LIST	(0xfc80)
+#define		HERMES_RID_CNF_CREATEIBSS	(0xfc81)
+#define		HERMES_RID_CNF_FRAG_THRESH	(0xfc82)
+#define		HERMES_RID_CNF_RTS_THRESH	(0xfc83)
+#define		HERMES_RID_CNF_TX_RATE_CTRL	(0xfc84)
+#define		HERMES_RID_CNF_PROMISCUOUS	(0xfc85)
+#define		HERMES_RID_CNF_KEYS		(0xfcb0)
+#define		HERMES_RID_CNF_TX_KEY		(0xfcb1)
+#define		HERMES_RID_CNF_TICKTIME		(0xfce0)
+
+#define		HERMES_RID_CNF_PRISM2_TX_KEY	(0xfc23)
+#define		HERMES_RID_CNF_PRISM2_KEY0	(0xfc24)
+#define		HERMES_RID_CNF_PRISM2_KEY1	(0xfc25)
+#define		HERMES_RID_CNF_PRISM2_KEY2	(0xfc26)
+#define		HERMES_RID_CNF_PRISM2_KEY3	(0xfc27)
+#define		HERMES_RID_CNF_SYMBOL_MANDATORY_BSSID	(0xfc21)
+#define		HERMES_RID_CNF_SYMBOL_AUTH_TYPE		(0xfc2A)
+#define		HERMES_RID_CNF_SYMBOL_BASIC_RATES	(0xfc8A)
+#define		HERMES_RID_CNF_SYMBOL_PREAMBLE		(0xfc8C)
 
 /*
  * Information RIDs
  */
-#define		HERMES_RID_CHANNEL_LIST		((uint16_t)0xfd10)
-#define		HERMES_RID_STAIDENTITY		((uint16_t)0xfd20)
-#define		HERMES_RID_CURRENT_SSID		((uint16_t)0xfd41)
-#define		HERMES_RID_CURRENT_BSSID	((uint16_t)0xfd42)
-#define		HERMES_RID_COMMSQUALITY		((uint16_t)0xfd43)
-#define 	HERMES_RID_CURRENT_TX_RATE	((uint16_t)0xfd44)
-#define 	HERMES_RID_SHORT_RETRY_LIMIT	((uint16_t)0xfd48)
-#define 	HERMES_RID_LONG_RETRY_LIMIT	((uint16_t)0xfd49)
-#define 	HERMES_RID_MAX_TX_LIFETIME	((uint16_t)0xfd4A)
-#define		HERMES_RID_WEP_AVAIL		((uint16_t)0xfd4f)
-#define		HERMES_RID_CURRENT_CHANNEL	((uint16_t)0xfdc1)
-#define		HERMES_RID_DATARATES		((uint16_t)0xfdc6)
+#define		HERMES_RID_CHANNEL_LIST		(0xfd10)
+#define		HERMES_RID_STAIDENTITY		(0xfd20)
+#define		HERMES_RID_CURRENT_SSID		(0xfd41)
+#define		HERMES_RID_CURRENT_BSSID	(0xfd42)
+#define		HERMES_RID_COMMSQUALITY		(0xfd43)
+#define 	HERMES_RID_CURRENT_TX_RATE	(0xfd44)
+#define 	HERMES_RID_SHORT_RETRY_LIMIT	(0xfd48)
+#define 	HERMES_RID_LONG_RETRY_LIMIT	(0xfd49)
+#define 	HERMES_RID_MAX_TX_LIFETIME	(0xfd4A)
+#define		HERMES_RID_WEP_AVAIL		(0xfd4f)
+#define		HERMES_RID_CURRENT_CHANNEL	(0xfdc1)
+#define		HERMES_RID_DATARATES		(0xfdc6)
+#define		HERMES_RID_SYMBOL_PRIMARY_VER	(0xfd03)
+#define		HERMES_RID_SYMBOL_SECONDARY_VER	(0xfd21)
+#define		HERMES_RID_SYMBOL_KEY_LENGTH	(0xfc2B)
 
 /*
  * Frame structures and constants
@@ -216,19 +219,19 @@ typedef struct hermes_frame_desc {
 	uint16_t tx_ctl; /* 0xC */
 } __attribute__ ((packed)) hermes_frame_desc_t;
 
-#define		HERMES_RXSTAT_ERR		((uint16_t)0x0003)
-#define		HERMES_RXSTAT_MACPORT		((uint16_t)0x0700)
-#define		HERMES_RXSTAT_MSGTYPE		((uint16_t)0xE000)
+#define		HERMES_RXSTAT_ERR		(0x0003)
+#define		HERMES_RXSTAT_MACPORT		(0x0700)
+#define		HERMES_RXSTAT_MSGTYPE		(0xE000)
 
-#define		HERMES_RXSTAT_BADCRC		((uint16_t)0x0001)
-#define		HERMES_RXSTAT_UNDECRYPTABLE	((uint16_t)0x0002)
+#define		HERMES_RXSTAT_BADCRC		(0x0001)
+#define		HERMES_RXSTAT_UNDECRYPTABLE	(0x0002)
 
 /* RFC-1042 encoded frame */
-#define		HERMES_RXSTAT_1042		((uint16_t)0x2000)
+#define		HERMES_RXSTAT_1042		(0x2000)
 /* Bridge-tunnel encoded frame */
-#define		HERMES_RXSTAT_TUNNEL		((uint16_t)0x4000)
+#define		HERMES_RXSTAT_TUNNEL		(0x4000)
 /* Wavelan-II Management Protocol frame */
-#define		HERMES_RXSTAT_WMP		((uint16_t)0x6000)
+#define		HERMES_RXSTAT_WMP		(0x6000)
 
 #ifdef __KERNEL__
 
@@ -331,8 +334,6 @@ static inline int hermes_disable_port(he
 	(hermes_read_ltv((hw),(bap),(rid), sizeof(*buf), NULL, (buf)))
 #define HERMES_WRITE_RECORD(hw, bap, rid, buf) \
 	(hermes_write_ltv((hw),(bap),(rid),HERMES_BYTES_TO_RECLEN(sizeof(*buf)),(buf)))
-#define HERMES_WRITE_RECORD_LEN(hw, bap, rid, buf, len) \
-	(hermes_write_ltv((hw),(bap),(rid),HERMES_BYTES_TO_RECLEN(len),(buf)))
 
 static inline int hermes_read_wordrec(hermes_t *hw, int bap, uint16_t rid, uint16_t *word)
 {
diff -u -p linux/drivers/net/pcmcia/wireless.25b/orinoco_cs.c linux/drivers/net/pcmcia/orinoco_cs.c
--- linux/drivers/net/pcmcia/wireless.25b/orinoco_cs.c	Tue Apr 24 15:57:48 2001
+++ linux/drivers/net/pcmcia/orinoco_cs.c	Tue Apr 24 17:47:26 2001
@@ -1,4 +1,4 @@
-/* orinoco_cs.c 0.03	- (formerly known as dldwd_cs.c)
+/* orinoco_cs.c 0.04	- (formerly known as dldwd_cs.c)
  *
  * A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
  * as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -97,6 +97,28 @@
  *	o Finish external renaming to orinoco...
  *	o Testing with various Wavelan firmwares
  *
+ * v0.03 -> v0.04 - 30/3/2001 - Jean II
+ *	o Update to Wireless 11 -> add retry limit/lifetime support
+ *	o Tested with a D-Link DWL 650 card, fill in firmware support
+ *	o Warning on Vcc mismatch (D-Link 3.3v card in Lucent 5v only slot)
+ *	o Fixed the Prims2 WEP bugs that I introduced in v0.03 :-(
+ *	  It work on D-Link *only* after a tcpdump. Weird...
+ *	  And still doesn't work on Intel card. Grrrr...
+ *	o Update the mode after a setport3
+ *	o Add preamble setting for Symbol cards (not yet enabled)
+ *	o Don't complain as much about Symbol cards...
+ *
+ * v0.04 -> v0.04b - 22/4/2001 - David Gibson
+ *      o Removed the 'eth' parameter - always use ethXX as the
+ *        interface name instead of dldwdXX.  The other was racy
+ *        anyway.
+ *	o Clean up RID definitions in hermes.h, other cleanups
+ *
+ * v0.04b -> v0.04c - 24/4/2001 - Jean II
+ *	o Tim Hurley <timster@seiki.bliztech.com> reported a D-Link card
+ *	  with vendor 02 and firmware 0.08. Added in the capabilities...
+ *	o Tested Lucent firmware 7.28, everything works...
+ *
  * TODO - Jean II
  *	o inline functions (lot's of candidate, need to reorder code)
  *	o Separate Pcmcia specific code to help Airport/Mini PCI driver
@@ -133,7 +155,7 @@
 
 #ifdef PCMCIA_DEBUG
 static int pc_debug = PCMCIA_DEBUG;
-static char *version = "orinoco_cs.c 0.03 (David Gibson <hermes@gibson.dropbear.id.au>)";
+static char *version = "orinoco_cs.c 0.04 (David Gibson <hermes@gibson.dropbear.id.au>)";
 MODULE_PARM(pc_debug, "i");
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 #define DEBUGMORE(n, args...) do { if (pc_debug>(n)) printk(args); } while (0)
@@ -165,12 +187,12 @@ MODULE_PARM(pc_debug, "i");
 static uint irq_mask = 0xdeb8;
 /* Newer, simpler way of listing specific interrupts */
 static int irq_list[4] = { -1 };
-/* Control device name allocation. 0 -> dldwdX ; 1 -> ethX */
-static int eth = 1;
+/* Do a Pcmcia soft reset (may help some cards) */
+static int reset_cor = 0;
 
 MODULE_PARM(irq_mask, "i");
 MODULE_PARM(irq_list, "1-4i");
-MODULE_PARM(eth, "i");
+MODULE_PARM(reset_cor, "i");
 
 /*====================================================================*/
 
@@ -240,13 +262,14 @@ typedef struct dldwd_priv {
 	int has_mwo;
 	int has_pm;
 	int has_retry;
+	int has_preamble;
 	int broken_reset, broken_allocate;
 	uint16_t channel_mask;
 
 	/* Current configuration */
 	uint32_t iw_mode;
 	int port_type, allow_ibss;
-	uint16_t wep_on, wep_auth, tx_key;
+	uint16_t wep_on, wep_restrict, tx_key;
 	dldwd_keys_t keys;
  	char nick[IW_ESSID_MAX_SIZE+1];
 	char desired_essid[IW_ESSID_MAX_SIZE+1];
@@ -256,6 +279,7 @@ typedef struct dldwd_priv {
 	uint16_t tx_rate_ctrl;
 	uint16_t pm_on, pm_mcast, pm_period, pm_timeout;
 	uint16_t retry_short, retry_long, retry_time;
+	uint16_t preamble;
 
 	int promiscuous, allmulti, mc_count;
 
@@ -665,6 +689,16 @@ ESSID in IBSS-Ad-Hoc mode.\n", dev->name
 			goto out;
 	}
 
+	/* Set preamble - only for Symbol so far... */
+	if (priv->has_preamble) {
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_PREAMBLE,
+					   priv->preamble);
+		if (err) {
+			printk(KERN_WARNING "%s: Can't set preamble!\n", dev->name);
+			goto out;
+		}
+	}
+
 	/* Set promiscuity / multicast*/
 	priv->promiscuous = 0;
 	priv->allmulti = 0;
@@ -692,7 +726,8 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 {
 	hermes_t *hw = &priv->hw;
 	int err = 0;
-	
+	int	extra_wep_flag = 0;
+
 	switch (priv->firmware_type) {
 	case FIRMWARE_TYPE_LUCENT: /* Lucent style WEP */
 		if (priv->wep_on) {
@@ -716,33 +751,53 @@ static int __dldwd_hw_setup_wep(dldwd_pr
 			int keylen;
 			int i;
 			
-			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_TX_KEY,
-						   priv->tx_key);
-			if (err)
-				return err;
-			
-			keybuf[LARGE_KEY_SIZE] = '\0';
-
 			/* Write all 4 keys */
 			for(i = 0; i < MAX_KEYS; i++) {
 				keylen = priv->keys[i].len;
-				keybuf[SMALL_KEY_SIZE] = '\0';
+				keybuf[keylen] = '\0';
 				memcpy(keybuf, priv->keys[i].data, keylen);
-				err = HERMES_WRITE_RECORD_LEN(hw, USER_BAP, HERMES_RID_CNF_PRISM2_KEY0, &keybuf, keylen);
+				err = hermes_write_ltv(hw, USER_BAP,
+						       HERMES_RID_CNF_PRISM2_KEY0 + i,
+						       HERMES_BYTES_TO_RECLEN(keylen + 1),
+						       &keybuf);
 				if (err)
 					return err;
 			}
-			/* Symbol cards : set the authentication :
-			 * 0 -> no encryption, 1 -> open,
-			 * 2 -> shared key, 3 -> shared key 128bit only */
+
+			err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_TX_KEY,
+						   priv->tx_key);
+			if (err)
+				return err;
+
+			/* Authentication is where Prism2 and Symbol
+			 * firmware differ... */
 			if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL) {
-				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, priv->wep_auth);
+				/* Symbol cards : set the authentication :
+				 * 0 -> no encryption, 1 -> open,
+				 * 2 -> shared key, 3 -> shared key 128bit */
+				if(priv->wep_restrict) {
+					if(priv->keys[priv->tx_key].len >
+					   SMALL_KEY_SIZE)
+						extra_wep_flag = 3;
+					else
+						extra_wep_flag = 2;
+				} else
+					extra_wep_flag = 1;
+				err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_AUTH_TYPE, priv->wep_restrict);
 				if (err)
 					return err;
+			} else {
+				/* Prism2 card : we need to modify master
+				 * WEP setting */
+				if(priv->wep_restrict)
+					extra_wep_flag = 2;
+				else
+					extra_wep_flag = 0;
 			}
 		}
 		
-		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, priv->wep_on);
+		/* Master WEP setting : on/off */
+		err = hermes_write_wordrec(hw, USER_BAP, HERMES_RID_CNF_PRISM2_WEP_ON, (priv->wep_on | extra_wep_flag));
 		if (err)
 			return err;	
 		break;
@@ -1266,6 +1321,7 @@ static int dldwd_init(struct net_device 
 	}
 
 	firmver = ((uint32_t)priv->firmware_info.major << 16) | priv->firmware_info.minor;
+	DEBUG(2, "%s: firmver = 0x%X\n", dev->name, firmver);
 
 	/* Determine capabilities from the firmware version */
 
@@ -1279,7 +1335,7 @@ static int dldwd_init(struct net_device 
 		priv->firmware_type = FIRMWARE_TYPE_LUCENT;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
-		priv->has_port3 = 1;
+		priv->has_port3 = 1;		/* Still works in 7.28 */
 		priv->has_ibss = (firmver >= 0x60006);
 		priv->has_ibss_any = (firmver >= 0x60010);
 		priv->has_wep = (firmver >= 0x40020);
@@ -1288,27 +1344,51 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = (firmver >= 0x60000);
 		priv->has_pm = (firmver >= 0x40020);
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 		/* Tested with Lucent firmware :
-		 *	1.16 ; 4.08 ; 4.52 ; 6.04 ; 6.16 => Jean II
+		 *	1.16 ; 4.08 ; 4.52 ; 6.04 ; 6.16 ; 7.28 => Jean II
 		 * Tested CableTron firmware : 4.32 => Anton */
 		break;
 	case 0x2:
 		vendor_str = "Generic Prism II";
-		/* Note : my Intel card report this value, but I can't do
-		 * much with it, so I guess it's broken - Jean II */
+		/* Some D-Link cards report vendor 0x02... */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
 		priv->broken_reset = 0;
-		priv->broken_allocate = (firmver <= 0x10001);
+		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: no idea if this is right */
-		priv->has_wep = (firmver >= 0x20000);
-		priv->has_big_wep = 1;
+		priv->has_ibss = (firmver >= 0x00007); /* FIXME */
+		priv->has_wep = (firmver >= 0x00007); /* FIXME */
+		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000);
+		priv->has_pm = (firmver >= 0x00007); /* FIXME */
 		priv->has_retry = 0;
-		/* Tested with Intel firmware : 1.01 => Jean II */
-		/* Note : firmware 1.01 is *seriously* broken */
+		priv->has_preamble = 0;
+
+		/* Tim Hurley -> D-Link card, vendor 02, firmware 0.08 */
+
+		/* Special case for Symbol cards */
+		if(firmver == 0x10001) {
+			/* Symbol , 3Com AirConnect, Intel, Ericsson WLAN */
+			vendor_str = "Symbol";
+			/* Intel MAC : 00:02:B3:* */
+			/* 3Com MAC : 00:50:DA:* */
+
+			/* FIXME : probably need to use SYMBOL_***ARY_VER
+			 * to get proper firmware version */
+			priv->firmware_type = FIRMWARE_TYPE_SYMBOL;
+			priv->broken_reset = 0;
+			priv->broken_allocate = 1;
+			priv->has_port3 = 1;
+			priv->has_ibss = 1; /* FIXME */
+			priv->has_wep = 1; /* FIXME */
+			priv->has_big_wep = 1;	/* RID_SYMBOL_KEY_LENGTH */
+			priv->has_mwo = 0;
+			priv->has_pm = 1; /* FIXME */
+			priv->has_retry = 0;
+			priv->has_preamble = 0; /* FIXME */
+			/* Tested with Intel firmware : v15 => Jean II */
+		}
 		break;
 	case 0x3:
 		vendor_str = "Samsung";
@@ -1324,39 +1404,27 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = 0;
 		priv->has_pm = (firmver >= 0x20000); /* FIXME */
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 		break;
 	case 0x6:
+		/* D-Link DWL 650, ... */
 		vendor_str = "LinkSys/D-Link";
-		/* To check */
+		/* D-Link MAC : 00:40:05:* */
 
 		priv->firmware_type = FIRMWARE_TYPE_PRISM2;
 		priv->broken_reset = 0;
 		priv->broken_allocate = 0;
 		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: available in later firmwares */
-		priv->has_wep = (firmver >= 0x20000); /* FIXME */
+		priv->has_ibss = (firmver >= 0x00007); /* FIXME */
+		priv->has_wep = (firmver >= 0x00007); /* FIXME */
 		priv->has_big_wep = 0;
 		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000); /* FIXME */
+		priv->has_pm = (firmver >= 0x00007); /* FIXME */
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
+		/* Tested with D-Link firmware 0.07 => Jean II */
+		/* Note : with 0.07, IBSS to a Lucent card seem flaky */
 		break;
-#if 0
-	case 0x???:		/* Could someone help here ??? */
-		vendor_str = "Symbol";
-		/* Symbol , 3Com AirConnect, Ericsson WLAN */
-
-		priv->firmware_type = FIRMWARE_TYPE_SYMBOL;
-		priv->broken_reset = 0;
-		priv->broken_allocate = 0;
-		priv->has_port3 = 1;
-		priv->has_ibss = 0; /* FIXME: available in later firmwares */
-		priv->has_wep = (firmver >= 0x20000); /* FIXME */
-		priv->has_big_wep = 1;	/* Probably RID_SYMBOL_KEY_LENGTH */
-		priv->has_mwo = 0;
-		priv->has_pm = (firmver >= 0x20000);
-		priv->has_retry = 0;
-		break;
-#endif
 	default:
 		vendor_str = "UNKNOWN";
 
@@ -1370,14 +1438,13 @@ static int dldwd_init(struct net_device 
 		priv->has_mwo = 0;
 		priv->has_pm = 0;
 		priv->has_retry = 0;
+		priv->has_preamble = 0;
 	}
 
 	printk(KERN_INFO "%s: Firmware ID %02X vendor 0x%x (%s) version %d.%02d\n",
 	       dev->name, priv->firmware_info.id, priv->firmware_info.vendor,
 	       vendor_str, priv->firmware_info.major, priv->firmware_info.minor);
 	
-	if ((priv->broken_reset) || (priv->broken_allocate))
-		printk(KERN_INFO "%s: Buggy firmware, please upgrade ASAP.\n", dev->name);
 	if (priv->has_port3)
 		printk(KERN_INFO "%s: Ad-hoc demo mode supported.\n", dev->name);
 	if (priv->has_ibss)
@@ -1388,7 +1455,7 @@ static int dldwd_init(struct net_device 
 		if (priv->has_big_wep)
 			printk("\"128\"-bit key.\n");
 		else
-			printk("40-bit key.");
+			printk("40-bit key.\n");
 	}
 
 	/* Get the MAC address */
@@ -1478,7 +1545,7 @@ static int dldwd_init(struct net_device 
 			goto out;
 		}
 	}
-		
+
 	/* Retry setup */
 	if (priv->has_retry) {
 		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_SHORT_RETRY_LIMIT, &priv->retry_short);
@@ -1494,6 +1561,13 @@ static int dldwd_init(struct net_device 
 			goto out;
 	}
 		
+	/* Preamble setup */
+	if (priv->has_preamble) {
+		err = hermes_read_wordrec(hw, USER_BAP, HERMES_RID_CNF_SYMBOL_PREAMBLE, &priv->preamble);
+		if (err)
+			goto out;
+	}
+		
 	/* Set up the default configuration */
 	priv->iw_mode = IW_MODE_INFRA;
 	/* By default use IEEE/IBSS ad-hoc mode if we have it */
@@ -1951,7 +2025,7 @@ static int dldwd_ioctl_setiwencode(struc
 	int index = (erq->flags & IW_ENCODE_INDEX) - 1;
 	int setindex = priv->tx_key;
 	int enable = priv->wep_on;
-	int auth = priv->wep_auth;
+	int restricted = priv->wep_restrict;
 	uint16_t xlen = 0;
 	int err = 0;
 	char keybuf[MAX_KEY_SIZE];
@@ -2013,16 +2087,11 @@ static int dldwd_ioctl_setiwencode(struc
 	
 	if (erq->flags & IW_ENCODE_DISABLED)
 		enable = 0;
-	/* Only for symbol cards (so far) - Jean II */
+	/* Only for Prism2 & Symbol cards (so far) - Jean II */
 	if (erq->flags & IW_ENCODE_OPEN)
-		auth = 1;
+		restricted = 0;
 	if (erq->flags & IW_ENCODE_RESTRICTED)
-		auth = 2;	/* If all key are 128 -> should be 3 ??? */
-	/* Agree with master wep setting */
-	if (enable == 0)
-		auth = 0;
-	else if(auth == 0)
-		auth = 1;	/* Encryption require some authentication */
+		restricted = 1;
 
 	if (erq->pointer) {
 		priv->keys[index].len = cpu_to_le16(xlen);
@@ -2031,7 +2100,7 @@ static int dldwd_ioctl_setiwencode(struc
 	}
 	priv->tx_key = setindex;
 	priv->wep_on = enable;
-	priv->wep_auth = auth;
+	priv->wep_restrict = restricted;
 	
  out:
 	dldwd_unlock(priv);
@@ -2058,19 +2127,11 @@ static int dldwd_ioctl_getiwencode(struc
 	erq->flags |= index + 1;
 	
 	/* Only for symbol cards - Jean II */
-	if (priv->firmware_type == FIRMWARE_TYPE_SYMBOL) {
-		switch(priv->wep_auth)	{
-		case 1:
-			erq->flags |= IW_ENCODE_OPEN;
-			break;
-		case 2:
-		case 3:
+	if (priv->firmware_type != FIRMWARE_TYPE_LUCENT) {
+		if(priv->wep_restrict)
 			erq->flags |= IW_ENCODE_RESTRICTED;
-			break;
-		case 0:
-		default:
-			break;
-		}
+		else
+			erq->flags |= IW_ENCODE_OPEN;
 	}
 
 	xlen = le16_to_cpu(priv->keys[index].len);
@@ -2691,6 +2752,10 @@ static int dldwd_ioctl_setport3(struct n
 		err = -EINVAL;
 	}
 
+	if (! err)
+		/* Actually update the mode we are using */
+		set_port_type(priv);
+
 	dldwd_unlock(priv);
 
 	return err;
@@ -3036,7 +3101,13 @@ static int dldwd_ioctl(struct net_device
 				  0, "set_port3" },
 				{ SIOCDEVPRIVATE + 0x3, 0,
 				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
-				  "get_port3" }
+				  "get_port3" },
+				{ SIOCDEVPRIVATE + 0x4,
+				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+				  0, "set_preamble" },
+				{ SIOCDEVPRIVATE + 0x5, 0,
+				  IW_PRIV_TYPE_INT | IW_PRIV_SIZE_FIXED | 1,
+				  "get_preamble" }
 			};
 
 			err = verify_area(VERIFY_WRITE, wrq->u.data.pointer, sizeof(privtab));
@@ -3080,6 +3151,46 @@ static int dldwd_ioctl(struct net_device
 		err = dldwd_ioctl_getport3(dev, wrq);
 		break;
 
+	case SIOCDEVPRIVATE + 0x4: /* set_preamble */
+		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x4 (set_preamble)\n",
+		      dev->name);
+		if (! capable(CAP_NET_ADMIN)) {
+			err = -EPERM;
+			break;
+		}
+
+		/* 802.11b has recently defined some short preamble.
+		 * Basically, the Phy header has been reduced in size.
+		 * This increase performance, especially at high rates
+		 * (the preamble is transmitted at 1Mb/s), unfortunately
+		 * this give compatibility troubles... - Jean II */
+		if(priv->has_preamble) {
+			int val = *( (int *) wrq->u.name );
+
+			dldwd_lock(priv);
+			if(val)
+				priv->preamble = 1;
+			else
+				priv->preamble = 0;
+			dldwd_unlock(priv);
+			changed = 1;
+		} else
+			err = -EOPNOTSUPP;
+		break;
+
+	case SIOCDEVPRIVATE + 0x5: /* get_preamble */
+		DEBUG(1, "%s: SIOCDEVPRIVATE + 0x5 (get_preamble)\n",
+		      dev->name);
+		if(priv->has_preamble) {
+			int *val = (int *)wrq->u.name;
+
+			dldwd_lock(priv);
+			*val = priv->preamble;
+			dldwd_unlock(priv);
+		} else
+			err = -EOPNOTSUPP;
+		break;
+
 	default:
 		err = -EOPNOTSUPP;
 	}
@@ -3756,6 +3867,44 @@ static void dldwd_detach(dev_link_t * li
 	TRACE_EXIT("dldwd");
 }				/* dldwd_detach */
 
+/*
+ * Do a soft reset of the Pcmcia card using the Configuration Option Register
+ * Can't do any harm, and actually may do some good on some cards...
+ */
+static int dldwd_cor_reset(dev_link_t *link)
+{
+	conf_reg_t reg;
+	u_long default_cor; 
+
+	/* Save original COR value */
+	reg.Function = 0;
+	reg.Action = CS_READ;
+	reg.Offset = CISREG_COR;
+	reg.Value = 0;
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+	default_cor = reg.Value;
+
+	DEBUG(2, "dldwd : dldwd_cor_reset() : cor=0x%lX\n", default_cor);
+
+	/* Soft-Reset card */
+	reg.Action = CS_WRITE;
+	reg.Offset = CISREG_COR;
+	reg.Value = (default_cor | COR_SOFT_RESET);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has acknowledged our reset */
+	mdelay(1);
+
+	/* Restore original COR configuration index */
+	reg.Value = (default_cor & COR_CONFIG_MASK);
+	CardServices(AccessConfigurationRegister, link->handle, &reg);
+
+	/* Wait until the card has finished restarting */
+	mdelay(1);
+
+	return(0);
+}
+
 /*======================================================================
   dldwd_config() is scheduled to run after a CARD_INSERTION event
   is received, to configure the PCMCIA socket, and to make the
@@ -3779,6 +3928,7 @@ static void dldwd_config(dev_link_t * li
 	int last_fn, last_ret;
 	u_char buf[64];
 	config_info_t conf;
+	cistpl_cftable_entry_t dflt = { 0 };
 	cisinfo_t info;
 
 	TRACE_ENTER("dldwd");
@@ -3825,7 +3975,6 @@ static void dldwd_config(dev_link_t * li
 	tuple.DesiredTuple = CISTPL_CFTABLE_ENTRY;
 	CS_CHECK(GetFirstTuple, handle, &tuple);
 	while (1) {
-		cistpl_cftable_entry_t dflt = { 0 };
 		cistpl_cftable_entry_t *cfg = &(parse.cftable_entry);
 		CFG_CHECK(GetTupleData, handle, &tuple);
 		CFG_CHECK(ParseTuple, handle, &tuple, &parse);
@@ -3849,12 +3998,16 @@ static void dldwd_config(dev_link_t * li
 		/*  Note that the CIS values need to be rescaled */
 		if (cfg->vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc !=
-			    cfg->vcc.param[CISTPL_POWER_VNOM] /
-			    10000) goto next_entry;
+			    cfg->vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "dldwd_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, cfg->vcc.param[CISTPL_POWER_VNOM] / 10000);
+				goto next_entry;
+			}
 		} else if (dflt.vcc.present & (1 << CISTPL_POWER_VNOM)) {
 			if (conf.Vcc !=
-			    dflt.vcc.param[CISTPL_POWER_VNOM] /
-			    10000) goto next_entry;
+			    dflt.vcc.param[CISTPL_POWER_VNOM] / 10000) {
+				DEBUG(2, "dldwd_config: Vcc mismatch (conf.Vcc = %d, CIS = %d)\n",  conf.Vcc, dflt.vcc.param[CISTPL_POWER_VNOM] / 10000);
+				goto next_entry;
+			}
 		}
 
 		if (cfg->vpp1.present & (1 << CISTPL_POWER_VNOM))
@@ -3945,12 +4098,12 @@ static void dldwd_config(dev_link_t * li
 	ndev->base_addr = link->io.BasePort1;
 	ndev->irq = link->irq.AssignedIRQ;
 
-	/* Instance name : by default, use hermesX, on demand use the
-	 * regular ethX (less risky) - Jean II */
-	if(!eth)
-		sprintf(ndev->name, "hermes%d", priv->instance);
-	else
-		ndev->name[0] = '\0';
+	/* Do a Pcmcia soft reset of the card (optional) */
+	if(reset_cor)
+		dldwd_cor_reset(link);
+
+	/* register_netdev will give us an ethX name */
+	ndev->name[0] = '\0';
 	/* Tell the stack we exist */
 	if (register_netdev(ndev) != 0) {
 		printk(KERN_ERR "orinoco_cs: register_netdev() failed\n");

--3V7upXqbjpZ4EhLz--
