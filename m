Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269394AbUIIJmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269394AbUIIJmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269396AbUIIJmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:42:11 -0400
Received: from postfix3-1.free.fr ([213.228.0.44]:54461 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S269394AbUIIJmF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:42:05 -0400
Message-ID: <4140256C.5090803@free.fr>
Date: Thu, 09 Sep 2004 11:42:04 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm4 badness in rtl8150.c ethernet driver : fixed
References: <413DB68C.7030508@free.fr>
In-Reply-To: <413DB68C.7030508@free.fr>
Content-Type: multipart/mixed;
 boundary="------------020207070807000906080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020207070807000906080902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eric Valette wrote:


> I tried your new test kernel and it broke my USB/Ethernet adapter. 
> Adapter is detected, ifup works but no ping using IP adress on a point 
> to point ethernet network. I saw the file change in the diff and 
> probably something broke (either bogus endianness fixes or changed reset 
> code data or ...). Bitkeeper being unreachable I can hardly follow what 
> incremental broke it but, for sure, it is broken (FYI 2.6.9-rc1-mm2 works).

Andrew,

Here is a small patch that makes the card functionnal again. I've 
forwarded the patch to driver author also.

Signed off by <eric.valette@free.fr>

Move value used to reset the card back to its previous definition.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr




--------------020207070807000906080902
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

--------------020207070807000906080902--
