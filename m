Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbQLTBaU>; Tue, 19 Dec 2000 20:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130794AbQLTBaK>; Tue, 19 Dec 2000 20:30:10 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:31483 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S130391AbQLTBaA>;
	Tue, 19 Dec 2000 20:30:00 -0500
Date: Tue, 19 Dec 2000 16:59:23 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Wireless Extension update
Message-ID: <20001219165923.A20989@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hi Linus and Alan,

	This is a totally trivial update of the Wireless Extensions
definition. It just adds a few more #define, so no troubles or pain
expected.
	The patch attached applies cleanly to *both* 2.4.0-test12 and
2.2.18 (tested), and I would suggest including it in both kernel
series...

	Changes :
		o Power Management update (max, min & capa)
			-> Needed by the Symbol/Intel/3Com 802.11b driver
		o Support for read only "encoding" keys
		o Support for TxPower parameter
			-> Both needed by the Cisco/Aironet 802.11b driver

	By the way, don't look in the kernel for the driver mentionned
above, the majority of the Wireless LAN drivers are not in the kernel
(but in the Pcmcia package or elsewhere), and some in the kernel are
not up to date with the version in the Pcmcia package.

	Thanks...

	Jean

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="w-ext.10.diff"

diff -u -p linux/include/linux/wireless.9.h linux/include/linux/wireless.h
--- linux/include/linux/wireless.9.h	Tue Nov 14 10:55:46 2000
+++ linux/include/linux/wireless.h	Tue Dec 19 14:42:02 2000
@@ -63,7 +63,7 @@
  * (there is some stuff that will be added in the future...)
  * I just plan to increment with each new version.
  */
-#define WIRELESS_EXT	9
+#define WIRELESS_EXT	10
 
 /*
  * Changes :
@@ -104,26 +104,33 @@
  *	- Change encoding to support larger tokens (>64 bits)
  *	- Updated iw_params (disable, flags) and use it for NWID
  *	- Extracted iw_point from iwreq for clarity
+ *
+ * V9 to V10
+ * ---------
+ *	- Add PM capability to range structure
+ *	- Add PM modifier : MAX/MIN/RELATIVE
+ *	- Add encoding option : IW_ENCODE_NOKEY
+ *	- Add TxPower ioctls (work like TxRate)
  */
 
 /* -------------------------- IOCTL LIST -------------------------- */
 
 /* Basic operations */
-#define SIOCSIWNAME	0x8B00		/* Unused ??? */
-#define SIOCGIWNAME	0x8B01		/* get name */
+#define SIOCSIWNAME	0x8B00		/* Unused */
+#define SIOCGIWNAME	0x8B01		/* get name == wireless protocol */
 #define SIOCSIWNWID	0x8B02		/* set network id (the cell) */
 #define SIOCGIWNWID	0x8B03		/* get network id */
-#define SIOCSIWFREQ	0x8B04		/* set channel/frequency */
-#define SIOCGIWFREQ	0x8B05		/* get channel/frequency */
+#define SIOCSIWFREQ	0x8B04		/* set channel/frequency (Hz) */
+#define SIOCGIWFREQ	0x8B05		/* get channel/frequency (Hz) */
 #define SIOCSIWMODE	0x8B06		/* set operation mode */
 #define SIOCGIWMODE	0x8B07		/* get operation mode */
-#define SIOCSIWSENS	0x8B08		/* set sensitivity */
-#define SIOCGIWSENS	0x8B09		/* get sensitivity */
+#define SIOCSIWSENS	0x8B08		/* set sensitivity (dBm) */
+#define SIOCGIWSENS	0x8B09		/* get sensitivity (dBm) */
 
 /* Informative stuff */
-#define SIOCSIWRANGE	0x8B0A		/* Unused ??? */
+#define SIOCSIWRANGE	0x8B0A		/* Unused */
 #define SIOCGIWRANGE	0x8B0B		/* Get range of parameters */
-#define SIOCSIWPRIV	0x8B0C		/* Unused ??? */
+#define SIOCSIWPRIV	0x8B0C		/* Unused */
 #define SIOCGIWPRIV	0x8B0D		/* get private ioctl interface info */
 
 /* Mobile IP support */
@@ -153,6 +160,8 @@
 #define SIOCGIWRTS	0x8B23		/* get RTS/CTS threshold (bytes) */
 #define SIOCSIWFRAG	0x8B24		/* set fragmentation thr (bytes) */
 #define SIOCGIWFRAG	0x8B25		/* get fragmentation thr (bytes) */
