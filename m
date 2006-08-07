Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWHGON6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWHGON6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWHGON5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:13:57 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30226 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932112AbWHGONl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:13:41 -0400
Date: Mon, 7 Aug 2006 14:02:23 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Message-ID: <20060807140222.GG4032@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <1154849246822-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154849246822-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The current hdaps driver queries the hardware on (almost) any sysfs
> read, reading just the information it needs and discarding the rest
> This is inefficient, because every hardware query actually gives all 
> information. It also means we're losing data, because readouts are
> offered by the hardware at a constant rate and each query "eats up"
> a readout. It also results in unnecessarily complex code.
> 
> This patch moves all hardware value reading+parsing to a single 
> function, __hdaps_update(). All values are cached, and easily 
> referenced afterwards. This function is still invoked on every sysfs 
> read. This will be fixed in a later patch.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

> +/* __hdaps_update - read current state and update global state variables.
> + * Also prefetches the next read, to reduce udelay busy-waiting.
> + * If fast!=0, do one quick attempt without retries.
> + * Caller must hold controller lock. 
>   */

Linuxdoc, please.

> +	/* Parse position data: */
> +	pos_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1) * (hdaps_invert?-1:1);
> +	pos_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1) * (hdaps_invert?-1:1);
> +
> +	/* Parse so-called "variance" data: */
> +	var_x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS2) * (hdaps_invert?-1:1);
> +	var_y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS2) * (hdaps_invert?-1:1);

Perhaps hdaps_invert should already have 1/-1 values.

>  {
> -	int ret = thinkpad_ec_lock();
> +	int ret;
> +	ret = thinkpad_ec_lock();

I actually liked the previous version more, and this change does not
really belong here.

						Pavel
-- 
Thanks for all the (sleeping) penguins.
