Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754549AbWKMMXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754549AbWKMMXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 07:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754554AbWKMMXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 07:23:38 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:15313 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1754549AbWKMMXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 07:23:20 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Alexey Dobriyan <adobriyan@gmail.com>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 8/8] V4L/DVB (4818): Flexcop-usb: fix debug printk
Date: Mon, 13 Nov 2006 10:18:44 -0200
Message-id: <20061113121844.PS6450200008@infradead.org>
In-Reply-To: <20061113121504.PS7687690000@infradead.org>
References: <20061113121504.PS7687690000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Alexey Dobriyan <adobriyan@gmail.com>

.. fix debug printk. Why, oh why, one would want to do
	(u16 & 0xff) << 8
and print it with %02x format?
Acked-by: Patrick Boettcher <pb@linuxtv.org>

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/dvb/b2c2/flexcop-usb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/dvb/b2c2/flexcop-usb.c b/drivers/media/dvb/b2c2/flexcop-usb.c
index 2853ea1..87fb75f 100644
--- a/drivers/media/dvb/b2c2/flexcop-usb.c
+++ b/drivers/media/dvb/b2c2/flexcop-usb.c
@@ -246,7 +246,7 @@ static int flexcop_usb_i2c_req(struct fl
 	wIndex = (chipaddr << 8 ) | addr;
 
 	deb_i2c("i2c %2d: %02x %02x %02x %02x %02x %02x\n",func,request_type,req,
-			((wValue && 0xff) << 8),wValue >> 8,((wIndex && 0xff) << 8),wIndex >> 8);
+		wValue & 0xff, wValue >> 8, wIndex & 0xff, wIndex >> 8);
 
 	len = usb_control_msg(fc_usb->udev,pipe,
 			req,

