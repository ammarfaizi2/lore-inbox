Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWFTQzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWFTQzC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWFTQzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:55:02 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:63536 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751419AbWFTQzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:55:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YZbW391CYgzogrcxP5hymEQdoiLMbAKFr9y2Mmq1rOUxF/+YeQ1FMElFubygkDCgd9dwk0pDVBbm//MMnCFoAIFkUTprUaw3f3LYtyQpLGR0ZQ4JAAE/+YC9bnKie9lfK947tPxwJHJVatlctpr6h7yK5qZhupUqg5yuXtETw+8=
Message-ID: <29495f1d0606200954u3e81acb4w648d5c31e8daff3a@mail.gmail.com>
Date: Tue, 20 Jun 2006 09:54:59 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] LED: add LED heartbeat trigger
Cc: linux-kernel@vger.kernel.org, "Richard Purdie" <rpurdie@rpsys.net>,
       akpm@osdl.org
In-Reply-To: <20060621.013603.132759710.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060621.013603.132759710.anemo@mba.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> Add an LED trigger acts like a heart beat.  This can be used as a
> replacement of CONFIG_HEARTBEAT code exists in some arch's timer code.
>
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

<snip>

> new file mode 100644
> index 0000000..07ac645
> --- /dev/null
> +++ b/drivers/leds/ledtrig-heartbeat.c
> +               heartbeat_data->period = heartbeat_data->period * HZ / 100;
> +               delay = 7 * HZ / 100;

Can these and the other HZ/100 users make use of the existing
*secs_to_jiffies() methods? FYI, if HZ=250, you're getting rounding
here, not sure if it's desired.

<snip>

> +static void heartbeat_trig_activate(struct led_classdev *led_cdev)
> +{
> +       struct heartbeat_trig_data *heartbeat_data;
> +
> +       heartbeat_data = kzalloc(sizeof(*heartbeat_data), GFP_KERNEL);
> +       if (!heartbeat_data)
> +               return;
> +
> +       led_cdev->trigger_data = heartbeat_data;
> +       init_timer(&heartbeat_data->timer);
> +       heartbeat_data->timer.function = led_heartbeat_function;
> +       heartbeat_data->timer.data = (unsigned long) led_cdev;

setup_timer()? (which will call init_timer() before returning.

Thanks,
Nish
