Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVBDGzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVBDGzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbVBDGzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:55:53 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:60887 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263481AbVBDGw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:52:57 -0500
Date: Fri, 4 Feb 2005 07:53:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net
Subject: Re: Touchpad problems with 2.6.11-rc2
Message-ID: <20050204065317.GA2682@ucw.cz>
References: <20050123190109.3d082021@localhost.localdomain> <m3acqr895h.fsf@telia.com> <20050201234148.4d5eac55@localhost.localdomain> <m3lla64r3w.fsf@telia.com> <20050202141117.688c8dd3@localhost.localdomain> <Pine.LNX.4.58.0502022345320.18555@telia.com> <20050203064645.GA2342@ucw.cz> <m31xbxxqac.fsf@telia.com> <20050204061703.GB2329@ucw.cz> <m38y64x1xw.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m38y64x1xw.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 07:40:43AM +0100, Peter Osterlund wrote:
> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Thu, Feb 03, 2005 at 10:54:51PM +0100, Peter Osterlund wrote:
> > 
> > > * Removes the xres/yres scaling so that you get the same speed in the
> > >   X and Y directions even if your screen is not square.
> > 
> > The old code assumed that both the pad and the screen are 4:3, not
> > square. It was wrong still.

> alps.c currently contains:
> 
> 	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
> 	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
> 	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1023, 0, 0);
> 	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
> 
> Maybe it should set the ABS_Y max value to 767 in that case.

Yes, and no. It could have been 1023, if it was 3:4 in size, but not in
maximum values. See the real values below, though, it seems the
resolution in X and Y is indeed the same.

> --- linux/drivers/input/mouse/alps.c~	2005-01-12 22:02:19.000000000 +0100
> +++ linux/drivers/input/mouse/alps.c	2005-02-04 07:38:12.203436768 +0100
> @@ -394,7 +394,7 @@
>  
>  	psmouse->dev.evbit[LONG(EV_ABS)] |= BIT(EV_ABS);
>  	input_set_abs_params(&psmouse->dev, ABS_X, 0, 1023, 0, 0);
> -	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 1023, 0, 0);
> +	input_set_abs_params(&psmouse->dev, ABS_Y, 0, 767, 0, 0);
>  	input_set_abs_params(&psmouse->dev, ABS_PRESSURE, 0, 127, 0, 0);
>  
>  	psmouse->dev.keybit[LONG(BTN_TOUCH)] |= BIT(BTN_TOUCH);
 
My ALPS gives values:

	X: 90-1019
	Y: 100-749
 Pressure: 0,34-108

So 0-1024, 0-768, 0-127 are probably the maximum theoretical ranges, and
the rest are likely the mechanical mounting limitations of the notebook
(the ridge around the pad is not rectangular).

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
