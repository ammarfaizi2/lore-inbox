Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313639AbSDPPjo>; Tue, 16 Apr 2002 11:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313619AbSDPPjn>; Tue, 16 Apr 2002 11:39:43 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:48390 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S313639AbSDPPjl>; Tue, 16 Apr 2002 11:39:41 -0400
Date: Tue, 16 Apr 2002 12:39:22 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Moritz Franosch <jfranosc@physik.tu-muenchen.de>,
        <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
In-Reply-To: <20020416165358.E29747@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0204161236320.16531-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Andrea Arcangeli wrote:
> On Fri, Apr 05, 2002 at 11:04:18PM +0200, Moritz Franosch wrote:

> > The problem is that writing to a DVD-RAM, ZIP or MO device almost
> > totally blocks reading from a _different_ device. Here is some data.
> >
> > nr bench read       write      2.4.18  2.4.19-rc5  expected factor
> > 1  dd    30GB HDD   DVD-RAM    278     490         60       8.2
> > 2  dd    120GB HDD  DVD-RAM    197     438         32       14
> > 3  dd    30GB HDD   ZIP        158     239         60       4.0
> > 4  dd    120GB HDD  ZIP        142     249         32       7.8
> > 5  dd    30GB HDD   120GB HDD   87      89         60       1.5
> > 6  dd    120GB HDD  30GB HDD    66      69         32       2.2
> > 7  cp    30GB HDD   120GB HDD   97      77         60       1.3
> > 8  cp    120GB HDD  30GB HDD    78      65         50       1.3
> >
> > The columns 2.4.18 and 2.4.19-rc5 list execution times in seconds of
> > the respective benchmark. The column "expected" lists the time I would
> > have expected for the respective benchmark to complete with a
> > "perfect" kernel. The "factor" is the factor 2.4.19-rc5 is slower than
> > a perfect kernel would be.

> The reason hd is faster is because new algorithm is much better than the
> previous mainline code. Now the reason the DVDRAM hangs the machine
> more, that's probably because more ram can be marked dirty with those
> new changes (beneficial for some workload, but it stalls much more the
> fast hd, if there's one very slow blkdev in the system). You can try
> decrasing the percent of vm dirty in the system with:
>
> 	echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush

Judging from the performance regression above it would seem the
new defaults suck rocks.

Can we please stop optimising Linux for a single workload benchmark
and start tuning it for the common case of running multiple kinds
of applications and making sure one application can't mess up the
others ?

Personally I couldn't care less if my tar went 30% faster if it
meant having my desktop unresponsive for the whole time.

regards,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/

