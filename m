Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSA2Ivb>; Tue, 29 Jan 2002 03:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288955AbSA2IvU>; Tue, 29 Jan 2002 03:51:20 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:44161 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288951AbSA2IvI>;
	Tue, 29 Jan 2002 03:51:08 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Momchil Velikov <velco@fadata.bg>, Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 09:55:02 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <87lmehft5b.fsf@fadata.bg>
In-Reply-To: <87lmehft5b.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VU2h-00009Y-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 09:39 am, Momchil Velikov wrote:
> >>>>> "Oliver" == Oliver Xymoron <oxymoron@waste.org> writes:
> Oliver> you can't actually _share_ the page tables without marking the pages
> Oliver> themselves readonly.
> 
> Of course, ptes are made COW, just like now. Which brings up the
> question how much speedup we'll gain with a code that touches every
> single pte anyway ?

It's only touching the ptes on tables that are actually used, so if a parent
with a massive amount of mapped memory forks a child that only instantiates
a small portion of it (common situation) then the saving is pretty big.

Note that I'm not counting on this to be a huge performance win, except in
the specific case that that is bothering rmap.  This is already worth the
price of admission.

This code might also be helpful if we want to get into swapping page tables
at some point, and it can also be pushed in the direction of sharing page
tables for mmaps.  There it could be quite helpful, for example, with glibc.
(Thanks to Suparna for that observation.)

-- 
Daniel
