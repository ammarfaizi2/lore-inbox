Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266714AbUBMES5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 23:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266718AbUBMES5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 23:18:57 -0500
Received: from mail016.syd.optusnet.com.au ([211.29.132.167]:4070 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266714AbUBMESx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 23:18:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kernbench-0.20
Date: Fri, 13 Feb 2004 15:18:34 +1100
User-Agent: KMail/1.6
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Cliff White <cliffw@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402131518.41209.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Martin J. Bligh has for some time been producing results of a benchmark he 
devised called "kernbench" which is designed to measure cpu throughput, with 
emphasis on SMP systems.

I set out to make this benchmark a portable and easy to use script for anyone 
with adequate hardware to perform kernbench, after some feedback from MJB. 
All the SMP work currently underway inspired this. So here is the first 
public release:

http://ck.kolivas.org/kernbench/

What it does:
It runs the venerable kernel compile a number of different ways:
It cleans and primes a kernel tree with a make defconfig. Then it reads all 
the kernel source to cache it in ram. Then it will perform a number of 
different kernel compiles after a warmup run compile the same as the one it 
is about to test. Then it times the following runs 5 times:

half load: make -j (NR_CPUS/2)
optimal load: make -j (NR_CPUS*4)
maximum load: make -j

Optionally it can also perform a single threaded make, the number of jobs for 
optimal can be defined, the number of runs can be defined, and any of the 
default runs can be disabled.

Then it will print out an average of each of the loads with some useful 
statistics. A sample from an IBM X440 8x1.5Ghz P4HT on linux-2.6.3-rc2 
follows:

Average Single Threaded Run:
Elapsed Time 1069.65
User Time 965.894
System Time 117.856
Percent CPU 101
Context Switches 6223.2
Sleeps 23056.4

Average Half Load Run:
Elapsed Time 120.808
User Time 802.428
System Time 92.072
Percent CPU 740
Context Switches 10613.6
Sleeps 26667

Average Optimum Load Run:
Elapsed Time 81.59
User Time 1007.89
System Time 112.36
Percent CPU 1372.6
Context Switches 63006.2
Sleeps 40406

Average Maximum Load Run:
Elapsed Time 82.944
User Time 1012.33
System Time 122.424
Percent CPU 1367.6
Context Switches 44822.2
Sleeps 22161

A few points:
Do not try to run the maximum load on a machine with less than 2Gb ram, as 
swap thrashing is likely, so the benchmark will not be a cpu throughput one 
but a vm benchmark (of course you may want to do this too).

It is best run on a non-journalled filesystem to minimise the effects of the 
journal write-out; although this is probably not greatly important.

If run on a 4x box, the half load will be make -j2. The problem with compiling 
a kernel at make -j2 is that usually only one job spawns so the results may 
not be very useful.


Cliff if you want to wrap this into an OSDL benchmark, it may be worthwhile 
profiling each group of runs together and using the -s option by default as a 
separate "kernbench-long" to include the single threaded runs. 

Thanks, Martin for the idea and feedback. Thanks osdl for the hardware for 
development, and others for code help.

Con Kolivas

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFALFAdZUg7+tp6mRURAlP5AJ4mNCVYx9t8l6/gfbWDkUnwgCOFqACfYAv2
j65YYRirO/9Y8OcEii/fO0U=
=JPCD
-----END PGP SIGNATURE-----
