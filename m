Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUGNCZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUGNCZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 22:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267297AbUGNCZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 22:25:26 -0400
Received: from mailgate2.mysql.com ([213.136.52.47]:15237 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S267294AbUGNCZU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 22:25:20 -0400
Subject: VM Problems in 2.6.7 (Too active OOM Killer)
From: Peter Zaitsev <peter@mysql.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MySQL
Message-Id: <1089771823.15336.2461.camel@abyss.home>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 19:23:44 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To be honest I was truly surprised seeing OOM killer killing MySQL
without any good reason during highly IO intensive test:

Out of Memory: Killed process 19301 (mysqld).
Out of Memory: Killed process 19302 (mysqld).
Out of Memory: Killed process 19303 (mysqld).
Out of Memory: Killed process 19304 (mysqld).
Out of Memory: Killed process 19305 (mysqld).
Out of Memory: Killed process 19306 (mysqld).
Out of Memory: Killed process 19309 (mysqld).
Out of Memory: Killed process 19310 (mysqld).
Out of Memory: Killed process 19311 (mysqld).
Out of Memory: Killed process 19312 (mysqld).
Out of Memory: Killed process 19737 (mysqld).
Out of Memory: Killed process 19739 (mysqld).
Out of Memory: Killed process 19821 (mysqld).


This box has 4G memory and running without swap (what I would need it
for If I can only use up to 3GB address space in the application anyway)


Here is how VMSTAT Looked like:

 0  4      0   7028  43436 1656020    0    0  3988  8752 1716 11803  8 
5 45 43
 0  9      0   7004  42520 1654692    0    0  4372  8642 1735 12803  8 
5 41 46
 2  3      0   7828  40784 1654252    0    0  4024  7838 1662 11486  7 
4 44 45
 5 13      0   7228  38652 1653800    0    0  4370  9087 1751 12864  9 
5 40 47
 0  2      0   5928  32976 1645808    0    0  4954  8866 1890 13352  9 
5 39 47
 0 15      0   6560  22052 1642996    0    0  5111  7699 2004 11819  8 
5 41 47
 0  2      0   6232  15760 1642624    0    0  4630  6841 1912 10315  6 
4 46 45
 1  6      0   7804  10912 1640332    0    0  4493  6446 1913  9362  6 
4 48 43
 0  5      0 391660   6080 1267356    0    0  4265  6404 1902  9483  6 
4 46 44
procs                      memory      swap          io    
system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
id wa
 0  2      0 330392   5696 1319216    0    0  4674  6309 1949  9792  6 
4 46 44
 0  2      0 278052   3520 1363212    0    0  4155  5177 1827  7459  4 
6 48 42
 1  0      0 2188840   5676 1387984    0    0  2176  2104 1410 21275  5
33 41 21
 0  1      0 2121864  16948 1421456    0    0  1110  3600 1317 85261 11
23 58  8
 1  0      0 2062688  27072 1454988    0    0   997  3612 1302 84842 11
22 58  9
 0  1      0 1997464  38160 1488236    0    0  1096  3685 1319 85041 11
23 59  8
 0  1      0 1930536  52184 1521540    0    0  1391  4318 1476 84995 11
23 58  9
 0  1      0 1841888  69896 1555032    0    0  1758  3630 1478 84814 11
23 58  8
 0  1      0 1758272  85860 1588504    0    0  1597  3651 1460 84212 11
23 58  8
 0  1      0 1683696 101220 1621764    0    0  1524  3694 1432 84605 11
23 58  8
 0  1      0 1609016 115756 1655032    0    0  1440  3802 1400 84774 11
23 59  8


So we had some 1.4GB of memory in "cached" state, so why not to shrink
cache instead ? 

I hope we're not going back to 2.4 times, where a lot of people fought
with VM/OOM problems and lost :)


I now this is likely not that much helpful and a lot more info is
needed. I'll see if I run into this again and will be asking which
information exactly is needed to troubleshoot the problem. 





-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com



