Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131730AbRCOSNB>; Thu, 15 Mar 2001 13:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131741AbRCOSMw>; Thu, 15 Mar 2001 13:12:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:59150 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131730AbRCOSMn>; Thu, 15 Mar 2001 13:12:43 -0500
Date: Thu, 15 Mar 2001 22:25:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: James Lewis Nance <jlnance@intrex.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <20010315124316.A29421@bessie.dyndns.org>
Message-ID: <Pine.LNX.4.33.0103152222121.1320-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, James Lewis Nance wrote:
> On Thu, Mar 15, 2001 at 08:26:35PM -0300, Rik van Riel wrote:
> > When we swap something in from swap, it is in effect "duplicated"
> > in memory and swap. Freeing the swap space of these duplicates
> > will mean we have, effectively, more swap space.
>
>     Thanks for the explanation.  It brings another question to
> mind.  Lets assume that I have two 16M processes and 32M of swap
> space.  Both the processes have been swapped out at some point
> in time so the swap space is full.  A third process is running
> and tries to allocate some memory, and the kernel has no free
> pages.  Since swap is full, will the kernel kill my process, or
> will it try and page out one of the processes that does have
> space on swap?

It will end up swapping out the two processes which already have
space in swap ... even if the 3rd process is idle.

In that situation you could argue for 2 things:

1) the kernel should reclaim space when swap is full
2) you need more swap

I guess we'll want a bit of both, possibly with 1) being an
optional thing (since swap fragmentation could well be as
bad for performance as swapping out the wrong thing).

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

