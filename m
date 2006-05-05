Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWEEWYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWEEWYR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751796AbWEEWYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:24:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:38846 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750878AbWEEWYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:24:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kKPYhuYYViufwcuQKs2496D0X7e+dqqEn3T9fjmW7tn5Vg4ekrBnBadUsxFGEFB32H5bmDNjBGSL0Ra16RJL/7W2Vm0eoljYtP8obL7lfQqBdCT4YcDCt7BZ/zafAeG1HlwqDhPpej4EqqWUojB4zsDUuLyMtSsmpiA1qw4tufI=
Date: Sat, 6 May 2006 02:22:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, arjan@linux.intel.com, greg@kroah.com
Subject: Re: [patch] add new uevent
Message-ID: <20060505222234.GA7238@mipter.zuzino.mipt.ru>
References: <1146867216.21633.6.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1146867216.21633.6.camel@whizzy>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 03:13:36PM -0700, Kristen Accardi wrote:
> Add dock uevents so that userspace can be notified of dock and undock
> events.

> --- 2.6-git-kca2.orig/include/linux/kobject.h
> +++ 2.6-git-kca2/include/linux/kobject.h
> @@ -46,6 +46,8 @@ enum kobject_action {
>  	KOBJ_UMOUNT	= (__force kobject_action_t) 0x05,	/* umount event for block devices (broken) */
>  	KOBJ_OFFLINE	= (__force kobject_action_t) 0x06,	/* device offline */
>  	KOBJ_ONLINE	= (__force kobject_action_t) 0x07,	/* device online */
> +	KOBJ_UNDOCK	= (__force kobject_action_t) 0x08, 	/* undocking */
> +	KOBJ_DOCK	= (__force kobject_action_t) 0x09,	/* dock */
>  };
>  
>  struct kobject {
> --- 2.6-git-kca2.orig/lib/kobject_uevent.c
> +++ 2.6-git-kca2/lib/kobject_uevent.c
> @@ -48,6 +48,10 @@ static char *action_to_string(enum kobje
>  		return "offline";
>  	case KOBJ_ONLINE:
>  		return "online";
> +	case KOBJ_DOCK:
> +		return "dock";
> +	case KOBJ_UNDOCK:
> +		return "undock";
>  	default:
>  		return NULL;
>  	}

Where exactly are you going to generate them?

