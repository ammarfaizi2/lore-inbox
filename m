Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273506AbRIQHT3>; Mon, 17 Sep 2001 03:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273507AbRIQHTS>; Mon, 17 Sep 2001 03:19:18 -0400
Received: from hh-hgfff.csh.uiuc.edu ([128.174.164.150]:24467 "EHLO
	somewhere.fscked.org") by vger.kernel.org with ESMTP
	id <S273506AbRIQHTH>; Mon, 17 Sep 2001 03:19:07 -0400
Date: Mon, 17 Sep 2001 02:24:24 -0500
From: Mike Perry <mikepery@fscked.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: PCnet/HOME media type
Message-ID: <20010917022424.A4282@fscked.org>
Mail-Followup-To: Mike Perry <mikepery@fscked.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I recently had the misfortune of having to use a one of those
PCnet/HOME RJ11 networking devices, and I noticed that the pcnet32
driver in 2.4.9 wasn't setting the media type for that device.
(Actually, it appeared to be moved within an #if 0, so all I really had
to do was move it back out). For some reason the default type on my
device was to use 10BaseT (0x8000), and not the HomePNA (0x8001).

Also, the tech docs for the PCnet/Home say it uses a 79c971 core, so I
was wondering if the flags for the 79c971 should be set for it as well.
Since it worked for me either way, I just left the new flags commented
in this patch.

--
Mike Perry
Minister of General Mayhem
fscked.org enterprises, inc

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pcnet.patch"

--- linux.orig/drivers/net/pcnet32.c	Mon Sep 17 01:49:58 2001
+++ linux/drivers/net/pcnet32.c	Mon Sep 17 01:56:21 2001
@@ -570,7 +570,10 @@
 	break;
     case 0x2626:
 	chipname = "PCnet/Home 79C978"; /* PCI */
-	fdx = 1;
+	/* We are the same as the 79c971, but these flags don't make
+	 * a difference either way as far as it working, so I left them 
+	 * off */
+	fdx = 1; /* mii = 1; fset = 1; ltint = 1; */
 	/* 
 	 * This is based on specs published at www.amd.com.  This section
 	 * assumes that a card with a 79C978 wants to go into 1Mb HomePNA
@@ -583,9 +586,9 @@
 #if 0
 	if (pcnet32_debug > 2)
 	    printk(KERN_DEBUG "pcnet32: pcnet32 media value %#x.\n",  media);
-	media &= ~3;
-	media |= 1;
 #endif
+	media &= ~3;
+	media |= 1; 
 	if (pcnet32_debug > 2)
 	    printk(KERN_DEBUG "pcnet32: pcnet32 media reset to %#x.\n",  media);
 	a->write_bcr (ioaddr, 49, media);

--OgqxwSJOaUobr8KG--
