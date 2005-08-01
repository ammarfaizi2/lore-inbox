Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVHAXHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVHAXHX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVHAXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:05:13 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:45022 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261273AbVHAXDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:03:52 -0400
X-ME-UUID: 20050801230351623.982171C00CF0@mwinf0108.wanadoo.fr
Message-ID: <42EEAA53.6020309@ens-lyon.org>
Date: Tue, 02 Aug 2005 01:03:47 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.13-rc4-mm1] Fix smsc_ircc_init return value
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/mixed;
 boundary="------------060702050909050600000207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060702050909050600000207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Andrew,

I noticed a strange return value in smsc_ircc_init in
drivers/net/irda/smsc_ircc2.c in rc4-mm1.

When reaching the line "if (ircc_fir > 0 && ircc_sir > 0)", ret is 0.
So I don't see the point of setting it to 0 in the "else" case.
>From what I see in 2.6.12 it should probably be set to -ENODEV at
the begining of the "else" case. The attached patch does this.

Note that I didn't actually see any breakage caused by this.

Signed-off-by: Brice Goglin <Brice.Goglin@ens-lyon.org>

Regards,
Brice

--------------060702050909050600000207
Content-Type: text/x-patch;
 name="fix-smsc_ircc2_init-return-value.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-smsc_ircc2_init-return-value.patch"

--- linux-mm/drivers/net/irda/smsc-ircc2.c.old	2005-08-01 14:39:21.000000000 +0200
+++ linux-mm/drivers/net/irda/smsc-ircc2.c	2005-08-01 14:51:08.000000000 +0200
@@ -360,6 +360,7 @@ static int __init smsc_ircc_init(void)
 		if (smsc_ircc_open(ircc_fir, ircc_sir, ircc_dma, ircc_irq))
 			ret = -ENODEV;
 	} else {
+		ret = -ENODEV;
 
 		/* try user provided configuration register base address */
 		if (ircc_cfg > 0) {

--------------060702050909050600000207--

