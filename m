Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTLVUkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264443AbTLVUkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:40:17 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:24256 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264429AbTLVUkK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:40:10 -0500
Message-ID: <3FE7569D.7030501@convergence.de>
Date: Mon, 22 Dec 2003 21:39:57 +0100
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.4] change two annoying messages from framebuffer drivers
References: <3FD9BB4B.6040900@convergence.de> <Pine.GSO.4.58.0312151109460.16964@waterleaf.sonytel.be> <Pine.LNX.4.58L.0312181704310.23845@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0312181704310.23845@logos.cnet>
Content-Type: multipart/mixed;
 boundary="------------060308040403080509090302"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060308040403080509090302
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcelo,

On 18.12.2003 20:05, Marcelo Tosatti schrieb:
> 
> On Mon, 15 Dec 2003, Geert Uytterhoeven wrote:
> 
> 
>>On Fri, 12 Dec 2003, Michael Hunold wrote:
>>
>>>Two framebuffer drivers (clgenfb.c and hgafb.c), however, use KERN_ERR
>>>to say that their particular card has *not* been found which is very
>>>annoying.
>>>
>>>Especially the clgenfb.c driver simply says on bootup:
>>> >  Couldn't find PCI device
>>>which can really confuse newbie users.
>>>
>>>The appended patch replaces two KERN_ERR with KERN_INFO and additionally
>>>makes the clgen.c message more descriptive.
>>>
>>>Please apply, thanks!
>>
>>Patch looks OK to me, except that I would print `clgenfb' instead of `clgen'.
> 
> 
> That looks sane.
> 
> Can you change it Michael?

Attached is an updated patch -- sorry for the long delay.

I'll create a separate patch for 2.6 and sent it to Linus/Andrew.

CU
Michael.

--------------060308040403080509090302
Content-Type: text/plain;
 name="video-fb-shutup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="video-fb-shutup.diff"

diff -ur xx-linux-2.4.22/drivers/video/clgenfb.c xx-linux-2.4.22.p/drivers/video/clgenfb.c
--- xx-linux-2.4.22/drivers/video/clgenfb.c	2003-06-13 16:51:37.000000000 +0200
+++ xx-linux-2.4.22.p/drivers/video/clgenfb.c	2003-12-12 13:48:34.000000000 +0100
@@ -2547,7 +2547,7 @@
 
 	pdev = clgen_pci_dev_get (btype);
 	if (!pdev) {
-		printk (KERN_ERR " Couldn't find PCI device\n");
+		printk (KERN_INFO "clgenfb: couldn't find Cirrus Logic PCI device\n");
 		DPRINTK ("EXIT, returning 1\n");
 		return 1;
 	}
diff -ur xx-linux-2.4.22/drivers/video/hgafb.c xx-linux-2.4.22.p/drivers/video/hgafb.c
--- xx-linux-2.4.22/drivers/video/hgafb.c	2001-11-12 18:46:25.000000000 +0100
+++ xx-linux-2.4.22.p/drivers/video/hgafb.c	2003-12-12 13:47:01.000000000 +0100
@@ -704,7 +704,7 @@
 int __init hgafb_init(void)
 {
 	if (! hga_card_detect()) {
-		printk(KERN_ERR "hgafb: HGA card not detected.\n");
+		printk(KERN_INFO "hgafb: HGA card not detected.\n");
 		return -EINVAL;
 	}
 

--------------060308040403080509090302--
