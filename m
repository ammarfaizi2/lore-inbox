Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289172AbSA2JTA>; Tue, 29 Jan 2002 04:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289114AbSA2JSt>; Tue, 29 Jan 2002 04:18:49 -0500
Received: from holomorphy.com ([216.36.33.161]:17052 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289084AbSA2JSs>;
	Tue, 29 Jan 2002 04:18:48 -0500
Date: Tue, 29 Jan 2002 01:20:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Momchil Velikov <velco@fadata.bg>, Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129012007.H899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Momchil Velikov <velco@fadata.bg>,
	Oliver Xymoron <oxymoron@waste.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.44.0201281918050.18405-100000@waste.org> <87lmehft5b.fsf@fadata.bg> <E16VU2h-00009Y-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E16VU2h-00009Y-00@starship.berlin>; from phillips@bonn-fries.net on Tue, Jan 29, 2002 at 09:55:02AM +0100
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 09:55:02AM +0100, Daniel Phillips wrote:
> It's only touching the ptes on tables that are actually used, so if a parent
> with a massive amount of mapped memory forks a child that only instantiates
> a small portion of it (common situation) then the saving is pretty big.

Please correct my attempt at clarifying this:
The COW markings are done at the next higher level of hierarchy above
the pte's themselves, and so experience the radix tree branch factor
reduction in the amount of work done at fork-time in comparison to a
full pagetable copy on fork.

On Tue, Jan 29, 2002 at 09:55:02AM +0100, Daniel Phillips wrote:
> Note that I'm not counting on this to be a huge performance win, except in
> the specific case that that is bothering rmap.  This is already worth the
> price of admission.

It is an overall throughput loss in the cases where the majority of the
page table entries are in fact referenced by the child, and this is
more than acceptable because it is more incremental, reference-all is
an uncommon case, and once all the page table entries are referenced,
there are no longer any penalties. Defeating this scheme would truly
require a contrived application, and penalizes only that application.

Cheers,
Bill
