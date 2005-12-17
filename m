Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVLQKW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVLQKW0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 05:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbVLQKW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 05:22:26 -0500
Received: from styx.suse.cz ([82.119.242.94]:30370 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751146AbVLQKWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 05:22:25 -0500
Date: Sat, 17 Dec 2005 11:22:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Input: fix an OOPS in HID driver
Message-ID: <20051217102223.GB27280@midnight.suse.cz>
References: <200512162131.04544.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512162131.04544.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 09:31:04PM -0500, Dmitry Torokhov wrote:
> Subject: 
> 
> This patch fixes an OOPS in HID driver when connecting simulation
> devices generating unknown simulation events.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Yup, needed indeed. I'm not sure if we want an 'unknown': 'ignore'
might be safer.

> ---
> 
>  drivers/usb/input/hid-input.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> Index: work/drivers/usb/input/hid-input.c
> ===================================================================
> --- work.orig/drivers/usb/input/hid-input.c
> +++ work/drivers/usb/input/hid-input.c
> @@ -137,6 +137,7 @@ static void hidinput_configure_usage(str
>  			switch (usage->hid & 0xffff) {
>  				case 0xba: map_abs(ABS_RUDDER); break;
>  				case 0xbb: map_abs(ABS_THROTTLE); break;
> +				default:   goto unknown;
>  			}
>  			break;
>  
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
