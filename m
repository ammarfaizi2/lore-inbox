Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVLXNZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVLXNZy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbVLXNZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 08:25:54 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:17885 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932454AbVLXNZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 08:25:54 -0500
Date: Sat, 24 Dec 2005 14:26:00 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, patrick.boettcher@desy.de
Subject: [PATCH] Kconfig option to enable faulty Artec DVB-T USB devices, cleanups, documentation
Message-ID: <20051224132559.GB5789@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.15-rc6-marc-gd5ea4e26
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch adds a Kconfig option in the DVB-T USB section that enables
a user to select wether some faulty Artec devices may be supported due to an
invalid EEPROM. Some googling stated that some people had problems getting the
device to be detected by the driver (though the device was stated to be
supported by the module on various sites). As not anyone is into changing source
code a Kconfig option would be appropriate for these users. Patrick Boettcher
also suggested a Kconfig would make sense. Moreover, one may share the option in
his/her .config accross several kernels instead of uncommenting the #define on
any -git checkout or new kernel release. It was simply annoying. :)

Moreover, there's some cleanup on indentation and such, added some explanation
to the faulty UDB IDs code, re-ordered the list of supported devices in Kconfig
to match out alphabet ;)

The #ifdef-fing of dibusb-mc functions was removed due to Adrian Bunks' hint.

Patrick Boettcher and the Linux DVB Maintainers are CC'ed...

The patch is against the current -git but should cause no problems on the recent
releases.

Regards,
	marc

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dvb-usb.patch"

diff -ruN drivers/media/dvb/dvb-usb.orig/a800.c drivers/media/dvb/dvb-usb/a800.c
--- drivers/media/dvb/dvb-usb.orig/a800.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/a800.c	2005-12-22 22:28:23.000000000 +0100
@@ -140,6 +140,7 @@
 			{ &a800_table[0], NULL },
 			{ &a800_table[1], NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/cxusb.c drivers/media/dvb/dvb-usb/cxusb.c
--- drivers/media/dvb/dvb-usb.orig/cxusb.c	2005-12-22 19:38:34.000000000 +0100
+++ drivers/media/dvb/dvb-usb/cxusb.c	2005-12-22 22:26:11.000000000 +0100
@@ -237,6 +237,7 @@
 			{ NULL },
 			{ &cxusb_table[0], NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/cxusb.h drivers/media/dvb/dvb-usb/cxusb.h
--- drivers/media/dvb/dvb-usb.orig/cxusb.h	2005-12-22 19:38:34.000000000 +0100
+++ drivers/media/dvb/dvb-usb/cxusb.h	2005-12-22 22:10:14.000000000 +0100
@@ -13,7 +13,7 @@
 
 #define CMD_GPIO_READ     0x0d
 #define CMD_GPIO_WRITE    0x0e
-#define     GPIO_TUNER         0x02
+#define     GPIO_TUNER    0x02
 
 #define CMD_POWER_OFF     0xdc
 #define CMD_POWER_ON      0xde
diff -ruN drivers/media/dvb/dvb-usb.orig/dibusb.h drivers/media/dvb/dvb-usb/dibusb.h
--- drivers/media/dvb/dvb-usb.orig/dibusb.h	2005-12-22 19:38:34.000000000 +0100
+++ drivers/media/dvb/dvb-usb/dibusb.h	2005-12-21 19:22:05.000000000 +0100
@@ -104,8 +104,10 @@
 
 extern struct i2c_algorithm dibusb_i2c_algo;
 
+#ifdef CONFIG_DVB_USB_DIBUSB_MC
 extern int dibusb_dib3000mc_frontend_attach(struct dvb_usb_device *);
 extern int dibusb_dib3000mc_tuner_attach (struct dvb_usb_device *);
+#endif
 
 extern int dibusb_streaming_ctrl(struct dvb_usb_device *, int);
 extern int dibusb_pid_filter(struct dvb_usb_device *, int, u16, int);
diff -ruN drivers/media/dvb/dvb-usb.orig/dibusb-mb.c drivers/media/dvb/dvb-usb/dibusb-mb.c
--- drivers/media/dvb/dvb-usb.orig/dibusb-mb.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/dibusb-mb.c	2005-12-22 22:29:10.000000000 +0100
@@ -65,11 +65,11 @@
 		d->tuner_pass_ctrl(d->fe,0,msg[0].addr);
 
 	if (b2[0] == 0xfe) {
-		info("this device has the Thomson Cable onboard. Which is default.");
+		info("This device has the Thomson Cable onboard. Which is default.");
 		dibusb_thomson_tuner_attach(d);
 	} else {
 		u8 bpll[4] = { 0x0b, 0xf5, 0x85, 0xab };
-		info("this device has the Panasonic ENV77H11D5 onboard.");
+		info("This device has the Panasonic ENV77H11D5 onboard.");
 		d->pll_addr = 0x60;
 		memcpy(d->pll_init,bpll,4);
 		d->pll_desc = &dvb_pll_tda665x;
@@ -98,15 +98,15 @@
 
 /* do not change the order of the ID table */
 static struct usb_device_id dibusb_dib3000mb_table [] = {
-/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_COLD)},
-/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_WARM)},
+/* 00 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_COLD) },
+/* 01 */	{ USB_DEVICE(USB_VID_WIDEVIEW,		USB_PID_AVERMEDIA_DVBT_USB_WARM) },
 /* 02 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_COLD) },
 /* 03 */	{ USB_DEVICE(USB_VID_COMPRO,		USB_PID_COMPRO_DVBU2000_WARM) },
 /* 04 */	{ USB_DEVICE(USB_VID_COMPRO_UNK,	USB_PID_COMPRO_DVBU2000_UNK_COLD) },
 /* 05 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_COLD) },
 /* 06 */	{ USB_DEVICE(USB_VID_DIBCOM,		USB_PID_DIBCOM_MOD3000_WARM) },
