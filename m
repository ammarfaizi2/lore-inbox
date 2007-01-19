Return-Path: <linux-kernel-owner+w=401wt.eu-S932857AbXASONu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbXASONu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932866AbXASONu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:13:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2162 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932857AbXASONt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:13:49 -0500
Date: Fri, 19 Jan 2007 15:13:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
Message-ID: <20070119141355.GM9093@stusta.de>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6> <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f020701190501x5d1efb49u87dc9537bfe1e791@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2007 at 03:01:44PM +0200, Pekka Enberg wrote:
> On 1/19/07, Robert P. J. Day <rpjday@mindspring.com> wrote:
> >is there a simple explanation for how to *properly* define inline
> >routines in the kernel?  and maybe this can be added to the
> >CodingStyle guide (he mused, wistfully).
> 
> AFAIK __always_inline is the only reliable way to force inlining where
> it matters for correctness (for example, when playing tricks with
> __builtin_return_address like we do in the slab).
> 
> Anything else is just a hint to the compiler that might be ignored if
> the optimizer thinks it knows better.

With the current implementation in the kernel (and considering that 
CONFIG_FORCED_INLINING was implemented in a way that it never had any 
effect), __always_inline and inline are currently equivalent.

__always_inline is mostly an annotation that really bad things might 
happen if the code doesn't get inlined.

But I'm not sure whether such a distinction is required at all - the 
rule of thumb should be that static functions in headers should be 
inline (otherwise, they belong into a C file), and functions in C files 
should never be marked inline. [1]

cu
Adrian

[1] For the latter there might be a handful of exceptions in the whole 
    kernel in real fastpath code, but usually gcc knows best when to 
    inline a function - and we have a global CONFIG_CC_OPTIMIZE_FOR_SIZE 
    knob for influencing the decision.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

