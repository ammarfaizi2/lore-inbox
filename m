Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUIKReS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUIKReS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268259AbUIKRbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:31:38 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:27596 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S268216AbUIKR3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:29:34 -0400
Message-ID: <414335FB.8050203@free.fr>
Date: Sat, 11 Sep 2004 19:29:31 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       petkan@nucleusys.com
Subject: rtl8150.c ethernet driver : usb_unlink_urb ->usb_kill_urb
References: <413DB68C.7030508@free.fr> <4140256C.5090803@free.fr> <20040909152454.14f7ebc9.akpm@osdl.org> <20040909223605.GA17655@kroah.com>
In-Reply-To: <20040909223605.GA17655@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------030201030706040406060500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030201030706040406060500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


> I'll defer to Petkan as to what to do about this, as he sent me that
> patch for a good reason I imagine :)

While we are looking at this driver, here is a way to avoid one full 
page of annoying messages at shutdown/module unload.

Signed-off-by: Eric Valette <Eric.Valette@free.fr>

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------030201030706040406060500
Content-Type: text/x-csrc;
 name="patch_fix_rtl8150.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_fix_rtl8150.c"

--- linux/drivers/usb/net/rtl8150.c-2.6.9-rc1-mm4.orig	2004-09-09 11:15:11.000000000 +0200
+++ linux/drivers/usb/net/rtl8150.c	2004-09-09 11:15:46.000000000 +0200
@@ -341,7 +341,7 @@
 
 static int rtl8150_reset(rtl8150_t * dev)
 {
-	u8 data = 0x11;
+	u8 data = 0x10;
 	int i = HZ;
 
 	set_registers(dev, CR, 1, &data);

--------------030201030706040406060500--
