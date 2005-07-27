Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVG0Q1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVG0Q1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 12:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262435AbVG0QYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 12:24:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:62470 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262422AbVG0QXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 12:23:46 -0400
Date: Wed, 27 Jul 2005 18:23:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kimball Murray <kmurray@redhat.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline"
Message-ID: <20050727162334.GF3160@stusta.de>
References: <20050726145344.GO3160@stusta.de> <20050727142912.GJ6920@suse.de> <42E7A157.3080508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E7A157.3080508@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 10:59:35AM -0400, Kimball Murray wrote:
> Jens Axboe wrote:
> 
> >On Tue, Jul 26 2005, Adrian Bunk wrote:
> > 
> >
> >>"extern inline" doesn't make much sense.
> >>   
> >>
> >
> >Yep, thanks.
> >
> > 
> >
> IIRC, there was a time when the extern inline construct was used to 
> catch cases where the compiler did not inline the function (you'd get a 
> link error).  Seems like it still works.  Try building the attached 
> files in each of the following ways:
> 
> gcc -o foo foo.c
> 
>    and
> 
> gcc -O2 -o foo foo.c
> 
> In the first case, you get a link error, because there is no inlining.

In the kernel, we have a
  # define inline         inline          __attribute__((always_inline))

This doesn't leave gcc any choice to not inline the function.

> -kimball

> #include "bar.h"
> 
> void foo(void) {
> 	bar();
> }
> 
> int main(int argc, char *argv[])
> {
> 	foo();
> 	return 0;
> }

> extern inline void bar(void)
> {
> }

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

