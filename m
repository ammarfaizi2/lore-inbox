Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRCBD4x>; Thu, 1 Mar 2001 22:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130301AbRCBD4n>; Thu, 1 Mar 2001 22:56:43 -0500
Received: from nakyup.mizi.com ([203.239.30.70]:53895 "EHLO nakyup.mizi.com")
	by vger.kernel.org with ESMTP id <S130198AbRCBD42>;
	Thu, 1 Mar 2001 22:56:28 -0500
Date: Fri, 2 Mar 2001 12:56:09 +0900
From: "Young-Ho. Cha" <ganadist@nakyup.mizi.com>
To: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [fix]some radeon build problem
Message-ID: <20010302125609.A19296@nakyup.mizi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have found some problem in building kernel with radeonfb 16bpp support at 2.4.2-ac8.

here is patch. 

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.2-ac8-radeonfb.patch"

--- linux/drivers/video/radeonfb.c.orig	Fri Mar  2 12:29:15 2001
+++ linux/drivers/video/radeonfb.c	Fri Mar  2 12:29:28 2001
@@ -845,9 +845,11 @@
 
 	rinfo->depth = disp->var.bits_per_pixel;	
         switch (disp->var.bits_per_pixel) {
+#ifdef FBCON_HAS_CFB8
                 case 8:
                         disp->dispsw = &fbcon_cfb8;
                         break;
+#endif			
 #ifdef FBCON_HAS_CFB16
                 case 16:
                         disp->dispsw = &fbcon_cfb16;
@@ -1322,8 +1322,8 @@
   		       		i = (regno << 8) | regno;
             			rinfo->con_cmap.cfb32[regno] = (i << 16) | i;
 		        	break;
-#endif
         		}
+#endif
 		}
         }
 #endif

--HlL+5n6rz5pIUxbD--
