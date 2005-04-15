Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVDOEs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVDOEs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 00:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVDOEs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 00:48:29 -0400
Received: from house2.arach.net.au ([203.30.44.85]:5541 "HELO
	house.arach.net.au") by vger.kernel.org with SMTP id S261689AbVDOEsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 00:48:18 -0400
Date: Fri, 15 Apr 2005 12:48:07 +0800
From: Michael Deegan <michael@ucc.gu.uwa.edu.au>
To: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc2: >100% memory usage
Message-ID: <20050415044806.GA12519@wibble>
Reply-To: michael@ucc.gu.uwa.edu.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Subliminal-Message: .yenom em dneS .tsixe ton od segassem lanimilbuS
X-ICQ-UIN: 562440
X-Random-Number: inf
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I noticed something unusual on my home desktop machine (K6II, 448M RAM, runs
KDE, samba, nfsd. 2.6.12-rc2 on Debian sarge). The machine seems to feel
slightly sluggish; it seems to swap a fair bit more than it did under
2.6.11, but at the same time it's not actually using more swap that it used
to. The large numbers are slowly growing larger too. The biggest spamd was
only 156% of memory yesterday. Normally it's only my xserver (and
occasionally konqueror) that manages to grab more than 10% of memory...

Cutting and pasting from top:

   top - 12:20:17 up 3 days, 17:00,  6 users,  load average: 0.91, 1.25, 1.35
   Tasks: 162 total,   3 running, 158 sleeping,   1 stopped,   0 zombie
   Cpu(s): 13.9% us, 11.1% sy, 37.0% ni, 27.8% id,  0.0% wa,  0.0% hi, 10.2% si
   Mem:    450340k total,   443452k used,     6888k free,     1740k buffers
   Swap:  2000020k total,   384300k used,  1615720k free,    22248k cached
   
     PID USER      NI  VIRT  RES SWAP  SHR S %CPU %MEM    TIME+  CODE DATA COMMAND
    2489 root       0 40088 1.0g  4.0 999m S  0.0 232.7   5:15.94  996  35m spamd child
    2485 root       0 38336 954m  4.0 933m S  0.0 217.0   5:03.79  996  33m spamd child
    2488 root       0 38528 949m  4.0 932m S  0.0 216.0   4:42.07  996  33m spamd child
    2486 root       0 38436 932m  4.0 912m S  0.0 212.1   5:15.02  996  33m spamd child
    2487 root       0 38660 914m  4.0 900m S  0.0 207.9   4:15.34  996  33m spamd child
    6741 root       0  128m 476m  4.0 470m R 14.6 108.3 790:48.57 1512  43m /usr/X11R6/bin/X -nolisten tcp -auth /var/run/xauth/A:0-W1z1fb vt7
    6867 michael    0 71600 369m  4.0 361m S  4.6 84.1 227:17.70   40  20m konqueror [kdeinit] konqueror -session 11c0a8012a00011044035570000

/proc/meminfo:

   MemTotal:       450340 kB
   MemFree:          5128 kB
   Buffers:           568 kB
   Cached:          21932 kB
   SwapCached:     120448 kB
   Active:         153944 kB
   Inactive:         2384 kB
   HighTotal:           0 kB
   HighFree:            0 kB
   LowTotal:       450340 kB
   LowFree:          5128 kB
   SwapTotal:     2000020 kB
   SwapFree:      1616164 kB
   Dirty:              48 kB
   Writeback:           0 kB
   Mapped:         152972 kB
   Slab:           273160 kB
   CommitLimit:   2225188 kB
   Committed_AS:   918036 kB
   PageTables:       3180 kB
   VmallocTotal:   581612 kB
   VmallocUsed:     22692 kB
   VmallocChunk:   555496 kB

/proc/2489/status:

   Name:   spamd
   State:  S (sleeping)
   SleepAVG:       78%
   Tgid:   2489
   Pid:    2489
   PPid:   1775
   TracerPid:      0
   Uid:    0       0       0       0
   Gid:    0       0       0       0
   FDSize: 256
   Groups: 1000
   VmSize:    40104 kB
   VmLck:         0 kB
   VmRSS:   1033176 kB
   VmData:    35772 kB
   VmStk:        88 kB
   VmExe:       996 kB
   VmLib:      3060 kB
   VmPTE:        52 kB
   Threads:        1
   SigQ:   0/3584
   SigPnd: 0000000000000000
   ShdPnd: 0000000000000000
   SigBlk: 0000000000000000
   SigIgn: 0000000000000087
   SigCgt: 0000000080000000
   CapInh: 0000000000000000
   CapPrm: 00000000fffffeff
   CapEff: 00000000fffffeff

pmap output seems normal too (total ~40M).

Any ideas on what's happening? Or is everything actually normal and I've
just made an incorrect assumption somewhere? (in which case I'd like to know
what definition of 'resident' I'm supposed to be using :P)

Thanks,

-MD

-- 
-------------------------------------------------------------------------------
Michael Deegan           Hugaholic          http://wibble.darktech.org/gallery/
------------------------- Nyy Tybel Gb Gur Ulcabgbnq! -------------------------
