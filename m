Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVALFyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVALFyA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 00:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbVALFx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 00:53:59 -0500
Received: from h-66-134-203-88.snvacaid.covad.net ([66.134.203.88]:37426 "EHLO
	mail.zanfx.com") by vger.kernel.org with ESMTP id S263007AbVALFx4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 00:53:56 -0500
Message-ID: <41E4BB99.90908@zanfx.com>
Date: Tue, 11 Jan 2005 21:54:33 -0800
From: "Paul A. Sumner" <paul@zanfx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041031
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: High write latency, iowait, slow writes 2.6.9
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I have a new server that during big io tasks, e.g., bonnie++ and
tiobench testing, becomes very unresponsive. Both bonnie++ and tiobench
show good read performance, but the write performance lags, max
latencies are into the *minutes* and it experiences extended high
iowait. I'm guessing the iowait may not be a real problem. The machine
is as follows:

Arima HDAMA mother board
Dual 250 opterons
16 GB ram
6x15K seagate drives
Adaptec 2200s controller (raid10)
Reproduced using 2.6.9-gentoo-r12, 2.4.28 vanilla & 2.6.10 mm-sources (a 
little better).

I have the latest driver from Adaptec, newest firmware in mobo, drives
and controller. The original guess was something hardware related, but
that seems very unlikely given how closely its been checked out.

Question 1: How can I tune the 2.6 kernel (sysctls?) and hopefully
eliminate [some] of this latency/improve writes? I've looked in the
kernel docs and I'm not finding much that is helpful given my limited
knowledge. FYI, I have used blockdev to up the read ahead.

Question 2: I get a msg in dmesg that says 'Please enable iommu' but I
have iommu on in the bios and I've tried adding iommu=force. I have also
tested w/ only 2GB of ram using mem= as well to eliminate the
possibility of the iommu as a cause of the latency, etc. problem.

Any help would be *greatly* appreciated.

-Paul Sumner

> Tiotest results for 4 concurrent io threads:
> ,----------------------------------------------------------------------.
> | Item                  | Time     | Rate         | Usr CPU  | Sys CPU |
> +-----------------------+----------+--------------+----------+---------+
> | Write       32768 MBs |  626.0 s |  52.346 MB/s |   0.5 %  |  11.9 % |
> | Random Write   16 MBs |    2.3 s |   6.757 MB/s |   0.0 %  |   3.0 % |
> | Read        32768 MBs |  136.9 s | 239.332 MB/s |   1.8 %  |  27.9 % |
> | Random Read    16 MBs |    5.7 s |   2.720 MB/s |   0.1 %  |   0.9 % |
> `----------------------------------------------------------------------'
> Tiotest latency results:
> ,-------------------------------------------------------------------------.
> | Item         | Average latency | Maximum latency | % >2 sec | % >10 sec |
> +--------------+-----------------+-----------------+----------+-----------+
> | Write        |        0.212 ms |   278200.296 ms |  0.00020 |   0.00013 |
> | Random Write |        0.008 ms |        1.559 ms |  0.00000 |   0.00000 |
> | Read         |        0.045 ms |      433.503 ms |  0.00000 |   0.00000 |
> | Random Read  |        3.365 ms |      100.382 ms |  0.00000 |   0.00000 |
> |--------------+-----------------+-----------------+----------+-----------|
> | Total        |        0.129 ms |   278200.296 ms |  0.00010 |   0.00007 |
> `--------------+-----------------+-----------------+----------+-----------'

Bonnie++:

> Version 1.93c       ------Sequential Output------ --Sequential Input- --Random-
> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> taz             31G   841  99 52718   9 28098   5  1324  98 240339  27 534.3  18
> Latency             10174us      132s     706ms   43611us   51630us     267ms
> Version 1.93c       ------Sequential Create------ --------Random Create--------
> taz                 -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>               files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>                  16  3303  27 +++++ +++  3124  22  2883  25 +++++ +++  1902  13
> Latency             67093us      56us   62705us   68970us      68us     263ms




