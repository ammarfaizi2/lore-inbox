Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbVFUGTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVFUGTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 02:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVFUGTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:19:34 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:44161 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261397AbVFUGMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:12:13 -0400
Message-ID: <42B7AFAF.7000402@brturbo.com.br>
Date: Tue, 21 Jun 2005 03:11:59 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: "Damien \"tuX\" THEBAULT" <damien.thebault@laposte.net>,
       LKML <linux-kernel@vger.kernel.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Tuner module is too verbose
References: <1119289192.22634.24.camel@tux.rezid.org>
In-Reply-To: <1119289192.22634.24.camel@tux.rezid.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damien,

Damien "tuX" THEBAULT wrote:

>I upgraded from my previous kernel (2.6.10-mm1) to 2.6.12-mm1 today.
>
>I have a problem with the "tuner" module : it is printing too many
>messages into the syslog :
>
>"tuner 2-0060: Cmd VIDIOCSCHAN accepted to TV"
>or
>"tuner 2-0060: Cmd VIDIOCGAUDIO accepted to radio"
>
>(about -			  return 0; } else \
>+	26 messages per second, but only when watching TV)
>  
>
    This thing is really strange... 26 msg/sec means a tuner change for
every two video frames! More strange is that tuner is switching from
radio mode to video mode. It is also generating 26 I2C calls to tuner by
second. Maybe you are experiencing some performance troubles with this
application bad behavior.

    Maybe there's a radio application that is competing with your TV app.

>I looked into the module's source code and I was able to disable those
>messages with a little modification (patch included).
>(maybe the same modification is needed when CONFIG_TUNER_MULTI_I2C is
>defined)
>
>I don't know if this is the good way to do this, but I didn't find any
>other way to solve my problem...
>
>PS : I'm not subscribed to the list so please CC me.
>
>--- ./drivers/media/video/tuner-core.old.c	2005-06-20 18:53:12.864742688
>+0200
>+++ ./drivers/media/video/tuner-core.c	2005-06-20 19:24:42.382492328
>+0200
>@@ -201,7 +201,7 @@
> 
> #ifdef CONFIG_TUNER_MULTI_I2C
> #define CHECK_ADDR(tp,cmd,tun)	if (client->addr!=tp) { \
>-			  return 0; } else \
>+			  return 0; } else if (tuner_debug!=0) \
> 			  tuner_info ("Cmd %s accepted to "tun"\n",cmd);
> #define CHECK_MODE(cmd)	if (t->mode == V4L2_TUNER_RADIO) { \
> 		 	CHECK_ADDR(radio_tuner,cmd,"radio") } else \
>
>  
>
    Your patch will help aliviating the verbose problem, but maybe you
should check if every radio apps are turned off before calling video
app, since they share the same resources.

Mauro Chehab.
