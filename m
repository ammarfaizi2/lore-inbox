Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbUCMA4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 19:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbUCMA4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 19:56:13 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:49386 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262911AbUCMA4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 19:56:10 -0500
Message-ID: <40525C1F.5030705@cyberone.com.au>
Date: Sat, 13 Mar 2004 11:55:59 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>
Subject: [BENCHMARKS] 2.6.4 vs 2.6.4-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are some benchmarks on a 16-way (4x4) NUMAQ. Basically
measures the scheduler patches with a couple of meaningless
but very scheduler intensive benchmarks.

hackbench:
The number in () is a projection for the time 1000 would take,
assuming a linear scaling. It is probably better shown on a
graph, but you can see a non linear element in 2.6.4 that is
basically absent in 2.6.4-mm1.

              2.6.4    2.6.4-mm1
 50      19.4 (388)   15.5 (310)
100      39.0 (390)   34.5 (345)
150      59.0 (393)   48.3 (322)
200      82.9 (414)   68.9 (344)
250     114.8 (459)   90.2 (360)
300     145.4 (484)  106.3 (354)
350     178.1 (508)  122.1 (348)
400     218.8 (547)  135.0 (337)
450     237.8 (528)  163.9 (364)
500     262.0 (524)  181.7 (363)

volanomark (MPS):
This one starts getting huge mmap_sem contention at 150+ coming
from futexes. Don't know what is taking the mmap_sem for writing.
Maybe just brk or mmap.

        2.6.4   2.6.4-mm1
 15      5850        6221
 30      5682        5852
 45      4736        5700
 60      2857        5622
 75      1024        4840
 90      1832        5191
105       491        5036
120      1591        4228
135       393        4986
150      1056        1586

