Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbVLODnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVLODnv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVLODnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:43:51 -0500
Received: from tecbc.mx ([201.140.139.2]:27875 "EHLO guardian.tecbc.mx")
	by vger.kernel.org with ESMTP id S1161005AbVLODnu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:43:50 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.14: Bad page state at free_hot_cold_page
Date: Wed, 14 Dec 2005 19:44:05 -0800
From: "Octavio Alvarez" <alvarezp@tecbc.mx>
Organization: TBC Universidad
Message-ID: <op.s1s28lqj4oyyg1@octavio.tecbc.mx>
User-Agent: Opera M2/8.50 (Win32, build 7700)
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I'd appreciate any replies to be CC'd to me, as I'm not subscribed to the  
list.)

Hi, I'm getting the following error:

Bad page state at free_hot_cold_page (in process 'kswapd0', page c10180e0)
flags:0x00010008 mapping:00000000 mapcount:-65536 count:0
Backtrace:
  [<c013a2e4>] bad_page+0x74/0xb0
  [<c013a9a0>] free_hot_cold_page+0x60/0xe0
  [<c0192a90>] ext2_get_block+0x0/0x370
  [<c013b1ac>] __pagevec_free+0x1c/0x30
  [<c014030b>] __pagevec_release_nonlru+0x6b/0x90
  [<c0135da4>] __remove_from_page_cache+0x24/0x50
  [<c01414bf>] shrink_list+0x2cf/0x400
  [<c01417a0>] shrink_cache+0x100/0x270
  [<c013c430>] throttle_vm_writeout+0x30/0x80
  [<c0140e9a>] shrink_slab+0x9a/0x1c0
  [<c0141d55>] shrink_zone+0xb5/0xf0
  [<c0142256>] balance_pgdat+0x2a6/0x3a0
  [<c014242e>] kswapd+0xde/0x100
  [<c012c2a0>] autoremove_wake_function+0x0/0x60
  [<c012c2a0>] autoremove_wake_function+0x0/0x60
  [<c0142350>] kswapd+0x0/0x100
  [<c0101359>] kernel_thread_helper+0x5/0xc
Trying to fix it up, but a reboot is needed

After the errror, the system behaves erratic: sometimes some apps won't  
load anymore, shutdown doesn't complete (it stucks at powering off hard  
disks or stopping some service), etc. It occurs at random.

I have seen this since the late 2.6.12. I have reproduced this both with  
and without X server and both, with nv and nvidia driver.

Computer has nVidia chipset, AMD Athlon XP 2400 with 256 MB of RAM. (NOT  
Opteron)

alvarezp@octavio:~$ uname -a
Linux octavio 2.6.14 #9 Tue Nov 8 23:13:00 PST 2005 i686 unknown unknown  
GNU/Linux

alvarezp@octavio:~$ cat /proc/meminfo
MemTotal:       256352 kB
MemFree:        214872 kB
Buffers:          1044 kB
Cached:          21752 kB
SwapCached:       2404 kB
Active:           8520 kB
Inactive:        17980 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256352 kB
LowFree:        214872 kB
SwapTotal:      401584 kB
SwapFree:       392744 kB
Dirty:              28 kB
Writeback:           0 kB
Mapped:           5520 kB
Slab:             7944 kB
CommitLimit:    529760 kB
Committed_AS:    34192 kB
PageTables:        376 kB
VmallocTotal:   778200 kB
VmallocUsed:      5644 kB
VmallocChunk:   769972 kB

Octavio.