-/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_COLD) },
-/* 08 */	{ USB_DEVICE(USB_VID_EMPIA,			USB_PID_KWORLD_VSTREAM_WARM) },
+/* 07 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_COLD) },
+/* 08 */	{ USB_DEVICE(USB_VID_EMPIA,		USB_PID_KWORLD_VSTREAM_WARM) },
 /* 09 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_COLD) },
 /* 10 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_GRANDTEC_DVBT_USB_WARM) },
 /* 11 */	{ USB_DEVICE(USB_VID_GRANDTEC,		USB_PID_DIBCOM_MOD3000_COLD) },
@@ -117,27 +117,34 @@
 /* 16 */	{ USB_DEVICE(USB_VID_VISIONPLUS,	USB_PID_TWINHAN_VP7041_WARM) },
 /* 17 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_COLD) },
 /* 18 */	{ USB_DEVICE(USB_VID_TWINHAN,		USB_PID_TWINHAN_VP7041_WARM) },
-/* 19 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_COLD) },
-/* 20 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_WARM) },
-/* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
-/* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC, USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
+/* 19 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_COLD) },
+/* 20 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_WARM) },
+/* 21 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_AN2235_COLD) },
+/* 22 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_AN2235_WARM) },
 /* 23 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_COLD) },
 
 /* device ID with default DIBUSB2_0-firmware and with the hacked firmware */
 /* 24 */	{ USB_DEVICE(USB_VID_ADSTECH,		USB_PID_ADSTECH_USB2_WARM) },
-/* 25 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_COLD) },
-/* 26 */	{ USB_DEVICE(USB_VID_KYE,			USB_PID_KYE_DVB_T_WARM) },
+/* 25 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_COLD) },
+/* 26 */	{ USB_DEVICE(USB_VID_KYE,		USB_PID_KYE_DVB_T_WARM) },
 
 /* 27 */	{ USB_DEVICE(USB_VID_KWORLD,		USB_PID_KWORLD_VSTREAM_COLD) },
 
-/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,		USB_PID_ULTIMA_TVBOX_USB2_COLD) },
-/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,		USB_PID_ULTIMA_TVBOX_USB2_WARM) },
+/* 28 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_COLD) },
+/* 29 */	{ USB_DEVICE(USB_VID_ULTIMA_ELECTRONIC,	USB_PID_ULTIMA_TVBOX_USB2_WARM) },
 
-// #define DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+/*
+ * XXX: As Artec just 'forgot' to program the EEPROM on some Artec T1 devices
+ *      we don't catch these faulty IDs (namely 'Cypress FX1 USB controller') that
+ *      have been left on the device. If you don't have such a device but an Artec
+ *      device that's supposed to work with this driver but is not detected by it,
+ *      free to enable CONFIG_DVB_USB_DIBUSB_MB_FAULTY via your kernel config.
+ */
 
