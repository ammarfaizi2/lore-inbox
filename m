Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129781AbQLZO37>; Tue, 26 Dec 2000 09:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130550AbQLZO3t>; Tue, 26 Dec 2000 09:29:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:52471 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129781AbQLZO3m>; Tue, 26 Dec 2000 09:29:42 -0500
Date: Tue, 26 Dec 2000 11:58:34 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Felix von Leitner <leitner@convergence.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RAID 0 performance on 2.4.0-test10 for IDE?
In-Reply-To: <20001226004843.A6103@convergence.de>
Message-ID: <Pine.LNX.4.21.0012261155160.16178-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000, Felix von Leitner wrote:
> Thus spake Felix von Leitner (leitner@convergence.de):
> > Here is the result of my test program on the strip set:
> >   # rb < /dev/md/0
> >   30.3 meg/sec
> >   #
> 
> One more detail: top says the CPU is 50% system when reading from either
> one of the disk or raid devices.  That seems awfully high considering
> that the Promise controller claims to do UDMA.
> 
> Any comments?

Your program reads in data at 30MB/second, on a memory bus
that most likely supports something like 60 to 100MB/second.

Part of this memory bandwidth is needed for the UDMA controller
to push the data to memory, probably between 30% and 50%.

Every time the UDMA controller has the memory bus for itself the
CPU will busy-wait on memory, which shows up as CPU busy time.

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
