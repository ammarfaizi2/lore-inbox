Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSHOA7a>; Wed, 14 Aug 2002 20:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316437AbSHOA7a>; Wed, 14 Aug 2002 20:59:30 -0400
Received: from CPE-203-51-32-20.nsw.bigpond.net.au ([203.51.32.20]:47856 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S316430AbSHOA72>; Wed, 14 Aug 2002 20:59:28 -0400
Message-ID: <3D5AFDD6.3178894D@eyal.emu.id.au>
Date: Thu, 15 Aug 2002 11:03:18 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac1
References: <200208141634.g7EGYGO29387@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------4AE8B87AF110A1B00FE726DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4AE8B87AF110A1B00FE726DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

To build it I needed the following patches:

- Makefile
	Has wrong EXTRAVERSION

- mm/swap_state.c
	Improper use of PAGE_BUG() macro

- drivers/isdn/hisax/st5481.h
	Usage of '...' in macro, not always compatible with prevailing
	versions of gcc. We all know the story though... I just disabled
	all the special macros for now

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------4AE8B87AF110A1B00FE726DB
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre2-ac1-Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre2-ac1-Makefile.patch"

--- linux/Makefile.orig	Thu Aug 15 10:30:15 2002
+++ linux/Makefile	Thu Aug 15 10:04:08 2002
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 4
 SUBLEVEL = 20
-EXTRAVERSION = -pre1-ac3
+EXTRAVERSION = -pre2-ac1
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
 

--------------4AE8B87AF110A1B00FE726DB
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre2-ac1-mm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre2-ac1-mm.patch"

--- linux/mm/swap_state.c.orig	Thu Aug 15 10:28:06 2002
+++ linux/mm/swap_state.c	Thu Aug 15 10:28:18 2002
@@ -152,7 +152,7 @@
 		BUG();
 
 	if (unlikely(!block_flushpage(page, 0)))
-		PAGE_BUG();	/* an anonymous page cannot have page->buffers set */
+		PAGE_BUG(page);	/* an anonymous page cannot have page->buffers set */
 
 	entry.val = page->index;
 

--------------4AE8B87AF110A1B00FE726DB
Content-Type: text/plain; charset=us-ascii;
 name="2.4.20-pre2-ac1-st5481.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.20-pre2-ac1-st5481.patch"

--- linux/drivers/isdn/hisax/st5481.h.orig	Thu Aug 15 10:38:11 2002
+++ linux/drivers/isdn/hisax/st5481.h	Thu Aug 15 10:39:25 2002
@@ -218,14 +218,11 @@
 
 #define L1_EVENT_COUNT (EV_TIMER3 + 1)
 
-#define ERR(format, arg...) \
-printk(KERN_ERR __FILE__ ": %s: " format "\n" , __FUNCTION__, ## arg)
+#define ERR(format, arg...) 0
 
-#define WARN(format, arg...) \
-printk(KERN_WARNING __FILE__ ": %s: " format "\n" , __FUNCTION__, ## arg)
+#define WARN(format, arg...) 0
 
-#define INFO(format, arg...) \
-printk(KERN_INFO __FILE__ ": %s: " format "\n" , __FUNCTION__, ## arg)
+#define INFO(format, arg...) 0
 
 #include "st5481_hdlc.h"
 #include "fsm.h"

--------------4AE8B87AF110A1B00FE726DB--

