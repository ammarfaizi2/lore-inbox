Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273474AbRIYUFX>; Tue, 25 Sep 2001 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273479AbRIYUFN>; Tue, 25 Sep 2001 16:05:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1288 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273474AbRIYUFA>; Tue, 25 Sep 2001 16:05:00 -0400
Date: Tue, 25 Sep 2001 17:05:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Out of memory handling broken
In-Reply-To: <20010925003416.A151@bug.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0109251702540.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Pavel Machek wrote:

> I need to allocate as much memory as possible (but not more).
> Okay, so I use out_of_memory, right?

Nope, out_of_memory() is about virtual memory handling,
not at all about physical memory.

> But, when I looked into out_of_memory... Of course its
> wrong. out_of_memory() contains
>
>         if (nr_swap_pages > 0)
>                 return 0;
>
> ...which is obviously wrong. It is well possible to have free
> swap _and_ be out of memory -- eat_memory() loop gets system to
> this state easily.

This is because you're using out_of_memory() for something
it was never meant for.  ;)

Even if it didn't take swap into account, you'd still end
up counting highmem pages your code cannot use...

cheers,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/


