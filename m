Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWINOaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWINOaz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWINOaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:30:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2744 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750803AbWINOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:30:54 -0400
Date: Thu, 14 Sep 2006 09:30:48 -0500
From: Dimitri Sivanich <sivanich@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Migration of standard timers
Message-ID: <20060914143048.GB9898@sgi.com>
References: <20060914132917.GA9898@sgi.com> <yq0irjqedwk.fsf@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq0irjqedwk.fsf@jaguar.mkp.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jes,

On Thu, Sep 14, 2006 at 10:11:39AM -0400, Jes Sorensen wrote:
> Hi Dimitri,
> 
> I just took a quick look at your patch, and at least on the surface it
> looks pretty nice to me.
> 
> One minor nit, why choose short for the affinity field in struct
> timer_list, it seems a strange size to pick for something which is
> either 0 or 1. Wouldn't int or char be better?  I don't know if all
> CPUs have 16 bit stores, but they should have 8 and 32 bit.

Yes, you're probably right.  I would have no problem with this being
changed to a 'char'.

> 
> The name 'aff' for affinity might not be good either, since we tend to
> refer to affinity as a mask specifying where it's locked to, maybe
> 'locked' would be better?

A field name of 'locked' would be OK with me.

> 
> All in the nit-picking department though.
> 
> Cheers,
> Jes
> 
> 
> Index: linux/include/linux/timer.h
> ===================================================================
> --- linux.orig/include/linux/timer.h
> +++ linux/include/linux/timer.h
> @@ -15,6 +15,8 @@ struct timer_list {
>  	unsigned long data;
>  
>  	struct tvec_t_base_s *base;
> +
> +	short aff;
>  };
>  
