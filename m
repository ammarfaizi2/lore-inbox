Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSFQNOn>; Mon, 17 Jun 2002 09:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSFQNOm>; Mon, 17 Jun 2002 09:14:42 -0400
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232]:19351 "EHLO
	flamingo.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S313087AbSFQNOl>; Mon, 17 Jun 2002 09:14:41 -0400
Date: Mon, 17 Jun 2002 09:16:07 -0400
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020617131607.GA2748@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> tiobench.pl --size 2048 --numruns 3 --threads 128  # 384 MB ram in machine

> From your trace it would seem that writeout completion has not
> occurred against one or more pages.  Could be that the device
> driver lost an interrupt, or it failed to deliver completion
> for one or more BIO segments, or something screwed up at the
> VFS level.

> I am (of course ;)) disinclined to believe the latter, mainly
> because of the amount of testing I do here.  Eight-hour Cerberus
> runs on quad CPU, five IDE disks and six SCSI disks all chugging
> along, no probs.

> Is it reproducible?   Are you able to try it on a different machine?
> On other disks in the same machine?

tiobench had a similar livelock in 2.5.19, 2.5.19 + 2 versions of
wli's lazy-buddy allocator, 2.5.20, 2.5.21, and 2.5.21 with the
request queue size change we talked about.  However, when I tried
it just now on a different disk and filesystem type (reiser instead
of ext2) it didn't happen.  The non-reproduced livelock didn't
have any of the previous stress testing run against the machine
though.

Since the tiobench livelock appeared in 2.5.19, the following
kernels have completed all tests.

2.4.19-pre10
2.5.20-dj3
2.4.19-pre10-ac2
2.4.19-pre10-aa1
2.5.20-dj4
2.4.19-pre10-jam2
2.4.19-pre10-jam2-O2
2.4.19-pre10-jam2-O3
2.4.18-cmpr-cache
2.4.19-pre10-mjc1

2.5.22 is out now and I'm trying that.  If it has a problem, I'm
inclined to rebuild the ext2 that tiobench, osdb, and dbench run 
on.  (may not help, but it won't hurt :)

-- 
Randy Hron

