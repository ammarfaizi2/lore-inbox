Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbWAJNwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWAJNwO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWAJNwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:52:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36932 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932067AbWAJNwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:52:13 -0500
Date: Tue, 10 Jan 2006 14:54:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110135404.GF3389@suse.de>
References: <20060110125852.GA3389@suse.de> <17347.47882.735057.154898@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17347.47882.735057.154898@alkaid.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Mikael Pettersson wrote:
> Jens Axboe writes:
>  > Hi,
>  > 
>  > It does annoy me that any 1G i386 machine will end up with 1/8th of the
>  > memory as highmem. A patch like this one has been used in various places
>  > since the early 2.4 days at least, is there a reason why it isn't merged
>  > yet? Note I just hacked this one up, but similar patches abound I'm
>  > sure. Bugs are mine.
>  > 
>  > Signed-off-by: Jens Axboe <axboe@suse.de>
>  > 
>  > diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
>  > index d849c68..0b2457b 100644
>  > --- a/arch/i386/Kconfig
>  > +++ b/arch/i386/Kconfig
>  > @@ -444,6 +464,24 @@ config HIGHMEM64G
>  >  
>  >  endchoice
>  >  
>  > +choice
>  > +	depends on NOHIGHMEM
>  > +	prompt "Memory split"
>  > +	default DEFAULT_3G
>  > +	help
>  > +	  Select the wanted split between kernel and user memory. On a 1G
>  > +	  machine, the 3G/1G default split will result in 128MiB of high
>  > +	  memory. Selecting a 2G/2G split will make all of memory available
>  > +	  as low memory. Note that this will make your kernel incompatible
>  > +	  with binary only kernel modules.
> 
> 2G/2G is not the only viable alternative. On my 1GB x86 box I'm

Yes I know, as I wrote to Ingo I wanted to keep it really simple. It can
easily be extended, of course.

> using "lowmem1g" patches for both 2.4 and 2.6, which results in
> 2.75G for user-space. I'm sure others have other preferences.
> Any standard option for this should either have several hard-coded
> alternatives, or should support arbitrary values (within reason).

That's just asking for trouble, imho. We should provide some defaults
(that work well on 1G and 2G machines, for instance) and stick to that.

> (See http://www.csd.uu.se/~mikpe/linux/patches/*/patch-i386-lowmem1g-*
> if you're interested.)

It's similar to what I've been doing so far (just changing page.h to
0xb0000000). 0x80000000 might be a bad default as suggested by Byron, as
it just misses the full 2G.

0xb0000000 is a much better default, but I didn't think that would fly
as a patch.

-- 
Jens Axboe

