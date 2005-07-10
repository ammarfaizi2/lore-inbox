Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVGJL5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVGJL5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 07:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVGJL5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 07:57:41 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:18893 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261909AbVGJL5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 07:57:41 -0400
Date: Sun, 10 Jul 2005 13:58:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Stelian Pop <stelian@popies.net>,
       Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
Message-ID: <20050710115807.GB3018@ucw.cz>
References: <20050708101731.GM18608@sd291.sivit.org> <1120821481.5065.2.camel@localhost> <20050708121005.GN18608@sd291.sivit.org> <m37jfzr4oi.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m37jfzr4oi.fsf@telia.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 12:32:45AM +0200, Peter Osterlund wrote:
> Stelian Pop <stelian@popies.net> writes:
> 
> > +Synaptics re-detection problems:
> > +--------------------------------
> > +
> > +The synaptics X11 driver tries to re-open the touchpad input device file
> > +(/dev/input/eventX) each time you change from text mode back to X11. If the
> > +input device file does not exist at this precise moment, the synaptics driver
> > +will give up searching for a touchpad, permanently. You will need to restart
> > +X11 if you want to reissue a scan.
> 
> I think this particular problem is fixed by the following patch to the
> X driver:
> 
> --- synaptics.c.old	2005-07-10 00:09:02.000000000 +0200
> +++ synaptics.c	2005-07-10 00:09:12.000000000 +0200
> @@ -524,6 +524,11 @@
>  
>      local->fd = xf86OpenSerial(local->options);
>      if (local->fd == -1) {
> +	xf86ReplaceStrOption(local->options, "Device", "");
> +	SetDeviceAndProtocol(local);
> +	local->fd = xf86OpenSerial(local->options);
> +    }
> +    if (local->fd == -1) {
>  	xf86Msg(X_WARNING, "%s: cannot open input device\n", local->name);
>  	return !Success;
>      }
> 
> > +static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact) {
> 
> I think this CodingStyle violation is quite annoying, because it
> prevents emacs from finding the beginning of the function. It should
> be written like this:
> 
> static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact)
> {
 
Agreed, this should be fixed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
