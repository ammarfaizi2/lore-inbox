Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263776AbUFCQyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbUFCQyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUFCQyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:54:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:21928 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263776AbUFCQxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:53:47 -0400
Date: Thu, 3 Jun 2004 09:51:42 -0700
From: Greg KH <greg@kroah.com>
To: Paul Jackson <pj@sgi.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ak@suse.de
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-ID: <20040603165142.GA3959@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com> <1086222156.29391.337.camel@bach> <20040603162712.GA3291@kroah.com> <20040603093807.33bc670d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603093807.33bc670d.pj@sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 09:38:07AM -0700, Paul Jackson wrote:
> > We do check for an error in that function, so returning any negative
> > error value for a show() sysfs callback will be handled properly.
> 
> If a show() function returns an error, you handle it - good.  As it
> should be.
> 
> But if a show() function overwrites the page buffer provided to it,
> before returning, then there is nothing you can do beyond sending
> condolences to the next of kin.

Yup, you broke the kernel, you get to keep both pieces :)

> This PATCH and email thread came about because the buffer size is not
> passed into the show() function, nor, so far as I can tell, is it
> documented anywhere other than implicitly in the fill_read_buffer()
> code:
> 
>     buffer->page = (char *) get_zeroed_page(GFP_KERNEL);

I agree that we should document this better.  This thread has shown
that.

> So we were getting confused as to what size buffer we had, when
> coding defensively to avoid buffer overrun.

Panicing the kernel is not really acceptable, even if you did just
scribble accross any portion of kernel memory in your show() function.
Just be aware of the size and code your show() function to be defensive
and not overrun that size.

thanks,

greg k-h
