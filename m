Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161193AbVKRUld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161193AbVKRUld (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161194AbVKRUlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:41:32 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:17849 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161193AbVKRUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:41:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.15-rc1-mm2 0x414 Bad page states
Date: Fri, 18 Nov 2005 21:42:16 +0100
User-Agent: KMail/1.8.3
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511181906240.2853@goblin.wat.veritas.com> <20051118201203.GA31209@isilmar.linta.de>
In-Reply-To: <20051118201203.GA31209@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511182142.17432.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 18 of November 2005 21:12, Dominik Brodowski wrote:
> [4294995.698000] Bad page state at free_hot_cold_page (in process 'gaim', page c15eb020)
> [4294995.698000] flags:0x80000414 mapping:00000000 mapcount:0 count:0
> [4294995.698000] vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x11 snd_pcm_mmap_data_nopage+0x0/0xa7

I've got pretty much the same:

Nov 18 21:23:22 albercik kernel: Bad page state at free_hot_cold_page (in process 'artsd', page ffff8100019613b8)
Nov 18 21:23:22 albercik kernel: flags:0x4000000000000414 mapping:0000000000000000 mapcount:0 count:0
Nov 18 21:23:22 albercik kernel: vm_flags:0x800fb snd_pcm_mmap_data_open+0x0/0x20 [snd_pcm] snd_pcm_mmap_data_nopage+0x0/0x150 [snd_pcm]
Nov 18 21:23:22 albercik kernel: Backtrace:
Nov 18 21:23:22 albercik kernel: 
Nov 18 21:23:22 albercik kernel: Call Trace:<ffffffff80160a5e>{bad_page+238} <ffffffff80161094>{free_hot_cold_page+116}
Nov 18 21:23:22 albercik kernel:        <ffffffff801611bb>{free_hot_page+11} <ffffffff80163cc9>{__page_cache_release+217}
Nov 18 21:23:22 albercik kernel:        <ffffffff80163d56>{put_page+118} <ffffffff80172508>{free_page_and_swap_cache+56}
Nov 18 21:23:22 albercik kernel:        <ffffffff80168fdf>{unmap_vmas+1391} <ffffffff8016c522>{unmap_region+178}
Nov 18 21:23:22 albercik kernel:        <ffffffff8016d7be>{do_munmap+558} <ffffffff8016d8b0>{sys_munmap+80}
Nov 18 21:23:22 albercik kernel:        <ffffffff8010eb5e>{system_call+126} 
Nov 18 21:23:22 albercik kernel: ---------------------------
Nov 18 21:23:22 albercik kernel: | preempt count: 00000002 ]
Nov 18 21:23:26 albercik kernel: | 2 level deep critical section nesting:
Nov 18 21:23:27 albercik kernel: ----------------------------------------
Nov 18 21:23:28 albercik kernel: .. [<ffffffff8016c4c7>] .... unmap_region+0x57/0x150
Nov 18 21:23:29 albercik kernel: .....[<ffffffff8016d7be>] ..   ( <= do_munmap+0x22e/0x2d0)
Nov 18 21:23:30 albercik kernel: .. [<ffffffff8035f2a6>] .... _spin_lock+0x16/0x30
Nov 18 21:23:30 albercik kernel: .....[<ffffffff80168e24>] ..   ( <= unmap_vmas+0x3b4/0x790)
Nov 18 21:23:31 albercik kernel: 
Nov 18 21:23:31 albercik kernel: Hexdump:
Nov 18 21:23:33 albercik kernel: 000: e8 0c 06 2b 00 81 ff ff 14 04 00 00 00 00 00 40
Nov 18 21:23:35 albercik kernel: 010: 00 00 00 00 ff ff ff ff 00 00 00 00 00 00 00 00
Nov 18 21:23:36 albercik kernel: 020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Nov 18 21:23:36 albercik kernel: 030: 00 01 10 00 00 00 00 00 00 02 20 00 00 00 00 00
Nov 18 21:23:36 albercik kernel: 040: 14 04 00 00 00 00 00 40 ff ff ff ff ff ff ff ff
Nov 18 21:23:37 albercik kernel: 050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Nov 18 21:23:37 albercik kernel: 060: 00 00 00 00 00 00 00 00 e0 13 96 01 00 81 ff ff
Nov 18 21:23:38 albercik kernel: 070: e0 13 96 01 00 81 ff ff 14 04 00 00 00 00 00 40
Nov 18 21:23:38 albercik kernel: 080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Nov 18 21:23:41 albercik kernel: 090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Nov 18 21:23:45 albercik kernel: 0a0: 18 14 96 01 00 81 ff ff 18 14 96 01 00 81 ff ff
Nov 18 21:23:46 albercik kernel: 0b0: 14 04 00 00 00 00 00 40 00 00 00 00 00 00 00 00
Nov 18 21:23:51 albercik kernel: Trying to fix it up, but a reboot is needed

and so forth.

> 0000:00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 0000:00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01)
> 
> readlink /sys/devices/pci0000\:00/0000\:00\:1f.5/driver 
> ../../../bus/pci/drivers/Intel ICH
>  readlink /sys/devices/pci0000\:00/0000\:00\:1f.6/driver
> ../../../bus/pci/drivers/Intel ICH Modem

0000:00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)

albercik:~ # readlink /sys/devices/pci0000\:00/0000\:00\:06.0/driver
../../../bus/pci/drivers/Intel ICH
 
> Thanks for taking care of this,

Ditto. :-)

Greetings,
Rafael