+#define SIOCSIWTXPOW	0x8B26		/* set transmit power (dBm) */
+#define SIOCGIWTXPOW	0x8B27		/* get transmit power (dBm) */
 
 /* Encoding stuff (scrambling, hardware security, WEP...) */
 #define SIOCSIWENCODE	0x8B2A		/* set encoding token & mode */
@@ -205,6 +214,9 @@
 /* Maximum bit rates in the range struct */
 #define IW_MAX_BITRATES		8
 
+/* Maximum tx powers in the range struct */
+#define IW_MAX_TXPOWER		8
+
 /* Maximum of address that you may set with SPY */
 #define IW_MAX_SPY		8
 
@@ -232,11 +244,13 @@
 
 /* Flags for encoding (along with the token) */
 #define IW_ENCODE_INDEX		0x00FF	/* Token index (if needed) */
-#define IW_ENCODE_FLAGS		0xF000	/* Flags defined below */
+#define IW_ENCODE_FLAGS		0xFF00	/* Flags defined below */
+#define IW_ENCODE_MODE		0xF000	/* Modes defined below */
 #define IW_ENCODE_DISABLED	0x8000	/* Encoding disabled */
 #define IW_ENCODE_ENABLED	0x0000	/* Encoding enabled */
 #define IW_ENCODE_RESTRICTED	0x4000	/* Refuse non-encoded packets */
 #define IW_ENCODE_OPEN		0x2000	/* Accept non-encoded packets */
+#define IW_ENCODE_NOKEY         0x0800  /* Key is write only, so not present */
 
 /* Power management flags available (along with the value, if any) */
 #define IW_POWER_ON		0x0000	/* No details... */
@@ -249,6 +263,14 @@
 #define IW_POWER_ALL_R		0x0300	/* Receive all messages though PM */
 #define IW_POWER_FORCE_S	0x0400	/* Force PM procedure for sending unicast */
 #define IW_POWER_REPEATER	0x0800	/* Repeat broadcast messages in PM period */
+#define IW_POWER_MODIFIER	0x000F	/* Modify a parameter */
+#define IW_POWER_MIN		0x0001	/* Value is a minimum  */
+#define IW_POWER_MAX		0x0002	/* Value is a maximum */
+#define IW_POWER_RELATIVE	0x0004	/* Value is not in seconds/ms/us */
+
+/* Transmit Power flags available */
+#define IW_TXPOW_DBM		0x0000	/* Value is in dBm */
+#define IW_TXPOW_MWATT		0x0001	/* Value is in mW */
 
 /****************************** TYPES ******************************/
 
@@ -359,6 +381,7 @@ struct	iwreq 
 
 		struct iw_param	sens;		/* signal level threshold */
 		struct iw_param	bitrate;	/* default bit rate */
+		struct iw_param	txpower;	/* default transmit power */
 		struct iw_param	rts;		/* RTS threshold threshold */
 		struct iw_param	frag;		/* Fragmentation threshold */
 		__u32		mode;		/* Operation mode */
@@ -422,15 +445,23 @@ struct	iw_range
 	__s32		max_frag;	/* Maximal frag threshold */
 
 	/* Power Management duration & timeout */
-	__s32		min_pmd;	/* Minimal PM duration */
-	__s32		max_pmd;	/* Maximal PM duration */
+	__s32		min_pmp;	/* Minimal PM period */
+	__s32		max_pmp;	/* Maximal PM period */
 	__s32		min_pmt;	/* Minimal PM timeout */
 	__s32		max_pmt;	/* Maximal PM timeout */
+	__u16		pmp_flags;	/* How to decode max/min PM period */
+	__u16		pmt_flags;	/* How to decode max/min PM timeout */
+	__u16		pm_capa;	/* What PM options are supported */
 
 	/* Encoder stuff */
 	__u16	encoding_size[IW_MAX_ENCODING_SIZES];	/* Different token sizes */
 	__u8	num_encoding_sizes;	/* Number of entry in the list */
 	__u8	max_encoding_tokens;	/* Max number of tokens */
+
+	/* Transmit power */
+	__u16		txpower_capa;	/* What options are supported */
+	__u8		num_txpower;	/* Number of entries in the list */
+	__s32		txpower[IW_MAX_TXPOWER];	/* list, in bps */
 };
 
 /*

--ikeVEW9yuYc//A+q--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
