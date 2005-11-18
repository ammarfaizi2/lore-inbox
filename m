Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbVKRUMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbVKRUMH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbVKRUMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:12:07 -0500
Received: from isilmar.linta.de ([213.239.214.66]:8616 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1161165AbVKRUMF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:12:05 -0500
Date: Fri, 18 Nov 2005 21:12:03 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
Message-ID: <20051118201203.GA31209@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

[4294995.698000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb020)
[4294995.698000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4294995.698000] vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x11 snd_pcm_mmap_data_nopage+0x0/0xa7
[4294995.698000] Backtrace:
[4294995.698000]  [<c0103b59>] dump_stack+0x15/0x17
[4294995.698000]  [<c0138ff1>] bad_page+0xab/0xe1
[4294995.698000]  [<c01396d2>] free_hot_cold_page+0x5c/0xfe
[4294995.698000]  [<c013977e>] free_hot_page+0xa/0xc
[4294995.698000]  [<c013f03c>] __page_cache_release+0x8f/0x94
[4294995.698000]  [<c013ed1f>] put_page+0x5b/0x5d
[4294995.698000]  [<c0148dc9>] free_page_and_swap_cache+0x2c/0x2f
[4294995.698000]  [<c014265e>] zap_pte_range+0x1aa/0x227
[4294995.698000]  [<c0142779>] unmap_page_range+0x9e/0xe8
[4294995.698000]  [<c0142886>] unmap_vmas+0xc3/0x199
[4294995.698000]  [<c0145d57>] unmap_region+0x77/0xf2
[4294995.698000]  [<c0145ff1>] do_munmap+0xdd/0xf3
[4294995.698000]  [<c0146056>] sys_munmap+0x4f/0x68
[4294995.698000]  [<c0102cab>] sysenter_past_esp+0x54/0x75
[4294995.698000] Trying to fix it up, but a reboot is needed
[4294995.698000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb040)
[4294995.698000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
[4294995.698000] vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x11 snd_pcm_mmap_data_nopage+0x0/0xa7
[4294995.698000] Backtrace:
[4294995.698000]  [<c0103b59>] dump_stack+0x15/0x17
[4294995.698000]  [<c0138ff1>] bad_page+0xab/0xe1
[4294995.698000]  [<c01396d2>] free_hot_cold_page+0x5c/0xfe
[4294995.698000]  [<c013977e>] free_hot_page+0xa/0xc
[4294995.698000]  [<c013f03c>] __page_cache_release+0x8f/0x94
[4294995.698000]  [<c013ed1f>] put_page+0x5b/0x5d
[4294995.698000]  [<c0148dc9>] free_page_and_swap_cache+0x2c/0x2f
[4294995.698000]  [<c014265e>] zap_pte_range+0x1aa/0x227
[4294995.698000]  [<c0142779>] unmap_page_range+0x9e/0xe8
[4294995.698000]  [<c0142886>] unmap_vmas+0xc3/0x199
[4294995.698000]  [<c0145d57>] unmap_region+0x77/0xf2
[4294995.698000]  [<c0145ff1>] do_munmap+0xdd/0xf3
[4294995.698000]  [<c0146056>] sys_munmap+0x4f/0x68
[4294995.698000]  [<c0102cab>] sysenter_past_esp+0x54/0x75

and so on.


0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)

readlink /sys/devices/pci0000\:00/0000\:00\:1f.5/driver 
../../../bus/pci/drivers/Intel ICH
 readlink /sys/devices/pci0000\:00/0000\:00\:1f.6/driver
../../../bus/pci/drivers/Intel ICH Modem


Thanks for taking care of this,
	Dominik
