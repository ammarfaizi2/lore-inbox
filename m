Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWIODsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWIODsN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 23:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWIODsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 23:48:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3288 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932188AbWIODsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 23:48:12 -0400
Date: Thu, 14 Sep 2006 20:48:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Chinner <dgc@sgi.com>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [xfs-masters] Re: 2.6.18-rc6-mm2
Message-Id: <20060914204801.e37a112b.akpm@osdl.org>
In-Reply-To: <20060915025745.GM3034@melbourne.sgi.com>
References: <20060913015850.GB3034@melbourne.sgi.com>
	<20060913042627.GE3024@melbourne.sgi.com>
	<6bffcb0e0609130243y776492c7g78f4d3902dc3c72c@mail.gmail.com>
	<20060914035904.GF3034@melbourne.sgi.com>
	<450914C4.2080607@gmail.com>
	<6bffcb0e0609140150n7499bf54k86e2b7da47766005@mail.gmail.com>
	<20060914090808.GS3024@melbourne.sgi.com>
	<6bffcb0e0609140229r59691de5i58d2d81f839d744e@mail.gmail.com>
	<6bffcb0e0609140303n72a73867qb308f5068733161c@mail.gmail.com>
	<6bffcb0e0609141001ic137201p6a2413f5ca915234@mail.gmail.com>
	<20060915025745.GM3034@melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 12:57:45 +1000
David Chinner <dgc@sgi.com> wrote:

> On Thu, Sep 14, 2006 at 07:01:38PM +0200, Michal Piotrowski wrote:
> > >>
> > >> I'll build system with gcc 3.4
> > >
> > >It's not a compiler issue.
> > >
> > >Binary search should solve this mystery.
> > 
> > I was wrong - it's in vanilla tree
> > (http://www.stardust.webpages.pl/files/mm/2.6.18-rc6-mm2/mm-dmesg1).
> > 
> > cat hunt | head -n 3
> > origin.patch
> > BAD
> > libata-ignore-cfa-signature-while-sanity-checking-an-atapi-device.patch
> 
> Not sure what this means....

"BAD" is a bisection point, as per
http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt.  So
just 2.6.18-rc6+origin.patch exhibits the failure.  That is mainline.

> > I can reproduce this bug with all CONFIG_DEBUG_*=y.
> > (only
> > CONFIG_DEBUG_SYNCHRO_TEST=m
> > CONFIG_RCU_TORTURE_TEST=m
> > as modules)
> 
> I notice you're running i386 with 4k stacks - I wonder if you're blowing the
> stack by running xfs on loopback. I've been testing on x86_64 and ia64
> which don't have those issues. Can you try with 8K stacks instead of
> 4k stacks?

hm, that wouldn't be good.

Enabling CONFIG_DEBUG_STACK_USAGE will make the fourth column in the
sysrq-T output display the minimum-ever free stack space for each task.

sleep         S ffff810100f0bea8     0 18893  22372                     (NOTLB)

                                     ^ this number.