-#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+#ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
 /* 30 */	{ USB_DEVICE(USB_VID_ANCHOR,		USB_PID_ULTIMA_TVBOX_ANCHOR_COLD) },
 #endif
+
 			{ }		/* Terminating entry */
 };
 MODULE_DEVICE_TABLE (usb, dibusb_dib3000mb_table);
@@ -257,7 +264,7 @@
 		}
 	},
 
-#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+#ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
 	.num_device_descs = 2,
 #else
 	.num_device_descs = 1,
@@ -267,11 +274,12 @@
 			{ &dibusb_dib3000mb_table[20], NULL },
 			{ &dibusb_dib3000mb_table[21], NULL },
 		},
-#ifdef DVB_USB_DIBUSB_MB_FAULTY_USB_IDs
+#ifdef CONFIG_DVB_USB_DIBUSB_MB_FAULTY
 		{	"Artec T1 USB1.1 TVBOX with AN2235 (faulty USB IDs)",
 			{ &dibusb_dib3000mb_table[30], NULL },
 			{ NULL },
 		},
+		{ NULL },
 #endif
 	}
 };
@@ -323,6 +331,7 @@
 			{ &dibusb_dib3000mb_table[27], NULL },
 			{ NULL }
 		},
+		{ NULL },
 	}
 };
 
@@ -369,6 +378,7 @@
 			{ &dibusb_dib3000mb_table[28], NULL },
 			{ &dibusb_dib3000mb_table[29], NULL },
 		},
+		{ NULL },
 	}
 };
 
Dateien drivers/media/dvb/dvb-usb.orig/dibusb-mb.o und drivers/media/dvb/dvb-usb/dibusb-mb.o sind verschieden.
diff -ruN drivers/media/dvb/dvb-usb.orig/.dibusb-mb.o.cmd drivers/media/dvb/dvb-usb/.dibusb-mb.o.cmd
--- drivers/media/dvb/dvb-usb.orig/.dibusb-mb.o.cmd	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/.dibusb-mb.o.cmd	2005-12-22 22:30:17.000000000 +0100
@@ -2,6 +2,7 @@
 
 deps_drivers/media/dvb/dvb-usb/dibusb-mb.o := \
   drivers/media/dvb/dvb-usb/dibusb-mb.c \
+    $(wildcard include/config/dvb/usb/dibusb/mb/faulty.h) \
   drivers/media/dvb/dvb-usb/dibusb.h \
     $(wildcard include/config/dvb/usb/dibusb/mc.h) \
   drivers/media/dvb/dvb-usb/dvb-usb.h \
