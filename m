Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271213AbRHZCDj>; Sat, 25 Aug 2001 22:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271241AbRHZCD3>; Sat, 25 Aug 2001 22:03:29 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:23823 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271213AbRHZCDW>;
	Sat, 25 Aug 2001 22:03:22 -0400
Date: Sat, 25 Aug 2001 23:02:25 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Marc A. Lehmann" <pcg@goof.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <20010826013442.C29129@cerebro.laendle>
Message-ID: <Pine.LNX.4.33L.0108252301180.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Aug 2001, Marc A. Lehmann wrote:
> On Sat, Aug 25, 2001 at 10:33:36PM +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > exactly this is a point: my disk can do 5mb/s with almost random seeks,
> > > and linux indeed reads 5mb/s from it. but the userpsace process doing
> > > read() only ever sees 2mb/s because the kernel throes away all the nice
> > > pages.
> >
> > Which means the VM in the relevant kernel is probably crap or your working
> > set exceeds ram.
>
> The relevant kernel is linux (all 2.4 versions I tested), and no,
> working set exceeding ram should never result in such excessive
> thrashing. So yes, the VM in the kernel is crap (in this particular
> case, namely high-volume fileserving) ;)

This is because the readahead windows are too large so the
kernel ends up evicting data before its needed and has to
re-read the data.

Also see http://linux-mm.org/wiki/moin.cgi/StreamingIo
in the Linux-MM wiki.

This problem should be relatively easy to fix for 2.4.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

