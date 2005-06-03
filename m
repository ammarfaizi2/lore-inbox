Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVFCJmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFCJmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 05:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVFCJmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 05:42:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:11163 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261194AbVFCJm0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 05:42:26 -0400
Date: Fri, 3 Jun 2005 11:42:23 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>
cc: XIAO Gang <xiao@unice.fr>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Suggestion on "int len" sanity
In-Reply-To: <20050601203933.GP18600@alpha.home.local>
Message-ID: <Pine.LNX.4.62.0506031142050.16362@numbat.sonytel.be>
References: <429D5E79.2010707@unice.fr> <20050601203933.GP18600@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2005, Willy Tarreau wrote:
> On Wed, Jun 01, 2005 at 09:06:33AM +0200, XIAO Gang wrote:
> > I would like to make a security suggestion.
> > 
> > There are many length variables in the kernel, locally declared as "len" 
> > or "length", either as "int", "unsigned int" or "size_t". However, 
> > declaring a length as "int" leads easily to an erroneous situation, as 
> > the author (or even a code checker) might make the implicite hypothesis 
> > that the length is positive, so that it is enough to make a sanity check 
> > of the kind
> > 
> > if (length > limit) ERROR;
> > 
> > which is not enough.
> > 
> > On the other hand, when a variable is named "len" or "length", it is 
> > usually used for length and never should go negative. So could I suggest 
> > that the declarations of these variables to be uniformized to "size_t", 
> > via a gradual but sysmatic cleanup?
> 
> Probably true for most cases, but be careful of code which would use
> -1 to report some errors if such thing exists.

In that case, use ssize_t.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
