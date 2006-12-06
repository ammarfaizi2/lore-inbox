Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937137AbWLFTDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937137AbWLFTDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937189AbWLFTDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:03:38 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58032 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937137AbWLFTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:03:36 -0500
Date: Wed, 6 Dec 2006 11:02:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
In-Reply-To: <16935.1165430602@redhat.com>
Message-ID: <Pine.LNX.4.64.0612061057540.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org> 
 <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> <1165125055.5320.14.camel@gullible>
 <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <21690.1165426993@redhat.com>
 <Pine.LNX.4.64.0612060951150.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612060955380.3542@woody.osdl.org>  <16935.1165430602@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, David Howells wrote:
>
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> >  (a) "volatile" on kernel data is basically always a bug, and you should 
> >      use locking.
> 
> But what about when you're building a lock?  Actually, I suspect correct usage
> of asm constraints and memory barriers trumps volatile anyway even there.

The word you look for is not "suspect".

You _cannot_ build a lock using "volatile", unless your CPU is strictly 
in-order and has an in-order memory subsystem too (so, for example, while 
all ia64 implementations today are in-order, they do /not/ have an 
in-order memory subsystem). Only then could you do locking with volatile 
and some crazy Peterson's algorithm.

I don't think any such CPU actually exists.

Anyway, we've had this discussion before on linux-kernel, it really boils 
down to that "volatile" is basically never correct with the exception of 
flags that don't have any meaning and that you don't actually _care_ about 
the exact value (the low word of "jiffies" being the canonical example of 
something where "volatile" is actually fine, and where - as long as you 
can load it atomically - "volatile" really does make sense).

		Linus
