Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317906AbSHCVxF>; Sat, 3 Aug 2002 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSHCVxF>; Sat, 3 Aug 2002 17:53:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:27575 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317906AbSHCVxE>; Sat, 3 Aug 2002 17:53:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: large page patch (fwd) (fwd)
Date: Sat, 3 Aug 2002 17:54:30 -0400
User-Agent: KMail/1.4.1
Cc: davidm@hpl.hp.com, "David S. Miller" <davem@redhat.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, <linux-kernel@vger.kernel.org>
References: <15692.12093.514064.496253@napali.hpl.hp.com> <Pine.LNX.4.44.0208031240270.9758-100000@home.transmeta.com> <15692.18584.1391.30730@napali.hpl.hp.com>
In-Reply-To: <15692.18584.1391.30730@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208031754.30337.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 05:18 pm, David Mosberger wrote:
> >>>>> On Sat, 3 Aug 2002 12:43:47 -0700 (PDT), Linus Torvalds
> >>>>> <torvalds@transmeta.com> said:
>   >>
>   >> You don't need separate system calls for that: with a transparent
>   >> superpage framework and a privileged & reserved giant-page pool,
>   >> it's trivial to set up things such that your favorite data base
>   >> will always be able to get the giant pages (and hence the giant
>   >> TLB mappings) it wants.  The only thing you lose in the
>   >> transparent case is control over _which_ pages need to use the
>   >> pinned giant pages.  I can certainly imagine cases where this
>   >> would be an issue, but I kind of doubt it would be an issue for
>   >> databases.
>
>   Linus> That's _probably_ true. There aren't that many allocations
>   Linus> that ask for megabytes of consecutive memory that wouldn't
>   Linus> want to do it. However, there might certainly be non-critical
>   Linus> maintenance programs (with the same privileges as the
>   Linus> database program proper) that _do_ do large allocations, and
>   Linus> that we don't want to give large pages to.
>
>   Linus> Guessing is always bad, especially since the application
>   Linus> certainly does know what it wants.
>
> Yes, but that applies even to a transparent superpage scheme: in those
> instances where an application knows what page size is optimal, it's
> better if the application can express that (saves time
> promoting/demoting pages needlessly).  It's not unlike madvise() or
> the readahead() syscall: use reasonable policies for the ordinary
> apps, and provide the means to let the smart apps tell the kernel
> exactly what they need.
>
> 	--david

So that's what is/can-be done through the madvice call or a flag on MMAP().
Force a specific size and policy. Why do you need a new system call.

The Rice paper solved this reasonably elegant. Reservation and check 
after a while. If you didn't use reserved memory, you loose it, this is the 
auto promotion/demotion.

For special apps one provides the interface using madvice().
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
