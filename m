Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130912AbRBPStu>; Fri, 16 Feb 2001 13:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130923AbRBPStk>; Fri, 16 Feb 2001 13:49:40 -0500
Received: from colorfullife.com ([216.156.138.34]:49679 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130912AbRBPSt1>;
	Fri, 16 Feb 2001 13:49:27 -0500
Message-ID: <3A8D764B.9CD6B3A8@colorfullife.com>
Date: Fri, 16 Feb 2001 19:49:47 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org,
        bcrl@redhat.com
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <Pine.LNX.4.10.10102160931580.14020-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> 
> >
> > That second pass is what I had in mind.
> >
> > > * munmap(file): No. Second pass required for correct msync behaviour.
> >
> > It is?
> 
> Not now it isn't. We just do a msync() + fsync() for msync(MS_SYNC). Which
> is admittedly not optimal, but it works.
>

Ok, munmap() will be fixed by the tlb shootdown changes - it also uses
zap_page_range().

That leaves msync() - it currently does a flush_tlb_page() for every
single dirty page.
Is it possible to integrate that into the mmu gather code?

tlb_transfer_dirty() in addition to tlb_clear_page()?

--
	Manfred
