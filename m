Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279394AbRKXVoV>; Sat, 24 Nov 2001 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280110AbRKXVoL>; Sat, 24 Nov 2001 16:44:11 -0500
Received: from maile.telia.com ([194.22.190.16]:2247 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S279394AbRKXVn4>;
	Sat, 24 Nov 2001 16:43:56 -0500
Message-Id: <200111242143.fAOLhsa10672@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.14/2.4.15 cpia driver IS broke.. no its parport
Date: Sat, 24 Nov 2001 22:43:11 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111230950580.24427-100000@netfinity.realnet.co.sz> <3BFF16F0.C331F0E4@mindspring.com> <3C000EE7.D69C1482@mindspring.com>
In-Reply-To: <3C000EE7.D69C1482@mindspring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Great!

I'll test it right away.
	/Jakob


On Saturdayen den 24 November 2001 22.19, Joe wrote:
> Okay I have done some more research and found out what is happening!
> After further testing I have found out that the problem with the parport
> driver is actually in the ieee1294 code.   One of the changes in the file
> drivers/parport/ieee1294_ops.c is causing problems.  (for me atleast)
>
> The code has changed from calls to parport_frob_control() to calls to
> parport_write_control ().(Fine)
>
> The problem is that in the call to acknowledge the handshake (Event 44?
> about line592) the call to parport_frob_control or parport_pc_frob_control
> as it is #defined to is called with a 0 which I think causes the code to
> call parport_pc_data_forward and the new code just calls
> parport_pc_data_reverse. I think that we may need to call the
> parport_pc_data_forward still.
>
> -               parport_write_control (port, ctl);   // new code
> +               parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0); 
> //old working code
>
> Joe
>
> > I have been doing some testing and debugging and found out that something
> > in the 2.4.14 parport driver is breaking my webcam II.  I have a patch
> > that reverts out all the changes in 2.4.14 parport driver back to 2.4.13
> > and the driver now works.  I am going to do some more testing and see if
> > I can narrow the code down.  Right now the patch is  about 700+ lines,
> > but reverts out ALL the parport changes.
> >
> > My hardward is a VIA chipset (686). It is the ABiT KT7A MB.
> >
> > What's happening is that the cpia is being recgonized, but the video
> > device is not accessable. This is in both 2.4.15 and 2.4.14, with the
> > creative WebCam II.
> >
> > In the /proc/cpia/video0 file it shows the CPIA version as 0.00 instead
> > of 1.20.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
