Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319037AbSHFJ6S>; Tue, 6 Aug 2002 05:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319039AbSHFJ6R>; Tue, 6 Aug 2002 05:58:17 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:23311 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S319037AbSHFJ6Q>; Tue, 6 Aug 2002 05:58:16 -0400
Date: Tue, 6 Aug 2002 12:01:52 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Chris Mason <mason@suse.com>
Cc: Oleg Drokin <green@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <1028594875.27694.350.camel@tiny>
Message-ID: <Pine.LNX.4.44.0208061153450.2135-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Aug 2002, Chris Mason wrote:

> On Mon, 2002-08-05 at 18:46, Roland Kuhn wrote:
> > 
> > But more important: the hiccups are more seldom and sometimes shorter than 
> > before. With plain 2.4.19 I would hit it about twice per minute (I have 
> > not measured it), now it happens only after two minutes when writing 1M 
> > chunks at 20MB/s. The longest seen so far was also about 4 seconds, 
> > though.
> 
> This is harder to guess at ;-)  But I'll try 2 things I know I've fixed.
> 
> #1 I've made the metadata writeback code much more efficient, especially
> for smaller transactions.  A dd to a large file won't generate lots of
> log traffic, writing 700M only changes about 160 blocks in 30 seconds. 
> Anyway, 03-data-logging-24 might make a big difference.
> 
It is hard to get precise numbers, but I have the feeling that with atime 
enabled the ls-hiccups have at least not decreased, and there has been a 
rather long one of about 13 seconds, frequency is about one per minute, 
usually taking 2-4 seconds.

With noatime this of course doesn't happen, but with the patch the file 
size does not increase smoothly any more, it sometimes stays the same for 
some ten seconds and then jumps a few hundred MBs. However, the throughput 
is roughly the same as without the patch (compatible within the errors of 
about 10%).

> #2 During an ls, the current code ends up reading the directory more or
> less one block at a time.  Try 05-search_reada-4.diff, which will read
> more tree nodes at once.
> 
Unfortunately I'm ordered to do something now, so I won't have the time to
check the performance of this one during the next few hours. The
combination of 01+02+04 seemed more stable (concerning sustained
throughput), so I will test it on all 12 machines and tell you what
happens.

Thanks very much for your help! I appreciate that!

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

