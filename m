Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWBGVtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWBGVtR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 16:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWBGVtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 16:49:17 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:23971 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965003AbWBGVtQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 16:49:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IOTMHPulE8LBoAmKEtctw27mkaoNQovsqIkwwtR6yNQjMSFJYFyz1JwHebKRA4JWqSWnsiuFzRb9YVnuX0JiKkRJstzlVgU16i+TYCgime+er2If28BgXTMbSeVRTbAjioyD+q4NGNtnXxWHn5UEp50tP6Uub8gtd3YVqh1P2JI=
Message-ID: <d9def9db0602071349h10b4d436h34a24e71fde89b85@mail.gmail.com>
Date: Tue, 7 Feb 2006 22:49:14 +0100
From: Markus Rechberger <mrechberger@gmail.com>
To: Andreas Oberritter <obi@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] [PATCH 07/16] Fixed i2c return value, conversion mdelay to msleep
Cc: mchehab@infradead.org, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org
In-Reply-To: <1139345524.9499.3.camel@ip6-localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060207153248.PS50860900000@infradead.org>
	 <20060207153331.PS65523100007@infradead.org>
	 <1139345524.9499.3.camel@ip6-localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is actually not needed but it saves as introduced by Luca Risolia
some CPU cycles. USB Devices might come and go whenever the user feels
he has to plug or unplug it.

On 2/7/06, Andreas Oberritter <obi@linuxtv.org> wrote:
> Hi,
>
> On Tue, 2006-02-07 at 13:33 -0200, mchehab@infradead.org wrote:
> > @@ -165,6 +168,9 @@ int em28xx_read_reg_req(struct em28xx *d
> >       u8 val;
> >       int ret;
> >
> > +     if (dev->state & DEV_DISCONNECTED)
> > +             return(-ENODEV);
>
> This looks like return was a function and is very uncommon for kernel
> coding style.
>
> > +
> >       em28xx_regdbg("req=%02x, reg=%02x:", req, reg);
> >
> >       ret = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0), req,
> > @@ -195,7 +201,12 @@ int em28xx_write_regs_req(struct em28xx
> >       int ret;
> >
> >       /*usb_control_msg seems to expect a kmalloced buffer */
> > -     unsigned char *bufs = kmalloc(len, GFP_KERNEL);
> > +     unsigned char *bufs;
> > +
> > +     if (dev->state & DEV_DISCONNECTED)
> > +             return(-ENODEV);
>
> Same as obove.
>
> > +
> > +     bufs = kmalloc(len, GFP_KERNEL);
>
> I think you should add this:
>
>           if (bufs == NULL)
>                   return -ENOMEM;

right, submit a patch? :)

>
> Best regards,
> Andreas
>
>

Markus
