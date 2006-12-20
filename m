Return-Path: <linux-kernel-owner+w=401wt.eu-S1030326AbWLTVTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWLTVTm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 16:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbWLTVTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 16:19:41 -0500
Received: from smtp105.sbc.mail.mud.yahoo.com ([68.142.198.204]:41349 "HELO
	smtp105.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1030326AbWLTVTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 16:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=b2gEuGh7VN2u4T2M6cQz1SuyaK9V1nnFD1YOY81wqlI8Ykf2eZMjLvNd/T7HmlFVyit66tPl/6w5+/ZKxcHQZ+/BgdB3sUWehvS86080WpAdNKmxtpSpMi5z006894IV+exmoC3ja3e2vY5WFuIuBSCVZKdXC3+KcvejYQQwTAw=  ;
X-YMail-OSG: 2pwbXdsVM1mJBwK.Qw8OFvaxSK8gDCQzcQBoN2Pf6kIbNpNdle3d923RU2ztg5_VkQqHH3qQNppDLc2oYYfWP6LVBoyetnBCyv_ovFa2322U1X0Jm4JKMBtJC8hRUK35khVnHjXSyzQ58pg-
From: David Brownell <david-b@pacbell.net>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/2] Fix /sys/device/.../power/state
Date: Wed, 20 Dec 2006 13:18:06 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
References: <20061219185223.GA13256@srcf.ucam.org> <200612192015.14587.david-b@pacbell.net> <20061220045604.GA20234@srcf.ucam.org>
In-Reply-To: <20061220045604.GA20234@srcf.ucam.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200612201318.06976.david-b@pacbell.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 December 2006 8:56 pm, Matthew Garrett wrote:

> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -46,7 +46,8 @@ static ssize_t state_store(struct device * dev, struct device_attribute *attr, c
>  	int error = -EINVAL;
>  
>  	/* disallow incomplete suspend sequences */
> -	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
> +	if (dev->bus && dev->bus->pm_has_noirq_stage 
> +	    && dev->bus->pm_has_noirq_stage(dev))
>  		return error;
>  

I'm suspecting these two patches won't be merged, but this fragment has
two bugs.  One is the whitespace bug already mentioned.  The other is that
the original test must still be used if that bus primitve doesn't exist.

And in a different vein, I'm a bit surprised that the update to the
feature-removal-schedule.txt file is a separate patch, but:

> +       bus->pm_has_noirq_stage()
> -When:  July 2007
> +When:  Once alternative functionality has been implemented

The "When" shouldn't change.
