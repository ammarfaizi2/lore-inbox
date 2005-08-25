Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVHYQBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVHYQBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVHYQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:01:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:52242 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932219AbVHYQBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:01:38 -0400
Date: Thu, 25 Aug 2005 18:01:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka Enberg <penberg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: -mm patch] kcalloc(): INT_MAX -> ULONG_MAX
Message-ID: <20050825160136.GA6471@stusta.de>
References: <20050820193237.GG3615@stusta.de> <84144f0205082112477979b053@mail.gmail.com> <20050821195434.GC5726@stusta.de> <84144f0205082113123049afe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f0205082113123049afe2@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2005 at 11:12:06PM +0300, Pekka Enberg wrote:
> On Sun, Aug 21, 2005 at 10:47:13PM +0300, Pekka Enberg wrote:
> > > You'll probably get even better code if you change the above to:
> > >
> > >     if (size != 0 && n > ULONG_MAX / size)
> > >
> > > Reason being that size is virtually always a constant so the compiler
> > > can evaluate the division at compile-time.
> 
> On 8/21/05, Adrian Bunk <bunk@stusta.de> wrote:
> > I doubt this would make any difference.
> > 
> > And besides, except in some rare cases, the second argument is a
> > sizeof(foo) whose size is already known at compile time.
> 
> Yes, that's my point. The second argument (size) is virtually always
> sizeof() whereas the first one (n) is sometimes a variable. GCC
> currently does not optimize away the division when n is not a
> constant.
> 
> Looking at 2.6.13-rc6-mm1, we have roughly 15 callers with the first
> parameter being a variable. The compiler would be able to get rid of
> one comparison and division instruction for each of these so looks
> like we could shave off some more bytes...

With gcc 4.0.1:

    text           data     bss     dec             hex filename
25675334        5851630 1819976 33346940        1fcd57c vmlinux-my-patch
25675366        5851630 1819976 33346972        1fcd59c vmlinux-your-patch

INT_MAX -> ULONG_MAX is correct, even though it doesn't seem to make a 
difference with today's gcc.

Trying to change the code in a way that gcc will produce better code 
doesn't seem to be worth it (except in extreme hot paths).

>                             Pekka

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

