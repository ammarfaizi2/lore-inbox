Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbSLFJfY>; Fri, 6 Dec 2002 04:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262224AbSLFJfY>; Fri, 6 Dec 2002 04:35:24 -0500
Received: from c17928.thoms1.vic.optusnet.com.au ([210.49.249.29]:54144 "EHLO
	laptop.localdomain") by vger.kernel.org with ESMTP
	id <S261371AbSLFJfW> convert rfc822-to-8bit; Fri, 6 Dec 2002 04:35:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [PATCH 2.4.20-aa1] Readlatency-2
Date: Fri, 6 Dec 2002 20:45:16 +1100
User-Agent: KMail/1.4.3
References: <200212061038.27387.m.c.p@wolk-project.de>
In-Reply-To: <200212061038.27387.m.c.p@wolk-project.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212062045.25377.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>On Thu, Dec 05, 2002 at 08:49:10PM +0100, Marc-Christian Petersen wrote:
>> Hi all,
>>
>> as requested by GrandMasterLee (does he have a realname? ;) here goes
>> readlatency2 for 2.4.20aa1. Apply ontop of it.
>>
>> Note: This patch rippes out the elevator-lowlatency hack.
>
>how does it perform compared to elevator-lowlatency? I guess this is a
>call for Con to run a pass on it.
>
>Actually I still think the 32M queue on a 32M scsi machine during
>contigous writes where the elevator basically doesn't matter is a
>""bit"" overkill so I still like elevator-lowlatency somehow.
>elevator-lowlatency could do something smarter than it currently does
>though.

Ask and ye shall receive. Here are contest results comparing vanilla 2.4.20, 
aa1 and aa1 with rl2:

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              67.3    97      0       0       1.02
2.4.20aa1 [1]           68.0    97      0       0       1.03
2.4.20aa1rl2 [3]        67.4    97      0       0       1.02

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              65.7    99      0       0       0.99
2.4.20aa1 [1]           65.6    99      0       0       0.99
2.4.20aa1rl2 [3]        65.4    99      0       0       0.99

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              108.1   58      84      40      1.63
2.4.20aa1 [2]           224.6   28      342     70      3.39
2.4.20aa1rl2 [3]        223.1   29      337     70      3.37

dbench_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              207.2   32      2       46      3.13
2.4.20aa1 [3]           263.7   25      3       42      3.99
2.4.20aa1rl2 [3]        502.8   13      7       52      7.60

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              85.4    83      2       9       1.29
2.4.20aa1 [3]           86.3    82      3       10      1.30
2.4.20aa1rl2 [3]        97.1    78      3       10      1.47

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              107.6   64      2       8       1.63
2.4.20aa1 [1]           127.8   53      4       9       1.93
2.4.20aa1rl2 [3]        188.9   36      6       10      2.86

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              203.4   33      40      15      3.07
2.4.20aa1 [3]           238.3   27      46      15      3.60
2.4.20aa1rl2 [3]        302.5   22      63      16      4.57

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              120.3   56      24      16      1.82
2.4.20aa1 [3]           115.5   58      23      16      1.75
2.4.20aa1rl2 [3]        107.4   64      23      17      1.62

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              88.8    82      16      4       1.34
2.4.20aa1 [2]           97.8    71      18      6       1.48
2.4.20aa1rl2 [3]        130.1   54      26      6       1.97

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              75.7    88      0       8       1.14
2.4.20aa1 [2]           78.4    85      0       9       1.19
2.4.20aa1rl2 [3]        78.3    85      0       8       1.18

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.4.20 [5]              84.8    80      44      2       1.28
2.4.20aa1 [3]           179.7   37      59      1       2.72
2.4.20aa1rl2 [3]        180.2   37      51      1       2.72

Changes all over the place. 

Cheers,
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE98HGsF6dfvkL3i1gRAnKJAJ9sW9tgN6Dzfu1s8/Ea8SUTBUf6egCfeyPY
3FAaG70qJYh7Z4PmZchFOYA=
=LCgH
-----END PGP SIGNATURE-----
