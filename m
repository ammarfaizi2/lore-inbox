Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129389AbRBXOgp>; Sat, 24 Feb 2001 09:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129392AbRBXOgf>; Sat, 24 Feb 2001 09:36:35 -0500
Received: from p108.usnyc3.stsn.com ([199.106.218.108]:27404 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S129389AbRBXOgQ>; Sat, 24 Feb 2001 09:36:16 -0500
Date: Sat, 24 Feb 2001 09:37:49 -0500 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Joseph Bueno <joseph.bueno@trader.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VM balancing problems under 2.4.2-ac1
In-Reply-To: <3A978DF8.FB1890E@trader.com>
Message-ID: <Pine.LNX.4.31.0102240935590.8568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Feb 2001, Joseph Bueno wrote:
> Rik van Riel a écrit :
> > On 23 Feb 2001, Adam Sampson wrote:
> >
> > > The VM balancing updates in the recent ac kernels seem to have caused
> > > some interesting performance problems on my desktop machine. I've got
> > > 160Mb of RAM, and 2.4.2-ac1 appears to be using excessively large
> > > amounts of it for buffers and cache while pushing stuff out to
> > > swap. This means that Mozilla, for instance, runs significantly worse
> > > than under 2.4.0, since bits of it are being swapped in and out.
> >
> > This is a known problem which I'll fix as soon as I have a
> > solution.
> >
> > The problem is that we still have no good way to balance
> > how much memory we take from the cache and how much memory
> > we take from processes.

> I understand that auto-balancing code that deals with all
> situations is very hard to design; so let me share my experience
> on other Unix systems (from a user/administrator point of view):
>
> I have used Unix systems (mainly HPUX) for several years as personal
> workstations or servers and buffer cache usage were very differents:
>
> On workstations, you are mainly looking for fast interactive response
> time and  you want to dedicate as much memory as possible to running
> processes so limiting buffer cache to 10% of physical memory (these
> workstations had typically 32 - 64 Mb of RAM) was good.

"Unfortunately" the cache also contains _process memory_ in
Linux. Limiting the cache to 10% also means limiting the
code size of all your processes to something smaller than
that.

Also, read-in swap pages are in the so-called swap cache,
which is also part of the page cache.

This means that simple limits on cache size probably won't do
much good on Linux.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

