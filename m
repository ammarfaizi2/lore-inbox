Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbWHHMu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWHHMu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 08:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWHHMu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 08:50:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44295 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932458AbWHHMu1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 08:50:27 -0400
Date: Tue, 8 Aug 2006 12:19:39 +0000
From: Pavel Machek <pavel@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Robert Love <rlove@rlove.org>, Jean Delvare <khali@linux-fr.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [PATCH 09/12] hdaps: Add new sysfs attributes
Message-ID: <20060808121939.GG4540@ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492882249-git-send-email-multinymous@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11548492882249-git-send-email-multinymous@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch adds 4 new r/w sysfs attributes to the hdaps driver:
> 
> /sys/devices/platform/hdaps/sampling_rate:
>   This determines the frequency of hardware queries and input device updates.
>   Default=50.
> /sys/devices/platform/hdaps/oversampling_ratio:
>   When set to X, the embedded controller is told to do physical accelerometer
>   measurements at a rate that is X times higher than the rate at which
>   the driver reads those measurements (i.e., X*sampling_rate). This
>   reduces sample phase difference is, and useful for the running average
>   filter (see next). Default=5
> /sys/devices/platform/hdaps/running_avg_filter_order:
>   When set to X, reported readouts will be the average of the last X physical
>   accelerometer measurements. Current firmware allows 1<=X<=8. Setting to a
>   high value decreases readout fluctuations. The averaging is handled
>   by the embedded controller, so no CPU resources are used. Default=2.
> /sys/devices/platform/hdaps/fake_data_mode:
>   If set to 1, enables a test mode where the physical accelerometer readouts
>   are replaced with an incrementing counter. This is useful for checking the
>   regularity of the sampling interval and driver<->userspace communication,
>   which is useful for development and testing of the hdapd userspace daemon.
> 
> Signed-off-by: Shem Multinymous <multinymous@gmail.com>

Signed-off-by: Pavel Machek <pavel@suse.cz>

> +static ssize_t hdaps_fake_data_mode_store(struct device *dev,
> +					  struct device_attribute *attr,
> +					  const char *buf, size_t count)
> +{
> +	int on, ret;
> +	if (sscanf(buf, "%d", &on) != 1 || on<0 || on>1) {
> +		printk(KERN_WARNING
> +		       "fake_data should be 0 or 1\n");

Kill the printk?
						Pavel
-- 
Thanks for all the (sleeping) penguins.
