Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRBWFCX>; Fri, 23 Feb 2001 00:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131447AbRBWFCO>; Fri, 23 Feb 2001 00:02:14 -0500
Received: from p188.usnyc5.stsn.com ([199.106.220.188]:17673 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131413AbRBWFCB>; Fri, 23 Feb 2001 00:02:01 -0500
Date: Fri, 23 Feb 2001 02:03:27 -0300 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Lars Marowsky-Bree <lmb@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 vs 2.2 performance under load comparison
In-Reply-To: <20010222135440.M1320@marowsky-bree.de>
Message-ID: <Pine.LNX.4.31.0102230201100.31559-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Lars Marowsky-Bree wrote:

> Situation: SAP R/3 + SAP DB + benchmark driver running on a
> single node 4 CPU SMP machine, tuned down to 1GB of RAM.
>
> Running the SAP benchmark with 75 users on 2.2 yields for the
> first benchmark run:
>
> - 7018ms average response time
> - 2967s CPU time in 1136s elapsed time
> - ~500MB swap allocated
> - ~1500 pages paged in/s, 268 pages/out/s on average
>
> Running the same benchmark on 2.4:
>
> - ~700ms average response time
> - 1884s CPU time in 669s elapsed time
> - ~500MB swap allocated
> - ~50 pages paged in, ~212 pages paged out per second on average

> Rik, it's time for you to break it again *g*

Actually, in 2.4 we have one big VM balancing problem left.

We have no way to auto-balance between refill_inactive_scan()
and swap_out(), so we can (and probably do) still end up paging
out the wrong pages lots of times ... this is alleviated somewhat
by having a 1-second inactive list, but still...

Another problem is a lack of smarter IO clustering, when we get
that better I'm sure we can increase performance even more.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

