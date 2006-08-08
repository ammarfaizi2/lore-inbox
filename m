Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWHHMtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWHHMtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWHHMtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:49:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32263 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964836AbWHHMtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:49:50 -0400
Date: Tue, 8 Aug 2006 12:16:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 08/12] hdaps: Add explicit hardware configuration functions
Message-ID: <20060808121619.GF4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492822826-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492822826-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This adds functions for configuring accelerometer-related hardware 
> parameters in the hdaps driver, and changes the init function to
> use these functions instead of opaque magic numbers.
> The parameters are configured via variables instead of constants
> since a later patch will add sysfs attributes for changing them.
> 
> A few of these functions aren't used yet, but will be used by later
> patches.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>

> @@ -68,6 +67,13 @@ static struct input_dev *hdaps_idev;
>  static unsigned int hdaps_invert;
>  static int needs_calibration = 0;

Unneccessary initializer.

> +/* Configuration: */
> +static int sampling_rate = 50;       /* Sampling rate  */
> +static int oversampling_ratio = 5;   /* Ratio between our sampling rate and 
> +                                      * EC accelerometer sampling rate      */
> +static int running_avg_filter_order = 2; /* EC running average filter order */
> +static int fake_data_mode = 0;       /* Enable EC fake data mode? */

Here too.

> @@ -162,6 +168,137 @@ static int hdaps_update(void)
>  }
>  
>  /*
> + * hdaps_set_power - enable or disable power to the accelerometer.
> + * Returns zero on success and negative error code on failure.  Can sleep.
> + */
> +static int hdaps_set_power(int on) {

{ on new line, kernel-doc.

> +/*
> + * hdaps_set_fake_data_mode - enable or disable EC test mode, which fakes 
> + * accelerometer data using an incrementing counter.
> + * Returns zero on success and negative error code on failure.  Can sleep.
> + */

Why do we want to have fake mode? I see it is useful for debugging,
but?

> +/*
> + * hdaps_check_ec - checks something about the EC.
> + * Follows the clean-room spec for HDAPS; we don't know what it means.
> + * Returns zero on success and negative error code on failure.  Can sleep.
> + */

URL for spec?

What happens when we delete this one?

						Pavel
-- 
Thanks for all the (sleeping) penguins.
