Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbUK3Xdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUK3Xdu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbUK3Xbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:31:51 -0500
Received: from waste.org ([209.173.204.2]:428 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262449AbUK3XaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:30:23 -0500
Date: Tue, 30 Nov 2004 15:29:58 -0800
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130232958.GW2460@waste.org>
References: <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <1101828924.26071.172.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org> <1101832116.26071.236.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org> <1101837135.26071.380.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org> <Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 02:55:00PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 30 Nov 2004, Matt Mackall wrote:
> > 
> > So we follow dhowell's plan with the following additions:
> 
> No.
> 
> We do _not_ move stuff over that is questionable.

Umm. I don't think you even read what I wrote.
 
> I thought that was clear by now. The rules are:
>  - we only move things that _have_ to move

Yes. And when we move a definition from linux/foo.h to user/foo.h, we include
them from linux/foo.h..

>  - we don't break existing programs, and no "but they are broken already" 
>    is not an excuse.

..which prevents userland breakage during the transition (and is generally what
you want in the kernel anyway).

>  - we only move things where that _particular_ move can be shown to be 
>    beneficial.

It's my opinion that it will eventually be deemed beneficial to
separate out everything that has a legitimate reason to be used by
userspace. But I'm not suggesting getting there in one go, what I'm
suggesting is how to get there incrementally. To rehash:

1. create include/user and friends
2. when we run across a troublesome ABI definition:
     create include/user/foo.h and move the definition there
     make sure include/linux/foo.h includes it
     userspace and kernel compile as before
     send a patch
3. repeat step 2 as often as useful
4. add new user ABI always to include/user/
5. if at some point we find that all of userspace builds from
   include/user/ without reference to include/linux/, declare
   include/user the canonical ABI
6. drop #define __KERNEL__, etc..
7. drop any superfluous include/linux -> include/user includes (there
   shouldn't be many)

-- 
Mathematics is the supreme nostalgia of our time.
