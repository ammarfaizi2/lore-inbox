Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277851AbRJLTzn>; Fri, 12 Oct 2001 15:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277849AbRJLTzd>; Fri, 12 Oct 2001 15:55:33 -0400
Received: from math.uci.edu ([128.200.174.70]:19190 "EHLO math.uci.edu")
	by vger.kernel.org with ESMTP id <S277844AbRJLTz2>;
	Fri, 12 Oct 2001 15:55:28 -0400
From: Eric Olson <ejolson@math.uci.edu>
Message-Id: <200110121954.MAA27243@math.uci.edu>
Subject: reiserfs performance loss
To: linux-kernel@vger.kernel.org
Date: Fri, 12 Oct 2001 12:54:47 -0700 (PDT)
Reply-To: ejolson@math.uci.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans and linux-kernel,

I am experiencing read performance loss of between 5 to 20 times 
due to what I think is data fragmentation in big files.

I am using linux-2.4.4 with the linux-2.4.4-knfsd-6.g.patch on a
dual processor VIA694 motherboard system with a 40GB Maxtor drive
on the builtin IDE controller DMA enabled and 512MB main memory.

The reiserfs partition is 31GB and about 60-70% full.  Also, tail-
packing has not been disabled.

My application consists of 8 programs tied together using MPI.
Each program opens a separate output file and periodically writes 
about 200k of data every 10-40 minutes.  Some programs run on 
remote machines and use the kernel nfsd to write their files on 
the server; other programs run directly on the server.  It is
possible all 8 programs write at the same time.

In this way 8 data files of about 500MB each are created.

For backup these data files are copied to a second server using 
rsync.  The second server is identical to the main server in both 
hardware and software.  Running hdparm -t gives about 20 MB/sec 
for each machine.  However,

	time cat *.dat >/dev/null

reads the data locally on the secondary server 5 to 20 times faster
than reading them locally on the main server.

Main server timings are

	real    6m26.789s
	user    0m0.210s
	sys     0m9.630s

and secondary server timings are

	real    0m34.358s
	user    0m0.250s
	sys     0m9.830s

This is 11 times speed difference.  I think the original copies of 
the files are quite fragmented.  However, I would have expected at 
most a two fold decrease in actual performace.  Is this reasonable?

I have experienced no other difficulties with reiserfs and like it 
very much.

All the best, Eric
