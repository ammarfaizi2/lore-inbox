Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUFZXsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUFZXsl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 19:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267236AbUFZXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 19:48:41 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5629 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267235AbUFZXsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 19:48:38 -0400
Date: Sun, 27 Jun 2004 01:48:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Andreas Gruenbacher <agruen@suse.de>,
       Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Testing for kernel features in external modules
Message-ID: <20040626234835.GP18303@fs.tum.de>
References: <20040624203043.GA4557@mars.ravnborg.org> <20040624203516.GV31203@schnapps.adilger.int> <200406251032.22797.agruen@suse.de> <20040625090413.GM3956@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040625090413.GM3956@marowsky-bree.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 11:04:13AM +0200, Lars Marowsky-Bree wrote:
> On 2004-06-25T10:32:22,
>    Andreas Gruenbacher <agruen@suse.de> said:
> 
> > I disagree. I don't think we want to clutter the code with feature
> > definitions that have no known users. That doesn't age/scale very
> > well. It's easy enough to test for features in the external module.
> 
> True enough, but how do you propose to do that? I do understand the pain
> of the external module builds who have to try and support the vanilla
> kernel plus several vendor trees.
> 
> Yes, of course, we could end up with a autoconf like approach for
> building them, but ... you know ... that's sort of ugly.
> 
> Having a list of defines to document the version of a specific API in
> the kernel, and a set of defines pre-fixed with <vendor>_ to document
> vendor tree extensions may not be the worst thing:
>...
> Now the granularity of the API versioning is interesting - per .h is too
> coarse, and per-call would be too fine. But I'm sure someone could come
> up with a sane proposal here.

What's an API for modules?
- whether a .h file is present under include/
- every EXPORT_SYMBOL{,_GPL}'ed function
- every inlined function under include/
- every struct defined under include/
- perhaps more things I'm currently forgetting

Every change to something mentioned above during a development kernel 
needs to be cover by an appropriate API versioning.

And then consider as an example cases like a function returning 
irqreturn_t in 2.6:
- in 2.6, this function returns irqreturn_t (typedef'd to int)
- in 2.4, this function might return irqreturn_t (typedef'd to void)
- in 2.4, this function might return void

I'm sure there is a correct solution for such cases - but it's extra
work and easy to get things wrong.

Why do you dislike autoconf? I do not pretend autoconf where perfect -
but it works. Looking at the external ALSA, autoconf seems to be a good 
solution to probe for exact the things a module needs without a big 
overhead in kernel development.

> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

