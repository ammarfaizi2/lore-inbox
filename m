Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbULUTCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbULUTCY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbULUTCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:02:24 -0500
Received: from bender.bawue.de ([193.7.176.20]:14998 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S261283AbULUS6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 13:58:04 -0500
Date: Tue, 21 Dec 2004 19:57:54 +0100
From: Joerg Sommrey <jo175@sommrey.de>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Oops on 2.6.9-ac16: xfs, dm and md may be involved
Message-ID: <20041221185754.GA28356@sommrey.de>
Mail-Followup-To: Joerg Sommrey <jo175@sommrey.de>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

last night my box died with a kernel oops.  There was a backup
running at that time. The setup:
- 2 SATA disks + 1 SCSI disk
- SATA partitions build up md-raid-arrays (level 0 and 1)
- md-raid-devices and SCSI partitions are physical volumes for dm
- dm logical volumes are used for xfs filesystems
- backup is done on dm-snapshots of those filesystems

Last week's full backup died too.  At that time 2.6.9-ac8 was running, but
I didn't get any diagnostic information.

See syslog and .config.

-jo

syslog:
Dec 21 03:28:09 bear kernel: Unable to handle kernel paging request at virtual address 6b6b6b73
Dec 21 03:28:10 bear kernel:  printing eip:
Dec 21 03:28:10 bear kernel: c028a8c0
Dec 21 03:28:10 bear kernel: *pde = 00000000
Dec 21 03:28:10 bear kernel: Oops: 0000 [#1]
Dec 21 03:28:10 bear kernel: PREEMPT SMP 
Dec 21 03:28:10 bear kernel: Modules linked in: hci_usb aes_i586 ide_cd amd76x_pm ppp_deflate bsd_comp n_hdlc ppp_synctty nvidia rfcomm l2cap bluetooth af_packet binfmt_misc capi capifs ppp_generic slhc ipt_state ipt_LOG ipt_limit ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore b1pci b1dma b1 kernelcapi amd74xx ide_core amd_k7_agp agpgart evdev usbhid ohci_hcd xfs st 3c59x usbcore eeprom w83781d i2c_sensor i2c_amd756 i2c_dev i2c_core hw_random w83627hf_wdt fan button ip_conntrack_ftp ip_conntrack cpuid msdos fat parport_pc lp parport rtc
Dec 21 03:28:10 bear kernel: CPU:    0
Dec 21 03:28:10 bear kernel: EIP:    0060:[__origin_write+112/608]    Tainted: P   VLI
Dec 21 03:28:10 bear kernel: EFLAGS: 00010217   (2.6.9-ac16) 
Dec 21 03:28:10 bear kernel: EIP is at __origin_write+0x70/0x260
Dec 21 03:28:10 bear kernel: eax: 6b6b6b4b   ebx: ccd2f888   ecx: f0f55190   edx: ffffffff
Dec 21 03:28:10 bear kernel: esi: 6b6b6b4b   edi: dc1eebd8   ebp: c4593920   esp: f7487d74
Dec 21 03:28:10 bear kernel: ds: 007b   es: 007b   ss: 0068
Dec 21 03:28:10 bear kernel: Process xfsbufd (pid: 849, threadinfo=f7486000 task=c1b9e070)
Dec 21 03:28:10 bear kernel: Stack: ec82b3b8 f7487dac 00000001 f7487d9c 00000000 c028a240 f7d6c9ec f7d6c9ec 
Dec 21 03:28:10 bear kernel:        00000000 00000000 dd07144c 000012f0 00000010 00000010 c1f239dc 00107e10 
Dec 21 03:28:10 bear kernel:        00000010 f7487dd8 c046295c 00000001 c2f4e644 f7487e4c c028ab0c dc1eebd8 
Dec 21 03:28:10 bear kernel: Call Trace:
Dec 21 03:28:10 bear kernel:  [copy_callback+0/80] copy_callback+0x0/0x50
Dec 21 03:28:10 bear kernel:  [do_origin+92/128] do_origin+0x5c/0x80
Dec 21 03:28:10 bear kernel:  [__map_bio+74/288] __map_bio+0x4a/0x120
Dec 21 03:28:10 bear kernel:  [__clone_and_map+673/688] __clone_and_map+0x2a1/0x2b0
Dec 21 03:28:10 bear kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Dec 21 03:28:10 bear kernel:  [__split_bio+168/304] __split_bio+0xa8/0x130
Dec 21 03:28:10 bear kernel:  [cache_alloc_debugcheck_after+65/368] cache_alloc_debugcheck_after+0x41/0x170
Dec 21 03:28:10 bear kernel:  [dm_request+160/224] dm_request+0xa0/0xe0
Dec 21 03:28:10 bear kernel:  [generic_make_request+283/416] generic_make_request+0x11b/0x1a0
Dec 21 03:28:10 bear kernel:  [mempool_alloc+125/368] mempool_alloc+0x7d/0x170
Dec 21 03:28:10 bear kernel:  [mempool_alloc+125/368] mempool_alloc+0x7d/0x170
Dec 21 03:28:10 bear kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Dec 21 03:28:10 bear kernel:  [submit_bio+112/304] submit_bio+0x70/0x130
Dec 21 03:28:10 bear kernel:  [bio_add_page+52/64] bio_add_page+0x34/0x40
Dec 21 03:28:10 bear kernel:  [pg0+948973600/1069106176] _pagebuf_ioapply+0x1d0/0x2d0 [xfs]
Dec 21 03:28:10 bear kernel:  [blk_backing_dev_unplug+0/48] blk_backing_dev_unplug+0x0/0x30
Dec 21 03:28:10 bear kernel:  [pg0+948973989/1069106176] pagebuf_iorequest+0x85/0x160 [xfs]
Dec 21 03:28:10 bear kernel:  [generic_unplug_device+30/48] generic_unplug_device+0x1e/0x30
Dec 21 03:28:10 bear kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 21 03:28:10 bear kernel:  [dm_table_unplug_all+72/80] dm_table_unplug_all+0x48/0x50
Dec 21 03:28:10 bear kernel:  [default_wake_function+0/32] default_wake_function+0x0/0x20
Dec 21 03:28:10 bear kernel:  [dm_table_unplug_all+72/80] dm_table_unplug_all+0x48/0x50
Dec 21 03:28:10 bear kernel:  [blk_backing_dev_unplug+0/48] blk_backing_dev_unplug+0x0/0x30
Dec 21 03:28:10 bear kernel:  [pg0+948997986/1069106176] xfs_bdstrat_cb+0x42/0x50 [xfs]
Dec 21 03:28:10 bear kernel:  [pg0+948975912/1069106176] pagebuf_daemon+0xf8/0x1f0 [xfs]
Dec 21 03:28:10 bear kernel:  [pg0+948975664/1069106176] pagebuf_daemon+0x0/0x1f0 [xfs]
Dec 21 03:28:10 bear kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Dec 21 03:28:10 bear kernel: Code: 0f 85 65 01 00 00 8b 53 20 8d 42 e0 89 c3 8b 40 20 0f 18 00 90 39 fa 75 e2 8b 44 24 1c 85 c0 0f 84 18 01 00 00 8b 74 24 1c 89 f6 <8b> 5e 28 c7 04 24 be 6c 30 c0 c7 44 24 04 42 00 00 00 e8 69 f2 
Dec 21 03:28:10 bear kernel:  <1>Unable to handle kernel paging request at virtual address 6b6b6b7b
Dec 21 03:28:10 bear kernel:  printing eip:
Dec 21 03:28:10 bear kernel: c0116665
Dec 21 03:28:10 bear kernel: *pde = 00000000
Dec 21 03:28:10 bear kernel: Oops: 0000 [#2]
Dec 21 03:28:10 bear kernel: PREEMPT SMP 
Dec 21 03:28:10 bear kernel: Modules linked in: hci_usb aes_i586 ide_cd amd76x_pm ppp_deflate bsd_comp n_hdlc ppp_synctty nvidia rfcomm l2cap bluetooth af_packet binfmt_misc capi capifs ppp_generic slhc ipt_state ipt_LOG ipt_limit ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore b1pci b1dma b1 kernelcapi amd74xx ide_core amd_k7_agp agpgart evdev usbhid ohci_hcd xfs st 3c59x usbcore eeprom w83781d i2c_sensor i2c_amd756 i2c_dev i2c_core hw_random w83627hf_wdt fan button ip_conntrack_ftp ip_conntrack cpuid msdos fat parport_pc lp parport rtc
Dec 21 03:28:10 bear kernel: CPU:    1
Dec 21 03:28:10 bear kernel: EIP:    0060:[task_rq_lock+37/112]    Tainted: P   VLI
Dec 21 03:28:10 bear kernel: EFLAGS: 00010096   (2.6.9-ac16) 
Dec 21 03:28:10 bear kernel: EIP is at task_rq_lock+0x25/0x70
Dec 21 03:28:10 bear kernel: eax: 6b6b6b6b   ebx: c0402080   ecx: f7880548   edx: c1b9e070
Dec 21 03:28:10 bear kernel: esi: c0402080   edi: c1b9e070   ebp: f7c61ea8   esp: f7c61e9c
Dec 21 03:28:10 bear kernel: ds: 007b   es: 007b   ss: 0068
Dec 21 03:28:10 bear kernel: Process kswapd0 (pid: 42, threadinfo=f7c60000 task=f7c5f630)
Dec 21 03:28:10 bear kernel: Stack: 00000068 00000000 00000000 f7c61ef4 c0116c42 c1b9e070 f7c61ee4 f7190a00 
Dec 21 03:28:10 bear kernel:        00000001 f7190a00 f7190a48 f7190a48 f7190a20 c01417eb f7190a00 00000000 
Dec 21 03:28:10 bear kernel:        00000001 00000001 00000296 00000068 00000000 00000000 f7c61f08 c0116eae 
Dec 21 03:28:10 bear kernel: Call Trace:
Dec 21 03:28:10 bear kernel:  [try_to_wake_up+34/624] try_to_wake_up+0x22/0x270
Dec 21 03:28:10 bear kernel:  [drain_cpu_caches+91/96] drain_cpu_caches+0x5b/0x60
Dec 21 03:28:10 bear kernel:  [wake_up_process+30/32] wake_up_process+0x1e/0x20
Dec 21 03:28:10 bear kernel:  [pg0+948975652/1069106176] pagebuf_daemon_wakeup+0x14/0x20 [xfs]
Dec 21 03:28:10 bear kernel:  [shrink_slab+138/432] shrink_slab+0x8a/0x1b0
Dec 21 03:28:10 bear kernel:  [balance_pgdat+605/688] balance_pgdat+0x25d/0x2b0
Dec 21 03:28:10 bear kernel:  [kswapd+212/256] kswapd+0xd4/0x100
Dec 21 03:28:10 bear kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Dec 21 03:28:10 bear kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Dec 21 03:28:10 bear kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Dec 21 03:28:10 bear kernel:  [kswapd+0/256] kswapd+0x0/0x100
Dec 21 03:28:10 bear kernel:  [kernel_thread_helper+5/20] kernel_thread_helper+0x5/0x14
Dec 21 03:28:10 bear kernel: Code: bc 27 00 00 00 00 55 89 e5 83 ec 0c 89 7c 24 08 89 1c 24 89 74 24 04 8b 7d 08 8b 45 0c 9c 8f 00 fa 8b 47 04 bb 80 20 40 c0 89 de <8b> 40 10 03 34 85 04 70 40 c0 89 f0 e8 ba ec 1d 00 8b 47 04 8b 
Dec 21 03:28:10 bear kernel:  <1>Unable to handle kernel paging request at virtual address 6b6b6b7b
Dec 21 03:28:10 bear kernel:  printing eip:
Dec 21 03:28:10 bear kernel: c0116665
Dec 21 03:28:10 bear kernel: *pde = 00000000
Dec 21 03:28:10 bear kernel: Oops: 0000 [#3]
Dec 21 03:28:10 bear kernel: PREEMPT SMP 
Dec 21 03:28:10 bear kernel: Modules linked in: hci_usb aes_i586 ide_cd amd76x_pm ppp_deflate bsd_comp n_hdlc ppp_synctty nvidia rfcomm l2cap bluetooth af_packet binfmt_misc capi capifs ppp_generic slhc ipt_state ipt_LOG ipt_limit ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore b1pci b1dma b1 kernelcapi amd74xx ide_core amd_k7_agp agpgart evdev usbhid ohci_hcd xfs st 3c59x usbcore eeprom w83781d i2c_sensor i2c_amd756 i2c_dev i2c_core hw_random w83627hf_wdt fan button ip_conntrack_ftp ip_conntrack cpuid msdos fat parport_pc lp parport rtc
Dec 21 03:28:10 bear kernel: CPU:    0
Dec 21 03:28:10 bear kernel: EIP:    0060:[task_rq_lock+37/112]    Tainted: P   VLI
Dec 21 03:28:10 bear kernel: EFLAGS: 00010092   (2.6.9-ac16) 
Dec 21 03:28:10 bear kernel: EIP is at task_rq_lock+0x25/0x70
Dec 21 03:28:10 bear kernel: eax: 6b6b6b6b   ebx: c0402080   ecx: f7880548   edx: c1b9e070
Dec 21 03:28:10 bear kernel: esi: c0402080   edi: c1b9e070   ebp: f4f6dc00   esp: f4f6dbf4
Dec 21 03:28:10 bear kernel: ds: 007b   es: 007b   ss: 0068
Dec 21 03:28:10 bear kernel: Process cpio (pid: 8398, threadinfo=f4f6c000 task=f0f54f50)
Dec 21 03:28:10 bear kernel: Stack: 00000068 00000000 00000000 f4f6dc4c c0116c42 c1b9e070 f4f6dc3c f7190a00 
Dec 21 03:28:10 bear kernel:        00000001 f7190a00 f7190a48 f7190a48 f7190a20 c01417eb f7190a00 00000000 
Dec 21 03:28:10 bear kernel:        00000001 00000001 00000292 00000068 00000000 00000000 f4f6dc60 c0116eae 
Dec 21 03:28:10 bear kernel: Call Trace:
Dec 21 03:28:10 bear kernel:  [try_to_wake_up+34/624] try_to_wake_up+0x22/0x270
Dec 21 03:28:10 bear kernel:  [drain_cpu_caches+91/96] drain_cpu_caches+0x5b/0x60
Dec 21 03:28:10 bear kernel:  [wake_up_process+30/32] wake_up_process+0x1e/0x20
Dec 21 03:28:10 bear kernel:  [pg0+948975652/1069106176] pagebuf_daemon_wakeup+0x14/0x20 [xfs]
Dec 21 03:28:10 bear kernel:  [shrink_slab+138/432] shrink_slab+0x8a/0x1b0
Dec 21 03:28:10 bear kernel:  [try_to_free_pages+224/432] try_to_free_pages+0xe0/0x1b0
Dec 21 03:28:10 bear kernel:  [__alloc_pages+554/912] __alloc_pages+0x22a/0x390
Dec 21 03:28:10 bear kernel:  [do_page_cache_readahead+307/384] do_page_cache_readahead+0x133/0x180
Dec 21 03:28:10 bear kernel:  [__lock_page+218/240] __lock_page+0xda/0xf0
Dec 21 03:28:10 bear kernel:  [page_cache_readahead+388/480] page_cache_readahead+0x184/0x1e0
Dec 21 03:28:10 bear kernel:  [do_generic_mapping_read+327/1360] do_generic_mapping_read+0x147/0x550
Dec 21 03:28:10 bear kernel:  [__generic_file_aio_read+510/560] __generic_file_aio_read+0x1fe/0x230
Dec 21 03:28:10 bear kernel:  [file_read_actor+0/288] file_read_actor+0x0/0x120
Dec 21 03:28:10 bear kernel:  [ata_scsi_queuecmd+90/272] ata_scsi_queuecmd+0x5a/0x110
Dec 21 03:28:10 bear kernel:  [pg0+948992755/1069106176] xfs_read+0x173/0x2c0 [xfs]
Dec 21 03:28:10 bear kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
Dec 21 03:28:10 bear kernel:  [scsi_request_fn+81/976] scsi_request_fn+0x51/0x3d0
Dec 21 03:28:10 bear kernel:  [pg0+948977162/1069106176] linvfs_read+0x8a/0xa0 [xfs]
Dec 21 03:28:10 bear kernel:  [do_sync_read+190/240] do_sync_read+0xbe/0xf0
Dec 21 03:28:10 bear kernel:  [sd_rw_intr+131/608] sd_rw_intr+0x83/0x260
Dec 21 03:28:10 bear kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
Dec 21 03:28:10 bear kernel:  [dnotify_parent+58/176] dnotify_parent+0x3a/0xb0
Dec 21 03:28:10 bear kernel:  [vfs_read+184/304] vfs_read+0xb8/0x130
Dec 21 03:28:10 bear kernel:  [sys_read+81/128] sys_read+0x51/0x80
Dec 21 03:28:10 bear kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 21 03:28:10 bear kernel: Code: bc 27 00 00 00 00 55 89 e5 83 ec 0c 89 7c 24 08 89 1c 24 89 74 24 04 8b 7d 08 8b 45 0c 9c 8f 00 fa 8b 47 04 bb 80 20 40 c0 89 de <8b> 40 10 03 34 85 04 70 40 c0 89 f0 e8 ba ec 1d 00 8b 47 04 8b 
Dec 21 03:28:10 bear kernel:  <1>Unable to handle kernel paging request at virtual address 6b6b6b7b
Dec 21 03:28:10 bear kernel:  printing eip:
Dec 21 03:28:10 bear kernel: c0116665
Dec 21 03:28:10 bear kernel: *pde = 00000000
Dec 21 03:28:10 bear kernel: Oops: 0000 [#4]
Dec 21 03:28:10 bear kernel: PREEMPT SMP 
Dec 21 03:28:10 bear kernel: Modules linked in: hci_usb aes_i586 ide_cd amd76x_pm ppp_deflate bsd_comp n_hdlc ppp_synctty nvidia rfcomm l2cap bluetooth af_packet binfmt_misc capi capifs ppp_generic slhc ipt_state ipt_LOG ipt_limit ipt_REJECT iptable_filter ipt_MASQUERADE iptable_nat ip_tables snd_emu10k1 snd_rawmidi snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd soundcore b1pci b1dma b1 kernelcapi amd74xx ide_core amd_k7_agp agpgart evdev usbhid ohci_hcd xfs st 3c59x usbcore eeprom w83781d i2c_sensor i2c_amd756 i2c_dev i2c_core hw_random w83627hf_wdt fan button ip_conntrack_ftp ip_conntrack cpuid msdos fat parport_pc lp parport rtc
Dec 21 03:28:10 bear kernel: CPU:    0
Dec 21 03:28:10 bear kernel: EIP:    0060:[task_rq_lock+37/112]    Tainted: P   VLI
Dec 21 03:28:10 bear kernel: EFLAGS: 00010096   (2.6.9-ac16) 
Dec 21 03:28:10 bear kernel: EIP is at task_rq_lock+0x25/0x70
Dec 21 03:28:10 bear kernel: eax: 6b6b6b6b   ebx: c0402080   ecx: f7880548   edx: c1b9e070
Dec 21 03:28:10 bear kernel: esi: c0402080   edi: c1b9e070   ebp: f2d33dc4   esp: f2d33db8
Dec 21 03:28:10 bear kernel: ds: 007b   es: 007b   ss: 0068
Dec 21 03:28:10 bear kernel: Process dovecot (pid: 3831, threadinfo=f2d32000 task=f2c3b3f0)
Dec 21 03:28:10 bear kernel: Stack: 00000068 00000000 00000000 f2d33e10 c0116c42 c1b9e070 f2d33e00 f7190a00 
Dec 21 03:28:10 bear kernel:        00000001 f7190a00 f7190a48 f7190a48 f7190a20 c01417eb f7190a00 00000000 
Dec 21 03:28:10 bear kernel:        00000001 00000001 00000296 00000068 00000000 00000000 f2d33e24 c0116eae 
Dec 21 03:28:10 bear kernel: Call Trace:
Dec 21 03:28:10 bear kernel:  [try_to_wake_up+34/624] try_to_wake_up+0x22/0x270
Dec 21 03:28:10 bear kernel:  [drain_cpu_caches+91/96] drain_cpu_caches+0x5b/0x60
Dec 21 03:28:10 bear kernel:  [wake_up_process+30/32] wake_up_process+0x1e/0x20
Dec 21 03:28:10 bear kernel:  [pg0+948975652/1069106176] pagebuf_daemon_wakeup+0x14/0x20 [xfs]
Dec 21 03:28:10 bear kernel:  [shrink_slab+138/432] shrink_slab+0x8a/0x1b0
Dec 21 03:28:10 bear kernel:  [try_to_free_pages+224/432] try_to_free_pages+0xe0/0x1b0
Dec 21 03:28:10 bear kernel:  [__alloc_pages+554/912] __alloc_pages+0x22a/0x390
Dec 21 03:28:10 bear kernel:  [schedule+778/1520] schedule+0x30a/0x5f0
Dec 21 03:28:10 bear kernel:  [__get_free_pages+37/64] __get_free_pages+0x25/0x40
Dec 21 03:28:10 bear kernel:  [__pollwait+134/208] __pollwait+0x86/0xd0
Dec 21 03:28:10 bear kernel:  [unix_poll+43/176] unix_poll+0x2b/0xb0
Dec 21 03:28:10 bear kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
Dec 21 03:28:10 bear kernel:  [do_pollfd+137/144] do_pollfd+0x89/0x90
Dec 21 03:28:10 bear kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
Dec 21 03:28:10 bear kernel:  [sys_poll+338/576] sys_poll+0x152/0x240
Dec 21 03:28:10 bear kernel:  [sys_gettimeofday+59/128] sys_gettimeofday+0x3b/0x80
Dec 21 03:28:10 bear kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
Dec 21 03:28:10 bear kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Dec 21 03:28:10 bear kernel: Code: bc 27 00 00 00 00 55 89 e5 83 ec 0c 89 7c 24 08 89 1c 24 89 74 24 04 8b 7d 08 8b 45 0c 9c 8f 00 fa 8b 47 04 bb 80 20 40 c0 89 de <8b> 40 10 03 34 85 04 70 40 c0 89 f0 e8 ba ec 1d 00 8b 47 04 8b 
Dec 21 03:28:11 bear kernel:  <1>Unable to handle kernel paging request at virtual address 6b6b6b7b

.config:
#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.9-ac16
# Sat Dec 18 09:50:32 2004
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
CONFIG_LOG_BUF_SHIFT=18
CONFIG_HOTPLUG=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SHMEM=y
# CONFIG_TINY_SHMEM is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y
CONFIG_STOP_MACHINE=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_HZ=1000
# CONFIG_X86_GENERIC is not set
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=y
CONFIG_NR_CPUS=2
# CONFIG_SCHED_SMT is not set
CONFIG_PREEMPT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_X86_MCE_P4THERMAL is not set
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m

#
# Firmware Drivers
#
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_IRQBALANCE=y
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_AMD76X_PM=m

#
# APM (Advanced Power Management) BIOS Support
#
# CONFIG_APM is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
# CONFIG_ISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play support
#

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_UB is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=m

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_IDEDISK is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8212 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI Transport Attributes
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
# CONFIG_AIC7XXX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_NV is not set
CONFIG_SCSI_SATA_PROMISE=y
# CONFIG_SCSI_SATA_SX4 is not set
# CONFIG_SCSI_SATA_SIL is not set
# CONFIG_SCSI_SATA_SIS is not set
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_SATA_VITESSE is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA2300 is not set
# CONFIG_SCSI_QLA2322 is not set
# CONFIG_SCSI_QLA6312 is not set
# CONFIG_SCSI_QLA6322 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
# CONFIG_MD_RAID10 is not set
CONFIG_MD_RAID5=y
# CONFIG_MD_RAID6 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=m
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_NET_KEY=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
CONFIG_IP_ADVANCED_ROUTER=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_ARPD is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_IPCOMP=y
CONFIG_INET_TUNNEL=y

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
# CONFIG_IPV6 is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
# CONFIG_IP_NF_CT_ACCT is not set
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_LOCAL=y
# CONFIG_IP_NF_NAT_SNMP_BASIC is not set
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
CONFIG_XFRM=y
CONFIG_XFRM_USER=m

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_BRIDGE is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set
CONFIG_NET_CLS_ROUTE=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
# CONFIG_BT_BNEP_MC_FILTER is not set
# CONFIG_BT_BNEP_PROTO_FILTER is not set
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_BCSP_TXCRC=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
CONFIG_TUN=m
# CONFIG_ETHERTAP is not set

#
# ARCnet devices
#
# CONFIG_ARCNET is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=m
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_S2IO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
# CONFIG_SLIP is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# ISDN subsystem
#
CONFIG_ISDN=m

#
# Old ISDN4Linux
#
# CONFIG_ISDN_I4L is not set

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=m
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_CAPIFS_BOOL=y
CONFIG_ISDN_CAPI_CAPIFS=m

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
# CONFIG_ISDN_DRV_AVMB1_B1PCMCIA is not set
# CONFIG_ISDN_DRV_AVMB1_T1PCI is not set
# CONFIG_ISDN_DRV_AVMB1_C4 is not set

#
# Active Eicon DIVA Server cards
#
# CONFIG_CAPI_EICON is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=m
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=m
CONFIG_INPUT_UINPUT=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
CONFIG_N_HDLC=m
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_SC520_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_I8XX_TCO is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_HW_RANDOM=m
# CONFIG_NVRAM is not set
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_ATI is not set
CONFIG_AGP_AMD=m
# CONFIG_AGP_AMD64 is not set
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_INTEL_MCH is not set
# CONFIG_AGP_NVIDIA is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_SWORKS is not set
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HPET=y
# CONFIG_HPET_RTC_IRQ is not set
CONFIG_HPET_MMAP=y
CONFIG_HANGCHECK_TIMER=m

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_CHARDEV=m

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
CONFIG_I2C_ISA=m
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_PARPORT is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set
# CONFIG_I2C_PCA_ISA is not set

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=m
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_FSCHER is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83627HF=m

#
# Other I2C Chip support
#
CONFIG_SENSORS_EEPROM=m
# CONFIG_SENSORS_PCF8574 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_SENSORS_RTC8564 is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Misc devices
#
# CONFIG_IBM_ASM is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
CONFIG_FB=y
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I810 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set

#
# Logo configuration
#
# CONFIG_LOGO is not set

#
# Sound
#
CONFIG_SOUND=m

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
CONFIG_SND_MPU401_UART=m
CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
CONFIG_SND_EMU10K1=m
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_USX2Y is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_DEBUG=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_RW_DETECT is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
CONFIG_USB_HIDDEV=y

#
# USB HID Boot Protocol drivers
#
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_MTOUCH is not set
# CONFIG_USB_EGALAX is not set
# CONFIG_USB_XPAD is not set
# CONFIG_USB_ATI_REMOTE is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_SAFE is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_PHIDGETSERVO is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
# CONFIG_EXT2_FS_SECURITY is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_SECURITY is not set
CONFIG_XFS_POSIX_ACL=y
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
CONFIG_QUOTACTL=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=m
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_TEST=m

#
# Library routines
#
CONFIG_CRC_CCITT=m
CONFIG_CRC32=m
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_PC=y
