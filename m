Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262082AbVANTUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVANTUu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVANTTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:19:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39323 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262072AbVANTRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 14:17:55 -0500
Date: Fri, 14 Jan 2005 11:17:07 -0800
From: Greg KH <greg@kroah.com>
To: Karim Yaghmour <karim@opersys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH 3/4] relayfs for 2.6.10: locking/lockless implementation
Message-ID: <20050114191707.GC15337@kroah.com>
References: <41E736C1.5060104@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E736C1.5060104@opersys.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 10:04:33PM -0500, Karim Yaghmour wrote:
> +/**
> + *	compare_and_store_volatile - self-explicit
> + *	@ptr: ptr to the word that will receive the new value
> + *	@oval: the value we think is currently in *ptr
> + *	@nval: the value *ptr will get if we were right
> + */
> +inline int
> +compare_and_store_volatile(volatile u32 *ptr,
> +			   u32 oval,
> +			   u32 nval)
> +{
> +	u32 prev;
> +
> +	barrier();
> +	prev = cmpxchg(ptr, oval, nval);
> +	barrier();
> +
> +	return (prev == oval);
> +}

Why is this function needed?  What's wrong with the "normal" cmpxchg?

> +/**
> + *	atomic_set_volatile - atomically set the value in ptr to nval.
> + *	@ptr: ptr to the word that will receive the new value
> + *	@nval: the new value
> + */
> +inline void
> +atomic_set_volatile(atomic_t *ptr,
> +		    u32 nval)
> +{
> +	barrier();
> +	atomic_set(ptr, (int)nval);
> +	barrier();
> +}

Same here, what's wrong with the normal atomic_set()?

Same question also goes for the other functions like this in this file.

thanks,

greg k-h
