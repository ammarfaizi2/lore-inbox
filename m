Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287869AbSAHBeT>; Mon, 7 Jan 2002 20:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSAHBeB>; Mon, 7 Jan 2002 20:34:01 -0500
Received: from air-1.osdl.org ([65.201.151.5]:56330 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S287447AbSAHBdx>;
	Mon, 7 Jan 2002 20:33:53 -0500
Date: Mon, 7 Jan 2002 17:44:35 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jens Axboe <axboe@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bounce buffer usage
In-Reply-To: <20011223150940.E7438@suse.de>
Message-ID: <Pine.LNX.4.33L2.0201071740350.7535-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001, Jens Axboe wrote:

| On Fri, Dec 21 2001, Randy.Dunlap wrote:
| > Are there any drivers in 2.4.x that support highmem directly,
| > or is all of that being done in 2.5.x (BIO patches)?
|
| 2.4 + my block-highmem patches support direct highmem I/O.
|
| > Would it be useful to try this with a 2.5.1 kernel?
|
| Sure


OK, here's 'fillmem 700' run against 5 kernels as described below,
with my bounce io/swap statistics patch added.

All tests are 6 instances of "fillmem 700" (700 MB) on a 4-way 4 GB
x86 VA 4450 server.

I'm including a reduced version of /proc/stat -- before and after the
fillmem test in each case.

Let me know if you'd like to see other variations.


=====bounce-stats-2416.txt
Linux 2.4.16 with bounce io/swap stats added:
elapsed run time: 2 min:58 sec.

BEFORE fillmem:
page 12847 816
swap 3 0
ctxt 11542
bounce io 23966 476
bounce swap io 0 0

AFTER fillmem:
page 686457 725766
swap 168354 181146
ctxt 4110183
bounce io 1311468 195826
bounce swap io 160892 24385

=====bounce-stats-low-2416.txt
Linux 2.4.16 with bounce io/swap stats added and some swap forced to low memory:
elapsed run time: 3 min:11 sec.

BEFORE fillmem:
page 12899 815
swap 3 0
ctxt 12951
bounce io 24046 476
bounce swap io 0 0

AFTER fillmem:
page 685718 854715
swap 168157 213360
ctxt 675273
bounce io 24410 164072
bounce swap io 0 20415

=====bounce-stats-2416-highio.txt
Linux 2.4.16 plus Jens's 2.4.x block-highmem patches, with CONFIG_HIGHIO=y:
elapsed run time: 2 min:45 sec.

BEFORE fillmem:
page 103940 1198
swap 3 0
ctxt 24409
bounce io 23978 576
bounce swap io 0 0

AFTER fillmem:
page 735853 651670
swap 157926 162541
ctxt 2328418
bounce io 1284928 186422
bounce swap io 157568 23194

=====bounce-stats-2416-nohighio.txt
Linux 2.4.16 plus Jens's 2.4.x block-highmem patches, with CONFIG_HIGHIO=n:
elapsed run time: 3 min:00 sec.

BEFORE fillmem:
page 13955 3177
swap 3 0
ctxt 20528
bounce io 26068 4052
bounce swap io 0 0

AFTER fillmem:
page 707172 741396
swap 173251 184456
ctxt 1013516
bounce io 1346488 156778
bounce swap io 165001 19066

=====bounce-stats-252-pre6.txt
Linux 2.5.2-pre6 with bounce io/swap stats added:
elapsed run time: 2 min:00 sec.

BEFORE fillmem:
page 16569 3318
swap 3 0
ctxt 46747
bounce io 30830 2080
bounce swap io 0 0

AFTER fillmem:
page 479343 546956
swap 115688 136051
ctxt 111294
bounce io 955046 427172
bounce swap io 115519 53094

-- 
~Randy

