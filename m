Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSA2WtN>; Tue, 29 Jan 2002 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285516AbSA2WtD>; Tue, 29 Jan 2002 17:49:03 -0500
Received: from dsl-213-023-043-145.arcor-ip.net ([213.23.43.145]:51080 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285352AbSA2Ws5>;
	Tue, 29 Jan 2002 17:48:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Oliver Xymoron <oxymoron@waste.org>
Subject: Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 23:53:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
In-Reply-To: <Pine.LNX.4.33.0201291326340.1334-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201291326340.1334-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Vh7h-0000AX-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 10:50 pm, Linus Torvalds wrote:
> On Tue, 29 Jan 2002, Oliver Xymoron wrote:
> >
> > I don't think read-only for the tables is sufficient if the pages
> > themselves are writable.
> 
> At least on x86, the WRITE bit in the page directory entries will override
> any bits int he PTE. In other words, it doesn't make the page directory
> entries thmselves unwritable - it makes the final pages unwritable.

Ah, didn't know that.

> Which are exactly the semantics we want.

Yes.  This feature might be useful to grab back a few cycles at the expense 
of some extra complexity.  It is not however, a fundamental change to my 
algorithm, just a decoration of it.  It's also possible that the cost of the 
resulting extra fault will wipe out the (small) saving of setting pte entries 
RO in the average case.

It's likely there are architectures where this won't work, and just not doing 
this optimization is the correct approach.

-- 
Daniel
