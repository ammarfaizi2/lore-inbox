Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136087AbREJMAk>; Thu, 10 May 2001 08:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREJMAb>; Thu, 10 May 2001 08:00:31 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136050AbREJMAS>;
	Thu, 10 May 2001 08:00:18 -0400
Date: Thu, 10 May 2001 13:19:45 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510131945.B11927@netppl.fi>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200105092125.f49LPew13300@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <200105092125.f49LPew13300@jen.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 04:25:40PM -0500, Steve Lord wrote:
> 
> > 
> > XFS is very fast most of the time (deleting a file is sooooo slow its like us
> > ing
> > old BSD systems). Im not familiar enough with its behaviour under Linux yet.
> 
> Hmm, I just removed 2.2 Gbytes of data in 30000 files in 37 seconds (14.4
> seconds system time), not tooo slow. And that is on a pretty vanilla 2 cpu
> linux box with a not very exciting scsi drive.
Here's some very unscientific numbers I've measured (ancient 4G SCSI
drive on a dual pII/450), XFS 1.0-pre2 and reiserfs is
the version in that kernel. The first bit is from tiobench, the multiple 
files one is a simple 30-line program that creates tons of 1k files and then
removes them.

XFS

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     256    4096    1  9.601 8.36% 0.644 1.48% 9.367 20.8% 0.587 1.12%
   .     256    4096    2  7.201 6.51% 0.672 1.50% 9.323 24.3% 0.582 1.63%
   .     256    4096    4  6.867 6.25% 0.693 1.46% 9.280 27.0% 0.590 1.91%
   .     256    4096    8  6.669 6.29% 0.708 1.57% 9.215 31.4% 0.597 1.99%

Create 20000 files: 116.882449
Unlink 20000 files: 47.449201

reiserfs

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     256    4096    1  9.591 11.9% 0.480 1.53% 4.506 21.4% 0.581 1.67%
   .     256    4096    2  7.176 8.91% 0.557 1.56% 5.559 30.3% 0.579 1.96%
   .     256    4096    4  6.509 8.34% 0.593 1.69% 6.142 36.9% 0.580 1.96%
   .     256    4096    8  5.602 7.17% 0.621 1.84% 6.430 40.5% 0.581 1.99%

Create 20000 files: 17.862143
Unlink 20000 files: 9.487520

ext2

         File   Block  Num  Seq Read    Rand Read   Seq Write  Rand Write
  Dir    Size   Size   Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
------- ------ ------- --- ----------- ----------- ----------- -----------
   .     256    4096    1  9.533 7.26% 0.472 1.11% 4.505 7.77% 0.582 1.11%
   .     256    4096    2  7.274 5.56% 0.559 1.16% 5.667 12.2% 0.584 1.14%
   .     256    4096    4  6.377 4.84% 0.600 1.13% 6.209 15.2% 0.587 1.40%
   .     256    4096    8  5.613 4.33% 0.623 1.16% 6.433 17.4% 0.589 1.58%

Create 20000 files: 248.758925
Unlink 20000 files: 2.287174

-- 
Pekka Pietikainen



