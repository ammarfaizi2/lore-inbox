Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422722AbWAMPzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWAMPzy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWAMPzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:55:53 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:34666 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422722AbWAMPzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:55:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=pPjghufTxgjuzwl1VQX0NXmghauXKVNeboPMspLOsQ0XZyj0mp0gVew3fDIoTgqsP06N0w5oxrFX3pAmMxLXfgiYqvDNQvTj+9Qp5B8h0pjI9LPMPyVkbgIh8c5BRfViqWUWPMI2+QbKZAJJDM03mKM/6EgVmsBUDagV+YRMOw4=
Message-ID: <3afbacad0601130755x507047eeqfdcfb1e54a163cdd@mail.gmail.com>
Date: Fri, 13 Jan 2006 16:55:51 +0100
From: Jim MacBaine <jmacbaine@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: /proc/sys/vm/swappiness == 0 makes OOM killer go beserk
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_5926_29802366.1137167751631"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_5926_29802366.1137167751631
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

the OOM killer just killed some of my processes while the system still
had >2.5 GB of free swap. I'm running vanilla 2.6.15 on my desktop.
The machine is a single Athlon64, 1 GB RAM, 3 GB swap, x86_64 kernel,
(mostly) i386 userland.  A few days ago I have set
/proc/sys/vm/swappiness to 0 to see whether it would increase the
interactive performance. This was successful to some extent but with
side effects as I just saw:

I was compiling QT4 in /tmp which is a tmpfs, size 2.5 GB, of which
~1.0 GB were used at that moment. This was when the OOM killer decided
to kill some (appearently random) processes.

I was able to reproduce this behaviour a few minutes later.  After
setting /proc/sys/vm/swappiness to 10 everything is ok again. I have
attached the kernel messages of the oom killer.

Regards,
Jim

------=_Part_5926_29802366.1137167751631
Content-Type: text/plain; name=01-syslog.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="01-syslog.txt"

