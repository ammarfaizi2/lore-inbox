Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUD1Umi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUD1Umi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUD1UmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:42:16 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:48482 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262073AbUD1Uk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:40:59 -0400
Date: Wed, 28 Apr 2004 15:39:10 -0500 (CDT)
From: Brent Cook <busterbcook@yahoo.com>
X-X-Sender: busterb@ozma.hauschen
Reply-To: busterbcook@yahoo.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
In-Reply-To: <20040428124809.418e005d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404281534110.3044@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
 <20040427230203.1e4693ac.akpm@osdl.org> <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
 <20040428124809.418e005d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please capture the contents of /proc/meminfo and /proc/vmstats
> when it's happening?
>
> Thanks.
>

Here is the top of top for one machine:

 15:36:55  up  7:09,  1 user,  load average: 1.00, 1.00, 1.00
48 processes: 46 sleeping, 2 running, 0 zombie, 0 stopped
CPU states:   0.1% user  99.8% system   0.0% nice   0.0% iowait   0.0% idle
Mem:   256992k av,  117644k used,  139348k free,       0k shrd,   36464k buff
        50968k active,              51592k inactive
Swap:  514040k av,       0k used,  514040k free                   61644k cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
    7 root      25   0     0    0     0 RW   99.4  0.0 415:26   0 pdflush

Here are memory stats for the same machine. The other machine's stats
are similar; there doesn't appear to be anything out of the ordinary and
its not even touching swap if these numbers are to be believed.

busterb@snowball2:~$ cat /proc/meminfo
MemTotal:       256992 kB
MemFree:        139700 kB
Buffers:         36464 kB
Cached:          61516 kB
SwapCached:          0 kB
Active:          50536 kB
Inactive:        51672 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256992 kB
LowFree:        139700 kB
SwapTotal:      514040 kB
SwapFree:       514040 kB
Dirty:            1876 kB
Writeback:           0 kB
Mapped:           8552 kB
Slab:            10924 kB
Committed_AS:    14612 kB
PageTables:        356 kB
VmallocTotal:   778164 kB
VmallocUsed:      2936 kB
VmallocChunk:   774708 kB

busterb@snowball2:~$ cat /proc/vmstat
nr_dirty 469
nr_writeback 0
nr_unstable 0
nr_page_table_pages 89
nr_mapped 2138
nr_slab 2730
pgpgin 79849
pgpgout 121656
pswpin 0
pswpout 0
pgalloc_high 0
pgalloc_normal 1812796
pgalloc_dma 18991
pgfree 1866775
pgactivate 55529
pgdeactivate 14634
pgfault 3622942
pgmajfault 2322
pgrefill_high 0
pgrefill_normal 16726
pgrefill_dma 49791
pgsteal_high 0
pgsteal_normal 11781
pgsteal_dma 203
pgscan_kswapd_high 0
pgscan_kswapd_normal 10065
pgscan_kswapd_dma 231
pgscan_direct_high 0
pgscan_direct_normal 2310
pgscan_direct_dma 0
pginodesteal 0
slabs_scanned 4349
kswapd_steal 9758
kswapd_inodesteal 0
pageoutrun 32
allocstall 35
pgrotated 0

