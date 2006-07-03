Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750887AbWGCCdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbWGCCdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 22:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWGCCdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 22:33:44 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:18212 "EHLO
	asav08.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1750791AbWGCCdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 22:33:43 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAMUdqESBSg
From: Dmitry Torokhov <dtor@insightbb.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [RFC] Apple Motion Sensor driver
Date: Sun, 2 Jul 2006 22:33:41 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       khali@linux-fr.org, linux-kernel@killerfox.forkbomb.ch,
       benh@kernel.crashing.org, johannes@sipsolutions.net, stelian@popies.net,
       chainsaw@gentoo.org
References: <20060702222649.GA13411@hansmi.ch>
In-Reply-To: <20060702222649.GA13411@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607022233.42055.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Sunday 02 July 2006 18:26, Michael Hanselmann wrote:
> 
> +
> +	if (x)
> +		*x = tmpx;
> +	if (y)
> +		*y = tmpy;
> +	if (z)
> +		*z = tmpz;


All callers of ams_sensors use all 3 arguments, why bother with temps?

> +
> +	ams.idev->name = "Apple Motion Sensor";
> +	ams.idev->id.bustype = BUS_I2C;

Should it be always BUS_I2C? Maybe it should be BUS_HOST in case of PMU?

> +	ams.idev->id.vendor = 0;

Please add:

	ams.idev->cdev.dev = &ams.of_dev->dev;

so that the input device has a proper parent in sysfs hierarchy.

-- 
Dmitry
