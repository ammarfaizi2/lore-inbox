Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTAaNLO>; Fri, 31 Jan 2003 08:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTAaNLO>; Fri, 31 Jan 2003 08:11:14 -0500
Received: from mail016.syd.optusnet.com.au ([210.49.20.174]:13750 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267624AbTAaNLM> convert rfc822-to-8bit; Fri, 31 Jan 2003 08:11:12 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 00:20:30 +1100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302010020.34119.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Using the osdl hardware (http://www.osdl.org) with contest 
(http://contest.kolivas.net) I've conducted a set of benchmarks with 
different filesystems. Note that contest does not claim to be a throughput 
benchmark.

All of these use kernel 2.5.59

First a set of contest benchmarks with the io load on a different hard disk 
containing each of the four filesystems:

io_other:
Kernel [runs]   Time    CPU%    Loads   LCPU%   Ratio
2559ext3    3   89      84.3    2       5.5     1.13
2559reiser  3   87      86.2    2       5.7     1.10
2559jfs     3   87      86.2    3       5.7     1.10
2559xfs     3   87      86.2    2       4.5     1.10

I found it interesting that there is virtually no difference in kernel 
compilation time with all fs. However jfs consistently wrote more during the 
io load than the other fs.


This is a set of benchmarks with the kernel compilation and load all performed 
on each of the fs:

ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        2       96      82.3    2       5.2     1.23
2559jfs         2       103     73.8    0       0.0     1.32
2559reiser      2       100     78.0    0       1.0     1.27
2559xfs         2       97      82.5    2       5.2     1.23

Not sure why the jfs load shows up as 0 cpu% unless it's an accounting issue 
within the kernel. Subtle differences between fs times.


xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        2       97      79.4    2       6.2     1.24
2559jfs         2       136     55.9    0       0.0     1.74
2559reiser      2       104     75.0    0       4.8     1.32
2559xfs         2       105     72.4    1       7.6     1.33

Once again jfs shows up no cpu%. These results show signficant prolongation of 
kernel compilation with repeated extracting of tars and jfs, without an 
increase in load work done.


io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        3       109     68.8    4       10.1    1.40
2559jfs         3       138     54.3    11      13.8    1.77
2559reiser      3       98      76.5    2       9.2     1.24
2559xfs         3       124     60.5    6       8.0     1.57

This shows the largest discrepancy with jfs holding up kernel compilation the 
most and doing the most work and reiserfs at the other end. Cpu usage by the 
jfs load seems to make sense here.


read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2559ext3        2       98      80.6    7       7.1     1.26
2559jfs         2       97      79.4    5       5.2     1.24
2559reiser      2       101     79.2    6       7.9     1.28
2559xfs         2       98      80.6    6       7.1     1.24

Interestingly reading has the opposite order to writing but with probably 
insignificant differences in time. Note the lowish cpu usage by jfs again.

Comments?
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD4DBQE+OngeF6dfvkL3i1gRAvKhAJYtmOkN1kLVuBMKI7Ygm317nXrUAJ0Y8UWI
IIdOlvqomgW5eEL4ZQkyGA==
=YDEz
-----END PGP SIGNATURE-----
