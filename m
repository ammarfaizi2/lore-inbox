Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVIESAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVIESAJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVIESAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:00:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932360AbVIESAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:00:07 -0400
Date: Mon, 5 Sep 2005 20:00:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Matz <matz@suse.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" -> "static inline"
Message-ID: <20050905180005.GA3776@stusta.de>
References: <20050902203123.GT3657@stusta.de> <Pine.LNX.4.58.0509051047530.27439@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509051047530.27439@wotan.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:52:47AM +0200, Michael Matz wrote:
> Hi,
> 
> On Fri, 2 Sep 2005, Adrian Bunk wrote:
> 
> > "extern inline" doesn't make much sense.
> 
> It does.  It's a GCC extension which says "never ever emit an out-of-line
> version of this function, not even if its address is taken", i.e. it's
> implicitely assumed, that if there is a need for such out-of-line variant,
> then it is provided by some other mean (for instance by defining it
> without inline markers in some .o file).  Usually there won't be such need

So you agree with my statement that it doesn't make sense because there 
are no out-of-line variants?

> as all instances are inlined, in which case the out-of-line version would
> be dead bloat, which you can't get rid of without this extension.  And if
> some calls are not inlined then this extension serves as a poor mans
> check, because a link error will result.

In the kernel (with gcc >= 3.1), _every_ inline is forced to             
always_inline resulting in gcc aborting with an error if it can't inline 
the function.

Therefore any such out-of-line version if it existed would be dead 
bloat.

> All in all, it does make sense, and no it's not the same as a "static 
> inline", not even if forced always_inline.

It isn't the same, but "static inline" is the correct variant.

"extern inline __attribute__((always_inline))" (which is what
"extern inline" is expanded to) doesn't make sense.

> Ciao,
> Michael.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

