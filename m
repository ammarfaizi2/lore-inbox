Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131702AbQLZRG6>; Tue, 26 Dec 2000 12:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131706AbQLZRGs>; Tue, 26 Dec 2000 12:06:48 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:39674 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131702AbQLZRGc>; Tue, 26 Dec 2000 12:06:32 -0500
Date: Tue, 26 Dec 2000 14:35:39 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Felix von Leitner <leitner@convergence.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
In-Reply-To: <20001226172448.A7660@convergence.de>
Message-ID: <Pine.LNX.4.21.0012261434110.16178-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000, Felix von Leitner wrote:
> Thus spake Rik van Riel (riel@conectiva.com.br):
> > > One more detail: top says the CPU is 50% system when reading from either
> > > one of the disk or raid devices.  That seems awfully high considering
> > > that the Promise controller claims to do UDMA.
> > > 
> > > Any comments?
> > Your program reads in data at 30MB/second, on a memory bus
> > that most likely supports something like 60 to 100MB/second.
> 
> 100.

So that's 30% for the UDMA controller and maybe
30% for the CPU (if your program reads in all the
data).

> > Part of this memory bandwidth is needed for the UDMA controller
> > to push the data to memory, probably between 30% and 50%.
> 
> That would be 30%.

Add to that the overhead of allocating and reclaiming
the memory, doing the RAID mapping, sending commands
to the hard disk, ...

> > Every time the UDMA controller has the memory bus for itself the
> > CPU will busy-wait on memory, which shows up as CPU busy time.
> 
> So, you are saying, when I add a gigabit ethernet card, CPU will hit
> 100% at about 30 MB/second?  That sounds like a weak architecture ;-)

Hey, there's a reason PCs are so cheap ;)

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
