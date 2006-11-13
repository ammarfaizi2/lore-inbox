Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755343AbWKMUxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbWKMUxb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755340AbWKMUxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:53:31 -0500
Received: from mx1.mail.ru ([194.67.23.121]:50737 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S1755342AbWKMUx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:53:29 -0500
X-Nat-Received: from [10.10.231.1]:1982 [ident-empty]
	by rt-cwn.z-net.ru with TPROXY id 1163451288.13088
	abuse-to abuse@ss-lan.ru
Date: Tue, 14 Nov 2006 00:56:26 +0300
From: Anton Vorontsov <cbou@mail.ru>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       rpurdie@rpsys.net
Subject: Re: [ARM] Corrupted .got section with 2.6.18 and JFFS2 (solved)
Message-ID: <20061113215626.GA22675@localhost>
Reply-To: cbou@mail.ru
References: <ly1wozcr1d.fsf@ensc-pc.intern.sigma-chemnitz.de> <ly64dyt7de.fsf@ensc-pc.intern.sigma-chemnitz.de> <1162497112.12781.51.camel@localhost.localdomain> <lywt6cc04g.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <lywt6cc04g.fsf_-_@ensc-pc.intern.sigma-chemnitz.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard, Enrico!

On Fri, Nov 03, 2006 at 11:09:35AM +0100, Enrico Scholz wrote:
> [CC lkml; original issue at
>  http://article.gmane.org/gmane.linux.ports.arm.kernel/28068]
> 
> rpurdie@rpsys.net (Richard Purdie) writes:
> 
> >> > I have a problem with JFFS2 filesystem and kernel 2.6.18. When
> >> > starting a program which uses a certain library (libutil.so.1 in
> >> > my case), the .got section of the library can be initialized
> >> > wrongly when the used memory is uninitialized.
> >> 
> >> Problem seems to be caused by
> >> 
> >> | [PATCH] zlib_inflate: Upgrade library code to a recent version
> >> 
> >> (4f3865fb57a04db7cca068fed1c15badc064a302)
> >> 
> >> After reverting this (and related patches), things seem to work.
> >> 
> >> I don't have an idea yet, which changes in this complex patch are
> >> really responsible....
> >
> > I'm the author of the above change. I just ran your test program
> > on a device (ARM PXA255 with 2.6.19-rc4 kernel, 2.3.5ish glibc,
> > gcc 3.4.4, libraries on jffs2) and I can't reproduce the
> > problem.
> 
> I can reproduce it 100% with:

Same here. I can reproduce exactly same problem. And reverting zlib
changes fixes it. I'm testing it on ARM PXA270 + binutils-2.17 +
glibc-2.5 + gcc-4.1.1 (old ABI).

> > Which other related patches did you remove?
> 
> For 2.6.18 tests, I reverted only the patches which changed
> lib/zlib_* after 2.6.17:
> 
> | 31925c8857ba17c11129b766a980ff7c87780301 [PATCH] Fix ppc32 zImage inflate
> | b762450e84e20a179ee5993b065caaad99a65fbf [PATCH] zlib inflate: fix function definitions
> | 0ecbf4b5fc38479ba29149455d56c11a23b131c0 move acknowledgment for Mark Adler to CREDITS
> | 4f3865fb57a04db7cca068fed1c15badc064a302 [PATCH] zlib_inflate: Upgrade library code to a recent version

Indeed. Reverting these patches fixes all these pesky issues with
jffs2/libutil/openpty.

> Enrico

Thanks,

-- Anton (irc: bd2)
