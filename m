Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSE3Iv0>; Thu, 30 May 2002 04:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316512AbSE3IvZ>; Thu, 30 May 2002 04:51:25 -0400
Received: from ftp.nfas.org.sz ([196.28.7.66]:44713 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316500AbSE3IvX>; Thu, 30 May 2002 04:51:23 -0400
Date: Thu, 30 May 2002 10:23:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] resync 2.4 apicdef.h w/ 2.5
In-Reply-To: <Pine.LNX.4.44.0205301021240.17117-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0205301023150.17117-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Zwane Mwaikambo wrote:

> This patch gets 2.4 linux/include/asm-i386/apicdef.h back in sync with 
> whats in 2.5

God i hate it when that happens...

--- linux-2.4-ac/include/asm-i386/apicdef.h	Sun Aug 12 20:13:59 2001
+++ linux-2.5-dj/include/asm-i386/apicdef.h	Thu May 30 09:38:02 2002
@@ -71,6 +71,7 @@
 #define			GET_APIC_DEST_FIELD(x)	(((x)>>24)&0xFF)
 #define			SET_APIC_DEST_FIELD(x)	((x)<<24)
 #define		APIC_LVTT	0x320
+#define		APIC_LVTTHMR	0x330
 #define		APIC_LVTPC	0x340
 #define		APIC_LVT0	0x350
 #define			APIC_LVT_TIMER_BASE_MASK	(0x3<<18)
@@ -280,7 +281,16 @@
 		u32 __reserved_4[3];
 	} lvt_timer;
 
-/*330*/	struct { u32 __reserved[4]; } __reserved_15;
+/*330*/	struct { /* LVT - Thermal Sensor */
+		u32  vector		:  8,
+			delivery_mode	:  3,
+			__reserved_1	:  1,
+			delivery_status	:  1,
+			__reserved_2	:  3,
+			mask		:  1,
+			__reserved_3	: 15;
+		u32 __reserved_4[3];
+	} lvt_thermal;
 
 /*340*/	struct { /* LVT - Performance Counter */
 		u32   vector		:  8,

-- 
http://function.linuxpower.ca
		

