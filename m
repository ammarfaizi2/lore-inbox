Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755447AbWKNHC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447AbWKNHC7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 02:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbWKNHC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 02:02:59 -0500
Received: from as3.cineca.com ([130.186.84.211]:31620 "EHLO as3.cineca.com")
	by vger.kernel.org with ESMTP id S1755451AbWKNHC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 02:02:58 -0500
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: [PATCH 10/33] usb: sn9c102_core free urb cleanup
Date: Tue, 14 Nov 2006 08:02:47 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140802.47705.luca.risolia@studio.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
>
>- usb_free_urb() cleanup
>
>Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
>
>--- linux-2.6.19-rc4-orig/drivers/media/video/sn9c102/sn9c102_core.c    2006-11-06 17:07:45.000000000 +0100
>+++ linux-2.6.19-rc4/drivers/media/video/sn9c102/sn9c102_core.c 2006-11-06 19:57:35.000000000 +0100
>@@ -775,7 +775,7 @@ static int sn9c102_start_transfer(struct
>        return 0;
> 
> free_urbs:
>-       for (i = 0; (i < SN9C102_URBS) &&  cam->urb[i]; i++)
>+       for (i = 0; i < SN9C102_URBS; i++)
>                usb_free_urb(cam->urb[i]);
> 
> free_buffers:

This patch might cause usb_free_urb() to fail if not all the URBs have been
allocated successfully: in this case, the original loop stops as soon as 
cam->urb[i] == NULL (where NULL is given from the failed allocation),
while in the second loop there might be a not null cam->urb[i+n]
pointing to an URB that has already been deallocated elsewhere.

The same bug is present in PATCH 12/33.

Best regards,
Luca Risolia

