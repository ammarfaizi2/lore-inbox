Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289466AbSA2KXz>; Tue, 29 Jan 2002 05:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289481AbSA2KXp>; Tue, 29 Jan 2002 05:23:45 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:28802 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289466AbSA2KX0>;
	Tue, 29 Jan 2002 05:23:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Momchil Velikov <velco@fadata.bg>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 11:27:36 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <E16VU2h-00009Y-00@starship.berlin> <87g04pfr8y.fsf@fadata.bg>
In-Reply-To: <87g04pfr8y.fsf@fadata.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VVUG-00009s-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 10:20 am, Momchil Velikov wrote:
> >>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:
> 
> Daniel> On January 29, 2002 09:39 am, Momchil Velikov wrote:
> >> >>>>> "Oliver" == Oliver Xymoron <oxymoron@waste.org> writes:
> Oliver> you can't actually _share_ the page tables without marking the pages
> Oliver> themselves readonly.
> >> 
> >> Of course, ptes are made COW, just like now. Which brings up the
> >> question how much speedup we'll gain with a code that touches every
> >> single pte anyway ?
> 
> Daniel> It's only touching the ptes on tables that are actually used, so if a parent
> Daniel> with a massive amount of mapped memory forks a child that only instantiates
> Daniel> a small portion of it (common situation) then the saving is pretty big.
> 
> Umm, all the ptes af the parent ought to be made COW, no ?

My explanation above is borked, please see my reply to wli.  In short, each 
page table of the parent is already either shared - in which case the CoW 
ptes are already marked RO - or it was instantiated by the parent, in which 
case the work of marking its pte's RO is insignificant, and is certainly not 
more than the cost incurred by the current method.

-- 
Daniel
