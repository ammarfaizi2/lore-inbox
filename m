Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131279AbRCNDBi>; Tue, 13 Mar 2001 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRCNDBS>; Tue, 13 Mar 2001 22:01:18 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:37878 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S131279AbRCNDBH>;
	Tue, 13 Mar 2001 22:01:07 -0500
Date: Tue, 13 Mar 2001 23:28:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, npsimons@fsmlabs.com,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: system call for process information?
In-Reply-To: <3AAECF17.727656A2@evision-ventures.com>
Message-ID: <Pine.LNX.4.21.0103132325140.2056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, Martin Dalecki wrote:

> Not the embedded folks!!! The server folks laugh histerically all
> times they go via ssh to a trashing busy box to see what's wrong and
> then they see top or ps auxe under linux never finishing they job:

That's a separate issue.

I guess the pagefault path should have _2_ locks.

One mmap_sem protecting read-only access to the address space
and another one for write access to the adress space (to stop
races with swapout, other page faults, ...).

At the point where the pagefault sleeps on IO, it could release
the read-only lock, so vmstat, top, etc can get the statistics
they need. Only during the time the pagefaulting code is actually
messing with the address space could it block read access (to
prevent others from seeing an inconsistent state).

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

