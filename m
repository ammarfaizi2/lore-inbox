Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbTCICdz>; Sat, 8 Mar 2003 21:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbTCICdu>; Sat, 8 Mar 2003 21:33:50 -0500
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:29659 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262369AbTCICds>; Sat, 8 Mar 2003 21:33:48 -0500
Date: Sat, 8 Mar 2003 21:50:15 -0500
To: linux-kernel@vger.kernel.org
Subject: scheduler starvation running irman with 2.5.64bk2
Message-ID: <20030309025015.GA2843@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irman triggers some odd behavior with 2.5.64bk2 on uniprocessor 
K6/2 475.  "ps aux" hasn't returned for a couple hours, though
irman appears to be doing it's thing.  I haven't tried irman on smp.

Time to run irman 3x.

2.5.63			4066 seconds
2.5.63-mjb1		2993 seconds
2.5.63-mm2-dline	2856 seconds
2.5.64			3473 seconds
2.5.64bk2		??

Time to complete irman is variable because the amount of work
done in 3 runs is also variable.

vmstat looks fairly typical, and it prints every 60 seconds.

vmstat 60
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  0  0   2564 376368    108   1916    0    0     0     0 1092 25978  2 98  0
 4  0  0   2564 376368    108   1920    0    0     0     0 1092 26102  2 98  0

This is vmstat 60 from 2.5.64

   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 4  0  0   2552 377024    116   1520    0    0     0     0 1092 32649  4 96  0
 3  0  0   2552 377024    116   1520    0    0     0     0 1092 32865  5 95  0


There are probably less than 50 processes running.  
"ps aux" doesn't hear <ctrl z> or <ctrl c>.

Machine doesn't accept new ssh connections.

It's as if after starting irman, new processes don't get any CPU time.

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

