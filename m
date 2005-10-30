Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVJ3ROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVJ3ROn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVJ3ROm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 12:14:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23567 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932186AbVJ3ROm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 12:14:42 -0500
Date: Sun, 30 Oct 2005 18:14:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: John David Anglin <dave@hiauly1.hia.nrc.ca>
Cc: matthew@wil.cx, parisc-linux@parisc-linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: [parisc-linux] [2.6 patch] parisc: "extern inline" -> "static
Message-ID: <20051030171431.GH4180@stusta.de>
References: <20051030155624.GG4180@stusta.de> <200510301642.j9UGgqp3000803@hiauly1.hia.nrc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510301642.j9UGgqp3000803@hiauly1.hia.nrc.ca>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 11:42:52AM -0500, John David Anglin wrote:
> > > I really don't think it makes any difference.  Such a function (returning
> > > always 0) is always going to be inlined, and the only difference between
> > > static inline and extern inline is what happens when it can't be inlined.
> > 
> > On !alpha we are defining inline to __attribute__((always_inline)) for 
> > any non-ancient gcc making this a zero difference.
> 
> It looks as if there are subtle differences between "always_inline"
> and "extern inline".  From the GCC extensions document:
> 
>   [always_inline]
>   Generally, functions are not inlined unless optimization is specified.
>   For functions declared inline, this attribute inlines the function even
>   if no optimization level was specified.
> 
>   [extern inline]
>   If you specify both @code{inline} and @code{extern} in the function
>   definition, then the definition is used only for inlining.  In no case
>   is the function compiled on its own, not even if you refer to its
>   address explicitly.  Such an address becomes an external reference, as
>   if you had only declared the function, and had not defined it.
> 
> The primary difference between "static inline" and "extern inline"
> is in what happens when the address of the function is referenced.
> With "extern inline", you need a unique library function to resolve
> external references.  With "static inline", you may end up with
> multiple copies of a function if its address is taken.
>...

In the kernel, "static inline" expands to
"static inline __attribute__((always_inline))" and
"extern inline" expands to 
"extern inline __attribute__((always_inline))".

> Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

