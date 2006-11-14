Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933284AbWKNJDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbWKNJDI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 04:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933295AbWKNJDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 04:03:07 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:30985 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S933284AbWKNJDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 04:03:04 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Luca Risolia <luca.risolia@studio.unibo.it>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 10/33] usb: sn9c102_core free urb cleanup
Date: Tue, 14 Nov 2006 10:02:17 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200611140802.47705.luca.risolia@studio.unibo.it>
In-Reply-To: <200611140802.47705.luca.risolia@studio.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141002.18946.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luca,

> >- usb_free_urb() cleanup
> >
> >Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> >
> >--- linux-2.6.19-rc4-orig/drivers/media/video/sn9c102/sn9c102_core.c   
> > 2006-11-06 17:07:45.000000000 +0100 +++
> > linux-2.6.19-rc4/drivers/media/video/sn9c102/sn9c102_core.c 2006-11-06
> > 19:57:35.000000000 +0100 @@ -775,7 +775,7 @@ static int
> > sn9c102_start_transfer(struct
> >        return 0;
> >
> > free_urbs:
> >-       for (i = 0; (i < SN9C102_URBS) &&  cam->urb[i]; i++)
> >+       for (i = 0; i < SN9C102_URBS; i++)
> >                usb_free_urb(cam->urb[i]);
> >
> > free_buffers:
>
> This patch might cause usb_free_urb() to fail if not all the URBs have been
> allocated successfully: in this case, the original loop stops as soon as
> cam->urb[i] == NULL (where NULL is given from the failed allocation),
> while in the second loop there might be a not null cam->urb[i+n]
> pointing to an URB that has already been deallocated elsewhere.
>
> The same bug is present in PATCH 12/33.

Err ... you are right :/ In most drivers urb pointers get zeroed right after 
deallocation. Here they don't. So my patches might cause what you described.

Andrew can you please drop these two patches? 

usb-zc0301_core-free-urb-cleanup.patch
usb-sn9c102_core-free-urb-cleanup.patch

Thanks.

-- 
Regards,

	Mariusz Kozlowski
