Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKSLG2>; Mon, 19 Nov 2001 06:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKSLGT>; Mon, 19 Nov 2001 06:06:19 -0500
Received: from maila.telia.com ([194.22.194.231]:232 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S277738AbRKSLGH>;
	Mon, 19 Nov 2001 06:06:07 -0500
Message-Id: <200111191106.fAJB65a12171@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14 cpia driver IS broke
Date: Mon, 19 Nov 2001 12:05:47 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3BF89B8D.BDE2DB1F@mindspring.com>
In-Reply-To: <3BF89B8D.BDE2DB1F@mindspring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's the new parport code in 2.4.14 which breaks things.
I haven't been able to use my Webcam drivers either since 2.4.14. And after 
some research in the parport code I found that something is broken with the 
new (2.4.14) code when doing ECP transfers (maybe EPP as well).

On Mondayen den 19 November 2001 06.41, Joe wrote:
> Earlier this week I reported cpia driver not finidng the /dev/video0 as
> a bug.  I did a little research and at first I thought it was RH 7.2 or
> the linux kernel, but it is not RH it is the linux kernel.  The cpia
> driver in 2.4.14 is broke! (at least on my system)
>
> This is the driver for the webcam II parallel port module.
>
> (From 2.4.13) The output of the file /proc/cpia/video0 should show the
> following:
>
>  cat /proc/cpia/video0 |head
> read-only
> -----------------------
> V4L Driver version:       0.7.4
> CPIA Version:             1.20 (1.0)
> CPIA PnP-ID:              0553:0002:0100
> VP-Version:               1.0 0100
> system_state:             0x02
> grab_state:               0x00
> stream_state:             0x00
> fatal_error:              0x00
> Current Directory = ~
>
> but it does not, in fact in 2.4.14 it shows CPIA Version:  0.00 and
> everything else is 0 as well.
>
> I have reverted back to 2.4.13 but would like to let the maintainers
> know.  If you look at the 2.4.14 patch the code for the cpia driver has
> changed.  I am not sure if it is the cpia driver itselef or the video
> subsystem (v4l/v4l2).  If anyone knows how to contact the maintainers
> and let them know that this code is not working great.
>
> zcat /public/untarred/patch-2.4.14.gz |grep cpia |head
> diff -u --recursive --new-file v2.4.13/linux/drivers/media/video/cpia.c
> linux/drivers/media/video/cpia.c
> --- v2.4.13/linux/drivers/media/video/cpia.c Tue Oct  9 17:06:51 2001
> +++ linux/drivers/media/video/cpia.c Thu Oct 25 13:53:47 2001
> - proc_cpia_create();
> - request_module("cpia_pp");
> - request_module("cpia_usb");
>
> oh I am not on the list
> thanks
> Joe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
