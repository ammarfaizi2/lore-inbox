Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268924AbRHZNtF>; Sun, 26 Aug 2001 09:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269641AbRHZNs4>; Sun, 26 Aug 2001 09:48:56 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:62212 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S268924AbRHZNso>;
	Sun, 26 Aug 2001 09:48:44 -0400
Date: Sun, 26 Aug 2001 10:48:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826152204.B22677@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108261036160.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Marc A. Lehmann wrote:
> On Sun, Aug 26, 2001 at 12:32:09AM -0300, Rik van Riel <riel@conectiva.com.br> wrote:
> > Reality check time indeed.  If you propose that disabling
> > readahead should improve read performance something fishy
> > is going on ;)
>
> Actually, I also believe that. If you have no memory to store
> read-ahead data then your only chance is what I try to do: massively
> parallelize reads so the elevator can optimize what's possible and do
> no read-ahead whatsoever.

Margo Selzer wrote a nice paper on letting an elevator
algorithm take care of request sorting. Only at the point
where several thousand requests were queued and latency
to get something from disk grew to about 30 seconds did
a disk system relying on just an elevator get anything
close to decent throughput.

This paper convinced me that doing just elevator sorting
is never enough ;)

> The problem is that read-ahead (seems to) go completely havoc when
> read()'s are issued in many threads at the same time.

In that case, probably the readahead windows are too large
or the cache memory used for these readahead pages is too
small.

One thing you could do, in recent -ac kernels, is make the
maximum readahead size smaller by lowering the value in
/proc/sys/vm/max-readahead

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

