Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264022AbUEHSaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUEHSaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264042AbUEHSaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:30:22 -0400
Received: from main.gmane.org ([80.91.224.249]:40411 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264022AbUEHSaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:30:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ari Pollak <ajp@aripollak.com>
Subject: Re: 2.6.6-rc3-mm2 oops in psmouse/serio after resuming from APM suspend-to-ram
Date: Sat, 08 May 2004 14:30:13 -0400
Message-ID: <c7j8vk$rhf$1@sea.gmane.org>
References: <409BEF21.6040206@aripollak.com> <200405071716.15523.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: wve202.resnet.neu.edu
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <200405071716.15523.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch did indeed fix the problem; thanks! Hopefully it will be in 
the next -mm update.

One of these days I need to learn how to debug my own crashes.

Dmitry Torokhov wrote:
> I think this should take care of your oops:
> 
> ===== drivers/input/mouse/psmouse-base.c 1.57 vs edited =====
> --- 1.57/drivers/input/mouse/psmouse-base.c	Mon May  3 18:34:11 2004
> +++ edited/drivers/input/mouse/psmouse-base.c	Fri May  7 17:12:22 2004
> @@ -424,17 +424,17 @@
>  		if (set_properties) {
>  			psmouse->vendor = "Synaptics";
>  			psmouse->name = "TouchPad";
> -		}
>  
> -		if (max_proto > PSMOUSE_IMEX) {
> -			if (synaptics_init(psmouse) == 0)
> -				return PSMOUSE_SYNAPTICS;
> +			if (max_proto > PSMOUSE_IMEX) {
> +				if (synaptics_init(psmouse) == 0)
> +					return PSMOUSE_SYNAPTICS;
>  /*
>   * Some Synaptics touchpads can emulate extended protocols (like IMPS/2).
>   * Unfortunately Logitech/Genius probes confuse some firmware versions so
>   * we'll have to skip them.
>   */
> -			max_proto = PSMOUSE_IMEX;
> +				max_proto = PSMOUSE_IMEX;
> +			}
>  		}
>  /*
>   * Make sure that touchpad is in relative mode, gestures (taps) are enabled

