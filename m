Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315383AbSEBTiB>; Thu, 2 May 2002 15:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315386AbSEBTiA>; Thu, 2 May 2002 15:38:00 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:41156 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP
	id <S315383AbSEBTh6>; Thu, 2 May 2002 15:37:58 -0400
Date: Thu, 2 May 2002 16:33:12 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: linux-kernel@vger.kernel.org
Cc: acl-devel@bestbits.at
Subject: kswapd in zombie state with 2.4.17+acl
Message-ID: <20020502163312.J217@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	linux-kernel@vger.kernel.org, acl-devel@bestbits.at
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-RAVMilter-Version: 8.3.0(snapshot 20010925) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Today i've found that kswapd is in a zombie state; but the machine is still
up and working just fine, under the normal (low) load.

The kernel is 2.4.17 with acl patches, and has been running without any
problems for 80 days. The versions of the different acl utilities and
patches are:

Nov  8 23:35 acl-0.7.23.tar.gz
Sep 20  2001 e2fsprogs-1.25.tar.gz
Oct 28  2001 ea-0.7.22.tar.gz
Nov 25 10:02 fileutils+acl-4.1-0.7.24.patch.gz
Jan 31 11:36 fileutils+acl-4.1.tar.gz
Apr 29  2001 fileutils-4.1.tar.gz
Jan  6 20:00 linux-2.4.17acl-0.7.27.patch.gz
Dec 29 18:58 linux-2.4.17ea-0.7.27.patch.gz


It's main (and almost only) taks is doing file serving with samba.

All the filesystems are ext3, one of them over a linear 2-disk raid.

Nothing strange appears on the logs.

I can't say when this happened because i haven't logged in for a couple of
days.

One strange thing is that, looking at vmstat's output, there are changes in
swap (spaces erased to make it fit):

0  0  0   5984   6388  16104 113968   0   0     0     0  104     3  1  0 99
0  0  0   5984   6388  16104 113968   0   0     0     0  103     3  0  1 99
0  0  0   5972   6480  16104 113976   0   0     0     0  141    44  1  4 95
0  0  0   5972   6552  16104 113980   0   0     0     0  369   333  2  1 97

(another sample)
0  0  0   5732   2992  17784 115672   0   0   708     0 1833  1633  2  7 91
1  0  0   5732   2292  17752 116520   0   0  1604  1080 3148  2846  1 23 76
0  0  0   5724   2264  17352 117028   0   0  2412     0 5240  4866  4 25 72
1  0  0   5724   2260  17352 117016   0   0  1128     0 3011  2749  3 17 81
 

The line from ps -aux is the following:
root         4  0.0  0.0     0    0 ?        Z    Feb11  18:21 [kswapd
<defunct>]


Thinking that maybe it was a parsing error from ps, i looked in /proc and
here's the output:

root@fs1:/proc/4# cat stat
4 (kswapd) Z 0 1 1 0 -1 2116 0 0 0 0 0 110185 0 0 9 0 0 0 95 0 0 4294967295
0 0 0 0 0 0 2147483647 0 0 3222360010 0 0 0 0
root@fs1:/proc/4# cat statm
0 0 0 0 0 0 0
root@fs1:/proc/4# cat status
Name:   kswapd
State:  Z (zombie)
Tgid:   0
Pid:    4
PPid:   0
TracerPid:      0
Uid:    0       0       0       0
Gid:    0       0       0       0
FDSize: 0
Groups:
SigPnd: 0000000000000000
SigBlk: ffffffffffffffff
SigIgn: 0000000000000000
SigCgt: 0000000000000000
CapInh: 0000000000000000
CapPrm: 00000000ffffffff
CapEff: 00000000fffffeff
root@fs1:/proc/4#

Apart from this, everything looks normal.

I don't want to push the machine to see if it oopses because there might be
some useful information to collect, so tell me if you want me to try
anything.

Thanks,
		Alberto


