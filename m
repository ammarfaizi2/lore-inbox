Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSJFRba>; Sun, 6 Oct 2002 13:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJFRaZ>; Sun, 6 Oct 2002 13:30:25 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:43661 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP
	id <S261724AbSJFR3i>; Sun, 6 Oct 2002 13:29:38 -0400
Message-ID: <001601c26d5e$b7a20fc0$0a00a8c0@refresco>
From: "John Tyner" <jtyner@cs.ucr.edu>
To: "Oliver Neukum" <oliver@neukum.name>, "Greg KH" <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>
References: <001c01c26ce4$39b67f80$0a00a8c0@refresco> <m17yAhF-006i5XC@Mail.ZEDAT.FU-Berlin.DE>
Subject: Re: Vicam/3com homeconnect usb camera driver
Date: Sun, 6 Oct 2002 10:35:09 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In vicam_v4l_open:
>
> Why is only the first control message checked for errors?

The second one turns on the LED. I didn't check it because I figured the LED
actually turning on was not a big deal. Though, I suppose that if an error
occurred, that could be indicative of some other problem.

> vicam_usb_probe:
>
> __devinit ???
>
> vicam_usb_disconnect:
>
> __devexit ???

I'm not sure I see the problem here. __devinit is only defined when HOTPLUG
is not defined, which seems right to me. If there is no HOTPLUG then we can
throw away the code as soon as init is completed. ...similar argument for
__devexit. Correct me if I'm wrong.

> And you should probably kill the tasklet before you unregister the video
> device.

Makes sense.

> PS: Is that just me, or did diff produce particularly unreadable output
> this time?

Probably. The existing driver always crashed on me. I started fresh with
this one partly as a learning experience. Therefore, the diff probably isn't
very readable since it is completely removing the old driver and putting
this one in its place.

I'll re-diff after the open and __devinit/__devexit discussion gets cleared
up.

Thanks,
John

