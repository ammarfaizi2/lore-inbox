Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266825AbSKOScN>; Fri, 15 Nov 2002 13:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266826AbSKOScM>; Fri, 15 Nov 2002 13:32:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:65218 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266825AbSKOScL>; Fri, 15 Nov 2002 13:32:11 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200211151837.gAFIbm610839@eng2.beaverton.ibm.com>
Subject: 2.5.47-mm3 IO rate question
To: linux-kernel@vger.kernel.org (lkml)
Date: Fri, 15 Nov 2002 10:37:48 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.5.47-mm3 and qlogic driver qla2x00src-v6.03.00b8.
I have 2 qlogic controllers connected to 2 trays (10 disks/tray).

I do 256K IO on raw devices using "dd".

dd of=/dev/null bs=256k count=2000 if=/dev/raw/raw1 &
dd of=/dev/null bs=256k count=2000 if=/dev/raw/raw2 &
dd of=/dev/null bs=256k count=2000 if=/dev/raw/raw3 &
...
dd of=/dev/null bs=256k count=2000 if=/dev/raw/raw20 &

IO throughput changes just by adjusting SG_SEGMENTS (from 32 to 64).
I was wondering why such a significant difference. (20MB/sec).

I used to get 194-198MB/sec with 2.5.37 (with DIO code sending
(fixed) 64K requests - qlogic max_sector=512, SG_SEGMETS=32).

Any thoughts ?

Thanks,
Badari

max_sectors = 512
SG_SEGMENTS = 64
[root]# vmstat 5
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0 20  0      0 3642680   8832  42836    0    0 194765    15 1762  2183  0 100  0
 0 20  0      0 3642680   8836  42836    0    0 194611     3 1761  2122  0 100  0
 0 20  0      0 3642680   8840  42836    0    0 194509     3 1774  2150 10 81  8
 0 20  0      0 3642680   8844  42836    0    0 194816     3 1762  2132  2 98  0
 0 20  0      0 3642680   8848  42836    0    0 194765     3 1764  2177  2 98  0


max_sectors = 512
SG_SEGMENTS = 32
[root]# vmstat 5
   procs                      memory      swap          io     system      cpu
 r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
 0 20  0      0 3652472   7752  34464    0    0 170755    15 2354  3477  2 98  0
 0 20  0      0 3652472   7756  34464    0    0 172771     3 2363  3512  2 98  0
 0 20  0      0 3652472   7760  34464    0    0 174031     3 2372  3576  0 100  0
 0 20  0      0 3652408   7764  34464    0    0 173074     7 2384  3538 10 87  3
 0 20  0      0 3652408   7768  34464    0    0 172670     3 2364  3502  2 98  0

