Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbQJ3JRr>; Mon, 30 Oct 2000 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbQJ3JRh>; Mon, 30 Oct 2000 04:17:37 -0500
Received: from chiara.elte.hu ([157.181.150.200]:45062 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129137AbQJ3JRW>;
	Mon, 30 Oct 2000 04:17:22 -0500
Date: Mon, 30 Oct 2000 11:27:04 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
In-Reply-To: <20001030015546.B19869@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.21.0010301114480.3186-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Oct 2000, Jeff V. Merkey wrote:

> For example, if you put a MOV EAX, CR3;  MOV CR3, EAX; in a context
> switching path, on a PPro 200, you can do about 35,000 context
> switches/second

in 2.4 & Xeons we can do more than 100,000 context switches/second, and
that is more than enough. But the point is: network IO performance does
not depend on context switching speed too much. Also, in Linux we are
using global pages which makes kernel-space TLBs persistent even across
CR3 flushes.

> [...] There's also the use of segment registers all over the place to
> copy from kernel to user and user to kernel space memory. [...]

we do not use the fs segment register for user-space copies anymore,
neither in 2.2, nor in 2.4. You must be reading old books and probably
forgot to cross-check with the kernel source? :-)

> [...] Having the fast paths you mention does help a lot, but it's the
> fact that this goes on at all that will make it tough to walk into a
> NetWare shop with Linux and rip out NetWare servers and replace them
> unless we look at a NetWare vs. NetLinux (that's what we call it! a
> NetWare-like Linux platform).

the worst thing you can do is to mis-identify performance problems and
spend braincells on the wrong problem. The problems limiting Linux network
scalability have been identified during the last 12 months by a small
team, and solved in TUX. TUX is a fileserver, it shouldnt be alot of work
to enable it for (TCP-only?) netware serving. It's *done*, Jeff, it's not
a hypotetical thing, it's here, it works and it performs.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
