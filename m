Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291665AbSBNOJc>; Thu, 14 Feb 2002 09:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291666AbSBNOJN>; Thu, 14 Feb 2002 09:09:13 -0500
Received: from [195.63.194.11] ([195.63.194.11]:20753 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291665AbSBNOI5>; Thu, 14 Feb 2002 09:08:57 -0500
Message-ID: <3C6BC4E7.3070407@evision-ventures.com>
Date: Thu, 14 Feb 2002 15:08:39 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH} 2.5.5-pre1 VESA fb
In-Reply-To: <Pine.LNX.4.33.0202131434350.21395-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080909080006050100010108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080909080006050100010108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This adjusts the VESA fb driver to the new bus mapping API.
I think that this time this is providing the right replacement.... but 
who knows
what DM had in mind once again...
At least this is working on my notebook without any glitch



--------------080909080006050100010108
Content-Type: text/plain;
 name="vesafb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vesafb.patch"

diff -ur linux-2.5.4/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.4/drivers/video/vesafb.c	Mon Feb 11 02:50:09 2002
+++ linux/drivers/video/vesafb.c	Thu Feb 14 13:17:02 2002
@@ -550,7 +550,7 @@
 		ypan = pmi_setpal = 0; /* not available or some DOS TSR ... */
 
 	if (ypan || pmi_setpal) {
-		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
+		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
 		pmi_start = (void*)((char*)pmi_base + pmi_base[1]);
 		pmi_pal   = (void*)((char*)pmi_base + pmi_base[2]);
 		printk(KERN_INFO "vesafb: pmi: set display start = %p, set palette = %p\n",pmi_start,pmi_pal);

--------------080909080006050100010108--

