Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVIDXwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVIDXwM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVIDXwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:52:10 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:33191 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932116AbVIDXwI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:52:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rbVJZfL3L10V9/EUhJIUtOXu3eX53EN6NkosYg5bIx5qPb+q6E+gbfbsbIAMPZjE4rWDBmroGl5BAbfxOMoxCEyIDVC5GMSzJnFhtBA7FpIsiar9N7kRbyEdF0orQJtKhU4i9Q6jztSKPGGSYXuZo7v/pdSu/7aMhBlvuYc7TPk=
Message-ID: <29495f1d050904165221291c1d@mail.gmail.com>
Date: Sun, 4 Sep 2005 16:52:08 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: nish.aravamudan@gmail.com
To: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [DVB patch 23/54] usb: add TwinhanDTV StarBox support
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Patrick Boettcher <pb@linuxtv.org>
In-Reply-To: <20050904232324.846856000@abc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050904232259.777473000@abc> <20050904232324.846856000@abc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Johannes Stezenbach <js@linuxtv.org> wrote:
> From: Patrick Boettcher <pb@linuxtv.org>
> 
> Add driver for the TwinhanDTV StarBox and clones.
> 
> Thanks to Ralph Metzler for his initial work on this box and thanks to Twinhan
> for their support.

<snip>

> --- /dev/null   1970-01-01 00:00:00.000000000 +0000
> +++ linux-2.6.13-git4/drivers/media/dvb/dvb-usb/vp702x-fe.c     2005-09-04 22:28:15.000000000 +0200

<snip>

> +static int vp702x_fe_refresh_state(struct vp702x_fe_state *st)
> +{
> +       u8 buf[10];
> +       if (time_after(jiffies,st->next_status_check)) {
> +               vp702x_usb_in_op(st->d,READ_STATUS,0,0,buf,10);
> +
> +               st->lock = buf[4];
> +               vp702x_usb_in_op(st->d,READ_TUNER_REG_REQ,0x11,0,&st->snr,1);
> +               vp702x_usb_in_op(st->d,READ_TUNER_REG_REQ,0x15,0,&st->sig,1);
> +
> +               st->next_status_check = jiffies + (st->status_check_interval*HZ)/1000;

Should this be

st->next_status_check = jiffies + msecs_to_jiffies(st->status_check_interval);

?

Thanks,
Nish
