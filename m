Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSC0Rxb>; Wed, 27 Mar 2002 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313044AbSC0RxL>; Wed, 27 Mar 2002 12:53:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313016AbSC0RxF>;
	Wed, 27 Mar 2002 12:53:05 -0500
Message-ID: <3CA20698.E8A9826E@zip.com.au>
Date: Wed, 27 Mar 2002 09:51:20 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Kirkwood <matthew@hairy.beasts.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <p73y9ge3xww.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0203271419230.28110-100000@sphinx.mythic-beasts.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Kirkwood wrote:
> 
> ...
> Yeah, I thought it was a little odd.  Postgres does so much
> fsync()ing that I thought it may just have been that the lower
> overhead won out over ext2's cleverer layout.  All the I/O was
> basically fsync-driven, so this test was only about write
> performance.
> 

For fsync-intensive loads ext3's best mode is generally
data=journal.  That way, an fsync is satisfied by a nice
single linear write to the journal.

With a high volume of data you'll quickly exhaust the
journal space so it would also be beneficial to create
a monster journal with, say, mke2fs -J 400.

-
