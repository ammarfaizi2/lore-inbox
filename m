Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVGKKJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVGKKJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 06:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVGKKJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 06:09:10 -0400
Received: from gw.alcove.fr ([81.80.245.157]:28853 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261579AbVGKKJI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 06:09:08 -0400
Subject: Re: [PATCH] Apple USB Touchpad driver (new)
From: Stelian Pop <stelian@popies.net>
To: Peter Osterlund <petero2@telia.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Frank Arnold <frank@scirocco-5v-turbo.de>
In-Reply-To: <m37jfzr4oi.fsf@telia.com>
References: <20050708101731.GM18608@sd291.sivit.org>
	 <1120821481.5065.2.camel@localhost>
	 <20050708121005.GN18608@sd291.sivit.org>  <m37jfzr4oi.fsf@telia.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 11 Jul 2005 12:06:25 +0200
Message-Id: <1121076385.12619.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 10 juillet 2005 à 00:32 +0200, Peter Osterlund a écrit :
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

It does indeed fix the problem.

I removed that section from the documentation, as I assume you will
integrate this patch in future synaptics releases (and it wasn't anyway
a big problem for users, just for developers).

> 
> > +static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact) {
> 
> I think this CodingStyle violation is quite annoying, because it
> prevents emacs from finding the beginning of the function. It should
> be written like this:

Indeed, that one slipped over, but this didn't prevent vim from finding
the beginning of the function :)

Thanks,

Stelian.
-- 
Stelian Pop <stelian@popies.net>

