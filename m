Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262187AbUKQGcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUKQGcj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 01:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbUKQGcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 01:32:39 -0500
Received: from mail.renesas.com ([202.234.163.13]:8625 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262187AbUKQGcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 01:32:12 -0500
Date: Wed, 17 Nov 2004 15:32:01 +0900 (JST)
Message-Id: <20041117.153201.27776357.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] media: Update drivers/media/video/arv.c
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a patch to update AR camera device driver.
Please apply.

	* drivers/media/video/arv.c:
	- Remove warnings; use module_param() instead of MODULE_PARM(),
          because MODULE_PARM() is deprecated.
	- Fix white-space damages.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arv.c |  118 +++++++++++++++++++++++++++++++++---------------------------------
 1 files changed, 59 insertions(+), 59 deletions(-)


diff -ruNp a/drivers/media/video/arv.c b/drivers/media/video/arv.c
--- a/drivers/media/video/arv.c	2004-11-15 12:17:04.000000000 +0900
+++ b/drivers/media/video/arv.c	2004-11-17 15:11:17.000000000 +0900
@@ -127,12 +127,12 @@ static unsigned char	yuv[MAX_AR_FRAME_BY
 /* module parameters */
 /* default frequency */
 #define DEFAULT_FREQ	50	// 50 or 75 (MHz) is available as BCLK
-static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 70 (MHz) */
+static int freq = DEFAULT_FREQ;	/* BCLK: available 50 or 75 (MHz) */
 static int vga = 0;		/* default mode(0:QVGA mode, other:VGA mode) */
 static int vga_interlace = 0;	/* 0 is normal mode for, else interlace mode */
-MODULE_PARM(freq, "i");
-MODULE_PARM(vga, "i");
-MODULE_PARM(vga_interlace, "i");
+module_param(freq, int, 0644);
+module_param(vga, bool, 0644);
+module_param(vga_interlace, bool, 0644);
 
 static int ar_initialize(struct video_device *dev);
 
@@ -143,57 +143,57 @@ void iic(int n, unsigned long addr, unsi
 {
 	int i;
 
-  	/* Slave Address */
-  	ar_outl(addr, PLDI2CDATA);
+	/* Slave Address */
+	ar_outl(addr, PLDI2CDATA);
 
 	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
 	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
-  	/* Start */
-  	ar_outl(1, PLDI2CCND);
+	/* Start */
+	ar_outl(1, PLDI2CCND);
 
-  	for(i=0; i<1000; i++);
-  	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
+	for(i=0; i<1000; i++);
+	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
 
-  	/* Trasfer data 1 */
-  	ar_outl(data1, PLDI2CDATA);
+	/* Trasfer data 1 */
+	ar_outl(data1, PLDI2CDATA);
 	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
 	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
-  	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
+	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
 
-  	/* Ack wait */
-  	for(i=0; i<1000; i++);
-  	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
+	/* Ack wait */
+	for(i=0; i<1000; i++);
+	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
 
-  	/* Trasfer data 2 */
-  	ar_outl(data2, PLDI2CDATA);
+	/* Trasfer data 2 */
+	ar_outl(data2, PLDI2CDATA);
 	while ( ar_inl(ARVCR0) & ARVCR0_VDS ); 	  // wait for VSYNC
 	while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
-  	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
+	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
 
-  	/* Ack wait */
-  	for(i=0; i<1000; i++);
+	/* Ack wait */
+	for(i=0; i<1000; i++);
 
-  	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
+	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
 
-  	if(n==3){
-    		/* Trasfer data 3 */
-	  	ar_outl(data3, PLDI2CDATA);
+	if(n==3){
+		/* Trasfer data 3 */
+		ar_outl(data3, PLDI2CDATA);
 		while ( ar_inl(ARVCR0) & ARVCR0_VDS );    // wait for VSYNC
 		while ( !(ar_inl(ARVCR0) & ARVCR0_VDS) ); // wait for VSYNC
-	  	ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
+		ar_outl(PLDI2CSTEN_STEN, PLDI2CSTEN);
 
-    		/* Ack wait */
-    		for(i=0; i<10000; i++);
+		/* Ack wait */
+		for(i=0; i<10000; i++);
 
-  		while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
-  	}
+		while( ar_inl(PLDI2CSTS) & PLDI2CSTS_NOACK );
+	}
 
-  	/* Stop */
-  	for(i=0; i<100; i++);
-  	ar_outl(2, PLDI2CCND);
-  	ar_outl(2, PLDI2CCND);
+	/* Stop */
+	for(i=0; i<100; i++);
+	ar_outl(2, PLDI2CCND);
+	ar_outl(2, PLDI2CCND);
 
-  	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_BB );
+	while( ar_inl(PLDI2CSTS) & PLDI2CSTS_BB );
 }
 
 
@@ -201,24 +201,24 @@ void init_iic(void)
 {
 	DEBUG(1, "init_iic:\n");
 
-  	/*
+	/*
 	 * ICU Setting (iic)
 	 */
-  	/* I2C Setting */
-  	ar_outl(0x0, PLDI2CCR);      	/* I2CCR Disable                   */
-  	ar_outl(0x0300, PLDI2CMOD); 	/* I2CMOD ACK/8b-data/7b-addr/auto */
-  	ar_outl(0x1, PLDI2CACK);	/* I2CACK ACK                      */
+	/* I2C Setting */
+	ar_outl(0x0, PLDI2CCR);		/* I2CCR Disable		   */
+	ar_outl(0x0300, PLDI2CMOD); 	/* I2CMOD ACK/8b-data/7b-addr/auto */
+	ar_outl(0x1, PLDI2CACK);	/* I2CACK ACK			   */
 
-    	/* I2C CLK */
-   	/* 50MH-100k */
+	/* I2C CLK */
+	/* 50MH-100k */
 	if (freq == 75) {
-  		ar_outl(369, PLDI2CFREQ);	/* BCLK = 75MHz */
+		ar_outl(369, PLDI2CFREQ);	/* BCLK = 75MHz */
 	} else if (freq == 50) {
 		ar_outl(244, PLDI2CFREQ);	/* BCLK = 50MHz */
 	} else {
 		ar_outl(244, PLDI2CFREQ);	/* default:BCLK = 50MHz */
 	}
-  	ar_outl(0x1, PLDI2CCR); 	/* I2CCR Enable */
+	ar_outl(0x1, PLDI2CCR); 		/* I2CCR Enable */
 }
 
 /**************************************************************************
@@ -233,8 +233,8 @@ static inline void wait_for_vertical_syn
 	int l;
 
 	/*
- 	 * check HCOUNT because we can not check vertual sync.
- 	 */
+	 * check HCOUNT because we can not check vertual sync.
+	 */
 	for (; tmout >= 0; tmout--) {
 		l = ar_inl(ARVHCOUNT);
 		if (l == exp_line) break;
@@ -269,14 +269,14 @@ static ssize_t ar_read(struct file *file
 
 #if USE_INT
 	local_irq_save(flags);
-	ar_outl(0x80000, M32R_DMAEN_PORTL);			// disable DMA0
+	ar_outl(0x80000, M32R_DMAEN_PORTL);		// disable DMA0
 	ar_outl(0xa1871300, M32R_DMA0CR0_PORTL);
 	ar_outl(0x01000000, M32R_DMA0CR1_PORTL);
 
 	// set AR FIFO address as source(BSEL5)
 	ar_outl(ARDATA32, M32R_DMA0CSA_PORTL);		//
 	ar_outl(ARDATA32, M32R_DMA0RSA_PORTL);		//
-	ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);		// destination address
+	ar_outl(ar->line_buff, M32R_DMA0CDA_PORTL);	// destination address
 	ar_outl(ar->line_buff, M32R_DMA0RDA_PORTL); 	// reload address
 	ar_outl(ar->line_bytes, M32R_DMA0CBCUT_PORTL); 	// byte count(bytes)
 	ar_outl(ar->line_bytes, M32R_DMA0RBCUT_PORTL); 	// reload count (bytes)
@@ -297,7 +297,7 @@ static ssize_t ar_read(struct file *file
 #else	/* ! USE_INT */
 	/* polling */
 	ar_outl(arvcr1, ARVCR1);
-	ar_outl(0x80000, M32R_DMAEN_PORTL);			// disable DMA0
+	ar_outl(0x80000, M32R_DMAEN_PORTL);		// disable DMA0
 	ar_outl(0x8000, M32R_DMAEDET_PORTL);
 	ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 	ar_outl(0x01000000, M32R_DMA0CR1_PORTL);
@@ -319,7 +319,7 @@ static ssize_t ar_read(struct file *file
 			ar_outl(0x8080, M32R_DMAEN_PORTL);	// enable DMA0
 			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000)) ;
 			ar_outl(0x80000, M32R_DMAEN_PORTL);	// disable DMA0
-			ar_outl(0x8000, M32R_DMAEDET_PORTL);// clear status
+			ar_outl(0x8000, M32R_DMAEDET_PORTL);	// clear status
 			ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 		}
 	} else {
@@ -329,7 +329,7 @@ static ssize_t ar_read(struct file *file
 			ar_outl(0x8080, M32R_DMAEN_PORTL);	// enable DMA0
 			while (!(ar_inl(M32R_DMAEDET_PORTL) & 0x8000)) ;
 			ar_outl(0x80000, M32R_DMAEN_PORTL);	// disable DMA0
-			ar_outl(0x8000, M32R_DMAEDET_PORTL);// clear status
+			ar_outl(0x8000, M32R_DMAEDET_PORTL);	// clear status
 			ar_outl(0xa0861300, M32R_DMA0CR0_PORTL);
 		}
 	}
