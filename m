Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWEFSJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWEFSJF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWEFSJE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 14:09:04 -0400
Received: from mail.crosswalkinc.com ([72.16.196.98]:61446 "EHLO
	coach.cozx.com") by vger.kernel.org with ESMTP id S1751034AbWEFSJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 14:09:04 -0400
Message-ID: <445CE6ED.30703@cozx.com>
Date: Sat, 06 May 2006 12:11:57 -0600
From: Dave Pitts <dpitts@cozx.com>
Organization: Colorado Zephyrs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How can I boost block I/O performance
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all:

I've been trying some hacks to boost disk I/O performance mostly by 
changing values
in the /proc/sys/vm filesystem.  A vmstat display shows bursty block out 
counts with
fairly consistent interrupt counts:

procs -----------memory---------- ---swap-- -----io---- --system-- 
----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
id wa
 4  0    720  80252   1820 7077456    0    0     9   852    5    11  1 
14 84  0
 1  0    720  80444   1820 7077456    0    0     0     0 15923 77712  4 
20 76  0
 2  0    720  80196   1820 7077524    0    0     0     0 14705 87207  4 
18 79  0
 2  0    720  79732   1828 7077856    0    0     8   116 16235 84459  4 
20 76  0
 4  0    720 104172   1812 7051964    0    0    24 62568 20447 73499  4 
27 69  0
 2  0    720 105172   1812 7051964    0    0     0 90740 16960 80149  1 
21 78  0
 2  0    720 104108   1812 7051964    0    0     0     0 14162 72632  3 
13 85  0
 4  0    720 103980   1812 7052032    0    0     0     0 13495 68133  4 
16 80  0
 1  0    720 103868   1820 7052704    0    0     0   128 15417 59969  4 
17 79  0
 0  0    720 104340   1828 7052696    0    0     0   280 19504 74281  0  
8 92  0
 0  0    720 104532   1828 7052696    0    0     0     0 14736 70017  0  
5 95  0
 1  0    720 104596   1828 7052696    0    0     0     0 16006 73173  0  
6 94  0
 2  0    720  92844   1828 7064256    0    0    12     0 16508 80601  0  
9 91  0
 2  0    720  91916   1836 7064248    0    0     4   104 20787 74676  0  
7 92  0
 0  0    720  92580   1844 7064240    0    0     0 14640 17789 71545  0 
10 90  0
 1  0    720  92900   1844 7064240    0    0     0     0 15460 74760  0  
8 92  0
 0  0    720  92668   1844 7065260    0    0     0     0 18585 77435  0  
7 93  0
 0  0    720  92604   1844 7065260    0    0     0     0 19187 86426  0  
9 91  0
 2  0    720  91964   1860 7065244    0    0     0   140 23659 87962  0  
8 92  0
 5  0    720  90364   1860 7067080    0    0    40 66956 17995 95384  0 
17 82  0

This test is running several NFS clients to a RAID disk storage array. I 
also see the
same behavior when running SFTP transfers. What I'd like is a more even 
block
out behavior (even at the expense of other apps as this is a file server 
not an app
server).  The values that I've been hacking are the 
dirty_writeback_centisecs,
dirty_background_ratio, etc. Am I barking up the wrong tree?

Thanks in advance.

-- 
Dave Pitts                   PULLMAN: Travel and sleep in safety and comfort.
dpitts@cozx.com              My other RV IS a Pullman (Colorado Pine).
http://www.cozx.com/~dpitts

