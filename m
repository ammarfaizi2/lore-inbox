Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284180AbSA2WMe>; Tue, 29 Jan 2002 17:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSA2WM3>; Tue, 29 Jan 2002 17:12:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61454 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284732AbSA2WLD>; Tue, 29 Jan 2002 17:11:03 -0500
Date: Tue, 29 Jan 2002 14:10:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201291553150.25443-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0201291407490.1533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Oliver Xymoron wrote:
>
> The "detached mm" approach should be sufficiently parallel to the
> read-only page directory entries that the two can use almost the same
> framework.

Yes. I suspect that it can be trivially hidden in just two
architecture-specific functions, ie something like "detach_pgd(pgd)" and
"attach_pgd_entry(mm, address)".

>	 The downside is faults on reads in the detached case, but that
> shouldn't be significantly worse than the original copy, thanks to the
> large fanout.

Right. We'd get a few "unnecessary" page faults, but they should be on the
order of 0.1% of the necessary ones. In fact, with pre-faulting in
sys_fork(), I wouldn't be surprised if the common case is to not have any
directory-related page faults at all.

		Linus

