Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315438AbSEBVh0>; Thu, 2 May 2002 17:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSEBVhZ>; Thu, 2 May 2002 17:37:25 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:31197 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S315438AbSEBVhY>; Thu, 2 May 2002 17:37:24 -0400
Date: Thu, 2 May 2002 17:36:56 -0400
To: linux-kernel@vger.kernel.org
Subject: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020502173656.A26986@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an OSDL 4 way x86 box the O(1) scheduler effect 
becomes obvious as the run queue gets large.  

2.4.19-pre7-ac2 and 2.4.19-pre7-jam6 have the O(1) scheduler.  

At 192 processes, O(1) shows about 340% improvement in throughput.
The dyn-sched in -aa appears to be somewhat improved over the
standard scheduler.

Numbers are in MB/second.

tbench 192 processes
2.4.16                    29.39
2.4.17                    29.70
2.4.19-pre5               29.01
2.4.19-pre5-aa1           29.22
2.4.19-pre5-aa1-2g-hio    29.94
2.4.19-pre5-aa1-3g-hio    28.66
2.4.19-pre7               29.93
2.4.19-pre7-aa1           32.75
2.4.19-pre7-ac2          103.98
2.4.19-pre7-rmap13        29.46
2.4.19-pre7-jam6         104.98
2.4.19-pre7-rl            29.74

At 64 processes, O(1) helps a little.  ac2 and jam6 have
the highest numbers here too.

tbench 64 processes
2.4.16                    101.99
2.4.17                    103.49
2.4.19-pre5-aa1           102.43
2.4.19-pre5-aa1-2g-hio    104.30
2.4.19-pre5-aa1-3g-hio    104.60
2.4.19-pre7               100.86
2.4.19-pre7-aa1           101.76
2.4.19-pre7-ac2           105.89
2.4.19-pre7-rmap13        100.94
2.4.19-pre7-rl             99.65
2.4.19-pre7-jam6          108.23

I've seen some benefit on a uniprocessor box running tbench 32 
for kernels with O(1).  Hmm, have to try tbench 192 on uniproc 
and see if the difference is all scheduler overhead.

I'm putting together a page with more results on this machine.
It will be growing at:
http://home.earthlink.net/~rwhron/kernel/bigbox.html

-- 
Randy Hron

