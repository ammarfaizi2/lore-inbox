Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290109AbSBSHrg>; Tue, 19 Feb 2002 02:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290232AbSBSHr1>; Tue, 19 Feb 2002 02:47:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29100 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290109AbSBSHrW>;
	Tue, 19 Feb 2002 02:47:22 -0500
Date: Tue, 19 Feb 2002 02:47:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nakayama Shintaro <nakayama@tritech.co.jp>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, shojima@tritech.co.jp,
        torvalds@transmeta.com
Subject: Re: BKL removal from VFS
In-Reply-To: <20020219161752B.nakayama@tritech.co.jp>
Message-ID: <Pine.GSO.4.21.0202190220290.8070-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Nakayama Shintaro wrote:

> I've found great BKL contention when running multiple postmark
> benchmarks. Here is the postmark results with lock contention
> sampled by lockmeter.

Conflicts with (and massively duplicates) patches that already went
into 2.5.  Absolutely useless wrt mount() locking changes (except for
remount they can't race with filesystem code even in principle and
definitely don't need system-wide exclusion among themselves).  Has
a nice DoS potential (on OOM).  Too large and changes too many things
to be acceptable at one chunk even if none of the above would apply.
Consider it vetoed.

Seriously, just watching the changelogs would show that it has no chance
to be applied.

I hadn't checked for races, but e.g. ext2_readdir() losing BKL without
corresponding changes to lseek() looks very suspicious.  I'm more than
sure that there's more - after doing that BKL-shifting in recent 2.5.
E.g. I'm pretty sure that you are screwing ->i_nlink checks.