diff -ruN drivers/media/dvb/dvb-usb.orig/dibusb-mc.c drivers/media/dvb/dvb-usb/dibusb-mc.c
--- drivers/media/dvb/dvb-usb.orig/dibusb-mc.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/dibusb-mc.c	2005-12-22 22:29:24.000000000 +0100
@@ -78,6 +78,7 @@
 			{ &dibusb_dib3000mc_table[2], NULL },
 			{ NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/digitv.c drivers/media/dvb/dvb-usb/digitv.c
--- drivers/media/dvb/dvb-usb.orig/digitv.c	2005-12-22 19:38:34.000000000 +0100
+++ drivers/media/dvb/dvb-usb/digitv.c	2005-12-22 22:25:57.000000000 +0100
@@ -229,6 +229,7 @@
 			{ &digitv_table[0], NULL },
 			{ NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/dtt200u.h drivers/media/dvb/dvb-usb/dtt200u.h
--- drivers/media/dvb/dvb-usb.orig/dtt200u.h	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/dtt200u.h	2005-12-22 22:15:22.000000000 +0100
@@ -13,6 +13,7 @@
 #define _DVB_USB_DTT200U_H_
 
 #define DVB_USB_LOG_PREFIX "dtt200u"
+
 #include "dvb-usb.h"
 
 extern int dvb_usb_dtt200u_debug;
@@ -25,15 +26,15 @@
  *  88 - locking 2 bytes (0x80 0x40 == no signal, 0x89 0x20 == nice signal)
  */
 
-#define GET_SPEED            0x00
-#define GET_TUNE_STATUS      0x81
-#define GET_RC_CODE          0x84
-#define GET_CONFIGURATION    0x88
-#define GET_AGC              0x89
-#define GET_SNR              0x8a
-#define GET_VIT_ERR_CNT      0x8c
-#define GET_RS_ERR_CNT       0x8d
-#define GET_RS_UNCOR_BLK_CNT 0x8e
+#define GET_SPEED		0x00
+#define GET_TUNE_STATUS		0x81
+#define GET_RC_CODE		0x84
+#define GET_CONFIGURATION	0x88
+#define GET_AGC			0x89
+#define GET_SNR			0x8a
+#define GET_VIT_ERR_CNT		0x8c
+#define GET_RS_ERR_CNT		0x8d
+#define GET_RS_UNCOR_BLK_CNT	0x8e
 
 /* write
  *  01 - init
@@ -44,12 +45,12 @@
  *  08 - transfer switch
  */
 
-#define SET_INIT         0x01
-#define SET_RF_FREQ      0x02
-#define SET_BANDWIDTH    0x03
-#define SET_PID_FILTER   0x04
-#define RESET_PID_FILTER 0x05
-#define SET_STREAMING    0x08
+#define SET_INIT		0x01
+#define SET_RF_FREQ		0x02
+#define SET_BANDWIDTH		0x03
+#define SET_PID_FILTER		0x04
+#define RESET_PID_FILTER	0x05
+#define SET_STREAMING		0x08
 
 extern struct dvb_frontend * dtt200u_fe_attach(struct dvb_usb_device *d);
 
Dateien drivers/media/dvb/dvb-usb.orig/dvb-usb-dibusb-mb.ko und drivers/media/dvb/dvb-usb/dvb-usb-dibusb-mb.ko sind verschieden.
diff -ruN drivers/media/dvb/dvb-usb.orig/dvb-usb-dibusb-mb.mod.c drivers/media/dvb/dvb-usb/dvb-usb-dibusb-mb.mod.c
--- drivers/media/dvb/dvb-usb.orig/dvb-usb-dibusb-mb.mod.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/dvb-usb-dibusb-mb.mod.c	2005-12-22 22:30:50.000000000 +0100
@@ -77,4 +77,4 @@
 MODULE_ALIAS("usb:v05D8p810Ad*dc*dsc*dp*ic*isc*ip*");
 MODULE_ALIAS("usb:v0547p2235d*dc*dsc*dp*ic*isc*ip*");
 
-MODULE_INFO(srcversion, "7612332C946BF81765C3231");
+MODULE_INFO(srcversion, "AEDF1B0A6189BB5A470AE8B");
Dateien drivers/media/dvb/dvb-usb.orig/dvb-usb-dibusb-mb.mod.o und drivers/media/dvb/dvb-usb/dvb-usb-dibusb-mb.mod.o sind verschieden.
Dateien drivers/media/dvb/dvb-usb.orig/dvb-usb-dibusb-mb.o und drivers/media/dvb/dvb-usb/dvb-usb-dibusb-mb.o sind verschieden.
diff -ruN drivers/media/dvb/dvb-usb.orig/Kconfig drivers/media/dvb/dvb-usb/Kconfig
--- drivers/media/dvb/dvb-usb.orig/Kconfig	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/Kconfig	2005-12-22 19:51:14.000000000 +0100
@@ -37,16 +37,16 @@
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-B demodulator.
 
 	  Devices supported by this driver:
-	    TwinhanDTV USB-Ter (VP7041)
-	    TwinhanDTV Magic Box (VP7041e)
-	    KWorld/JetWay/ADSTech V-Stream XPERT DTV - DVB-T USB1.1 and USB2.0
-	    Hama DVB-T USB1.1-Box
-	    DiBcom USB1.1 reference devices (non-public)
-	    Ultima Electronic/Artec T1 USB TVBOX
+	    Artec T1 USB1.1 boxes
+	    Avermedia AverTV DVBT USB1.1
 	    Compro Videomate DVB-U2000 - DVB-T USB
+	    DiBcom USB1.1 reference devices (non-public)
 	    Grandtec DVB-T USB
-	    Avermedia AverTV DVBT USB1.1
-	    Artec T1 USB1.1 boxes
+	    Hama DVB-T USB1.1-Box
+	    KWorld/JetWay/ADSTech V-Stream XPERT DTV - DVB-T USB1.1 and USB2.0
+	    TwinhanDTV Magic Box (VP7041e)
+	    TwinhanDTV USB-Ter (VP7041)
+	    Ultima Electronic/Artec T1 USB TVBOX
 
 	  The VP7041 seems to be identical to "CTS Portable" (Chinese
 	  Television System).
@@ -54,6 +54,12 @@
 	  Say Y if you own such a device and want to use it. You should build it as
 	  a module.
 
+config DVB_USB_DIBUSB_MB_FAULTY
+	bool "Support faulty USB IDs"
+	depends on DVB_USB_DIBUSB_MB
+	help
+	  Support for faulty USB IDs due to an invalid EEPROM on some Artec devices.
+
 config DVB_USB_DIBUSB_MC
 	tristate "DiBcom USB DVB-T devices (based on the DiB3000M-C/P) (see help for device list)"
 	depends on DVB_USB
@@ -63,8 +69,8 @@
 	  DiBcom (<http://www.dibcom.fr>) equipped with a DiB3000M-C/P demodulator.
 
 	  Devices supported by this driver:
-	    DiBcom USB2.0 reference devices (non-public)
 	    Artec T1 USB2.0 boxes
+	    DiBcom USB2.0 reference devices (non-public)
 
 	  Say Y if you own such a device and want to use it. You should build it as
 	  a module.
diff -ruN drivers/media/dvb/dvb-usb.orig/nova-t-usb2.c drivers/media/dvb/dvb-usb/nova-t-usb2.c
--- drivers/media/dvb/dvb-usb.orig/nova-t-usb2.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/nova-t-usb2.c	2005-12-24 14:08:41.000000000 +0100
@@ -129,10 +129,6 @@
 		dibusb_read_eeprom_byte(d,i, &b);
 
 		mac[5 - (i - 136)] = b;
-
-/*		deb_ee("%02x ",b);
-		if ((i+1) % 16 == 0)
-			deb_ee("\n");*/
 	}
 
 	return 0;
@@ -153,7 +149,7 @@
 /* 01 */	{ USB_DEVICE(USB_VID_HAUPPAUGE,     USB_PID_WINTV_NOVA_T_USB2_WARM) },
 			{ }		/* Terminating entry */
 };
-MODULE_DEVICE_TABLE (usb, nova_t_table);
+MODULE_DEVICE_TABLE(usb, nova_t_table);
 
 static struct dvb_usb_properties nova_t_properties = {
 	.caps = DVB_USB_HAS_PID_FILTER | DVB_USB_PID_FILTER_CAN_BE_TURNED_OFF | DVB_USB_IS_AN_I2C_ADAPTER,
@@ -198,6 +194,7 @@
 			{ &nova_t_table[0], NULL },
 			{ &nova_t_table[1], NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/umt-010.c drivers/media/dvb/dvb-usb/umt-010.c
--- drivers/media/dvb/dvb-usb.orig/umt-010.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/umt-010.c	2005-12-22 22:28:31.000000000 +0100
@@ -124,6 +124,7 @@
 			{ &umt_table[0], NULL },
 			{ &umt_table[1], NULL },
 		},
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/vp702x.c drivers/media/dvb/dvb-usb/vp702x.c
--- drivers/media/dvb/dvb-usb.orig/vp702x.c	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/vp702x.c	2005-12-22 22:26:27.000000000 +0100
@@ -250,7 +250,7 @@
 		  .cold_ids = { &vp702x_usb_table[2], NULL },
 		  .warm_ids = { &vp702x_usb_table[3], NULL },
 		},
-		{ 0 },
+		{ NULL },
 	}
 };
 
