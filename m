Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316080AbSENVjW>; Tue, 14 May 2002 17:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316081AbSENVjV>; Tue, 14 May 2002 17:39:21 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:46348 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316080AbSENVjU>; Tue, 14 May 2002 17:39:20 -0400
Date: Tue, 14 May 2002 18:38:54 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Kurtis D. Rader" <kdrader@us.ibm.com>
cc: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <20020514124915.F21303@us.ibm.com>
Message-ID: <Pine.LNX.4.44L.0205141835490.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, Kurtis D. Rader wrote:

> On the topic of how this is defined by other UNIXes ...


> On each todclock() interrupt (100 times per second) the sum of the
>
>     1) number of processes currently waiting on the swap in queue,
>     2) number of processes waiting for a page to be brought into memory,
>     3) number of processes waiting on filesystem I/O, and
>     4) number or processes waiting on physical/raw I/O
>
> is calculated.  The smaller of that value and the number of CPUs
> currently idle is added to the procstat.ps_cpuwait counter (sar's %wio).
> This means that wait time is a subset of idle time.

This is basically what my patch does, except that it doesn't take
the minimum of the number of threads waiting on IO and the number
of idle CPUs. I'm still thinking about a cheap way to make this
work ...

> The rationale for separating out I/O wait time is that since an I/O
> operation may complete at any instant, and the process will be marked
> runable and begin consuming CPU cycles, the CPUs should not really be
> considered idle.  The %wio metric most definitely does not tell you
> anything about how busy the disk subsystem is or whether the disks are
> overloaded. It can indicate whether or not the workload is I/O bound.  Or,
> to look at it another way, %wio is good for tracking how much busier the
> CPUs would be if you could make the disk subsystem infinitely fast.

Indeed, this would be a good paragraph to copy into the procps
manual ;)

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

