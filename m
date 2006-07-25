Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964834AbWGYVJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964834AbWGYVJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 17:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWGYVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 17:09:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:6117 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964834AbWGYVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 17:09:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=fV6K9lPPWISejRTfqiHkaG6Sq8ts1UC1q+Od33Blut6+qaGeIi9sc+hGY4+L1Y875QxFKQEnmspNsXr5lZE+odIM9GqceYl0TzP1SlwaHWCrOMSQEhI5CTKVCZX5VScmeRJX3xlW1IPHxhHcB5bysWrCV2BX+NZA2H7J3IDTvWc=
Date: Wed, 26 Jul 2006 01:09:53 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060725210953.GA11405@martell.zuzino.mipt.ru>
References: <20060725203028.GA1270@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725203028.GA1270@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2006 at 01:30:28PM -0700, Greg KH wrote:
> This adds the infrastructure for drivers to do a threaded probe.

> -			goto ProbeFailed;
> +			goto probe_failed;
>  		}
>  	} else if (drv->probe) {
>  		ret = drv->probe(dev);
>  		if (ret) {
>  			dev->driver = NULL;
> -			goto ProbeFailed;
> +			goto probe_failed;
>  		}
>  	}
>  	device_bind_driver(dev);
>  	ret = 1;
>  	pr_debug("%s: Bound Device %s to Driver %s\n",
>  		 drv->bus->name, dev->bus_id, drv->name);
> -	goto Done;
> +	goto done;
>  
> - ProbeFailed:
> +probe_failed:
>  	if (ret == -ENODEV || ret == -ENXIO) {
>  		/* Driver matched, but didn't support device
>  		 * or device not found.
> @@ -110,7 +99,53 @@ int driver_probe_device(struct device_dr
>  		       "%s: probe of %s failed with error %d\n",
>  		       drv->name, dev->bus_id, ret);
>  	}
> - Done:
> +done:

Removing these changes will make this patch smaller and do one thing. ;-)

