Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWAJNff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWAJNff (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWAJNff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:35:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:21301 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750794AbWAJNfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:35:34 -0500
Date: Tue, 10 Jan 2006 14:37:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110133728.GB3389@suse.de>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110132957.GA28666@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > Hi,
> > 
> > It does annoy me that any 1G i386 machine will end up with 1/8th of 
> > the memory as highmem. A patch like this one has been used in various 
> > places since the early 2.4 days at least, is there a reason why it 
> > isn't merged yet? Note I just hacked this one up, but similar patches 
> > abound I'm sure. Bugs are mine.
> 
> yes, i made it totally configurable in 2.4 days: 1:3, 2/2 and 3:1 splits 
> were possible. It was a larger patch to enable all this across x86, but 
> the Kconfig portion was removed a bit later because people _frequently_ 
> misconfigured their kernels and then complained about the results.

How is this different than all other sorts of misconfigurations? As far
as I can tell, the biggest "problem" for some is if they depend on some
binary module that will of course break with a different page offset.

For simplicity, I didn't add more than the 2/2 split, where we could add
even a 3/1 kernel/user or a 0.5/3.5 (I think sles8 had this).

> so for now the trivial solution is to change the "C" to "8" in the 
> following line in include/asm-i386/page.h:
> 
> >  #define __PAGE_OFFSET		(0xC0000000)
> 
> instead of editing your .config :-)

:-)

That is what I have been doing, but that requires me to carry this patch
along with me all the time. So it annoys me!

I would have posted a simple patch moving it to 0xB0000000 which would
solve the problem for me as well, but I didn't because I'm sure people
would be screaming at me...

> Maybe we could try the Kconfig solution again, but it'll need alot 
> better documentation, dependency on KERNEL_DEBUG and some heavy warnings 
> all around.

The help text could definitely be improved, it was a 30 second hackup.
Why would you want to make it depend on DEBUG?

-- 
Jens Axboe

