Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136412AbREJNMn>; Thu, 10 May 2001 09:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136471AbREJNMe>; Thu, 10 May 2001 09:12:34 -0400
Received: from ns.suse.de ([213.95.15.193]:56589 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136412AbREJNMV>;
	Thu, 10 May 2001 09:12:21 -0400
Date: Thu, 10 May 2001 15:12:04 +0200
From: Andi Kleen <ak@suse.de>
To: Steve Lord <lord@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        =?iso-8859-1?Q?Mart=EDn_Marqu=E9s?= <martin@bugs.unl.edu.ar>,
        linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510151204.A16686@gruyere.muc.suse.de>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200105092125.f49LPew13300@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105092125.f49LPew13300@jen.americas.sgi.com>; from lord@sgi.com on Wed, May 09, 2001 at 04:25:40PM -0500
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

On one not very scientific test: unpacking and deleting a cache hot 40MB/230MB
gzipped/unzipped tar on ext2 and xfs on a IDE drive on a lowend SMP box.

XFS (very recent 2.4.4 CVS, filesystem created with mkxfs defaults)

> time tar xzf ~ak/src.tgz 
real    1m58.125s
user    0m16.410s
sys     0m44.350s
> time rm -rf src/
real    0m50.344s
user    0m0.190s
sys     0m13.950s

ext2 (on same kernel as above)

> time tar xzf ~ak/src.tgz 

real    1m26.126s
user    0m16.100s
sys     0m36.080s

> time rm -rf src/

real    0m1.085s
user    0m0.160s
sys     0m0.930s

ext2 seems to be faster and the difference on deletion is dramatic, so
at least here it looks like Alan's statement is true.

The test did not involve very large files, the biggest files in the 
tar are a few hundred K with most of them being much smaller.

The values stay similar over multiple runs.  I did not do any comparisons
recently with reiserfs, but at least in the past reiserfs usually came out
ahead of ext2 for similar tests (especially being much faster for deletion)

-Andi
