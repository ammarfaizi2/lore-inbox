Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbRG0Mvy>; Fri, 27 Jul 2001 08:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268840AbRG0Mvo>; Fri, 27 Jul 2001 08:51:44 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54027 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267980AbRG0Mvd>; Fri, 27 Jul 2001 08:51:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: hochakhung@netscape.net, linux-kernel@vger.kernel.org
Subject: Re: Lock the page
Date: Fri, 27 Jul 2001 14:56:21 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <03E90795.17A1F592.0F45C3B8@netscape.net>
In-Reply-To: <03E90795.17A1F592.0F45C3B8@netscape.net>
MIME-Version: 1.0
Message-Id: <01072714562107.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 04:55, hochakhung@netscape.net wrote:
> After getting a page from alloc_pages(mask, order), is it necessary
> to lock the page to prevent it from being swapped out? Can I assume
> that I already have exclusive access to the page? Can I assume that
> the page is free and no other kernel control paths would use it?

You alloced it, it's yours.  You haven't entered it into any managed
structure like the page cache, it's not on a lru list so it won't be
scanned by reclaim, and no page table entry points at it (except for
the kernel's own linear mapping if it's not a highuser page) so
virtual scanning won't find it either.

--
Daniel
