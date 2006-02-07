Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWBGUsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWBGUsw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 15:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWBGUsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 15:48:52 -0500
Received: from ffm.saftware.de ([217.20.127.95]:14352 "EHLO ffm.saftware.de")
	by vger.kernel.org with ESMTP id S932110AbWBGUsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 15:48:51 -0500
Subject: Re: [v4l-dvb-maintainer] [PATCH 07/16] Fixed i2c return value,
	conversion mdelay to msleep
From: Andreas Oberritter <obi@linuxtv.org>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>
In-Reply-To: <20060207153331.PS65523100007@infradead.org>
References: <20060207153248.PS50860900000@infradead.org>
	 <20060207153331.PS65523100007@infradead.org>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 21:52:04 +0100
Message-Id: <1139345524.9499.3.camel@ip6-localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-02-07 at 13:33 -0200, mchehab@infradead.org wrote:
> @@ -165,6 +168,9 @@ int em28xx_read_reg_req(struct em28xx *d
>  	u8 val;
>  	int ret;
>  
> +	if (dev->state & DEV_DISCONNECTED)
> +		return(-ENODEV);

This looks like return was a function and is very uncommon for kernel
coding style.

> +
>  	em28xx_regdbg("req=%02x, reg=%02x:", req, reg);
>  
>  	ret = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0), req,
> @@ -195,7 +201,12 @@ int em28xx_write_regs_req(struct em28xx 
>  	int ret;
>  
>  	/*usb_control_msg seems to expect a kmalloced buffer */
> -	unsigned char *bufs = kmalloc(len, GFP_KERNEL);
> +	unsigned char *bufs;
> +
> +	if (dev->state & DEV_DISCONNECTED)
> +		return(-ENODEV);

Same as obove.

> +
> +	bufs = kmalloc(len, GFP_KERNEL);

I think you should add this:

          if (bufs == NULL)
                  return -ENOMEM;

Best regards,
Andreas

