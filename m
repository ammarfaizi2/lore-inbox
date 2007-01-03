Return-Path: <linux-kernel-owner+w=401wt.eu-S1754870AbXACHgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870AbXACHgw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 02:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754896AbXACHgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 02:36:52 -0500
Received: from pasmtpa.tele.dk ([80.160.77.114]:50068 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754870AbXACHgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 02:36:51 -0500
Date: Wed, 3 Jan 2007 08:36:37 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andres Salomon <dilinger@queued.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Andres Salomon <dilinger@debian.org>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz, warp@aehallh.com
Subject: Re: [PATCH] psmouse split [01/03]
Message-ID: <20070103073637.GA26825@uranus.ravnborg.org>
References: <457F822E.4040404@debian.org> <200612130108.19447.dtor@insightbb.com> <457FAA01.9010807@debian.org> <d120d5000612130612v5d12adc0uc878b8307770d79@mail.gmail.com> <45802D98.7030608@debian.org> <d120d5000612130947w899614y68cf32cb1e3b35ec@mail.gmail.com> <459B51C4.8040906@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459B51C4.8040906@queued.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andres.

> diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
> index 21a1de6..e7c7fbb 100644
> --- a/drivers/input/mouse/Makefile
> +++ b/drivers/input/mouse/Makefile
> @@ -14,4 +14,24 @@ obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
>  obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
>  obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
>  
> -psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
> +psmouse-objs := psmouse-base.o
> +
> +ifeq ($(CONFIG_MOUSE_PS2_ALPS),y)
> +psmouse-objs += alps.o
> +endif
> +
> +ifeq ($(CONFIG_MOUSE_PS2_LOGIPS2PP),y)
> +psmouse-objs += logips2pp.o
> +endif
> +
> +ifeq ($(CONFIG_MOUSE_PS2_SYNAPTICS),y)
> +psmouse-objs += synaptics.o
> +endif
> +
> +ifeq ($(CONFIG_MOUSE_PS2_LIFEBOOK),y)
> +psmouse-objs += lifebook.o
> +endif
> +
> +ifeq ($(CONFIG_MOUSE_PS2_TRACKPOINT),y)
> +psmouse-objs += trackpoint.o
> +endif


The above code should be redone to use list based assignement.
Something like this:

psmouse-y := psmouse-base.o
psmouse-$(CONFIG_MOUSE_PS2_ALPS)       += alps.o
psmouse-$(CONFIG_MOUSE_PS2_LOGIPS2PP)  += logips2pp.o
psmouse-$(CONFIG_MOUSE_PS2_SYNAPTICS)  += synaptics.o
psmouse-$(CONFIG_MOUSE_PS2_LIFEBOOK)   += lifebook.o
psmouse-$(CONFIG_MOUSE_PS2_TRACKPOINT) += trackpoint.o

	Sam
