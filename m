Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267616AbTAaFne>; Fri, 31 Jan 2003 00:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267698AbTAaFne>; Fri, 31 Jan 2003 00:43:34 -0500
Received: from mail016.syd.optusnet.com.au ([210.49.20.174]:60569 "EHLO
	mail016.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S267616AbTAaFnd> convert rfc822-to-8bit; Fri, 31 Jan 2003 00:43:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] 2.5.59-mm6 with contest
Date: Fri, 31 Jan 2003 16:52:14 +1100
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, Nick Piggin <piggin@cyberone.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301311652.47715.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here are contest (http://contest.kolivas.net) benchmark results with the osdl 
hardware (http://www.osdl.org) for 2.5.59-mm6 (reconfigured hardware again to 
get most useful results with contest). These results have been checked for 
accuracy, repeatability and asterisks have been placed next to statistically 
significant differences.

I do believe these show that sequential reads are indeed scheduled before 
writes with this kernel.  The question is, how long should they be scheduled 
for?

no_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       79      94.9    0       0.0     1.00
2.5.59-mm6      1       78      96.2    0       0.0     1.00
cacherun:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       76      98.7    0       0.0     0.96
2.5.59-mm6      1       76      97.4    0       0.0     0.97
process_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       92      81.5    28      16.3    1.16
2.5.59-mm6      1       92      81.5    25      15.2    1.18
ctar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       98      80.6    2       5.1     1.24*
2.5.59-mm6      3       112     70.5    2       4.5     1.44*
xtar_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       101     75.2    1       4.0     1.28*
2.5.59-mm6      3       115     66.1    1       4.3     1.47*
io_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       153     50.3    8       13.7    1.94*
2.5.59-mm6      3       106     70.8    4       9.4     1.36*
read_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       102     76.5    5       4.9     1.29*
2.5.59-mm6      3       733     10.8    56      6.3     9.40*
list_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       95      80.0    0       6.3     1.20*
2.5.59-mm6      3       97      79.4    0       6.2     1.24*
mem_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       97      80.4    56      2.1     1.23
2.5.59-mm6      3       94      83.0    50      2.1     1.21
dbench_load:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       126     60.3    3       22.2    1.59
2.5.59-mm6      3       122     61.5    3       25.4    1.56
io_other:
Kernel     [runs]       Time    CPU%    Loads   LCPU%   Ratio
2.5.59          3       89      84.3    2       5.5     1.13
2.5.59-mm6      2       90      83.3    2       6.7     1.15

io_load result is excellent showing the continuous write is delaying kernel 
compilation by much less. read_load tells the rest of the story though. 
read_load repeatedly reads a 256Mb file (the size of physical ram in the test 
machine)

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+Og8RF6dfvkL3i1gRAvLaAJ96HIePSeQ3TasNr8o19fzJGOyUUwCfTM4w
UKY8C9r2/2F5e4rrv9yOx7g=
=y8wz
-----END PGP SIGNATURE-----
