Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131731AbRCOOLK>; Thu, 15 Mar 2001 09:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131732AbRCOOLA>; Thu, 15 Mar 2001 09:11:00 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:45583 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131731AbRCOOK4>; Thu, 15 Mar 2001 09:10:56 -0500
Date: Thu, 15 Mar 2001 10:08:50 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <Pine.LNX.4.33.0103150720100.757-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.21.0103151005210.4165-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Mike A. Harris wrote:

> Is the fact that we're supposed to use double the RAM size as
> swap a permanent thing or a temporary annoyance that will get
> tweaked/fixed in the future at some point during 2.4.x perhaps?
>
> What are the technical reasons behind this change?

The reason is that the Linux 2.4 kernel no longer reclaims swap
space on swapin (2.2 reclaimed swap space on write access, which
lead to fragmented swap space in lots of workloads).

This means that a lot of memory ends up "duplicated" in RAM and
in swap.

I plan on doing some code to reclaim swap space when we run out,
but Linus doesn't seem to like that idea very much. His argument
(when you're OOM, you should just fail instead of limp along)
makes a lot of sense, however, and the reclaiming of swap space
isn't really high on my TODO list ...

OTOH, for people who have swap < RAM and use it just as a small
overflow area, Linus' argument falls short, so I guess some time
in the future we will have code to reclaim swap space when needed.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

