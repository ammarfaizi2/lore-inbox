Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVCCCr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVCCCr7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 21:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVCCCps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 21:45:48 -0500
Received: from smtp.cce.hp.com ([161.114.21.24]:33723 "EHLO
	ccerelrim03.cce.hp.com") by vger.kernel.org with ESMTP
	id S261433AbVCCCkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 21:40:31 -0500
Message-ID: <422679B4.8080401@hp.com>
Date: Wed, 02 Mar 2005 21:43:00 -0500
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Initialisation sequencing.
References: <42264D23.6010206@f2s.com>
In-Reply-To: <42264D23.6010206@f2s.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.0, Antispam-Data: 2005.3.2.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:

> Hi.
>
> I have a problem. It affects both modular and non modular builds, and 
> I dont see an obviously correct solution.
>
> The problem is that I have a video chip which supports some GPIOs and 
> an LCD display.
>
> some LCD functions are controlled via the GPIOs, like backlighting.
>
> so the driver is split into a video driver which exports three GPIO 
> related functions, and a backlight driver which requires them to work. 
> Both are on the platform bus.
>
> the problem occurs when the backlight driver gets probed before the 
> video driver. it tries to access the GPIO functions, which try to 
> write to random locations as the memory hasnt been ioremap()ed by the 
> as yet unprobed video driver, and it all predictably falls over in a 
> gibbering heap.
>
> I cant spin at this point without deadlocking the video driver and 
> ending up never being able to call the gpio functions, for obvious 
> reasons.
>
> I've tried making the backlight driver a child of the video driver, 
> hoping the probe functions are called in 'bus order', ie. parents 
> first. This failed.
>
> I could make the backlight driver initialise late, but that seems like 
> a hack. scheduling work risks deadlock.
>
I think initialising the backlight driver after the core of the driver 
that implements the GPIO is the right thing.  The backlight_device 
framework includes a notifier chain so that the video driver can take 
the right action when the backlight driver is registered.  Using soc to 
split the chip driver into a core, backlight and video might be another 
option that lets you bring up the backlight driver before the video driver.

Jamey