@@ -530,13 +530,13 @@ static void ar_interrupt(int irq, void *
 	unsigned int line_number;
 	unsigned int arvcr1;
 
-	line_count = ar_inl(ARVHCOUNT);		// line number
+	line_count = ar_inl(ARVHCOUNT);			// line number
 	if (ar->mode == AR_MODE_INTERLACE && ar->size == AR_SIZE_VGA) {
 		/* operations for interlace mode */
-		if ( line_count < (AR_HEIGHT_VGA/2) ) 	/* even line */
+		if ( line_count < (AR_HEIGHT_VGA/2) )	/* even line */
 			line_number = (line_count << 1);
 		else 		  			/* odd line */
- 			line_number =
+			line_number =
 			(((line_count - (AR_HEIGHT_VGA/2)) << 1) + 1);
 	} else {
 		line_number = line_count;
@@ -552,7 +552,7 @@ static void ar_interrupt(int irq, void *
 		memcpy(ar->frame[0], ar->line_buff, ar->line_bytes);
 		//ar_outl(0xa1861300, M32R_DMA0CR0_PORTL);
 		ar_outl(0x8080, M32R_DMAEN_PORTL);		// enable DMA0
-		ar->start_capture = 1;			// during capture
+		ar->start_capture = 1;				// during capture
 		return;
 	}
 
@@ -614,7 +614,7 @@ static int ar_initialize(struct video_de
 	if (ar->mode == AR_MODE_NORMAL) cr |= ARVCR1_NORMAL;
 	ar_outl(cr, ARVCR1);
 
-  	/*
+	/*
 	 * Initialize IIC so that CPU can communicate with AR LSI,
 	 * and send boot commands to AR LSI.
 	 */
@@ -681,7 +681,7 @@ static int ar_initialize(struct video_de
 	iic(3,0x78,0x49,0x05,0x84);	// f(Lo)
 	iic(3,0x78,0x49,0x06,0x04);	// e(Hi)
 	iic(3,0x78,0x49,0x07,0x04);	// e(Hi)
-	iic(2,0x78,0x48,0x01,0x00);     // on=1 off=0
+	iic(2,0x78,0x48,0x01,0x00);	// on=1 off=0
 #else
 	iic(3,0x78,0x49,0x00,0x95);	// a
 	iic(3,0x78,0x49,0x01,0x96);	// b
@@ -691,7 +691,7 @@ static int ar_initialize(struct video_de
 	iic(3,0x78,0x49,0x05,0xa4);	// f(Lo)
 	iic(3,0x78,0x49,0x06,0x04);	// e(Hi)
 	iic(3,0x78,0x49,0x07,0x04);	// e(Hi)
-	iic(2,0x78,0x48,0x01,0x00);     // on=1 off=0
+	iic(2,0x78,0x48,0x01,0x00);	// on=1 off=0
 #endif
 
 	printk(".");
@@ -815,7 +815,7 @@ static int __init ar_init(void)
 	 * so register video device as a frame grabber type.
 	 * device is named "video[0-64]".
 	 * video_register_device() initializes h/w using ar_initialize().
- 	 */
+	 */
 	if (video_register_device(ar->vdev, VFL_TYPE_GRABBER, video_nr)!=0) {
 		/* return -1, -ENFILE(full) or others */
 		printk("arv: register video (Colour AR) failed.\n");

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

