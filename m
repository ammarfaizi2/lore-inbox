Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319394AbSH2WUM>; Thu, 29 Aug 2002 18:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319391AbSH2Vw7>; Thu, 29 Aug 2002 17:52:59 -0400
Received: from smtpout.mac.com ([204.179.120.85]:55775 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319392AbSH2Vwp>;
	Thu, 29 Aug 2002 17:52:45 -0400
Message-Id: <200208292157.g7TLv8ZH003968@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 25/41 sound/oss/dev_table.h - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/dev_table.h	Sat Apr 20 18:25:19 2002
+++ linux-2.5-cli-oss/sound/oss/dev_table.h	Fri Aug 16 12:41:32 2002
@@ -15,6 +15,7 @@
 #ifndef _DEV_TABLE_H_
 #define _DEV_TABLE_H_
 
+#include <linux/spinlock.h>
 /*
  * Sound card numbers 27 to 999. (1 to 26 are defined in soundcard.h)
  * Numbers 1000 to N are reserved for driver's internal use.
@@ -107,9 +108,11 @@
 	/*
 	 * Queue parameters.
 	 */
-       	int      qlen;
-       	int      qhead;
-       	int      qtail;
+	int      qlen;
+	int      qhead;
+	int      qtail;
+	spinlock_t lock;
+		
 	int	 cfrag;	/* Current incomplete fragment (write) */
 
 	int      nbufs;
@@ -205,7 +208,7 @@
 	int  format_mask;	/* Bitmask for supported audio formats */
 	void *devc;		/* Driver specific info */
 	struct audio_driver *d;
-	void *portc;		/* Driver spesific info */
+	void *portc;		/* Driver specific info */
 	struct dma_buffparms *dmap_in, *dmap_out;
 	struct coproc_operations *coproc;
 	int mixer_dev;
@@ -292,7 +295,7 @@
 {
 	/* MIDI input scanner variables */
 #define MI_MAX	10
-	int             m_busy;
+	volatile int             m_busy;
     	unsigned char   m_buf[MI_MAX];
 	unsigned char	m_prev_status;	/* For running status */
     	int             m_ptr;

