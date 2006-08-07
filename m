Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWHGOOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWHGOOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWHGOOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:14:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30738 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932090AbWHGONx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:13:53 -0400
Date: Mon, 7 Aug 2006 14:07:21 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes
Message-ID: <20060807140721.GH4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492543835-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The current hdaps driver got some details wrong about the result of
> hardware queries. 
> 
> First, it fails to check a couple of status values.
> 
> Second, it turns out that the hardware will return up to two readouts:
> the latest one and also the previous one if it was missed (host didn't
> poll fast enough). The current driver wrongly interprets the latter as
> a "variance", which is nonsensical. We have no use for that previous
> readout, so it should be ignored.
> 
> This patch adds proper status checking, and removes the "variance" and
> "temp2" sysfs attributes which refer to the old readout.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>

> +	if (data.val[EC_ACCEL_IDX_READOUTS]<1)

Could we get spaces around '<'?

> +	int total, ret;
> +	for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {

Could we go from 0 to timeout, not the other way around?

>  static DEVICE_ATTR(position, 0444, hdaps_position_show, NULL);
> -static DEVICE_ATTR(variance, 0444, hdaps_variance_show, NULL);
>  static DEVICE_ATTR(temp1, 0444, hdaps_temp1_show, NULL);
> -static DEVICE_ATTR(temp2, 0444, hdaps_temp2_show, NULL);
> +  /* "temp1" instead of "temperature" is hwmon convention */
>  static DEVICE_ATTR(keyboard_activity, 0444, hdaps_keyboard_activity_show, NULL);
>  static DEVICE_ATTR(mouse_activity, 0444, hdaps_mouse_activity_show, NULL);
>  static DEVICE_ATTR(calibrate, 0644, hdaps_calibrate_show,hdaps_calibrate_store);

This actually changes userland interface... but that is probably okay.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
