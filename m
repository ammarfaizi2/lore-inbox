Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAISY3>; Tue, 9 Jan 2001 13:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAISYT>; Tue, 9 Jan 2001 13:24:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29711 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129324AbRAISYK>; Tue, 9 Jan 2001 13:24:10 -0500
Date: Tue, 9 Jan 2001 10:23:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        "Sergey E. Volkov" <sve@raiden.bancorp.ru>,
        linux-kernel@vger.kernel.org, Christoph Rohland <cr@sap.com>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <20010109140932.E4284@redhat.com>
Message-ID: <Pine.LNX.4.10.10101091021280.2070-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Stephen C. Tweedie wrote:
> 
> But again, how do you clear the bit?  Locking is a per-vma property,
> not per-page.  I can mmap a file twice and mlock just one of the
> mappings.  If you get a munlock(), how are you to know how many other
> locked mappings still exist?

Note that this would be solved very cleanly if the SHM code would use the
"VM_LOCKED" flag, and actually lock the pages in the VM, instead of trying
to lock them down for writepage().

That would mean that such a segment would still get swapped out when it is
not mapped anywhere, but I wonder if that semantic difference really
matters.

If the vma is marked VM_LOCKED, the VM subsystem will do the right thing
(the page will never get removed from the page tables, so it won't ever
make it into that back-and-forth bounce between the active and the
inactive lists).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
