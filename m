Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275711AbRI0AEH>; Wed, 26 Sep 2001 20:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275713AbRI0AD6>; Wed, 26 Sep 2001 20:03:58 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:38132 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275711AbRI0ADv>; Wed, 26 Sep 2001 20:03:51 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 26 Sep 2001 18:03:37 -0600
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] invalidate buffers on blkdev_put
Message-ID: <20010926180337.F1140@turbolinux.com>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20010925231124.0309ac70@pop.cus.cam.ac.uk> <5.1.0.14.2.20010926212916.022c3e00@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20010926212916.022c3e00@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 26, 2001  23:42 +0100, Anton Altaparmakov wrote:
> I wrote a quick benchmark program + script (appended at bottom of this 
> mail) and did 50 million iterations of either the do/while function or the 
> ffs() equivalent (including the BUG() check for power of 2) and it turns 
> out that on all CPUs tested (Pentium 133S, Pentium III 800, Alpha EV56 
> 533(or so), Athlon 1.33GHz 266FSB) the do/while loop is marginally faster 
> for sizes of 256 and 512 (except P3/800 where the ffs is faster even for 
> these smaller sizes) but is increasingly slower for increasing sizes. For 
> large sizes the do/while loop becomes significantly slower than the ffs() 
> approach, which of course is irrelevant at the moment with the block size 
> limitation...

How does this comapre with:

switch(blocksize) {
case  512: bits =  9; break;
case 1024: bits = 10; break;
case 2048: bits = 11; break;
case 4096: bits = 12; break;
case 8192: bits = 13; break;
default: BUG();
}

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

