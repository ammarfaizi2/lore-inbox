Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVBYDI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVBYDI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 22:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262603AbVBYDIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 22:08:25 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:4267 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262602AbVBYDIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 22:08:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Ian E. Morgan" <imorgan@webcon.ca>
Subject: Re: ALPS tapping disabled. WHY?
Date: Thu, 24 Feb 2005 22:08:15 -0500
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net>
In-Reply-To: <Pine.LNX.4.62.0502241822310.8449@light.int.webcon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502242208.16065.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 February 2005 18:29, Ian E. Morgan wrote:
> Trying out 2.6.11-rc5, I discovered my ALPS touchpad misbehaving. After
> reading several threads related to the topic, noe seemed to resolve my
> issue.
> 
> The pad has always worked fine as a plain PS/2 mouse, from 2.4.0 through
> 2.6.10.
> 
> This change fixes the problem by NOT disabling hardware tapping:
> 
> --- linux-2.6.11-rc5/drivers/input/mouse/alps.c~	2005-02-24 18:16:03.000000000 -0500
> +++ linux-2.6.11-rc5/drivers/input/mouse/alps.c	2005-02-24 18:16:03.000000000 -0500
> @@ -334,8 +334,8 @@
>   	if (alps_get_status(psmouse, param))
>   		return -1;
> 
> -	if (param[0] & 0x04)
> -		alps_tap_mode(psmouse, 0);
> +//	if (param[0] & 0x04)
> +//		alps_tap_mode(psmouse, 0);
> 
>   	if (alps_absolute_mode(psmouse)) {
>   		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
> @@ -372,11 +372,11 @@
>   		return -1;
>   	}
> 
> -	if (param[0] & 0x04) {
> -		printk(KERN_INFO "  Disabling hardware tapping\n");
> -		if (alps_tap_mode(psmouse, 0))
> -			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
> -	}
> +//	if (param[0] & 0x04) {
> +//		printk(KERN_INFO "  Disabling hardware tapping\n");
> +//		if (alps_tap_mode(psmouse, 0))
> +//			printk(KERN_WARNING "alps.c: Failed to disable hardware tapping\n");
> +//	}
> 
>   	if (alps_absolute_mode(psmouse)) {
>   		printk(KERN_ERR "alps.c: Failed to enable absolute mode\n");
> 
> 
> 
> So now, can anyone explain what bit 3 of param[0] does, and why you would
> want to disable hardware tapping support when it's set? My pad (ALPS
> 56AAA1760C on a Sager NP8560V) has always worked with hardware tapping as a
> plain PS/2 mouse, no special ALPS support req'd.
> 
> Can this disabling of hardware tapping support be made optional (boot time
> param or other)? I don't want to have to patch every kernel from here on
> out.
> 

It still should do software tap emulation (although support is a bit flakey
with ALPS I must admit, but there are patches that should improve it) - so
people who don't like tapping can deactivate it.

Anyway, "psmouse.proto=exps" boot option should disable ALPS native mode and
restore previous behavior.

-- 
Dmitry
