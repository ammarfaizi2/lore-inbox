Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMKbV>; Mon, 13 Nov 2000 05:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129193AbQKMKbL>; Mon, 13 Nov 2000 05:31:11 -0500
Received: from hermes.mixx.net ([212.84.196.2]:2052 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129050AbQKMKa6>;
	Mon, 13 Nov 2000 05:30:58 -0500
From: Daniel Phillips <news-innominate.list.linux.kernel@innominate.de>
Reply-To: Daniel Phillips <phillips@innominate.de>
X-Newsgroups: innominate.list.linux.kernel
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Date: Mon, 13 Nov 2000 11:30:52 +0100
Organization: innominate
Distribution: local
Message-ID: <news2mail-3A0FC2DC.AF767E23@innominate.de>
In-Reply-To: <200011110012.TAA22015@tsx-prime.MIT.EDU> <3A0CBD16.5A07D189@alacritech.com> <200011111758.eABHw8O05566@trampoline.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: mate.bln.innominate.de 974111451 4992 10.0.0.90 (13 Nov 2000 10:30:51 GMT)
X-Complaints-To: news@innominate.de
To: tytso@mit.edu
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 
>    Date: Fri, 10 Nov 2000 19:29:26 -0800
>    From: "Matt D. Robinson" <yakker@alacritech.com>
> 
>    We're planning to isolate the write functions as much as possible.
>    In the past, we've been bitten by this whole concept of Linux "raw I/O".
>    When I was at SGI, we were able to write to a block device directly
>    through low-level driver functions that weren't inhibited by any
>    locking, and that was after shutting down all processors and any
>    other outstanding interrupts.  For Linux, I had given up and stuck
>    with the raw I/O interpretation of kiobufs, which is just flat out
>    wrong to do for dumping purposes.  Secondly, as Linus said to me a
>    few weeks ago, he doesn't trust the current disk drivers to be able
>    to reliably dump when a crash occurs.  Don't even ask me to go into
>    all the reasons kiobufs are wrong for crash dumping.  Just read
>    the code -- it'll be obvious enough.
> 
> Oh, yeah, I could have told you that from the beginning.  kiobufs were
> never intended to be crash-dump friendly.  :-)   My preference would be
> that each block device that was going to be doing crash dumping would
> use a special busy-looping driver that's guaranteed never to fail.
> (Sort of like how the serial console driver is done; it's separate from
> the rest of the driver, and does not depend on interrupts working.)
> Hence my comment about putting that separate bit of code in a page which
> is write-protected and segregated from everything else....

This is also needed for single-machine source level kernel debugging.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
