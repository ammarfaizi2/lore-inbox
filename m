Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164019AbWLGXvB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164019AbWLGXvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 18:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164020AbWLGXvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 18:51:01 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3360 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164019AbWLGXvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 18:51:00 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Amit Choudhary <amit2030@gmail.com>
Subject: Re: [PATCH 2.6.19] drivers/media/video/cpia2/cpia2_usb.c: Free previously allocated memory (in array elements) if kmalloc() returns NULL.
Date: Fri, 8 Dec 2006 00:50:53 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061206211317.b996bc34.amit2030@gmail.com>
In-Reply-To: <20061206211317.b996bc34.amit2030@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612080050.53895.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> --- a/drivers/media/video/cpia2/cpia2_usb.c
> +++ b/drivers/media/video/cpia2/cpia2_usb.c
> @@ -640,6 +640,10 @@ static int submit_urbs(struct camera_dat
>  		cam->sbuf[i].data =
>  		    kmalloc(FRAMES_PER_DESC * FRAME_SIZE_PER_DESC, GFP_KERNEL);
>  		if (!cam->sbuf[i].data) {
> +			for (--i; i >= 0; i--) {
> +				kfree(cam->sbuf[i].data);
> +				cam->sbuf[i].data = NULL;
> +			}
>  			return -ENOMEM;
>  		}
>  	}

Just for future. Shorter and more readable version of your for(...) thing:

	while (i--) {
		...
	}

-- 
Regards,

	Mariusz Kozlowski
