Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTAILQG>; Thu, 9 Jan 2003 06:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTAILQF>; Thu, 9 Jan 2003 06:16:05 -0500
Received: from CPE-203-51-25-222.nsw.bigpond.net.au ([203.51.25.222]:20988
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S265637AbTAILQD>; Thu, 9 Jan 2003 06:16:03 -0500
Message-ID: <3E1D5BF9.D537AA23@eyal.emu.id.au>
Date: Thu, 09 Jan 2003 22:24:41 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre2-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2 - some trivial patches
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------06765D97BCF43B246B7B0FB9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------06765D97BCF43B246B7B0FB9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

A few small patches that I needed to finish a build on Debian 3.0.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
--------------06765D97BCF43B246B7B0FB9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-ac2-ehci-hcd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-ac2-ehci-hcd.patch"

343c343
< 			ehci_warn (ehci, "illegal capability!\n");
---
> 			ehci_warn (ehci, "illegal capability!\n", "");
416c416
< 			ehci_info (ehci, "enabled 64bit PCI DMA\n");
---
> 			ehci_info (ehci, "enabled 64bit PCI DMA\n", "");
501c501
< 		ehci_err (ehci, "stopped in_interrupt!\n");
---
> 		ehci_err (ehci, "stopped in_interrupt!\n", "");
685c685
< 		ehci_err (ehci, "fatal error\n");
---
> 		ehci_err (ehci, "fatal error\n", "");

--------------06765D97BCF43B246B7B0FB9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-ac2-sbp2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-ac2-sbp2.patch"

--- linux/drivers/ieee1394/sbp2.c.orig	Thu Dec 19 10:22:33 2002
+++ linux/drivers/ieee1394/sbp2.c	Thu Dec 19 10:23:17 2002
@@ -1511,7 +1511,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_write(struct hpsb_host *host, int nodeid, int destid, quadlet_t *data,
-                                     u64 addr, unsigned int length)
+                                     u64 addr, unsigned int length, u16 flags)
 {
 
         /*
@@ -1527,7 +1527,7 @@
  * physical dma in hardware). Mostly just here for debugging...
  */
 static int sbp2_handle_physdma_read(struct hpsb_host *host, int nodeid, quadlet_t *data,
-                                    u64 addr, unsigned int length)
+                                    u64 addr, unsigned int length, u16 flags)
 {
 
         /*

--------------06765D97BCF43B246B7B0FB9
Content-Type: text/plain; charset=us-ascii;
 name="2.4.21-pre3-ac2-via82cxxx_audio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.21-pre3-ac2-via82cxxx_audio.patch"

--- linux/drivers/sound/via82cxxx_audio.c.orig	Thu Jan  9 21:51:00 2003
+++ linux/drivers/sound/via82cxxx_audio.c	Thu Jan  9 21:51:14 2003
@@ -1918,6 +1918,7 @@
 static void via_new_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct via_info *card = dev_id;
+	u32 status32;
 
 	/* to minimize interrupt sharing costs, we use the SGD status
 	 * shadow register to check the status of all inputs and

--------------06765D97BCF43B246B7B0FB9--

