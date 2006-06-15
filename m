Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030635AbWFOQKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030635AbWFOQKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030715AbWFOQKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:10:35 -0400
Received: from ns2.suse.de ([195.135.220.15]:17086 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030635AbWFOQKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:10:35 -0400
Date: Thu, 15 Jun 2006 09:07:05 -0700
From: Greg KH <gregkh@suse.de>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Pete Zaitcev <zaitcev@redhat.com>, rmk+lkml@arm.linux.org.uk,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: Serial-Core: USB-Serial port current issues.
Message-ID: <20060615160705.GB12371@suse.de>
References: <20060613192829.3f4b7c34@home.brethil> <20060614152809.GA17432@flint.arm.linux.org.uk> <20060614173824.60d1bc2e@doriath.conectiva> <20060614175308.877cf6a0.zaitcev@redhat.com> <20060615102940.472d0815@home.brethil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060615102940.472d0815@home.brethil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 10:29:40AM -0300, Luiz Fernando N. Capitulino wrote:
> On Wed, 14 Jun 2006 17:53:08 -0700
> Pete Zaitcev <zaitcev@redhat.com> wrote:
> 
> | On Wed, 14 Jun 2006 17:38:24 -0300, "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> | 
> | >  I think BUG_ON(in_interrupt()) does the job. I'll try it here, and
> | > if it doesn't trigger I'll submit a patch to Andrew only for
> | > testing porpuses (ie, not for mainline).
> | 
> | Luiz, you can't be serious! You have to do a review and write call paths
> | on a piece of paper or however you prefer to do it. Your testing is
> | extremely limited as we know, you don't even have a null-modem cable.
> | So if the patch does not trip in your testing it tells you absolutely
> | nothing. But even in context of AKPM's tree you can't rely on run-time
> | checks to pick this sort of things.
> 
>  Hey, take it easy. :)
> 
>  I won't test it in my patches. I'll hack the Serial Core code and add
> debug code just before every call to those functions we want to know
> whether they run in interrupt context or not.
> 
>  Yeah, I know, it's still limited because the driver itself can call its
> methods directly in interrupt context. But I think it's a good start.
> 
> | And putting a BUG in there is irresponsible too. It's such a critical
> | subsystem. Drop bytes or return zero modem lines, but do not bug out.
> 
>  Well, I want the easier, fastest and non-questionable way to know whether
> they are called from an interrupt context or not. The first thing that
> came to my mind was: blow up everything if it has been called in
> interrupt context.
> 
>  But I'm open for suggestions, of course.

WARN_ON(in_interrupt());
is much nicer.  It gives you a full dump, yet lets the machine keep
working so that users can actually give you the bug report.

thanks,

greg k-h