diff -ruN drivers/media/dvb/dvb-usb.orig/vp702x.h drivers/media/dvb/dvb-usb/vp702x.h
--- drivers/media/dvb/dvb-usb.orig/vp702x.h	2005-12-22 19:38:35.000000000 +0100
+++ drivers/media/dvb/dvb-usb/vp702x.h	2005-12-22 22:37:39.000000000 +0100
@@ -13,47 +13,47 @@
 /* commands are read and written with USB control messages */
 
 /* consecutive read/write operation */
-#define REQUEST_OUT       0xB2
-#define REQUEST_IN		  0xB3
+#define REQUEST_OUT		0xB2
+#define REQUEST_IN		0xB3
 
 /* the out-buffer of these consecutive operations contain sub-commands when b[0] = 0
  * request: 0xB2; i: 0; v: 0; b[0] = 0, b[1] = subcmd, additional buffer
  * the returning buffer looks as follows
  * request: 0xB3; i: 0; v: 0; b[0] = 0xB3, additional buffer */
 
-#define GET_TUNER_STATUS  0x05
+#define GET_TUNER_STATUS	0x05
 /* additional in buffer:
  * 0   1   2    3              4   5   6               7       8
  * N/A N/A 0x05 signal-quality N/A N/A signal-strength lock==0 N/A */
 
