Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbTEaROb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 13:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTEaROb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 13:14:31 -0400
Received: from smtp4.poczta.onet.pl ([213.180.130.28]:38029 "EHLO
	smtp4.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S264542AbTEaRO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 13:14:28 -0400
Message-ID: <3ED8E682.5020506@poczta.onet.pl>
Date: Sat, 31 May 2003 19:29:38 +0200
From: Gutko <gutko@poczta.onet.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.4) Gecko/20030529
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.21rc6-ac1 Nforce2 AGP+ATI FireGL v2.9.12=hard lock
Content-Type: multipart/mixed;
 boundary="------------040704010700070905010506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040704010700070905010506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,
Just compiled 2.4.21rc6-ac1 with Nforce2 AGP as module.
Then tried to install Ati FGLRX 2.9.12 from
http://www.schneider-digital.de/html/download_ati.html
http://www.schneider-digital.de/download/ati/glx1_linux_X4.3.zip
because Ati didn't released XFree 4.3 driver on their www yet.

During install of this rpm i get something like this:
"Patching drmP.h  FAILED, saving rejects to....."
This *.rej file is in attachment.
Then module loads normally. I can start X on this driver, but only in 2d.
Trying to run Tuxracer and any other 3d game hardlocks my machine. 2d 
games works ok.

Everything was OK on clean 2.4.21rc6 patched with this Nforce2 AGP patch.
http://etudiant.epita.fr:8000/~nonolk/nforce-agp.diff
but Dave Jones told me it is buggy.

My machine
Asus A7N8X-deluxe nforce2 mb
1 GB of ram
Ati Radeon 9700 128M
Agp aperature set to 128M in bios
Mandrake 9.1
XFree86  v4.3

I'll be happy to provide more info if needed :)

Gutko


--------------040704010700070905010506
Content-Type: text/plain;
 name="drmP.h.rej"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="drmP.h.rej"

***************
*** 255,263 ****
  
  				/* Macros to make printk easier */
  #define DRM_ERROR(fmt, arg...) \
- 	printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ "] *ERROR* " fmt , ##arg)
  #define DRM_MEM_ERROR(area, fmt, arg...) \
- 	printk(KERN_ERR "[" DRM_NAME ":" __FUNCTION__ ":%s] *ERROR* " fmt , \
  	       DRM(mem_stats)[area].name , ##arg)
  #define DRM_INFO(fmt, arg...)  printk(KERN_INFO "[" DRM_NAME "] " fmt , ##arg)
  
--- 255,263 ----
  
  				/* Macros to make printk easier */
  #define DRM_ERROR(fmt, arg...) \
+ 	printk(KERN_ERR "[" DRM_NAME ":%s] *ERROR* " fmt, __FUNCTION__ , ##arg)
  #define DRM_MEM_ERROR(area, fmt, arg...) \
+ 	printk(KERN_ERR "[" DRM_NAME ":%s:%s] *ERROR* " fmt, __FUNCTION__, \
  	       DRM(mem_stats)[area].name , ##arg)
  #define DRM_INFO(fmt, arg...)  printk(KERN_INFO "[" DRM_NAME "] " fmt , ##arg)
  
***************
*** 266,272 ****
  	do {								\
  		if ( DRM(flags) & DRM_FLAG_DEBUG )			\
  			printk(KERN_DEBUG				\
- 			       "[" DRM_NAME ":" __FUNCTION__ "] " fmt ,	\
  			       ##arg);					\
  	} while (0)
  #else
--- 266,272 ----
  	do {								\
  		if ( DRM(flags) & DRM_FLAG_DEBUG )			\
  			printk(KERN_DEBUG				\
+ 			       "[" DRM_NAME ":%s] " fmt, __FUNCTION__ ,  \
  			       ##arg);					\
  	} while (0)
  #else

--------------040704010700070905010506--

