Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131158AbRCRKtm>; Sun, 18 Mar 2001 05:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbRCRKtc>; Sun, 18 Mar 2001 05:49:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:46084 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131158AbRCRKt0>; Sun, 18 Mar 2001 05:49:26 -0500
Date: Sun, 18 Mar 2001 07:46:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: changing mm->mmap_sem  (was: Re: system call for process
 information?)
In-Reply-To: <Pine.LNX.4.33.0103181050020.878-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103180742510.13050-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Mar 2001, Mike Galbraith wrote:

> I gave this patch a try, and the initial results are extremely encouraging.
> Not only do I have vmstat (SCHED_RR) info in realtime with zero delays :))
> I also have a _nice_ throughput improvement.  There are some worrisome
> warnings below along with the compile changes I made here, but for an
> initial patch, things look pretty darn wonderful.

	[snip compile fixes .. integrated]

> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 196k freed
> Adding Swap: 265064k swap-space (priority 2)
> VM: Bad swap entry 00011e00
> VM: Bad swap entry 00058d00
> Unused swap offset entry in swap_dup 00058d00
> Unused swap offset entry in swap_dup 00011e00
> VM: Bad swap entry 00011e00
> VM: Bad swap entry 00058d00

Heh, I guess do_swap_page isn't too happy when multiple threads
of the same program take a page fault at the same address at the
same time.

I take it you were testing something like mysql, jvm or apache2 ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

