Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRKLVuN>; Mon, 12 Nov 2001 16:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281027AbRKLVuD>; Mon, 12 Nov 2001 16:50:03 -0500
Received: from rj.sgi.com ([204.94.215.100]:29638 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281024AbRKLVts>;
	Mon, 12 Nov 2001 16:49:48 -0500
Subject: Re: File System Performance
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ben Israel <ben@genesis-one.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3BF04289.8FC8B7B7@zip.com.au>
In-Reply-To: <3BF03402.87D44589@zip.com.au>, <3BF02702.34C21E75@zip.com.au>,
	<00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net>
	<3BEFF9D1.3CC01AB3@zip.com.au>
	<00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> 
	<3BF02702.34C21E75@zip.com.au>
	<1005595583.13307.5.camel@jen.americas.sgi.com> 
	<3BF03402.87D44589@zip.com.au>
	<1005600431.13303.10.camel@jen.americas.sgi.com> 
	<3BF04289.8FC8B7B7@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 15:45:02 -0600
Message-Id: <1005601502.13301.12.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-11-12 at 15:43, Andrew Morton wrote:

> 
> It's tar.  It cheats.  It somehow detects that the
> output is /dev/null, and so it doesn't read the input files.
> I think.
> 

Yep it cheats all right:

execve("/bin/tar", ["tar", "cf", "/dev/null", "linux"], [/* 30 vars */])
= 0
% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 59.70    1.114097         740      1505           getdents64
 37.22    0.694516          55     12650           lstat64
  1.62    0.030264          39       775         3 open
  0.56    0.010518          14       777           close
  0.40    0.007395          10       770           fstat64
  0.24    0.004553           6       749           fcntl64
  0.11    0.001972         986         2           poll
  0.02    0.000420         210         2         2 connect
  0.02    0.000418          32        13           read
  0.02    0.000345          20        17           old_mmap
  0.02    0.000286          36         8           munmap
  0.02    0.000281          18        16           mmap2
  0.01    0.000189          47         4           socket
  0.01    0.000161          16        10           brk
  0.01    0.000101          51         2           sendto
  0.00    0.000076          15         5           mprotect
  0.00    0.000076          38         2           recvfrom
  0.00    0.000075          25         3           uname
  0.00    0.000059          30         2           readv
  0.00    0.000057          29         2           bind
  0.00    0.000056          28         2           setsockopt
  0.00    0.000039          39         1           readlink
  0.00    0.000025          13         2           getpid
  0.00    0.000023          23         1           rt_sigaction
  0.00    0.000021          21         1           time
  0.00    0.000021          21         1           gettimeofday
  0.00    0.000014           7         2           ioctl
------ ----------- ----------- --------- --------- ----------------
100.00    1.866058                 17324         5 total

Not a lot of reads in there.... I should have known it could
not go that fast.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
