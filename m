Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTAXBLZ>; Thu, 23 Jan 2003 20:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267470AbTAXBLZ>; Thu, 23 Jan 2003 20:11:25 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:35522 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267463AbTAXBLY>; Thu, 23 Jan 2003 20:11:24 -0500
Date: Thu, 23 Jan 2003 20:26:18 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1?
Message-ID: <20030124012618.GA12005@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >lovely.  These two files have perfectly intermingled blocks.  

>> Writeback? or read?

> Both.

>  The fileystems need fixing....

Did you add a secret sauce to 2.5.59-mm2?  10x sequential
write improvement on ext3 for multiple tiobench threads.

Quad P3 Xeon (4GB ram)
8 GB files
4K blocksize
32 threads
Rate = MB/sec
latency in milliseconds

Sequential Writes ext3
                              Avg       Maximum     Lat%     Lat%    CPU
Kernel       Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
----------  ------------------------------------------------------------
2.4.20aa1    11.85 72.77%    11.814    21802.73  0.05036  0.00000     16
2.5.59        3.42 17.36%    83.976  3109518.52  0.11253  0.05088     20
2.5.59-mm2   32.39 34.28%     7.742   340597.62  0.04287  0.01765     94

Similar improvement for seq writes for 2, 4, 8, 16, 64, 128, 256 threads.

Sequential reads on ext3 with 2.5.59-mm2 improves around 3x for various 
thread counts.  Below is 32 threads.

Sequential Reads ext3
                              Avg       Maximum     Lat%     Lat%    CPU
Kernel       Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
----------  ------------------------------------------------------------
2.4.20aa1     8.24  7.21%    28.587   449134.11  0.10395  0.07086    114
2.5.59        9.50  5.50%    36.703     4310.62  0.00000  0.00000    173
2.5.59-mm2   35.28 17.69%    10.173    18950.56  0.01010  0.00000    199


-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