Jan 13 14:39:32 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:62
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219844 inactive:1011 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871284kB inactive:4044kB present:1017768kB pages_scanned:1018871 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0x200d2, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:33 localhost kernel: 5063 reserved pages
Jan 13 14:39:33 localhost kernel: 130083 pages shared
Jan 13 14:39:33 localhost kernel: 13895 pages swap cached
Jan 13 14:39:33 localhost kernel: Out of Memory: Killed process 3718 (firefox-bin).
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:63
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219800 inactive:1055 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8403 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871108kB inactive:4220kB present:1017768kB pages_scanned:1018927 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:33 localhost kernel: 5063 reserved pages
Jan 13 14:39:33 localhost kernel: 130083 pages shared
Jan 13 14:39:33 localhost kernel: 13895 pages swap cached
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:64
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219794 inactive:1061 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8404 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871084kB inactive:4244kB present:1017768kB pages_scanned:1018983 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:33 localhost kernel: Mem-info:
Jan 13 14:39:33 localhost kernel: DMA per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:33 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:64
Jan 13 14:39:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:33 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:33 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:33 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:33 localhost kernel: Active:219794 inactive:1061 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:33 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8404 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:33 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871084kB inactive:4244kB present:1017768kB pages_scanned:1018983 all_unreclaimable? yes
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:33 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:33 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:33 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:33 localhost kernel: Normal: empty
Jan 13 14:39:33 localhost kernel: HighMem: empty
Jan 13 14:39:33 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:33 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:33 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:33 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:33 localhost kernel: 5063 reserved pages
Jan 13 14:39:33 localhost kernel: 130083 pages shared
Jan 13 14:39:33 localhost kernel: 13895 pages swap cached
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:33 localhost kernel: 5063 reserved pages
Jan 13 14:39:33 localhost kernel: 130083 pages shared
Jan 13 14:39:33 localhost kernel: 13895 pages swap cached
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:33 localhost kernel: 5063 reserved pages
Jan 13 14:39:33 localhost kernel: 130083 pages shared
Jan 13 14:39:33 localhost kernel: 13895 pages swap cached
Jan 13 14:39:33 localhost kernel: 262064 pages of RAM
Jan 13 14:39:34 localhost kernel: 5063 reserved pages
Jan 13 14:39:34 localhost kernel: 130083 pages shared
Jan 13 14:39:34 localhost kernel: 13895 pages swap cached
Jan 13 14:39:34 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 14:39:34 localhost kernel: Mem-info:
Jan 13 14:39:34 localhost kernel: DMA per-cpu:
Jan 13 14:39:34 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 14:39:34 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 14:39:34 localhost kernel: DMA32 per-cpu:
Jan 13 14:39:34 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:64
Jan 13 14:39:34 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:56
Jan 13 14:39:34 localhost kernel: Normal per-cpu: empty
Jan 13 14:39:34 localhost kernel: HighMem per-cpu: empty
Jan 13 14:39:34 localhost kernel: Free pages:        8008kB (0kB HighMem)
Jan 13 14:39:34 localhost kernel: Active:219794 inactive:1061 dirty:0 writeback:0 unstable:0 free:2002 slab:14732 mapped:218887 pagetables:6139
Jan 13 14:39:34 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8092kB inactive:0kB present:12732kB pages_scanned:8404 all_unreclaimable? yes
Jan 13 14:39:34 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 14:39:34 localhost kernel: DMA32 free:3988kB min:4008kB low:5008kB high:6012kB active:871084kB inactive:4244kB present:1017768kB pages_scanned:1018983 all_unreclaimable? yes
Jan 13 14:39:34 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:34 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:34 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:34 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 14:39:34 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 14:39:34 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 14:39:34 localhost kernel: DMA32: 5*4kB 6*8kB 3*16kB 3*32kB 9*64kB 3*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 3988kB
Jan 13 14:39:34 localhost kernel: Normal: empty
Jan 13 14:39:34 localhost kernel: HighMem: empty
Jan 13 14:39:34 localhost kernel: Swap cache: add 883961, delete 870066, find 924670/961587, race 0+0
Jan 13 14:39:34 localhost kernel: Free swap  = 2914940kB
Jan 13 14:39:34 localhost kernel: Total swap = 3410080kB
Jan 13 14:39:34 localhost kernel: Free swap:       2914940kB
Jan 13 14:39:34 localhost kernel: 262064 pages of RAM
Jan 13 14:39:34 localhost kernel: 5063 reserved pages
Jan 13 14:39:34 localhost kernel: 130083 pages shared
Jan 13 14:39:34 localhost kernel: 13895 pages swap cached
Jan 13 14:39:34 localhost kernel: 262064 pages of RAM
Jan 13 14:39:34 localhost kernel: 5063 reserved pages
Jan 13 14:39:34 localhost kernel: 130083 pages shared
Jan 13 14:39:34 localhost kernel: 13895 pages swap cached
Jan 13 14:39:34 localhost kernel: 262064 pages of RAM
Jan 13 14:39:34 localhost kernel: 5063 reserved pages
Jan 13 14:39:34 localhost kernel: 130083 pages shared
Jan 13 14:39:34 localhost kernel: 13895 pages swap cached
Jan 13 14:39:34 localhost kernel: Out of Memory: Killed process 3757 (firefox-bin).
Jan 13 14:39:34 localhost kernel: 262064 pages of RAM
Jan 13 14:39:34 localhost kernel: 5063 reserved pages
Jan 13 14:39:34 localhost kernel: 130083 pages shared
Jan 13 14:39:34 localhost kernel: 13895 pages swap cached

------=_Part_5926_29802366.1137167751631
Content-Type: text/plain; name=02-syslog.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="02-syslog.txt"

