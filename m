Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136963AbREJWYk>; Thu, 10 May 2001 18:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136964AbREJWYV>; Thu, 10 May 2001 18:24:21 -0400
Received: from ghostwheel.underley.eu.org ([217.97.235.9]:11533 "EHLO
	bobas.nowytarg.top.pl") by vger.kernel.org with ESMTP
	id <S136963AbREJWYN>; Thu, 10 May 2001 18:24:13 -0400
From: Daniel Podlejski <underley@witch.underley.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
In-Reply-To: <20010510151204.A16686@gruyere.muc.suse.de>
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <20010510151204.A16686@gruyere.muc.suse.de>
X-PGP-Fingerprint: 4D 72 53 F8 FE 8C 53 B9  66 AD F6 EA C9 17 CD 82
X-Homepage: http://www.underley.eu.org/
Message-Id: <20010510222313Z5297730-750+10@witch.underley.eu.org>
Date: Fri, 11 May 2001 00:23:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On linux-kernel, ak@suse.de (Andi Kleen) wrote:
:  On one not very scientific test: unpacking and deleting a cache hot 40MB/230MB
:  gzipped/unzipped tar on ext2 and xfs on a IDE drive on a lowend SMP box.
:  
:  XFS (very recent 2.4.4 CVS, filesystem created with mkxfs defaults)
:  
: > time tar xzf ~ak/src.tgz 
:  real    1m58.125s
:  user    0m16.410s
:  sys     0m44.350s
: > time rm -rf src/
:  real    0m50.344s
:  user    0m0.190s
:  sys     0m13.950s
:  
:  ext2 (on same kernel as above)
:  
: > time tar xzf ~ak/src.tgz 
:  
:  real    1m26.126s
:  user    0m16.100s
:  sys     0m36.080s
:  
: > time rm -rf src/
:  
:  real    0m1.085s
:  user    0m0.160s
:  sys     0m0.930s

And another test:

ext2:

root@witch:/mobile:# time tar xzf /arc/test.tar.gz

real    5m25.249s
user    1m33.430s
sys     0m31.710s

root@witch:/mobile:# time rm -rf test/

real    0m8.843s
user    0m0.000s
sys     0m0.420s

xfs:

root@witch:/mobile:# time tar xzf /arc/test.tar.gz

real    5m23.744s
user    1m34.800s
sys     0m39.100s
root@witch:/mobile:# time rm -rf test/

real    0m1.364s
user    0m0.030s
sys     0m0.430s

test.tar.gz is tree created by script:

#!/bin/bash

for lev1 in aa bb cc dd ee ff gg hh ii jj kk ll
do

	mkdir $lev1
	cd $lev1

	for lev2 in 0 1 2 3 4 5 6 7
	do
		mkdir $lev2
		cd $lev2

		for fname in a b c d e f g h i
		do
			dd if=/dev/urandom of=$fname bs=4k count=1024
		done

		cd ..
	done

	cd ..
done


-- 
Daniel Podlejski <underley@underley.eu.org>
   ... When you're talkin to yourself and nobody's home
   You can fool yourself, you came in this world alone ...
