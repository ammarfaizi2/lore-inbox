Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423809AbWKHWZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423809AbWKHWZd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423810AbWKHWZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:25:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58031 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423723AbWKHWZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:25:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UuIs5+h8wkOWAShptvVq+yIcacFksRx3MIBRM2Q/Mk586Zb3IERl/MFP75OYBrA3UeP/1kWXN9k+IbxkRXXxodEzcPTt4aiOcuDYJUkz/JTZFrgrXZ9xtLdbkl8ObYxdbyjUNCxevZ/4eEc3YH8qcaBhWI1CBiwvTWMQWHvPbgU=
Date: Thu, 9 Nov 2006 01:25:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [PATCH] flexcop-usb.c: fix "&& 0xff" typos and ...
Message-ID: <20061108222527.GF4972@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.. fix debug printk. Why, oh why, one would want to do

	(u16 & 0xff) << 8

and print it with %02x format?

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/media/dvb/b2c2/flexcop-usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb/b2c2/flexcop-usb.c
+++ b/drivers/media/dvb/b2c2/flexcop-usb.c
@@ -246,7 +246,7 @@ static int flexcop_usb_i2c_req(struct fl
 	wIndex = (chipaddr << 8 ) | addr;
 
 	deb_i2c("i2c %2d: %02x %02x %02x %02x %02x %02x\n",func,request_type,req,
-			((wValue && 0xff) << 8),wValue >> 8,((wIndex && 0xff) << 8),wIndex >> 8);
+		wValue & 0xff, wValue >> 8, wIndex & 0xff, wIndex >> 8);
 
 	len = usb_control_msg(fc_usb->udev,pipe,
 			req,

