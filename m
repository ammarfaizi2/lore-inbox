Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbWCCXn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbWCCXn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 18:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932595AbWCCXnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 18:43:25 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25101 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932562AbWCCXnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 18:43:24 -0500
Date: Sat, 4 Mar 2006 00:43:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, geert@linux-m68k.org, zippel@linux-m68k.org,
       linux-m68k@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Message-ID: <20060303234323.GF9295@stusta.de>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org> <20060303230149.GB9295@stusta.de> <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603031515321.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2006 at 03:22:42PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 4 Mar 2006, Adrian Bunk wrote:
> > 
> > It seems the problem is that in the CONFIG_RMW_INSNS=n case, there's no 
> > cmpxchg #define in include/asm-m68k/system.h required for the 
> > atomic_add_unless #define in include/asm-m68k/atomic.h.
> 
> Hmm. It seems like it never has been there.. Do you know what brought this 
> on? Was it Nick's RCU changes from "rcuref_dec_and_test()" to 
> "atomic_dec_and_test()" and friends? 

It was Nick's commit 8426e1f6af0fd7f44d040af7263750c5a52f3cc3 that added 
atomic_inc_not_zero(), and Nick's patch that changed fs/file_table.c 
from rcuref_dec_and_test() to atomic_dec_and_test() exposed this 
problem.

> Judging by your error messages, I _think_ it's the "atomic_inc_not_zero()" 
> that gets expanded to a cmpxchg() that simply doesn't exist on m68k and 
> never has.

Exactly, that's what I wanted to say in my report.

> I guess we've never depended on cmpxchg before. Or am I missing something?

It seems this is the case.

And as far as I can see, m68k is the only architecture where cmpxchg 
isn't always available.

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