-#define GET_SYSTEM_STRING 0x06
+#define GET_SYSTEM_STRING	0x06
 /* additional in buffer:
  * 0   1   2   3   4   5   6   7   8
  * N/A 'U' 'S' 'B' '7' '0' '2' 'X' N/A */
 
-#define SET_DISEQC_CMD    0x08
+#define SET_DISEQC_CMD		0x08
 /* additional out buffer:
  * 0    1  2  3  4
  * len  X1 X2 X3 X4
  * additional in buffer:
  * 0   1 2
- * N/A 0 0   b[1] == b[2] == 0 -> success otherwise not */
+ * N/A 0 0   b[1] == b[2] == 0 -> success, failure otherwise */
 
-#define SET_LNB_POWER     0x09
+#define SET_LNB_POWER		0x09
 /* additional out buffer:
  * 0    1    2
  * 0x00 0xff 1 = on, 0 = off
  * additional in buffer:
  * 0   1 2
- * N/A 0 0   b[1] == b[2] == 0 -> success otherwise not */
+ * N/A 0 0   b[1] == b[2] == 0 -> success failure otherwise */
 
-#define GET_MAC_ADDRESS   0x0A
+#define GET_MAC_ADDRESS		0x0A
 /* #define GET_MAC_ADDRESS   0x0B */
 /* additional in buffer:
  * 0   1   2            3    4    5    6    7    8
  * N/A N/A 0x0A or 0x0B MAC0 MAC1 MAC2 MAC3 MAC4 MAC5 */
 
-#define SET_PID_FILTER    0x11
+#define SET_PID_FILTER		0x11
 /* additional in buffer:
  * 0        1        ... 14       15       16
  * PID0_MSB PID0_LSB ... PID7_MSB PID7_LSB PID_active (bits) */
@@ -64,39 +64,38 @@
  * freq0 freq1 divstep srate0 srate1 srate2 flag chksum
  */
 
-
 /* one direction requests */
-#define READ_REMOTE_REQ       0xB4
+#define READ_REMOTE_REQ		0xB4
 /* IN  i: 0; v: 0; b[0] == request, b[1] == key */
 
-#define READ_PID_NUMBER_REQ   0xB5
+#define READ_PID_NUMBER_REQ	0xB5
 /* IN  i: 0; v: 0; b[0] == request, b[1] == 0, b[2] = pid number */
 
-#define WRITE_EEPROM_REQ      0xB6
+#define WRITE_EEPROM_REQ	0xB6
 /* OUT i: offset; v: value to write; no extra buffer */
 
-#define READ_EEPROM_REQ       0xB7
+#define READ_EEPROM_REQ		0xB7
 /* IN  i: bufferlen; v: offset; buffer with bufferlen bytes */
 
-#define READ_STATUS           0xB8
+#define READ_STATUS		0xB8
 /* IN  i: 0; v: 0; bufferlen 10 */
 
-#define READ_TUNER_REG_REQ    0xB9
+#define READ_TUNER_REG_REQ	0xB9
 /* IN  i: 0; v: register; b[0] = value */
 
-#define READ_FX2_REG_REQ      0xBA
+#define READ_FX2_REG_REQ	0xBA
 /* IN  i: offset; v: 0; b[0] = value */
 
-#define WRITE_FX2_REG_REQ     0xBB
+#define WRITE_FX2_REG_REQ	0xBB
 /* OUT i: offset; v: value to write; 1 byte extra buffer */
 
-#define SET_TUNER_POWER_REQ   0xBC
+#define SET_TUNER_POWER_REQ	0xBC
 /* IN  i: 0 = power off, 1 = power on */
 
-#define WRITE_TUNER_REG_REQ   0xBD
+#define WRITE_TUNER_REG_REQ	0xBD
 /* IN  i: register, v: value to write, no extra buffer */
 
-#define RESET_TUNER           0xBE
+#define RESET_TUNER		0xBE
 /* IN  i: 0, v: 0, no extra buffer */
 
 extern struct dvb_frontend * vp702x_fe_attach(struct dvb_usb_device *d);

--X1bOJ3K7DJ5YkBrT--
