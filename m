Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbUCTHmL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 02:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263246AbUCTHmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 02:42:11 -0500
Received: from alt.aurema.com ([203.217.18.57]:59066 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S263244AbUCTHl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 02:41:59 -0500
Date: Sat, 20 Mar 2004 18:41:56 +1100 (EST)
From: John Lee <johnl@aurema.com>
X-X-Sender: johnl@johnl.sw.oz.au
To: linux-kernel@vger.kernel.org
Subject: [PATCH] O(1) Entitlement Based Scheduler v1.1
Message-ID: <Pine.LNX.4.44.0403201758100.26496-100000@johnl.sw.oz.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is an update of the original Entitlement Based Scheduler 
announed a few weeks ago. The patch can be downloaded from

http://sourceforge.net/projects/ebs-linux/

and applies to Linux 2.6.4.

The two main changes in this version are:
1) Interactivity has been greatly improved, courtesy of "ramp-up" 
dampening being applied to newly forked tasks. 
2) Background tasks are now "almost background" tasks in that they are 
given periodic (but slow) promotion.

As before, when using this patch X should be reniced to -15.

Below is a contest benchmark for this patch, performed on a dual 
P3-800MHz:

no_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    86      168.6   0       25.6    1.00    194.2
2.6.4-EBS          3    82      176.8   0       15.9    1.00    192.7
cacherun:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    85      170.6   0       27.1    0.99    197.7
2.6.4-EBS          3    80      181.2   0       15.0    0.98    196.2
process_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    103     140.8   34      54.4    1.20    195.2
2.6.4-EBS          3    103     139.8   35      53.4    1.26    193.2
ctar_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    100     153.0   0       1.0     1.16    154.0
2.6.4-EBS          3    98      157.1   0       0.0     1.20    157.1
xtar_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    95      160.0   0       6.3     1.10    166.3
2.6.4-EBS          3    92      163.0   0       5.4     1.12    168.4
io_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    312     51.0    23      12.1    3.63    63.1
2.6.4-EBS          3    200     77.0    14      11.4    2.44    88.4
read_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    116     135.3   6       7.8     1.35    143.1
2.6.4-EBS          3    111     139.6   6       8.1     1.35    147.7
2list_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    122     123.8   0       10.7    1.42    134.5
2.6.4-EBS          3    123     121.1   0       8.1     1.50    129.2
mem_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    102     158.8   31      2.9     1.19    161.7
2.6.4-EBS          3    103     159.2   31      2.9     1.26    162.1
dbench_load:
Kernel        [runs]    Time    CPU%    Loads   LCPU%   Ratio CPU+LCPU%
2.6.4              3    203     76.4    2       45.6    2.36    122.0
2.6.4-EBS          3    150     104.0   1       22.0    1.83    126.0

Comments, bug reports and testing are welcome.

Thanks,

John


