Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVAIOYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVAIOYn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 09:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVAIOYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 09:24:43 -0500
Received: from mx.freeshell.org ([192.94.73.21]:26093 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261430AbVAIOYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 09:24:40 -0500
Date: Sun, 9 Jan 2005 14:24:20 +0000 (UTC)
From: Roey Katz <roey@sdf.lonestar.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
In-Reply-To: <200501090035.07247.dtor_core@ameritech.net>
Message-ID: <Pine.NEB.4.61.0501091421530.22271@sdf.lonestar.org>
References: <Pine.NEB.4.61.0501010814490.26191@sdf.lonestar.org>
 <d120d50005010707204463492@mail.gmail.com> <Pine.NEB.4.61.0501090513180.18441@sdf.lonestar.org>
 <200501090035.07247.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried (at the top of 2.6.9rc2-bk3/ ), "cat 
dmitrys-patch | patch -p1".  It complained of rejecting hunks and whatnot:

patching file drivers/Makefile
Hunk #1 FAILED at 21.
Hunk #2 FAILED at 43.
2 out of 2 hunks FAILED -- saving rejects to file drivers/Makefile.rej

I tried this in 2.6.10/, but got the same response.


Roey


On Sun, 9 Jan 2005, Dmitry Torokhov wrote:

> Date: Sun, 9 Jan 2005 00:35:02 -0500
> From: Dmitry Torokhov <dtor_core@ameritech.net>
> To: linux-kernel@vger.kernel.org
> Cc: Roey Katz <roey@sdf.lonestar.org>
> Subject: Re: 2.6.9 & 2.6.10 unresponsive to keyboard upon bootup
> 
> On Sunday 09 January 2005 12:14 am, Roey Katz wrote:
>> Dmitry,
>>
>> maybe I'm misunderstanding you;  how should the file look like once I
>> modify it with your changes (what does "reversing the fragment" mean
>> here)?
>>
>
> Now that I am at my box, just try applying the patch below.
>
> -- 
> Dmitry
>
> ===== drivers/Makefile 1.50 vs edited =====
> --- 1.50/drivers/Makefile	2004-12-01 01:00:21 -05:00
> +++ edited/drivers/Makefile	2005-01-09 00:33:32 -05:00
> @@ -21,9 +21,6 @@
> obj-$(CONFIG_FB_I810)           += video/i810/
> obj-$(CONFIG_FB_INTEL)          += video/intelfb/
>
> -# we also need input/serio early so serio bus is initialized by the time
> -# serial drivers start registering their serio ports
> -obj-$(CONFIG_SERIO)		+= input/serio/
> obj-y				+= serial/
> obj-$(CONFIG_PARPORT)		+= parport/
> obj-y				+= base/ block/ misc/ net/ media/
> @@ -46,6 +43,7 @@
> obj-$(CONFIG_TC)		+= tc/
> obj-$(CONFIG_USB)		+= usb/
> obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
> +obj-$(CONFIG_SERIO)		+= input/serio/
> obj-$(CONFIG_INPUT)		+= input/
> obj-$(CONFIG_GAMEPORT)		+= input/gameport/
> obj-$(CONFIG_I2O)		+= message/
>
