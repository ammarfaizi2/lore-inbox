Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWGHVFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWGHVFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 17:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWGHVFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 17:05:16 -0400
Received: from main.gmane.org ([80.91.229.2]:51625 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030381AbWGHVFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 17:05:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ask List <askthelist@gmail.com>
Subject: Runnable threads on run queue
Date: Sat, 8 Jul 2006 20:18:40 +0000 (UTC)
Message-ID: <loom.20060708T220409-206@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 66.237.13.5 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.4) Gecko/20060508 Firefox/1.5.0.4)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have an issue maybe someone on this list can help with. 

At times of very high load the number of processes on the run queue drops to
 0 then jumps really high and then drops to 0 and back and forth. It seems to
last 10 seconds or so. If you look at this vmstat you can see an example of 
what I mean. Now im not a linux kernel expert but i am thinking it has 
something to do with the scheduling algorithm and locking of the run queue. 
For this particular application I need all available threads to be processed as
fast as possible. Is there a way for me to elimnate this behavior or at least
minimize the window in which there are no threads on the run queue? Is there a
sysctl parameter I can use?

Please help.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
83  0   1328 301684  37868 1520632    0    0     0   264  400  1332 98  2  0  0
17  0   1328 293936  37868 1520688    0    0     0     0  537   979 97  3  0  0
73  0   1328 293688  37868 1520712    0    0     0     0  268  2643 98  2  0  0
80  0   1328 277220  37868 1520756    0    0     0     0  351   824 98  2  0  0
49  0   1328 262452  37868 1520800    0    0     0     0  393  1882 97  3  0  0
45  0   1328 246796  37868 1520828    0    0     0   304  302  1631 96  4  0  0
55  0   1328 243852  37868 1520872    0    0     0     0  356  1101 99  1  0  0
17  0   1328 228672  37868 1520916    0    0     0     0  336   748 97  3  0  0
 0  0   1328 299948  37868 1520956    0    0     0     0  299   821 78  3 19  0
 0  0   1328 299184  37868 1520960    0    0     0     0  168    78  8  0 92  0
 0  0   1328 299184  37868 1520960    0    0     0   248  173    38  0  1 99  0
 0  0   1328 299184  37868 1520960    0    0     0     0  160    20  0  0 100  0
 0  0   1328 299184  37868 1520960    0    0     0     0  151     6  0  0 100  0
 0  0   1328 299184  37868 1520960    0    0     0     0  162    42  0  1 99  0
 1  0   1328 299188  37868 1520960    0    0     0     0  161    24  0  0 100  0
 0  0   1328 298808  37868 1520988    0    0     0   100  303  1119 57  0 42  0
 0  0   1328 298808  37868 1520988    0    0     0     0  162    22  0  1 99  0
 3  0   1328 298808  37868 1520992    0    0     0     0  195   233 16  0 84  0
14  0   1328 298788  37868 1521032    0    0     0     0  400  1158 87  3 10  0
54  0   1328 298860  37868 1521064    0    0     0     0  438   940 97  3  0  0
80  0   1328 298296  37868 1521092    0    0     0   180  476   556 97  3  0  0
29  0   1328 294632  37868 1521148    0    0     0     0  824  1178 99  1  0  0
68  0   1328 292936  37868 1521172    0    0     0     0  404  2283 96  4  0  0
73  0   1328 292740  37868 1521216    0    0     0     0  521   828 98  2  0  0
38  0   1328 260340  37868 1521260    0    0     0     0  405  1069 96  4  0  0
46  0   1328 253072  37868 1521292    0    0     0   300  371  1692 95  5  0  0
71  0   1328 244084  37868 1521328    0    0     0     0  357  1478 98  2  0  0
71  0   1328 233916  37868 1521384    0    0     0     0  528  1121 97  3  0  0
32  0   1328 222784  37868 1521416    0    0     0     0  347  1191 96  4  0  0
76  0   1328 212396  37868 1521448    0    0     0     0  337  2526 97  3  0  0
71  0   1328 198684  37868 1521488    0    0     0   284  497   942 98  2  0  0
40  0   1328 189964  37868 1521532    0    0     0     0  420  1525 96  4  0  0
53  0   1328 179656  37868 1521576    0    0     0     0  391  1983 98  2  0  0
91  0   1328 169164  37868 1521608    0    0     0     0  415  2018 98  2  0  0
70  0   1328 151300  37868 1521648    0    0     0     0  411  1769 98  2  0  0
43  0   1328 145980  37868 1521684    0    0     0   308  420  1713 96  4  0  0
48  0   1328 142708  37868 1521724    0    0     0     0  290  1490 97  3  0  0
76  0   1328 126080  37868 1521752    0    0     0     0  389  1568 97  3  0  0
85  0   1328 120544  37864 1518164    0    0     0     0  365  1261 96  4  0  0
51  0   1328 121312  37864 1506908    0    0     0     0  306  1217 98  2  0  0
55  0   1328 121488  37864 1495128    0    0     0   292  364  1976 98  2  0  0
79  0   1328 120408  37864 1486072    0    0     0     0  328  2106 97  3  0  0
29  0   1328 216660  37864 1482744    0    0     0     0  387   866 97  3  0  0
 0  0   1328 321932  37864 1482788    0    0     0     0  289   750 67  3 31  0
 0  0   1328 321932  37864 1482788    0    0     0     0  158    10  0  0 100  0
 2  0   1328 321912  37864 1482792    0    0     0   268  201   156  4  1 94  0
 0  0   1328 321892  37864 1482796    0    0     0     0  180   270  7  0 93  0
 0  0   1328 321892  37864 1482796    0    0     0     0  152     4  0  0 100  0
 0  0   1328 321880  37864 1482796    0    0     0     0  158    26  0  1 99  0
 0  0   1328 321844  37864 1482820    0    0     0     0  330   454 41  1 58  0
 0  0   1328 321844  37864 1482820    0    0     0   120  167    30  0  0 100  0
 0  0   1328 321844  37864 1482820    0    0     0     0  166    35  1  0 99  0
35  0   1328 321476  37864 1482836    0    0     0     0  530  1026 67  2 31  0
76  0   1328 321528  37868 1482864    0    0     0     0  406  1744 96  4  0  0
41  0   1328 321172  37868 1482920    0    0     0   192  409   690 97  3  0  0
34  0   1328 314788  37868 1482956    0    0     0     0  356  1616 97  3  0  0
63  0   1328 314368  37868 1482996    0    0     0     0  437  1277 98  2  0  0
 1  0   1328 331744  37868 1483044    0    0     0     0  331   709 90  3  7  0
 0  0   1328 331724  37868 1483048    0    0     0     0  174   395  4  0 96  0
 0  0   1328 331724  37868 1483048    0    0     0   224  168    16  0  0 100  0
 0  0   1328 331724  37868 1483048    0    0     0     0  167    54  0  1 99  0
 7  0   1328 331744  37868 1483048    0    0     0     0  238   167 10  0 90  0
46  0   1328 330788  37868 1483076    0    0     0     0  878  1677 98  2  0  0
84  0   1328 330444  37868 1483100    0    0     0     0  425  1449 97  3  0  0

