Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWCGA5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWCGA5Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWCGA5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:57:25 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:50562 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932561AbWCGA5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:57:24 -0500
Date: Mon, 6 Mar 2006 17:01:39 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, serue@us.ibm.com, frankeh@watson.ibm.com,
       clg@fr.ibm.com, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
Message-ID: <20060307010139.GF27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235249.880CB28A@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306235249.880CB28A@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
>  	/* If there is no strategy routine, or if the strategy returns
>  	 * zero, proceed with automatic r/w */
> -	if (table->data && table->maxlen) {
> +	data = sysctl_table_data(table);
> +	if (data && table->maxlen) {
>  		if (oldval && oldlenp) {
>  			if (get_user(len, oldlenp))
>  				return -EFAULT;
>  			if (len) {
>  				if (len > table->maxlen)
>  					len = table->maxlen;
> -				if(copy_to_user(oldval, table->data, len))
> +				if(copy_to_user(oldval, data, len))
>  					return -EFAULT;
>  				if(put_user(len, oldlenp))
>  					return -EFAULT;
> @@ -1241,7 +1261,7 @@ int do_sysctl_strategy (ctl_table *table
>  			len = newlen;
>  			if (len > table->maxlen)
>  				len = table->maxlen;
> -			if(copy_from_user(table->data, newval, len))
> +			if(copy_from_user(data, newval, len))
>  				return -EFAULT;

Interesting idea.  One piece that's missing is strategy for controlling
creation the new context (assuming the data_access() will always evaluate
into a context sensitive piece of data).  Otherwise a user can get out
of the limits imposed by sysadmin (since they may have placed themselves
in a context which differs from admin).

thanks,
-chris
