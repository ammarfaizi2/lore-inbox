Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUHMTdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUHMTdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUHMTae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:30:34 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:51692 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S267325AbUHMT1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:27:33 -0400
Message-ID: <411D15F1.1090005@ttnet.net.tr>
Date: Fri, 13 Aug 2004 22:26:41 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4] pm3fb and kaweth missing casts
Content-Type: multipart/mixed;
	boundary="------------020307050506070802080600"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020307050506070802080600
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

$SUBJECT


--------------020307050506070802080600
Content-Type: text/plain;
	name="kawetch-cast.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="kawetch-cast.diff"

--- 27rc5~/drivers/usb/kaweth.c	2003-08-25 14:44:42.000000000 +0300
+++ 27rc5/drivers/usb/kaweth.c	2004-08-07 14:18:04.000000000 +0300
@@ -735,7 +735,7 @@
 		}
 	}
 
-	private_header = __skb_push(skb, 2);
+	private_header = (u16 *)__skb_push(skb, 2);
 	*private_header = cpu_to_le16(skb->len-2);
 	kaweth->tx_skb = skb;
 

--------------020307050506070802080600
Content-Type: text/plain;
	name="pm3fb.c-cast.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="pm3fb.c-cast.diff"

--- 27rc5~/drivers/video/pm3fb.c	2004-04-14 16:05:38.000000000 +0300
+++ 27rc5/drivers/video/pm3fb.c	2004-08-07 14:09:39.000000000 +0300
@@ -3838,11 +3838,9 @@
 				    (unsigned char *) -1) {
 					pm3fb_unmapIO(l_fb_info);
 #if (defined KERNEL_2_4) || (defined KERNEL_2_5)
-					release_mem_region(l_fb_info->p_fb,
-							   l_fb_info->
-							   fb_size);
-					release_mem_region(l_fb_info->
-							   pIOBase,
+					release_mem_region((u_long)l_fb_info->p_fb,
+							   l_fb_info->fb_size);
+					release_mem_region((u_long)l_fb_info->pIOBase,
 							   PM3_REGS_SIZE);
 #endif /* KERNEL_2_4 or KERNEL_2_5 */
 				}

--------------020307050506070802080600--
