Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUL3WGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUL3WGD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbUL3WGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:06:03 -0500
Received: from c148216.adsl.hansenet.de ([213.39.148.216]:59270 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S261725AbUL3WFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:05:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: Kernel 2.6.10 crashing repeatedly and hard
References: <m3is6k4oeu.fsf@reason.gnu-hamburg>
	<Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org>
From: "Georg C. F. Greve" <greve@fsfeurope.org>
Organisation: Free Software Foundation Europe
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 30 Dec 2004 23:04:58 +0100
In-Reply-To: <Pine.LNX.4.58.0412301239160.22893@ppc970.osdl.org> (Linus
	Torvalds's message of "Thu, 30 Dec 2004 12:40:52 -0800 (PST)")
Message-ID: <m3zmzvl9x1.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="20041230230458+01002037820786202264-36642645";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--20041230230458+01002037820786202264-36642645

 || On Thu, 30 Dec 2004 12:40:52 -0800 (PST)
 || Linus Torvalds <torvalds@osdl.org> wrote: 

 >> This is what I could preserve in output from the crashes:

 lt> Any chance that you can get a full oops, with register info?
 lt> Right now your errors only have the call trace, not the registers
 lt> or the EIP itself..

Yes, for the first two times, the top of the crash report scrolled off
the screen and I don't have a serial console handy. The third crash
contained the 

 EFLAGS: 00010002   (2.6.10)
 EIP is at free_block+0x45/0xd0
 eax: 46484849   ebx: df2b1000   ecx: df2b1050   edx: df2ab000
 esi: c183cd80   edi: 00000001   ebp: 00000018   esp: c188fef8
 ds: 007b   es: 007b   ss: 0068
 Process events/0 (pid: 6, threadinfo:c188e000 task=c185ca20)
 Stack: c183cdb8 c1858810 c1858800 00000018 c183cd80 c0141724 c183cd80 c1858810
        00000018 c183ccb8 c183cd80 00000002 c183cce0 c01417c6 c183cd80 c1858800
        00000000 c183ccb8 c183ce10 00000003 c170fc20 c183b000 c170fc24 00000000

header, which I think may contain what you were looking for.

But I have something better to offer -- today, when trying ext3 on
raid5 directly, I also got the following dumped to syslog:

 Unable to handle kernel paging request at virtual address 24232428
  printing eip:
 c0140ef2
 *pde = 00000000
 Oops: 0002 [#1]
 PREEMPT SMP
 Modules linked in: w83627hf lm75 eeprom i2c_sensor i2c_isa 8139cp eth1394 dvb_ttpci saa7146_vv saa7146 ves1820 stv0299 tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc i2c_i801 ehci_hcd uhci_hcd shpchp pci_hotplug 8250_pnp 8250 serial_core pcspkr tsdev tuner tvaudio msp3400 bttv video_buf firmware_class i2c_algo_bit btcx_risc i2c_core lirc_serial lirc_dev 8139too
 CPU:    1
 EIP:    0060:[cache_alloc_refill+258/560]    Not tainted
 EFLAGS: 00010046   (2.6.10-lirc)
 EIP is at cache_alloc_refill+0x102/0x230
 eax: 24232424   ebx: c1855600   ecx: e30f0000   edx: c182d9a8
 esi: ffffffff   edi: e30f0018   ebp: c1855610   esp: ccbc3c38
 ds: 007b   es: 007b   ss: 0068
 Process cp (pid: 7568, threadinfo=ccbc2000 task=e4d90a20)
 Stack: e30f0018 c182d9e0 c182d9a8 c182d9b0 00000246 00000000 00001000 c111b9a0
        c01411d8 c182d980 00000050 00000050 c0158be3 c182d980 00000050 00000000
        00000000 c01565fe 00000050 c111b9a0 00000000 c111b9a0 00001000 c0156ea8
 Call Trace:
  [kmem_cache_alloc+56/64] kmem_cache_alloc+0x38/0x40
  [alloc_buffer_head+19/96] alloc_buffer_head+0x13/0x60
  [alloc_page_buffers+30/144] alloc_page_buffers+0x1e/0x90
  [create_empty_buffers+24/144] create_empty_buffers+0x18/0x90
  [__block_prepare_write+883/960] __block_prepare_write+0x373/0x3c0
  [block_prepare_write+32/48] block_prepare_write+0x20/0x30
  [ext3_get_block+0/112] ext3_get_block+0x0/0x70
  [ext3_prepare_write+88/272] ext3_prepare_write+0x58/0x110
  [ext3_get_block+0/112] ext3_get_block+0x0/0x70
  [generic_file_buffered_write+415/1536] generic_file_buffered_write+0x19f/0x600
  [update_atime+110/176] update_atime+0x6e/0xb0
  [inode_update_time+130/176] inode_update_time+0x82/0xb0
  [__generic_file_aio_write_nolock+595/1152] __generic_file_aio_write_nolock+0x253/0x480
  [generic_file_aio_write_nolock+55/144] generic_file_aio_write_nolock+0x37/0x90
  [generic_file_aio_write+96/192] generic_file_aio_write+0x60/0xc0
  [ext3_file_write+42/160] ext3_file_write+0x2a/0xa0
  [do_sync_write+171/224] do_sync_write+0xab/0xe0
  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
  [scheduler_tick+269/1184] scheduler_tick+0x10d/0x4a0
  [vfs_write+140/208] vfs_write+0x8c/0xd0
  [sys_write+61/112] sys_write+0x3d/0x70
  [syscall_call+7/11] syscall_call+0x7/0xb
 Code: 14 42 25 ff ff 00 00 89 51 10 8b 3c 24 66 8b 04 47 66 89 41 14 8b 44 24 24 3b 50 58 73 06 4e 83 fe ff 75 b5 8b 51 04
 01 10 00 c7 41 04 00 02 20 00 66 83 79 14 ff
  <6>note: cp[7568] exited with preempt_count 1
 Assertion failure in journal_start() at fs/jbd/transaction.c:271: "handle->h_transaction->t_journal == journal"
 ------------[ cut here ]------------
 kernel BUG at fs/jbd/transaction.c:271!
 invalid operand: 0000 [#2]
 PREEMPT SMP
 Modules linked in: w83627hf lm75 eeprom i2c_sensor i2c_isa 8139cp eth1394 dvb_ttpci saa7146_vv saa7146 ves1820 stv0299 tda8083 stv0297 sp8870 ves1x93 ttpci_eeprom ohci1394 ieee1394 snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd snd_page_alloc i2c_i801 ehci_hcd uhci_hcd shpchp pci_hotplug 8250_pnp 8250 serial_core pcspkr tsdev tuner tvaudio msp3400 bttv video_buf firmware_class i2c_algo_bit btcx_risc i2c_core lirc_serial lirc_dev 8139too
 CPU:    1
 EIP:    0060:[journal_start+71/176]    Not tainted
 EFLAGS: 00010246   (2.6.10-lirc)
 EIP is at journal_start+0x47/0xb0
 eax: 00000073   ebx: f69238bc   ecx: ccbc3860   edx: c03e7e20
 esi: f7cade00   edi: ccbc2000   ebp: f2593164   esp: ccbc385c
 ds: 007b   es: 007b   ss: 0068
 Process cp (pid: 7568, threadinfo=ccbc2000 task=e4d90a20)
 Stack: c03e7e20 c03cbe02 c03e4c5a 0000010f c03ea860 c1be2400 f69238bc f2593164
        c0191cc4 f7cade00 00000002 00000001 41d428b6 24a3b2da c0173b3b f2593164
        00000001 00009033 00009033 c1be2400 f2593164 41d428b6 24a3b2da 00000001
 Call Trace:
  [ext3_dirty_inode+36/112] ext3_dirty_inode+0x24/0x70
  [__mark_inode_dirty+411/432] __mark_inode_dirty+0x19b/0x1b0
  [inode_update_time+161/176] inode_update_time+0xa1/0xb0
  [__generic_file_aio_write_nolock+538/1152] __generic_file_aio_write_nolock+0x21a/0x480
  [generic_file_aio_write_nolock+55/144] generic_file_aio_write_nolock+0x37/0x90
  [generic_file_aio_write+96/192] generic_file_aio_write+0x60/0xc0
  [ext3_file_write+42/160] ext3_file_write+0x2a/0xa0
  [do_sync_write+171/224] do_sync_write+0xab/0xe0
  [getnstimeofday+15/48] getnstimeofday+0xf/0x30
  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
  [do_posix_clock_monotonic_gettime+16/64] do_posix_clock_monotonic_gettime+0x10/0x40
  [do_acct_process+872/912] do_acct_process+0x368/0x390
  [acct_process+59/82] acct_process+0x3b/0x52
  [do_exit+1029/1136] do_exit+0x405/0x470
  [die+361/368] die+0x169/0x170
  [do_page_fault+490/1418] do_page_fault+0x1ea/0x58a
  [do_page_fault+0/1418] do_page_fault+0x0/0x58a
  [do_page_fault+514/1418] do_page_fault+0x202/0x58a
  [__getblk+23/48] __getblk+0x17/0x30
  [ext3_do_update_inode+332/912] ext3_do_update_inode+0x14c/0x390
  [ext3_do_update_inode+382/912] ext3_do_update_inode+0x17e/0x390
  [ext3_mark_iloc_dirty+27/48] ext3_mark_iloc_dirty+0x1b/0x30
  [ext3_mark_inode_dirty+46/64] ext3_mark_inode_dirty+0x2e/0x40
  [do_get_write_access+665/1616] do_get_write_access+0x299/0x650
  [do_page_fault+0/1418] do_page_fault+0x0/0x58a
  [error_code+43/48] error_code+0x2b/0x30
  [cache_alloc_refill+258/560] cache_alloc_refill+0x102/0x230
  [kmem_cache_alloc+56/64] kmem_cache_alloc+0x38/0x40
  [alloc_buffer_head+19/96] alloc_buffer_head+0x13/0x60
  [alloc_page_buffers+30/144] alloc_page_buffers+0x1e/0x90
  [create_empty_buffers+24/144] create_empty_buffers+0x18/0x90
  [__block_prepare_write+883/960] __block_prepare_write+0x373/0x3c0
  [block_prepare_write+32/48] block_prepare_write+0x20/0x30
  [ext3_get_block+0/112] ext3_get_block+0x0/0x70
  [ext3_prepare_write+88/272] ext3_prepare_write+0x58/0x110
  [ext3_get_block+0/112] ext3_get_block+0x0/0x70
  [generic_file_buffered_write+415/1536] generic_file_buffered_write+0x19f/0x600
  [update_atime+110/176] update_atime+0x6e/0xb0
  [inode_update_time+130/176] inode_update_time+0x82/0xb0
  [__generic_file_aio_write_nolock+595/1152] __generic_file_aio_write_nolock+0x253/0x480
  [generic_file_aio_write_nolock+55/144] generic_file_aio_write_nolock+0x37/0x90
  [generic_file_aio_write+96/192] generic_file_aio_write+0x60/0xc0
  [ext3_file_write+42/160] ext3_file_write+0x2a/0xa0
  [do_sync_write+171/224] do_sync_write+0xab/0xe0
  [autoremove_wake_function+0/64] autoremove_wake_function+0x0/0x40
  [scheduler_tick+269/1184] scheduler_tick+0x10d/0x4a0
  [vfs_write+140/208] vfs_write+0x8c/0xd0
  [sys_write+61/112] sys_write+0x3d/0x70
  [syscall_call+7/11] syscall_call+0x7/0xb
 Code: ff 74 3c 85 db 74 3c 8b 03 39 30 74 29 68 60 a8 3e c0 68 0f 01 00 00 68 5a 4c 3e c0 68 02 be 3c c0 68 20 7e 3e c0 e8
 3e c0 83 c4 14 8b 73 08 46 89 73 08 89 d8 5b
  <6>note: cp[7568] exited with preempt_count 1


Meanwhile, because of the trouble, I gave Alans patch-2.6.10-ac1 a try
and again put ext3 on dm-crypt on raid5, and: No crash so far despite
moving and removing ~100 gigabytes a couple of times on to/from the
partition.

Let's keep the fingers crossed this will hold.


I did however get occasional

 EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #37306376: directory entry across blocks - offset=0, inode=3350155169, rec_len=11148, name_len=1
 Aborting journal on device dm-0.
 ext3_abort called.
 EXT3-fs error (device dm-0): ext3_journal_start_sb: Detected aborted journal
 Remounting filesystem read-only
 EXT3-fs error (device dm-0) in start_transaction: Journal has aborted
 EXT3-fs error (device dm-0) in ext3_ordered_writepage: IO failure
 __journal_remove_journal_head: freeing b_committed_data
 __journal_remove_journal_head: freeing b_frozen_data
 __journal_remove_journal_head: freeing b_committed_data
 __journal_remove_journal_head: freeing b_frozen_data

messages, leaving the partition intact, but mounted read-only.

These seem to be related to the bttv being in use. I got lots of

 bttv0: OCERR @ 36a09014,bits: HSYNC OFLOW RISCI* FBUS OCERR*
 bttv0: OCERR @ 36a09014,bits: HSYNC OFLOW OCERR*
 bttv0: OCERR @ 36a09000,bits: HSYNC OFLOW OCERR*
 bttv0: OCERR @ 36a09014,bits: OFLOW OCERR*
 bttv0: OCERR @ 36a09000,bits: HSYNC OFLOW OCERR*
 bttv0: IRQ lockup, cleared int mask [bits: HSYNC OFLOW OCERR*]
 bttv0: timeout: drop=0 irq=139531/451361, risc=36a09014, bits: VSYNC HSYNC OFLOW FBUS OCERR SCERR
 bttv0: reset, reinitialize
 bttv0: PLL: 28636363 => 35468950 . ok

messages (once per 0.5 seconds or so) until I stopped the mythtv
process that used the bttv card. Ever since I have also not seen the
problems with EXT3 and it remained mounted as read/write.


In essence: Whatever Alan put into his -ac1 patch helped, but there
still seems to be some sort of IRQ/driver/coordination problem with
the DVB code.

Hope this helps -- if you need more info, please let me know.

Regards,
Georg

-- 
Georg C. F. Greve                                 <greve@fsfeurope.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
GNU Business Network                        (http://mailman.gnubiz.org)
Brave GNU World	                           (http://brave-gnu-world.org)

--20041230230458+01002037820786202264-36642645
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.3.92 (GNU/Linux)

iD8DBQBB1HuKbvivwoZXSsoRApYuAJ0cxDyCoUKIbLfy0sYHOSJniTAOHQCcDHQP
WQM+DyJj6e8bMWZAaXBQ2E0=
=65ED
-----END PGP SIGNATURE-----
--20041230230458+01002037820786202264-36642645--
