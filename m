Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRCXGmt>; Sat, 24 Mar 2001 01:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRCXGlI>; Sat, 24 Mar 2001 01:41:08 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30734 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131588AbRCXGlE>; Sat, 24 Mar 2001 01:41:04 -0500
Date: Sat, 24 Mar 2001 02:54:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: "Patrick O'Rourke" <orourke@missioncriticallinux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <Pine.LNX.4.30.0103231854470.13864-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.21.0103240252080.1863-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Szabolcs Szakacsits wrote:

> When I ported your OOM killer to 2.2.x and integrated it into the
> 'reserved root memory' [*] patch, during intensive testing I found two
> cases when init was killed. It happened on low-end machines and when
> OOM killer wasn't triggered so init was killed in the page fault
> handler. The later was also one of the reasons I replaced the "random"
> OOM killer in page fault handler with yours [so there is only one OOM
> killer].

Good idea, we should do this for 2.4.  I cannot remember
reading an email from you about this, it's quite possible
I just missed it and didn't answer because I never read
it ...

> Other things that bothered me,
>  - niced processes are penalized

This can be considered a bug and should be fixed...

>  - trying to kill a task that is permanently in TASK_UNINTERRUPTIBLE
>    will probably deadlock the machine [or the random OOM killer will
>    kill the box].

This could indeed be a problem, though I cannot really see any
case where a task would be in TASK_UNINTERRUPTIBLE permanently.
OTOH, a 1GB read() will take a (much) too long time to finish.

Your ideas sound really good, would you have the time to implement
them for 2.4 ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

