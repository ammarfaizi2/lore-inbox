Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266000AbRF1P77>; Thu, 28 Jun 2001 11:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266005AbRF1P7t>; Thu, 28 Jun 2001 11:59:49 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30735 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266000AbRF1P7n>; Thu, 28 Jun 2001 11:59:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jonathan Morton <chromi@cyberspace.org>, mike_phillips@urscorp.com,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM Requirement Document - v0.0
Date: Thu, 28 Jun 2001 18:02:58 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <OF95A43E53.39291B42-ON84256A79.003D421D@urscorp.com> <01062816393503.00419@starship> <a05100301b760fb217ddc@[192.168.239.101]>
In-Reply-To: <a05100301b760fb217ddc@[192.168.239.101]>
MIME-Version: 1.0
Message-Id: <01062818025707.00419@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 June 2001 17:21, Jonathan Morton wrote:
> >There is a simple change in strategy that will fix up the updatedb case
> > quite nicely, it goes something like this: a single access to a page
> > (e.g., reading it) isn't enough to bring it to the front of the LRU
> > queue, but accessing it twice or more is.  This is being looked at.
>
> Say, when a page is created due to a page fault, page->age is set to
> zero instead of whatever it is now.

This isn't quite enough.  We do want to be able to assign a ranking to 
members of the accessed-once set, and we do want to distinguish between newly 
created pages and pages that have aged all the way to zero.

> Then, on the first access, it is
> incremented to one.  All accesses where page->age was previously zero
> cause it to be incremented to one, and subsequent accesses where
> page->age is non-zero cause a doubling rather than an increment.
> This gives a nice heavy priority boost to frequently-accessed pages...

While on that topic, could somebody please explain to me why exponential 
aging is better than linear aging by a suitably chosen increment?  It's clear 
what's wrong with it: after 32 hits you lose all further information.  I 
suspect there are more problems with it than that.

--
Daniel
