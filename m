Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289515AbSA2Lj1>; Tue, 29 Jan 2002 06:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289523AbSA2LjR>; Tue, 29 Jan 2002 06:39:17 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:59656 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289515AbSA2LjF>;
	Tue, 29 Jan 2002 06:39:05 -0500
Date: Tue, 29 Jan 2002 09:38:50 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <E16VWR4-00009x-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L.0201290937160.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Daniel Phillips wrote:

> > Either that, or we don't populate the page tables of the
> > parent and the child at all and have the page tables
> > filled in at fault time.
>
> Yes, you could go that route but you'd have to do some weird and wonderful
> bookkeeping to figure out how to populate those page tables.

Not really, if the page table isn't present you just check whether
you need to allocate a new one or whether you need to instantiate
one.

That can all be done from within pte_alloc, which is always called
by handle_mm_fault()...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

