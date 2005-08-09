Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932451AbVHIHdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbVHIHdV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 03:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbVHIHdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 03:33:20 -0400
Received: from mail.kroah.org ([69.55.234.183]:63688 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932451AbVHIHdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 03:33:20 -0400
Date: Tue, 9 Aug 2005 00:32:35 -0700
From: Greg KH <greg@kroah.com>
To: Todd Poynor <tpoynor@mvista.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: Re: PowerOP 1/3: PowerOP core
Message-ID: <20050809073234.GB13203@kroah.com>
References: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050809025157.GB25064@slurryseal.ddns.mvista.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 07:51:57PM -0700, Todd Poynor wrote:
> +static void powerop_kobj_release(struct kobject *kobj)
> +{
> +	return;
> +}

Hint, if your release function is just a noop like this, your code is
wrong.  The kernel requires you to have a release function for a reason.
Please fix it.

> +struct powerop_param_attribute {
> +	int index;
> +        struct attribute        attr;
> +};

space vs. tab issue.

> +static ssize_t
> +powerop_param_attr_show(struct kobject * kobj, struct attribute * attr,
> +			char * buf)
> +{
> +	struct powerop_param_attribute * param_attr = to_param_attr(attr);
> +	struct powerop_point point;
> +	ssize_t ret = 0;
> +
> +	if ((ret = powerop_get_point(&point)) == 0)
> +		ret = sprintf(buf, "%d\n", point.param[param_attr->index]);

Please break this up into 3 lines instead of 2 to make it easier to read
and maintain over time.

You do this in other places too, please fix them too.

thanks,

greg k-h
