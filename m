Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131096AbRAJQUC>; Wed, 10 Jan 2001 11:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132374AbRAJQTm>; Wed, 10 Jan 2001 11:19:42 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:43535 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S132176AbRAJQTl>; Wed, 10 Jan 2001 11:19:41 -0500
Date: Wed, 10 Jan 2001 17:18:28 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010110171828.I30055@pcep-jamie.cern.ch>
In-Reply-To: <3A5C4FAC.CA6E46A9@colorfullife.com> <Pine.LNX.4.30.0101101304330.1681-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0101101304330.1681-100000@e2>; from mingo@elte.hu on Wed, Jan 10, 2001 at 01:07:53PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> > > well, this is a performance problem if you are using threads. For normal
> > > processes there is no need for a SMP cross-call, there TLB flushes are
> > > local only.
> > >
> > But that would be ugly as hell:
> > so apache 2.0 would become slower with MSG_NOCOPY, whereas samba 2.2
> > would become faster.
> 
> there *is* a cost of having a shared VM - and this is i suspect
> unavoidable.

Is it possible to avoid the SMP cross-call in the case that the other
threads have neither accessed nor dirtied the page in question?

One way to implement this is to share VMs but not the page tables, or to
share parts of the page tables that don't contain writable pages.

Just a sudden inspired thought...  I don't know if it is possible or
worthwhile.

enjoy,
-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
