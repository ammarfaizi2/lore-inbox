Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284171AbRLFT5U>; Thu, 6 Dec 2001 14:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283924AbRLFT5H>; Thu, 6 Dec 2001 14:57:07 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:6925 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S282670AbRLFT4x>; Thu, 6 Dec 2001 14:56:53 -0500
Date: Thu, 6 Dec 2001 17:56:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Pablo Borges <pablo.borges@uol.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.16 & Heavy I/O
In-Reply-To: <Pine.LNX.4.33.0112062031491.1053-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33L.0112061737480.2283-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Mike Galbraith wrote:
> On Thu, 6 Dec 2001, Rik van Riel wrote:
> > On Thu, 6 Dec 2001, Roy Sigurd Karlsbakk wrote:
> >
> > > Is it really neccecary? Free memory's a waste! The cache will be
> > > discarded the moment an application needs the memory.
> >
> > That's not the case with use-once ...
>
> A little more verbosity please?

Once a page is used twice, it's not a candidate for eviction
until (most of) the use-once pages are gone.

This means that if you have these 40 MB of used-twice-but-never-again
buffer cache memory, this memory will never be evicted until other
pages get promoted from use-once to active.

Now say you have 200 MB of RAM, 40 MB of which are the above
buffer cache pages. Now you start a program which needs 170
MB of RAM.

This 170 MB program touches each page once before starting
at the front again, which means all its pages are used once
before getting evicted ... and they never get promoted to
active pages so the 40 MB of no longer used buffer cache
never gets evicted.

Use-once has this property in principle and the warnings have
gone out since around 2.4.8-pre4, but it's in 2.4 now so you're
stuck with it.

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

