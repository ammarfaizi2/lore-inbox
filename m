Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290827AbSAYXJY>; Fri, 25 Jan 2002 18:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290756AbSAYXJF>; Fri, 25 Jan 2002 18:09:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:59853 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288781AbSAYXIs>; Fri, 25 Jan 2002 18:08:48 -0500
Date: Fri, 25 Jan 2002 15:07:13 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu
Subject: Performance of Ingo's O(1) scheduler on 8 way NUMA-Q
Message-ID: <23350000.1012000033@flay>
In-Reply-To: <119440000.1011836623@flay>
In-Reply-To: <Pine.LNX.4.33.0201211626030.12418-100000@localhost.localdomain> <119440000.1011836623@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring the performace of a parallelized kernel compile with warm caches
on a 8 way NUMA-Q box. Highmem support is turned OFF so I'm only using
the first 1Gb or so of RAM (it's much faster without HIGHMEM).

prepare:
make -j16 dep; make -j16 bzImage; make mrproper; make -j16 dep; 

measured:
time make -j16 bzImage

2.4.18-pre7 

330.06user 99.92system 1:00.35elapsed 712%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (411135major+486026minor)pagefaults 0swaps

2.4.18-pre7 with J6 scheduler

307.19user 88.54system 0:57.63elapsed 686%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (399255major+484472minor)pagefaults 0swaps

Seems to give a significant improvement, not only giving a shorter 
elapsed time, but also lower CPU load.

Martin.

