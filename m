Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRHZUfr>; Sun, 26 Aug 2001 16:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271555AbRHZUfg>; Sun, 26 Aug 2001 16:35:36 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:7954 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271552AbRHZUfR>;
	Sun, 26 Aug 2001 16:35:17 -0400
Date: Sun, 26 Aug 2001 17:34:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826140537.A21106@hq2>
Message-ID: <Pine.LNX.4.33L.0108261715010.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Victor Yodaiken wrote:
> On Sun, Aug 26, 2001 at 04:38:55PM -0300, Rik van Riel wrote:
> > On Sun, 26 Aug 2001, Victor Yodaiken wrote:
> >
> Daniel was suggesting a readahead thread, if I'm not mistaken.

Ouch, that's about as insane as it gets ;)


> > > BTW: maybe I'm oversimplifying, but since read-ahead is an optimization
> > > trading memory space for time, why doesn't it just turn off when there's
> > > a shortage of free memory?
> > > 		num_pages = (num_requestd_pages +  (there_is_a_boatload_of_free_space? readahead: 0)
> >
> > When the VM load is high, the last thing you want to do is
> > shrink the size of your IO operations, this would only lead
> > to more disk seeks and possibly thrashing.
>
> Doesn't this very much depend on why VM load is high and on the
> kind of I/O load? For example, if your I/O load is already in
> big chunks or if VM stress is being caused by a bunch of big
> threads hammering shared data that is in page cache already.

Processes accessing stuff already in RAM aren't causing
any VM stress, since all the stuff they need is already
in RAM.

As for I/O already being done in big chunks, I'm not sure
if readahead would have any influence on this situation.

> At least to me, "thrashing" where the OS is shuffling pages in and
> out without work getting done is different from "thrashing" where
> user processes run with suboptimal I/O.

Actually, "suboptimal I/O" and "shuffling pages without getting
work done" are pretty similar.

> > It would be nice to do something similar to TCP window
> > collapse for readahead, though...

> That is, failure to use readahead may be caused by memory pressure,
> scheduling delays, etc - how do you tell the difference between a
> process that would profit from readahead if the scheduler would let it
> and one that would not?

I don't think we'd need to know the difference at all times.
After all, TCP manages fine without knowing the reason for
packet loss ;)


> > IA64: a worthy successor to i860.
>
> Not the 432?

;)

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

