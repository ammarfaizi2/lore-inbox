Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272342AbTHIMkT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 08:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272356AbTHIMkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 08:40:19 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:33289 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S272342AbTHIMkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 08:40:12 -0400
Date: Sat, 9 Aug 2003 22:39:09 +1000
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-usb-devel@lists.sourceforge.net
Subject: Re: [PATCH] Fix usb interface change in hisax st5481_*
Message-ID: <20030809123909.GA26782@gondor.apana.org.au>
References: <20030809122539.GA23890@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <20030809122539.GA23890@gondor.apana.org.au>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 09, 2003 at 10:25:39PM +1000, herbert wrote:
> 
> This patch makes the HISAX ST5481 driver build again with 2.6.0-test3
> where the usb_host_config structure has changed.

And here is the patch.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=q

Index: kernel-source-2.5/drivers/isdn/hisax/st5481_b.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/isdn/hisax/st5481_b.c,v
retrieving revision 1.1.1.5
diff -u -r1.1.1.5 st5481_b.c
--- kernel-source-2.5/drivers/isdn/hisax/st5481_b.c	9 Aug 2003 08:11:56 -0000	1.1.1.5
+++ kernel-source-2.5/drivers/isdn/hisax/st5481_b.c	9 Aug 2003 12:20:58 -0000
@@ -254,7 +254,7 @@
 
 	DBG(4,"");
 
-	altsetting = &(dev->config->interface[0].altsetting[3]);
+	altsetting = &(dev->config->interface[0]->altsetting[3]);
 
 	// Allocate URBs and buffers for the B channel out
 	endpoint = &altsetting->endpoint[EP_B1_OUT - 1 + bcs->channel * 2];
Index: kernel-source-2.5/drivers/isdn/hisax/st5481_d.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/isdn/hisax/st5481_d.c,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 st5481_d.c
--- kernel-source-2.5/drivers/isdn/hisax/st5481_d.c	3 Jan 2003 01:36:52 -0000	1.1.1.2
+++ kernel-source-2.5/drivers/isdn/hisax/st5481_d.c	9 Aug 2003 12:20:13 -0000
@@ -658,7 +658,7 @@
 
 	DBG(2,"");
 
-	altsetting = &(dev->config->interface[0].altsetting[3]);
+	altsetting = &(dev->config->interface[0]->altsetting[3]);
 
 	// Allocate URBs and buffers for the D channel out
 	endpoint = &altsetting->endpoint[EP_D_OUT-1];
Index: kernel-source-2.5/drivers/isdn/hisax/st5481_usb.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/isdn/hisax/st5481_usb.c,v
retrieving revision 1.1.1.4
diff -u -r1.1.1.4 st5481_usb.c
--- kernel-source-2.5/drivers/isdn/hisax/st5481_usb.c	11 Jan 2003 04:58:06 -0000	1.1.1.4
+++ kernel-source-2.5/drivers/isdn/hisax/st5481_usb.c	9 Aug 2003 12:19:09 -0000
@@ -258,7 +258,7 @@
 	}
 
 	
-	altsetting = &(dev->config->interface[0].altsetting[3]);	
+	altsetting = &(dev->config->interface[0]->altsetting[3]);	
 
 	// Check if the config is sane
 	if ( altsetting->desc.bNumEndpoints != 7 ) {

--7JfCtLOvnd9MIVvH--
