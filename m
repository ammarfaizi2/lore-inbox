Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRALQYQ>; Fri, 12 Jan 2001 11:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRALQYH>; Fri, 12 Jan 2001 11:24:07 -0500
Received: from slc246.modem.xmission.com ([166.70.9.246]:7948 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129733AbRALQXv>; Fri, 12 Jan 2001 11:23:51 -0500
To: Ralf Baechle <ralf@conectiva.com.br>
Cc: David Weinehall <tao@acc.umu.se>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrea Arcangeli <andrea@suse.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Zlatko Calusic <zlatko@iskon.hr>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Jan 2001 09:10:54 -0700
In-Reply-To: Ralf Baechle's message of "Fri, 12 Jan 2001 03:56:20 -0200"
Message-ID: <m17l40hhtd.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle <ralf@conectiva.com.br> writes:

> On Thu, Jan 11, 2001 at 12:56:57AM +0100, David Weinehall wrote:
> 
> > > The MMU on these systems is a CAM, and the mmu table is thus backwards to
> > > convention. (It also means you can notionally map two physical addresses to
> > > one virtual but thats undefined in the implementation ;))
> > 
> > Are there any other (not yet supported) platforms with similar (or other
> > unrelated, but hard to support because of the current architecture of
> > the kernel) problems?
> > 
> > (No, I have no secret trumps up my sleeve, I'm just curious.)
> 
> Having a reverse mappings is the least sucky way to handle virtual aliases
> of certain types of MIPS caches.

Hmm.  I would think that increasing the logical page size in the kernel would
be the trivial way to handle virtual aliases.  (i.e.) with a large enough page
size you can't actually have a virtual alias.

You could also play some games with simply allocating pages only with the proper 
proper high bits.   These games might also be useful on architectures for L2 caches
who have significant physical bits than PAGE_SHIFT bits.

But how does a reverse mapping help to handle virtual aliases?  What are those
caches doing?  The only model in my head is having a virtually indexed cache
where you have more index bits than PAGE_SHIFT bits.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
