Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266913AbUG1Nl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266913AbUG1Nl1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266914AbUG1Nl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:41:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:33672 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S266913AbUG1NlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:41:25 -0400
Date: Wed, 28 Jul 2004 15:43:13 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olav Kongas <olav@enif.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: input system: EVIOCSABS(abs) ioctl disabled, why?
Message-ID: <20040728134313.GB4831@ucw.cz>
References: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 03:41:28PM +0300, Olav Kongas wrote:

> When trying to feed calibration information to a touchscreen driver with
> the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
> in 2.6.7. Only after the modification given in the patch below it was
> possible to use this ioctl command.
> 
> Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses

It's a bug. I'll fix it.

> or needs it.

Nobody uses it, surprisingly.

> The touchscreen drivers have no good way of determining the
> absolute limits themselves, do they?

Many do.

> Thanks in advance,
> Olav
> 
> --- linux-2.6.7/drivers/input/evdev.c.or	2004-07-21 13:27:03.000000000 +0300
> +++ linux-2.6.7/drivers/input/evdev.c	2004-07-21 15:53:46.000000000 +0300
> @@ -284,7 +284,7 @@
> 
>  		default:
> 
> -			if (_IOC_TYPE(cmd) != 'E' || _IOC_DIR(cmd) != _IOC_READ)
> +			if (_IOC_TYPE(cmd) != 'E' || (_IOC_DIR(cmd) != _IOC_READ && (cmd & ~ABS_MAX) !=  EVIOCSABS(0)))
>  				return -EINVAL;
> 
>  			if ((_IOC_NR(cmd) & ~EV_MAX) == _IOC_NR(EVIOCGBIT(0,0))) {

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
