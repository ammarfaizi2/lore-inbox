Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264451AbTCXRXi>; Mon, 24 Mar 2003 12:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264452AbTCXRXD>; Mon, 24 Mar 2003 12:23:03 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:11869 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S264451AbTCXRWV>; Mon, 24 Mar 2003 12:22:21 -0500
Date: Mon, 24 Mar 2003 17:35:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: lmbench on anobjrmap
Message-ID: <Pine.LNX.4.44.0303241731540.2456-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the historical record...

lmbench comparison of 2.5.65-mm3 (which included anonymous extension
of objrmap) against 2.5.65-mm3 without it (those patches backed out).

fork and exec tests show 9% benefit from anobjrmap
(looks like selct TCP does significant forking too).

Both machines booted with mem=512M, but the 2*HT*P4 configured
HIGHMEM4G, and the 2*PIII configured HIGHMEM64G and HIGHPTE.

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                OS  Mhz null null      open selct sig  sig  fork exec sh  
                            call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
2*HT*P4 with anobjrmap 1800 0.73 1.22 6.01 7.85  39.8 1.41 4.75 405. 1287 4246
2*HT*P4 with anobjrmap 1800 0.73 1.22 6.01 7.88  39.8 1.43 4.70 406. 1287 4172
2*HT*P4 with anobjrmap 1800 0.77 1.22 6.03 7.83  39.8 1.45 4.63 407. 1269 4192
2*HT*P4 with anobjrmap 1800 0.72 1.21 6.58 7.92  40.3 1.44 4.68 403. 1241 4229
2*HT*P4 with anobjrmap 1800 0.72 1.21 5.95 7.84  43.2 1.43 4.77 404. 1242 3989
2*HT*P4 with anobjrmap 1800 0.72 1.22 6.10 7.88  39.8 1.44 4.68 435. 1254 4025

2*HT*P4  w/o anobjrmap 1800 0.73 1.22 6.19 8.02  40.2 1.43 4.64 455. 1336 4133
2*HT*P4  w/o anobjrmap 1800 0.73 1.23 6.18 7.96  40.0 1.53 4.63 462. 1340 4131
2*HT*P4  w/o anobjrmap 1800 0.73 1.22 6.21 8.04  40.4 1.45 4.60 441. 1326 4161
2*HT*P4  w/o anobjrmap 1800 0.78 1.22 6.12 7.90  40.2 1.44 4.93 447. 1344 4151
2*HT*P4  w/o anobjrmap 1800 0.72 1.21 6.08 7.87  42.5 1.46 4.79 444. 1325 4140
2*HT*P4  w/o anobjrmap 1800 0.78 1.22 6.11 7.88  40.3 1.46 4.51 446. 1314 4157

2*PIII  with anobjrmap  794 0.46 0.84 27.8 31.2  37.0 1.27 5.50 539. 2164 6959
2*PIII  with anobjrmap  794 0.46 0.85 28.0 31.3  35.7 1.26 5.33 540. 2048 6895
2*PIII  with anobjrmap  794 0.46 0.84 27.8 31.2  35.5 1.27 5.26 503. 2150 6962
2*PIII  with anobjrmap  794 0.46 0.81 27.8 30.8  35.4 1.26 5.50 547. 2076 6761
2*PIII  with anobjrmap  794 0.46 0.84 27.8 31.0  36.7 1.26 5.53 553. 2235 6931
2*PIII  with anobjrmap  794 0.46 0.83 28.0 30.9  37.8 1.27 5.55 536. 2073 6842

2*PIII   w/o anobjrmap  794 0.46 0.83 28.0 31.2  38.5 1.26 5.31 570. 2323 7053
2*PIII   w/o anobjrmap  794 0.46 0.82 27.8 31.3  36.8 1.27 5.56 631. 2321 7062
2*PIII   w/o anobjrmap  794 0.46 0.83 27.8 31.3  38.9 1.27 5.36 655. 2349 7145
2*PIII   w/o anobjrmap  794 0.46 0.81 27.7 31.2  38.3 1.27 5.57 564. 2311 7011
2*PIII   w/o anobjrmap  794 0.46 0.80 27.9 31.5  37.4 1.27 5.36 611. 2332 7081
2*PIII   w/o anobjrmap  794 0.46 0.82 27.8 31.2  35.4 1.26 5.31 595. 2332 7084

