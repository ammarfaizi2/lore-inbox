Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWFGSkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWFGSkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 14:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWFGSkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 14:40:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48813 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751223AbWFGSkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 14:40:09 -0400
Date: Wed, 7 Jun 2006 11:39:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrew Victor <andrew@sanpeople.com>
Cc: linux-kernel@vger.kernel.org, alessandro.zummo@towertech.it
Subject: Re: [PATCH] RTC: Ensure that time being passed to set_alarm() is
 valid.
Message-Id: <20060607113911.1dd03687.akpm@osdl.org>
In-Reply-To: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
References: <1149704455.20386.90.camel@fuzzie.sanpeople.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jun 2006 20:20:55 +0200
Andrew Victor <andrew@sanpeople.com> wrote:

> RTC: Ensure that the time being passed to set_alarm() is valid.
> 
> 
> Signed-off-by: Andrew Victor <andrew@sanpeople.com>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
> 
> 
> diff -urN -x CVS linux-2.6.17-rc6/drivers/rtc/interface.c
> linux-2.6.17-rc/drivers/rtc/interface.c
> --- linux-2.6.17-rc6/drivers/rtc/interface.c	Tue Jun  6 10:28:05 2006
> +++ linux-2.6.17-rc/drivers/rtc/interface.c	Wed Jun  7 11:46:28 2006
> @@ -129,6 +129,10 @@
>  	int err;
>  	struct rtc_device *rtc = to_rtc_device(class_dev);
>  
> +	err = rtc_valid_tm(&alarm->time);
> +	if (err != 0)
> +		return err;
> +
>  	err = mutex_lock_interruptible(&rtc->ops_lock);
>  	if (err)
>  		return -EBUSY;
> 

More details, please.  How can this situation come about?  Buggy kernel
code?  Userspace action?
