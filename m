Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHRNHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHRNHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 09:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUHRM7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 08:59:00 -0400
Received: from penguin.cohaesio.net ([212.97.129.34]:14748 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S266310AbUHRMzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 08:55:38 -0400
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: linux-kernel@vger.kernel.org
Subject: oom-killer 2.6.8.1
Date: Wed, 18 Aug 2004 14:55:42 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408181455.42279.as@cohaesio.com>
X-OriginalArrivalTime: 18 Aug 2004 12:55:37.0325 (UTC) FILETIME=[A85CC1D0:01C48522]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a high-volume NFS server running almost no user-space applications. It 
serves a handfull of web server NFS clients from a ~700G XFS filesystem.

The machine has about 2.5 GB of RAM and 4G of swap (which is almost not in use 
- i may use 5-10 MB total tops).  CONFIG_HIGHMEM and CONFIG_HIGHMEM4G 
enabled, SMP enabled, preempt disabled.

Today the OOM killer kicked in - it seemed that swap was almost unused at the 
time (which is strange, as that should prevent the OOM killer from kicking 
in).

Relevant part of the syslog follows (syslogd was killed too eventually):

Aug 18 14:14:52 st1 kernel: oom-killer: gfp_mask=0xd0
Aug 18 14:14:52 st1 kernel: DMA per-cpu:
Aug 18 14:14:52 st1 kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 18 14:14:52 st1 kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 18 14:14:52 st1 kernel: cpu 1 hot: low 2, high 6, batch 1
Aug 18 14:14:52 st1 kernel: cpu 1 cold: low 0, high 2, batch 1
Aug 18 14:14:52 st1 kernel: Normal per-cpu:
Aug 18 14:14:52 st1 kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 18 14:14:52 st1 kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 18 14:14:52 st1 kernel: cpu 1 hot: low 32, high 96, batch 16
Aug 18 14:14:52 st1 kernel: cpu 1 cold: low 0, high 32, batch 16
Aug 18 14:14:52 st1 kernel: HighMem per-cpu:
Aug 18 14:14:52 st1 kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 18 14:14:53 st1 kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 18 14:14:54 st1 kernel: cpu 1 hot: low 32, high 96, batch 16
Aug 18 14:14:54 st1 kernel: cpu 1 cold: low 0, high 32, batch 16
Aug 18 14:14:54 st1 kernel:
Aug 18 14:14:54 st1 kernel: Free pages:      352376kB (348672kB HighMem)
Aug 18 14:14:54 st1 kernel: Active:18220 inactive:319911 dirty:12154
writeback:0 unstable:0 free:88094 slab:219644 mapped:3231 pagetables:121
Aug 18 14:14:54 st1 kernel: DMA free:1880kB min:16kB low:32kB high:48kB 
active:0kB inactive:0kB present:16384kB
Aug 18 14:14:54 st1 kernel: protections[]: 8 476 732
Aug 18 14:14:54 st1 kernel: Normal free:1824kB min:936kB low:1872kB 
high:2808kB active:84kB inactive:284kB present:901120kB
Aug 18 14:14:54 st1 kernel: protections[]: 0 468 724
Aug 18 14:14:54 st1 kernel: HighMem free:348672kB min:512kB low:1024kB 
high:1536kB active:72796kB inactive:1279360kB present:1703788kB
Aug 18 14:14:54 st1 kernel: protections[]: 0 0 256
Aug 18 14:14:54 st1 kernel: DMA: 6*4kB 2*8kB 1*16kB 1*32kB 0*64kB 0*128kB 
1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1880kB
Aug 18 14:14:54 st1 kernel: Normal: 88*4kB 42*8kB 3*16kB 6*32kB 2*64kB 2*128kB 
0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1824kB
Aug 18 14:14:55 st1 kernel: HighMem: 62500*4kB 11396*8kB 409*16kB 0*32kB 
1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 348672kB
Aug 18 14:14:55 st1 kernel: Swap cache: add 6433, delete 6394, find 
35305/35334, race 0+0
Aug 18 14:14:55 st1 kernel: Out of Memory: Killed process 1049 (rpc.statd).

Any ideas?

Try to disable swap?  Tune magic VM settings?  Any suggestions are highly 
welcome.

Thank you very much,

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
