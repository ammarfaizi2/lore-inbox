Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTEWRzd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 13:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTEWRzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 13:55:33 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:58847 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264110AbTEWRzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 13:55:31 -0400
Date: Fri, 23 May 2003 14:06:08 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap - a schema proposal
In-Reply-To: <Pine.LNX.4.44.0305172141110.32047-100000@marcellos.corky.net>
Message-ID: <Pine.LNX.4.33.0305231355030.13942-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yoav:

I am sort of back, sorry for not getting back earlier but there i am sort
of juggling a couple of things right now ;)

Any how, here is a slightly different approach to our problem that may
solve some of these issues:

Maintain a seperate key-pair list seperately with an expiry, say with an
entropy factor determining the hard limit on the number of elements in the
list of the key-pair.

Take a page-based unique id, and map it to the keylist using some type of
bucket hashing scheme.

Add a page to a key's pagelist until a particular upper limit at which
case the key is flagged as retired and only will be used to decrypt any
pending pages, a new key will be added in its place.

A key may also retire after a soft timeout.  We can have kswapd or a
sibling run through the list and retire keys in one shot, or during a BH.

Round-robin :-) between keys.  The number of keys maintained and the
overhead etc. at a given time can now be significantly tuned by the system
administrator based on the exact resource requirements.

What do you think?

Ahmed.

On Sat, 17 May 2003, Yoav Weiss wrote:

> On Sat, 17 May 2003, Ahmed Masud wrote:
>
> > Hi Yoav:
> >
> > I have read your latest emails (ref, mm_struct and vma_struct), i am
> > just dropping a note to ack them because i won't have a chance to study
> > the points you make in detail over this weekend busy with something else.
> >
> > Cheers and a good weekend to you,
> >
> > Ahmed.
> >
>
> Have a good weekend too.  (mine is over now).
>
> When you're back, read Hugh Dickins' message re multiple mm's owning the
> same page in swap.  If it really works this way, we may have to assoc the
> keys with an even lower layer, and work harder on the relationship between
> pages and processes.
>
> 	Yoav
>
>

