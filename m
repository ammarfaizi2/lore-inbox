Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310654AbSC1AFO>; Wed, 27 Mar 2002 19:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310740AbSC1AFE>; Wed, 27 Mar 2002 19:05:04 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:30991 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S310654AbSC1AEy>; Wed, 27 Mar 2002 19:04:54 -0500
Date: Thu, 28 Mar 2002 00:04:42 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <3CA20698.E8A9826E@zip.com.au>
Message-ID: <Pine.LNX.4.33.0203272354430.17217-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Andrew Morton wrote:

> > Yeah, I thought it was a little odd.  Postgres does so much
> > fsync()ing that I thought it may just have been that the lower
> > overhead won out over ext2's cleverer layout.  All the I/O was
> > basically fsync-driven, so this test was only about write
> > performance.
>
> For fsync-intensive loads ext3's best mode is generally
> data=journal.  That way, an fsync is satisfied by a nice
> single linear write to the journal.

Here we are.  This is with just a 200Mb journal (the partition
is only a little over 1Gb, and the datafiles grow fairly big,
so I didn't brave making it any bigger).

	tuning?	single	ir	mx-ir	oltp	mixed-oltp
		(sec)	(tps)	(sec)	(tps)	(sec)
ext3    bn      1285.32 65.98   1996.41 90.05   307.79
ext3-wb	bn      1287.31 98.42   2149.38 125.13  236.02
ext3-jd	bn      1306.90	72.07	1813.54	125.15	305.27

The I/O load should be almost exclusively fsync-driven writes,
so I'm not sure how to account for the fact that the OLTP and
OLTP + misc (mostly read) activity give different numbers.

I'll try to find time to run these again tomorrow to convince
myself that all is sane, but these numbers are usually pretty
stable.

Matthew.

