Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317484AbSGONcY>; Mon, 15 Jul 2002 09:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317481AbSGONcX>; Mon, 15 Jul 2002 09:32:23 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:34820 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317484AbSGONcW>; Mon, 15 Jul 2002 09:32:22 -0400
Date: Mon, 15 Jul 2002 15:35:07 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715133507.GF32155@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Richard B. Johnson wrote:

> These are things that should be addressed rather than flamed-
> away. I think that the intent of fsync() on a file is to make
> certain that it is on the physical media in a state from which
> it can be accessed after a crash. If this is the intent, then
> playing games with individual directories is not useful and
> fsync() on the read/write file-descriptor actually updating the
> file should be sufficient.

We had a similar discussion along the lines of an MTA roughly a year
ago, but without your (unquoted) objection that fsync() on a fiel
without write permit should be impossible.

The essence was that Linux 2.4 ext3fs and reiserfs guarantee that on
fsync(), the file is recoverable from the place it was created, 2.2 was
halfway there; but beware: only data=ordered or data=journal (in ext3fs,
as beta patch for reiserfs from
ftp.suse.com:/pub/people/mason/patches/data-logging/ <- from memory))
will guarantee that your file contents are recoverable.

This does not constitute any statement on JFS or XFS. I'm unaware of
their characteristics in fsync and directory update issues.

That aside, it would really useful to get this "hog a writer" issue
ironed out either way, and that the illogical "fsync() a O_RDONLY" file
be resolved somehow.

For the data of users not acquainted with kernel intrinsics, the way
things are now are most dangerous, and I'd really ask that Andrew
Morton's dirsync() patches (where still necessary) and tool patches
(chattr, mount) be deployed NOW and that -o dirsync (call it noasync for
compatibility) be the default. A safety-speed tradeoff should only
sacrifice safety at the explicit request and mke2fs should be told to
generate ext3fs by default NOW.

The argumentation that Linux leaves the choice of when to sync directory
data to the application is nice, but not more, and having this as tuning
option is fine, but to quote Wietse Venema "it's interesting to see that
out of the box, Linux handles logging more securely (sync writes) than
email (async directory updates)". And right he is.

Is fsync()ing directories any portable?

-- archived at: http://groups.google.com/groups?selm=89uj5c%242h2s%241%40FreeBSD.csie.NCTU.edu.tw&oe=utf-8&output=gplain

-- 
Matthias Andree
