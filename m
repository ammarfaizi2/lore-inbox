Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263978AbTEFQYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTEFQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:23:16 -0400
Received: from mail.convergence.de ([212.84.236.4]:8393 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263936AbTEFQN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:13:59 -0400
Message-ID: <3EB7DF9B.3020908@convergence.de>
Date: Tue, 06 May 2003 18:15:23 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH[[2.5][7-11] update include files for dvb and saa7146
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------090402080201010801060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090402080201010801060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this patch updates the dvb include files:
- more changes from __u8 to u8 and uint32_t to u32

and the saa7146 include file saa7146.h:
- removed some LINUX_VERSION_CODE magic and introduced some new stuff, 
we're working on it...

Please review and apply.

Thanks
Michael Hunold.









--------------090402080201010801060909
Content-Type: text/plain;
 name="07-include-files-update.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="07-include-files-update.diff"

diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/linux/dvb/dmx.h linux-2.5.69.patch/include/linux/dvb/dmx.h
--- linux-2.5.69/include/linux/dvb/dmx.h	2003-05-06 13:15:49.000000000 +0200
+++ linux-2.5.69.patch/include/linux/dvb/dmx.h	2003-03-22 18:13:22.000000000 +0100
@@ -24,10 +24,10 @@
 #ifndef _DVBDMX_H_
 #define _DVBDMX_H_
 
+#include <asm/types.h>
 #ifdef __KERNEL__
-#include <linux/types.h>
+#include <linux/time.h>
 #else
-#include <stdint.h>
 #include <time.h>
 #endif
 
@@ -103,18 +104,18 @@
 
 typedef struct dmx_filter
 {
-	uint8_t         filter[DMX_FILTER_SIZE];
-	uint8_t         mask[DMX_FILTER_SIZE];
-	uint8_t         mode[DMX_FILTER_SIZE];
+	__u8  filter[DMX_FILTER_SIZE];
+	__u8  mask[DMX_FILTER_SIZE];
+	__u8  mode[DMX_FILTER_SIZE];
 } dmx_filter_t;
 
 
 struct dmx_sct_filter_params
 {
-	uint16_t            pid;
+	__u16            pid;
 	dmx_filter_t        filter;
-	uint32_t            timeout;
-	uint32_t            flags;
+	__u32            timeout;
+	__u32            flags;
 #define DMX_CHECK_CRC       1
 #define DMX_ONESHOT         2
 #define DMX_IMMEDIATE_START 4
@@ -124,11 +125,11 @@
 
 struct dmx_pes_filter_params
 {
-	uint16_t            pid;
+	__u16            pid;
 	dmx_input_t         input;
 	dmx_output_t        output;
 	dmx_pes_type_t      pes_type;
-	uint32_t            flags;
+	__u32            flags;
 };
 
 
@@ -143,7 +144,7 @@
 };
 
 typedef struct dmx_caps {
-	uint32_t caps;
+	__u32 caps;
 	int num_decoders; 
 } dmx_caps_t;
 
@@ -161,7 +162,7 @@
 struct dmx_stc {
 	unsigned int num;	/* input : which STC? 0..N */
 	unsigned int base;	/* output: divisor for stc to get 90 kHz clock */
-	uint64_t stc;		/* output: stc in 'base'*90 kHz units */
+	__u64 stc;		/* output: stc in 'base'*90 kHz units */
 };
 
 
@@ -171,7 +172,7 @@
 #define DMX_SET_PES_FILTER       _IOW('o',44,struct dmx_pes_filter_params)
 #define DMX_SET_BUFFER_SIZE      _IO('o',45)
 #define DMX_GET_EVENT            _IOR('o',46,struct dmx_event)
-#define DMX_GET_PES_PIDS         _IOR('o',47,uint16_t[5])
+#define DMX_GET_PES_PIDS         _IOR('o', 47, __u16[5])
 #define DMX_GET_CAPS             _IOR('o',48,dmx_caps_t)
 #define DMX_SET_SOURCE           _IOW('o',49,dmx_source_t)
 #define DMX_GET_STC              _IOWR('o',50,struct dmx_stc)
diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/linux/dvb/frontend.h linux-2.5.69.patch/include/linux/dvb/frontend.h
--- linux-2.5.69/include/linux/dvb/frontend.h	2003-05-06 13:15:49.000000000 +0200
+++ linux-2.5.69.patch/include/linux/dvb/frontend.h	2003-03-21 16:28:11.000000000 +0100
@@ -26,11 +26,7 @@
 #ifndef _DVBFRONTEND_H_
 #define _DVBFRONTEND_H_
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
+#include <asm/types.h>
 
 
 typedef enum fe_type {
@@ -72,14 +68,14 @@
 struct dvb_frontend_info {
 	char       name[128];
         fe_type_t  type;
-        uint32_t   frequency_min;
-        uint32_t   frequency_max;
-	uint32_t   frequency_stepsize;
-	uint32_t   frequency_tolerance;
-	uint32_t   symbol_rate_min;
-        uint32_t   symbol_rate_max;
-	uint32_t   symbol_rate_tolerance;     /* ppm */
-	uint32_t   notifier_delay;            /* ms */
+        __u32      frequency_min;
+        __u32      frequency_max;
+	__u32      frequency_stepsize;
+	__u32      frequency_tolerance;
+	__u32      symbol_rate_min;
+        __u32      symbol_rate_max;
+	__u32      symbol_rate_tolerance;     /* ppm */
+	__u32      notifier_delay;            /* ms */
 	fe_caps_t  caps;
 };
 
@@ -89,14 +85,14 @@
  *  the meaning of this struct...
  */
 struct dvb_diseqc_master_cmd {
-        uint8_t msg [6];        /*  { framing, address, command, data [3] } */
-        uint8_t msg_len;        /*  valid values are 3...6  */
+        __u8 msg [6];        /*  { framing, address, command, data [3] } */
+        __u8 msg_len;        /*  valid values are 3...6  */
 };
 
 
 struct dvb_diseqc_slave_reply {
-	uint8_t msg [4];        /*  { framing, data [3] } */
-	uint8_t msg_len;        /*  valid values are 0...4, 0 means no msg  */
+	__u8 msg [4];        /*  { framing, data [3] } */
+	__u8 msg_len;        /*  valid values are 0...4, 0 means no msg  */
 	int     timeout;        /*  return from ioctl after timeout ms with */
 };                              /*  errorcode when no message was received  */
 
@@ -195,13 +191,13 @@
 
 
 struct dvb_qpsk_parameters {
-        uint32_t        symbol_rate;  /* symbol rate in Symbols per second */
+        __u32           symbol_rate;  /* symbol rate in Symbols per second */
         fe_code_rate_t  fec_inner;    /* forward error correction (see above) */
 };
 
 
 struct dvb_qam_parameters {
-        uint32_t         symbol_rate; /* symbol rate in Symbols per second */
+        __u32            symbol_rate; /* symbol rate in Symbols per second */
         fe_code_rate_t   fec_inner;   /* forward error correction (see above) */
         fe_modulation_t  modulation;  /* modulation type (see above) */
 };
@@ -219,7 +215,7 @@
 
 
 struct dvb_frontend_parameters {
-        uint32_t frequency;       /* (absolute) frequency in Hz for QAM/OFDM */
+        __u32 frequency;     /* (absolute) frequency in Hz for QAM/OFDM */
                                   /* intermediate frequency in kHz for QPSK */
 	fe_spectral_inversion_t inversion;
 	union {
@@ -249,10 +245,10 @@
 #define FE_ENABLE_HIGH_LNB_VOLTAGE _IO('o', 68)  /* int */
 
 #define FE_READ_STATUS             _IOR('o', 69, fe_status_t)
-#define FE_READ_BER                _IOR('o', 70, uint32_t)
-#define FE_READ_SIGNAL_STRENGTH    _IOR('o', 71, uint16_t)
-#define FE_READ_SNR                _IOR('o', 72, uint16_t)
-#define FE_READ_UNCORRECTED_BLOCKS _IOR('o', 73, uint32_t)
+#define FE_READ_BER                _IOR('o', 70, __u32)
+#define FE_READ_SIGNAL_STRENGTH    _IOR('o', 71, __u16)
+#define FE_READ_SNR                _IOR('o', 72, __u16)
+#define FE_READ_UNCORRECTED_BLOCKS _IOR('o', 73, __u32)
 
 #define FE_SET_FRONTEND            _IOW('o', 76, struct dvb_frontend_parameters)
 #define FE_GET_FRONTEND            _IOR('o', 77, struct dvb_frontend_parameters)
diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/linux/dvb/net.h linux-2.5.69.patch/include/linux/dvb/net.h
--- linux-2.5.69/include/linux/dvb/net.h	2003-05-06 13:15:49.000000000 +0200
+++ linux-2.5.69.patch/include/linux/dvb/net.h	2003-03-21 16:09:55.000000000 +0100
@@ -24,16 +24,12 @@
 #ifndef _DVBNET_H_
 #define _DVBNET_H_
 
-#ifdef __KERNEL__
-#include <linux/types.h>
-#else
-#include <stdint.h>
-#endif
+#include <asm/types.h>
 
 
 struct dvb_net_if {
-	uint16_t pid;
-	uint16_t if_num;
+	__u16 pid;
+	__u16 if_num;
 };
 
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/linux/dvb/version.h linux-2.5.69.patch/include/linux/dvb/version.h
--- linux-2.5.69/include/linux/dvb/version.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.69.patch/include/linux/dvb/version.h	2003-03-07 12:40:08.000000000 +0100
@@ -0,0 +1,29 @@
+/*
+ * version.h
+ *
+ * Copyright (C) 2000 Holger Waechtler <holger@convergence.de>
+ *                    for convergence integrated media GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ */
+
+#ifndef _DVBVERSION_H_
+#define _DVBVERSION_H_
+
+#define DVB_API_VERSION 3
+
+#endif /*_DVBVERSION_H_*/
+
diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/linux/dvb/video.h linux-2.5.69.patch/include/linux/dvb/video.h
--- linux-2.5.69/include/linux/dvb/video.h	2003-05-06 13:15:49.000000000 +0200
+++ linux-2.5.69.patch/include/linux/dvb/video.h	2003-04-22 15:19:06.000000000 +0200
@@ -34,7 +34,8 @@
 
 typedef enum {
 	VIDEO_FORMAT_4_3,     /* Select 4:3 format */ 
-        VIDEO_FORMAT_16_9     /* Select 16:9 format. */ 
+        VIDEO_FORMAT_16_9,    /* Select 16:9 format. */
+	VIDEO_FORMAT_221_1    /* 2.21:1 */
 } video_format_t;
 
 
@@ -56,6 +57,11 @@
 	VIDEO_CENTER_CUT_OUT  /* use center cut out format */
 } video_displayformat_t;
 
+typedef struct {
+	int w;
+	int h;
+	video_format_t aspect_ratio;
+} video_size_t;
 
 typedef enum {
         VIDEO_SOURCE_DEMUX, /* Select the demux as the main source */ 
@@ -74,9 +80,10 @@
 
 struct video_event { 
         int32_t type; 
+#define VIDEO_EVENT_SIZE_CHANGED 1
         time_t timestamp;
 	union { 
-	        video_format_t video_format;
+	        video_size_t size;
 	} u; 
 };
 
@@ -186,6 +193,7 @@
 #define VIDEO_SET_SPU_PALETTE      _IOW('o', 51, video_spu_palette_t)
 #define VIDEO_GET_NAVI             _IOR('o', 52, video_navi_pack_t)
 #define VIDEO_SET_ATTRIBUTES       _IO('o', 53)
+#define VIDEO_GET_SIZE             _IOR('o', 55, video_size_t)
 
 #endif /*_DVBVIDEO_H_*/
 
diff -uNrwB -x '*.o' --new-file linux-2.5.69/include/media/saa7146.h linux-2.5.69.patch/include/media/saa7146.h
--- linux-2.5.69/include/media/saa7146.h	2003-05-06 13:16:43.000000000 +0200
+++ linux-2.5.69.patch/include/media/saa7146.h	2003-05-06 17:17:55.000000000 +0200
@@ -13,10 +13,6 @@
 #include <asm/io.h>		/* for accessing devices */
 #include <linux/stringify.h>
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
-	#include "compat.h"
-#endif
-
 #define SAA7146_VERSION_CODE KERNEL_VERSION(0,5,0)
 
 #define saa7146_write(sxy,adr,dat)    writel((dat),(sxy->mem+(adr)))
@@ -30,7 +26,16 @@
 	#define DEBUG_VARIABLE saa7146_debug
 #endif
 
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,51)
+#define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_BASENAME),__FUNCTION__)
+#define INFO(x) { printk("%s: ",__stringify(KBUILD_BASENAME)); printk x; }
+#else
 #define DEBUG_PROLOG printk("%s: %s(): ",__stringify(KBUILD_MODNAME),__FUNCTION__)
+#define INFO(x) { printk("%s: ",__stringify(KBUILD_MODNAME)); printk x; }
+#endif
+
+#define ERR(x) { DEBUG_PROLOG; printk x; }
+
 #define DEB_S(x)    if (0!=(DEBUG_VARIABLE&0x01)) { DEBUG_PROLOG; printk x; } /* simple debug messages */
 #define DEB_D(x)    if (0!=(DEBUG_VARIABLE&0x02)) { DEBUG_PROLOG; printk x; } /* more detailed debug messages */
 #define DEB_EE(x)   if (0!=(DEBUG_VARIABLE&0x04)) { DEBUG_PROLOG; printk x; } /* print enter and exit of functions */
@@ -39,9 +44,6 @@
 #define DEB_INT(x)  if (0!=(DEBUG_VARIABLE&0x20)) { DEBUG_PROLOG; printk x; } /* interrupt debug messages */
 #define DEB_CAP(x)  if (0!=(DEBUG_VARIABLE&0x40)) { DEBUG_PROLOG; printk x; } /* capture debug messages */
 
-#define ERR(x) { DEBUG_PROLOG; printk x; }
-#define INFO(x) { printk("%s: ",__stringify(KBUILD_MODNAME)); printk x; }
-
 #define IER_DISABLE(x,y) \
 	saa7146_write(x, IER, saa7146_read(x, IER) & ~(y));
 #define IER_ENABLE(x,y) \

--------------090402080201010801060909--


