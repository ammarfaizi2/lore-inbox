Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964882AbWHHMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWHHMvf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWHHMvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:51:03 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44039 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S964875AbWHHMuY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:50:24 -0400
Date: Tue, 8 Aug 2006 12:45:48 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 10/12] hdaps: Power off accelerometer on suspend and unload
Message-ID: <20060808124547.GH4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492972486-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492972486-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch disables accelerometer power and stops its polling by the
> embedded controller upon suspend and module unload. The power saving
> is negligible, but it's the right thing to do.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>


> +/*
> + * hdaps_device_shutdown - power off the accelerometer. Can sleep.
> + */
> +static void hdaps_device_shutdown(void) {

{ on newline?

> +	if (hdaps_set_power(0))
> +		printk(KERN_WARNING "hdaps: cannot power off\n");
> +	if (hdaps_set_ec_config(0, 1))
> +		printk(KERN_WARNING "hdaps: cannot stop EC sampling\n");
> +}

Maybe propagate error value?

> +static int hdaps_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	hdaps_device_shutdown();
> +	return 0;
> +}
> +

-- 
Thanks for all the (sleeping) penguins.