Jan 13 15:04:32 localhost kernel: oom-killer: gfp_mask=0x200d2, order=0
Jan 13 15:04:33 localhost kernel: Mem-info:
Jan 13 15:04:33 localhost kernel: DMA per-cpu:
Jan 13 15:04:33 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 15:04:33 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 15:04:33 localhost kernel: DMA32 per-cpu:
Jan 13 15:04:33 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:32
Jan 13 15:04:33 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Jan 13 15:04:33 localhost kernel: Normal per-cpu: empty
Jan 13 15:04:34 localhost kernel: HighMem per-cpu: empty
Jan 13 15:04:34 localhost kernel: Free pages:        8320kB (0kB HighMem)
Jan 13 15:04:34 localhost kernel: Active:212221 inactive:1666 dirty:0 writeback:0 unstable:0 free:2080 slab:17323 mapped:212030 pagetables:9522
Jan 13 15:04:34 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8056kB inactive:0kB present:12732kB pages_scanned:9833 all_unreclaimable? yes
Jan 13 15:04:34 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 15:04:34 localhost kernel: DMA32 free:4300kB min:4008kB low:5008kB high:6012kB active:840828kB inactive:6664kB present:1017768kB pages_scanned:970229 all_unreclaimable? yes
Jan 13 15:04:34 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:34 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 15:04:35 localhost kernel: DMA32: 85*4kB 9*8kB 1*16kB 9*32kB 10*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 4300kB
Jan 13 15:04:35 localhost kernel: Normal: empty
Jan 13 15:04:35 localhost kernel: HighMem: empty
Jan 13 15:04:35 localhost kernel: Swap cache: add 1106805, delete 1092312, find 991386/1041271, race 0+0
Jan 13 15:04:35 localhost kernel: Free swap  = 2500676kB
Jan 13 15:04:35 localhost kernel: Total swap = 3410080kB
Jan 13 15:04:35 localhost kernel: Free swap:       2500676kB
Jan 13 15:04:35 localhost kernel: 262064 pages of RAM
Jan 13 15:04:35 localhost kernel: 5063 reserved pages
Jan 13 15:04:35 localhost kernel: 161996 pages shared
Jan 13 15:04:35 localhost kernel: 14493 pages swap cached
Jan 13 15:04:35 localhost kernel: Out of Memory: Killed process 9698 (klauncher).
Jan 13 15:04:35 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 15:04:35 localhost kernel: Mem-info:
Jan 13 15:04:35 localhost kernel: DMA per-cpu:
Jan 13 15:04:35 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 15:04:35 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 15:04:35 localhost kernel: DMA32 per-cpu:
Jan 13 15:04:35 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:106
Jan 13 15:04:35 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Jan 13 15:04:35 localhost kernel: Normal per-cpu: empty
Jan 13 15:04:35 localhost kernel: HighMem per-cpu: empty
Jan 13 15:04:35 localhost kernel: Free pages:        8320kB (0kB HighMem)
Jan 13 15:04:35 localhost kernel: Active:212152 inactive:1698 dirty:0 writeback:1 unstable:0 free:2080 slab:17323 mapped:211946 pagetables:9496
Jan 13 15:04:35 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8056kB inactive:0kB present:12732kB pages_scanned:9833 all_unreclaimable? yes
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 15:04:35 localhost kernel: DMA32 free:4300kB min:4008kB low:5008kB high:6012kB active:840552kB inactive:6792kB present:1017768kB pages_scanned:984815 all_unreclaimable? yes
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 15:04:35 localhost kernel: DMA32: 85*4kB 9*8kB 1*16kB 9*32kB 10*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 4300kB
Jan 13 15:04:35 localhost kernel: Normal: empty
Jan 13 15:04:35 localhost kernel: HighMem: empty
Jan 13 15:04:35 localhost kernel: Swap cache: add 1106833, delete 1092354, find 991386/1041275, race 0+0
Jan 13 15:04:35 localhost kernel: Free swap  = 2501080kB
Jan 13 15:04:35 localhost kernel: Total swap = 3410080kB
Jan 13 15:04:35 localhost kernel: Free swap:       2501080kB
Jan 13 15:04:35 localhost kernel: 262064 pages of RAM
Jan 13 15:04:35 localhost kernel: 5063 reserved pages
Jan 13 15:04:35 localhost kernel: 161239 pages shared
Jan 13 15:04:35 localhost kernel: 14479 pages swap cached
Jan 13 15:04:35 localhost kernel: Out of Memory: Killed process 9739 (artsd).
Jan 13 15:04:35 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 15:04:35 localhost kernel: Mem-info:
Jan 13 15:04:35 localhost kernel: DMA per-cpu:
Jan 13 15:04:35 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 15:04:35 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 15:04:35 localhost kernel: DMA32 per-cpu:
Jan 13 15:04:35 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:107
Jan 13 15:04:35 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Jan 13 15:04:35 localhost kernel: Normal per-cpu: empty
Jan 13 15:04:35 localhost kernel: HighMem per-cpu: empty
Jan 13 15:04:35 localhost kernel: Free pages:        8320kB (0kB HighMem)
Jan 13 15:04:35 localhost kernel: Active:212152 inactive:1698 dirty:0 writeback:1 unstable:0 free:2080 slab:17323 mapped:211946 pagetables:9496
Jan 13 15:04:35 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8056kB inactive:0kB present:12732kB pages_scanned:9833 all_unreclaimable? yes
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 15:04:35 localhost kernel: DMA32 free:4300kB min:4008kB low:5008kB high:6012kB active:840552kB inactive:6792kB present:1017768kB pages_scanned:984869 all_unreclaimable? yes
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:35 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:35 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 15:04:36 localhost kernel: DMA32: 85*4kB 9*8kB 1*16kB 9*32kB 10*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 4300kB
Jan 13 15:04:36 localhost kernel: Normal: empty
Jan 13 15:04:36 localhost kernel: HighMem: empty
Jan 13 15:04:36 localhost kernel: Swap cache: add 1106833, delete 1092354, find 991386/1041275, race 0+0
Jan 13 15:04:36 localhost kernel: Free swap  = 2501080kB
Jan 13 15:04:36 localhost kernel: Total swap = 3410080kB
Jan 13 15:04:36 localhost kernel: Free swap:       2501080kB
Jan 13 15:04:36 localhost kernel: 262064 pages of RAM
Jan 13 15:04:36 localhost kernel: 5063 reserved pages
Jan 13 15:04:36 localhost kernel: 161239 pages shared
Jan 13 15:04:36 localhost kernel: 14479 pages swap cached
Jan 13 15:04:36 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 15:04:36 localhost kernel: Mem-info:
Jan 13 15:04:36 localhost kernel: DMA per-cpu:
Jan 13 15:04:36 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 15:04:36 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 15:04:36 localhost kernel: DMA32 per-cpu:
Jan 13 15:04:36 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:107
Jan 13 15:04:36 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Jan 13 15:04:36 localhost kernel: Normal per-cpu: empty
Jan 13 15:04:36 localhost kernel: HighMem per-cpu: empty
Jan 13 15:04:36 localhost kernel: Free pages:        8320kB (0kB HighMem)
Jan 13 15:04:36 localhost kernel: Active:212152 inactive:1698 dirty:0 writeback:1 unstable:0 free:2080 slab:17323 mapped:211946 pagetables:9496
Jan 13 15:04:36 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8056kB inactive:0kB present:12732kB pages_scanned:9833 all_unreclaimable? yes
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 15:04:36 localhost kernel: DMA32 free:4300kB min:4008kB low:5008kB high:6012kB active:840552kB inactive:6792kB present:1017768kB pages_scanned:984923 all_unreclaimable? yes
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 15:04:36 localhost kernel: DMA32: 85*4kB 9*8kB 1*16kB 9*32kB 10*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 4300kB
Jan 13 15:04:36 localhost kernel: Normal: empty
Jan 13 15:04:36 localhost kernel: HighMem: empty
Jan 13 15:04:36 localhost kernel: Swap cache: add 1106833, delete 1092354, find 991386/1041275, race 0+0
Jan 13 15:04:36 localhost kernel: Free swap  = 2501080kB
Jan 13 15:04:36 localhost kernel: Total swap = 3410080kB
Jan 13 15:04:36 localhost kernel: Free swap:       2501080kB
Jan 13 15:04:36 localhost kernel: oom-killer: gfp_mask=0xd0, order=0
Jan 13 15:04:36 localhost kernel: Mem-info:
Jan 13 15:04:36 localhost kernel: DMA per-cpu:
Jan 13 15:04:36 localhost kernel: cpu 0 hot: low 0, high 0, batch 1 used:0
Jan 13 15:04:36 localhost kernel: cpu 0 cold: low 0, high 0, batch 1 used:0
Jan 13 15:04:36 localhost kernel: DMA32 per-cpu:
Jan 13 15:04:36 localhost kernel: cpu 0 hot: low 0, high 186, batch 31 used:107
Jan 13 15:04:36 localhost kernel: cpu 0 cold: low 0, high 62, batch 15 used:49
Jan 13 15:04:36 localhost kernel: Normal per-cpu: empty
Jan 13 15:04:36 localhost kernel: HighMem per-cpu: empty
Jan 13 15:04:36 localhost kernel: Free pages:        8320kB (0kB HighMem)
Jan 13 15:04:36 localhost kernel: Active:212152 inactive:1698 dirty:0 writeback:1 unstable:0 free:2080 slab:17323 mapped:211946 pagetables:9496
Jan 13 15:04:36 localhost kernel: DMA free:4020kB min:48kB low:60kB high:72kB active:8056kB inactive:0kB present:12732kB pages_scanned:9833 all_unreclaimable? yes
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 993 993 993
Jan 13 15:04:36 localhost kernel: DMA32 free:4300kB min:4008kB low:5008kB high:6012kB active:840552kB inactive:6792kB present:1017768kB pages_scanned:984923 all_unreclaimable? yes
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: HighMem free:0kB min:128kB low:128kB high:128kB active:0kB inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
Jan 13 15:04:36 localhost kernel: lowmem_reserve[]: 0 0 0 0
Jan 13 15:04:36 localhost kernel: DMA: 1*4kB 0*8kB 1*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 4020kB
Jan 13 15:04:36 localhost kernel: DMA32: 85*4kB 9*8kB 1*16kB 9*32kB 10*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 1*2048kB 0*4096kB = 4300kB
Jan 13 15:04:36 localhost kernel: Normal: empty
Jan 13 15:04:36 localhost kernel: HighMem: empty
Jan 13 15:04:36 localhost kernel: Swap cache: add 1106833, delete 1092354, find 991386/1041275, race 0+0
Jan 13 15:04:36 localhost kernel: Free swap  = 2501080kB
Jan 13 15:04:36 localhost kernel: Total swap = 3410080kB
Jan 13 15:04:36 localhost kernel: Free swap:       2501080kB
Jan 13 15:04:36 localhost kernel: 262064 pages of RAM
Jan 13 15:04:36 localhost kernel: 5063 reserved pages
Jan 13 15:04:36 localhost kernel: 161240 pages shared
Jan 13 15:04:36 localhost kernel: 14487 pages swap cached
Jan 13 15:04:36 localhost kernel: 262064 pages of RAM
Jan 13 15:04:36 localhost kernel: 5063 reserved pages
Jan 13 15:04:36 localhost kernel: 160303 pages shared
Jan 13 15:04:36 localhost kernel: 14337 pages swap cached
Jan 13 15:04:36 localhost kernel: Out of Memory: Killed process 9743 (kwin).

------=_Part_5926_29802366.1137167751631--
