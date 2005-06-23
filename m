Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVFWQxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVFWQxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVFWQxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 12:53:19 -0400
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:50319 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S262588AbVFWQxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 12:53:12 -0400
Date: Thu, 23 Jun 2005 18:53:09 +0200
From: =?iso-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>
To: Tim Bird <tim.bird@am.sony.com>
Cc: linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       "Sean M. Burke" <sburke@cpan.org>, trivial@rustcorp.com.au
Subject: Re: PATCH: "Ok" -> "OK" in messages
Message-ID: <20050623165309.GA23548@ojjektum.uhulinux.hu>
References: <42985251.6030006@cpan.org> <1117279792.32118.11.camel@localhost.localdomain> <20050528125430.GB3870@ojjektum.uhulinux.hu> <42BAE3B1.5010209@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAE3B1.5010209@am.sony.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 09:30:41AM -0700, Tim Bird wrote:
> >> While we are at it, what about changing this string to something
> >> language-neutral, like this:
> >>
> >> diff -Naurdp a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
> >> --- a/arch/i386/boot/compressed/misc.c	2004-04-04 05:37:23.000000000 +0200
> >> +++ b/arch/i386/boot/compressed/misc.c	2004-05-09 23:18:06.000000000 +0200
> >> @@ -10,6 +10,7 @@
> >>   */
> >>
> >>  #include <linux/linkage.h>
> >> +#include <linux/version.h>
> >>  #include <linux/vmalloc.h>
> >>  #include <linux/tty.h>
> >>  #include <video/edid.h>
> >> @@ -373,9 +374,9 @@ asmlinkage int decompress_kernel(struct
> >>  	else setup_output_buffer_if_we_run_high(mv);
> >>
> >>  	makecrc();
> >> -	putstr("Uncompressing Linux... ");
> >> +	putstr("Linux " UTS_RELEASE);
> >>  	gunzip();
> >> -	putstr("Ok, booting the kernel.\n");
> >> +	putstr("\n");
> >>  	if (high_loaded) close_output_buffer_if_we_run_high(mv);
> >>  	return high_loaded;
> >>  }
> 
> 
> Language neutrality is not a goal for kernel messages,
> that I'm aware of.

Of course this is true, but I think this very one is an exception: this 
is the only one seen when booting with the "quiet" kernel option or 
using some shiny bootlogo patches, both of which is common practice 
among distribution-shipped kernels.


> I disagree with this change because
> it yields a net reduction in understanding what's going
> on during booting.

No, it does not yields any reduction. Only the strings itself are 
changed, not the time they are printed.
Besides, nobody is interested that actually an uncompress step is in 
progress, that just works. And, btw if it fails (the gunzip), it prints 
an error message anyway iirc.


-- 
pozsy
