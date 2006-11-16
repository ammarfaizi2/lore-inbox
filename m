Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424181AbWKPPjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424181AbWKPPjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424184AbWKPPjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:39:00 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:11795 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1424181AbWKPPi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:38:59 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Luc Saillard <luc@saillard.org>, Greg KH <greg@kroah.com>
Subject: [PATCH] usb: pwc-if loop fix
Date: Thu, 16 Nov 2006 16:38:57 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161639.05830.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	We should free urbs starting at [i-1] not [i].

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

drivers/media/video/pwc/pwc-if.c |    3 +--
1 file changed, 1 insertion(+), 2 deletions(-)

diff -upr linux-2.6.19-rc5-mm2-a/drivers/media/video/pwc/pwc-if.c linux-2.6.19-rc5-mm2-b/drivers/media/video/pwc/pwc-if.c
--- linux-2.6.19-rc5-mm2-a/drivers/media/video/pwc/pwc-if.c	2006-11-15 11:24:20.000000000 +0100
+++ linux-2.6.19-rc5-mm2-b/drivers/media/video/pwc/pwc-if.c	2006-11-15 21:08:07.000000000 +0100
@@ -866,10 +866,9 @@ int pwc_isoc_init(struct pwc_device *pde
 	}
 	if (ret) {
 		/* De-allocate in reverse order */
-		while (i >= 0) {
+		while (i--) {
 			usb_free_urb(pdev->sbuf[i].urb);
 			pdev->sbuf[i].urb = NULL;
-			i--;
 		}
 		return ret;
 	}

-- 
Regards,

	Mariusz Kozlowski
