Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSECQiZ>; Fri, 3 May 2002 12:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314687AbSECQiY>; Fri, 3 May 2002 12:38:24 -0400
Received: from oss.SGI.COM ([128.167.58.27]:56716 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S314680AbSECQiX>;
	Fri, 3 May 2002 12:38:23 -0400
Date: Fri, 3 May 2002 09:37:17 -0700
From: John Hawkes <hawkes@oss.sgi.com>
Message-Id: <200205031637.g43GbHv0026268@oss.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler gives big boost to tbench 192
Cc: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: <rwhron@earthlink.net>
...
> tbench 192 is an anomaly test too.  AIM looks like a nice
> "mixed" bench.  Do you have any scripts for it?  I'd like 
> to use AIM too.

Try http://www.caldera.com/developers/community/contrib/aim.html for a tarball
with everything you'll need.

The "Multiuser Shared System Mix" (aka "workfile.shared") is the one I use.
You'll need several disk spindles to keep it compute-bound, though.  Several
of the disk subtests, especially the sync_* tests, quickly drive one or two
spindles to their max transaction rates, and from that point AIM7 will be
I/O-bound and produce a largely idle system, which isn't very interesting if
you're trying to example CPU scheduler performance with high process counts.

One thing you can do is to comment-out the three sync_* tests in the
workfile.shared configuration file, and then watch your idle time with
something like vmstat.  Experiment with commenting-out more disk subtests,
like creat-clo, disk_cp, and disk_src, one by one, until AIM7 becomes
compute-bound.

John Hawkes
