Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSKEGM3>; Tue, 5 Nov 2002 01:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSKEGM3>; Tue, 5 Nov 2002 01:12:29 -0500
Received: from [211.150.96.25] ([211.150.96.25]:48621 "EHLO smtp.x263.net")
	by vger.kernel.org with ESMTP id <S264786AbSKEGM0>;
	Tue, 5 Nov 2002 01:12:26 -0500
From: "kcn" <kcn@263.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel freeze
Date: Tue, 5 Nov 2002 14:18:21 +0800
Message-ID: <002c01c28493$2b489070$31036fa6@zhoulin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  After I reported a kernel freeze in this mail list("2.4.18 freeze on
4G memory."),
I try 2.4.19 & 2.4.19+rmap14a patch, all of those have been frozen.
I try to enable kernel profiling to detect what is the problem and found

the function _text_lock_vmscan make the cpu busy. Any comment?
The result below:
  Normal state:
# uptime
12:20pm  up  2:00,  6 users,  load average: 8.18, 10.13, 8.28
# vmstat 2 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 1  0  4      0 182988 408272 1919636   0   0    89   164  853   499  11
9  79
 0  1  0      0 184288 408516 1919840   0   0   332    12 4869  2587  20
30  50
# readprofile | sort -g
   ...
    36 _text_lock_vmscan                          0.2727
   ...
  4666 _text_lock_read_write                     95.2245
  5027 _text_lock_namei                           2.8465
  5113 ip_packet_match                           13.8940
  6124 _text_lock_inode                          12.6529
  6342 prune_icache                              11.3250
  7549 shrink_cache                               8.1347
 10010 __constant_memcpy                         36.8015
 11099 _text_lock_swap                          194.7193
1242957 default_idle                             15536.9625
1414706 total                                      1.0008
 after freeze:
#uptime
12:44pm  up  2:25,  6 users,  load average: 292.05, 528.62, 117.95
#vmstat 2 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 9 207  4      0 565776 337108 1948476   0   0    77   144  751   433
10  22  68
 3 239  1      0 548152 337312 1949624   0   0   718  3666 2256  2789
34  38  27
# readprofile | sort -g
  ...
21999 _text_lock_swap                          385.9474
 84239 prune_icache                             150.4268
101555 _text_lock_inode                         209.8244
122285 shrink_cache                             131.7726
173019 _text_lock_vmscan                        1310.7500
1311668 default_idle                             16395.8500
1992753 total                                      1.4098




