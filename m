Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWGVQUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWGVQUs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWGVQUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:20:48 -0400
Received: from pih-relay06.plus.net ([212.159.14.133]:62879 "EHLO
	pih-relay06.plus.net") by vger.kernel.org with ESMTP
	id S1750863AbWGVQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:20:47 -0400
Message-ID: <44C2505A.4010308@mauve.plus.com>
Date: Sat, 22 Jul 2006 17:20:42 +0100
From: Ian Stirling <tandra@mauve.plus.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB snd-usb-audio wedges lsusb when unplugged while playing sound.
References: <44C21635.5090808@mauve.plus.com> <20060722084429.6d00217b.akpm@osdl.org>
In-Reply-To: <20060722084429.6d00217b.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------050301030907000309070101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050301030907000309070101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Sat, 22 Jul 2006 13:12:37 +0100
> Ian Stirling <tandra@mauve.plus.com> wrote:
> 
> 
>>Config/... as my earlier message on USB - though with the bandwidth 
>>enforcement
>>turned off so it actually plays sound, when plugged into the USB1 port.
>>
>>2.6.17.
>>
>>Basically - playing sound with
>>mplayer -ao alsa:device=hw=1 or whatever - and then unplugging the
>>soundcard completely wedges lsusb/usb configuration, until the mplayer 
>>process is killed.
>>
>>cat /proc/bus/usb/devices stalls.
> 
> 
> Please get the machine into the wedged state, then do
> 
> 	dmesg -c
> 	echo t > /proc/sysrq-trigger
> 	dmesg -s 1000000 > foo
> 
> then send foo, thanks.


--------------050301030907000309070101
Content-Type: text/plain;
 name="foo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo"

dma_pool_free+0x6b/0xea
 <c0106f24> convert_fxsr_to_user+0xdb/0x16c  <c0138c80> free_hot_cold_page+0xff/0x14d
 <c013f6c5> zap_pte_range+0x9d/0x212  <c013f931> unmap_page_range+0xf7/0x11c
 <c013f134> free_pgtables+0x74/0x84  <c0126dd6> remove_wait_queue+0x39/0x52
 <c0119003> do_wait+0x1e7/0x3a2  <c01120cc> default_wake_function+0x0/0x12
 <c01120cc> default_wake_function+0x0/0x12  <c016271f> sys_poll+0x44/0x48
 <c0102d4f> syscall_call+0x7/0xb 
firefox-bin   S C011D801     0  5781   5780          5782       (NOTLB)
       c446fbd8 c446fd64 00000000 c011d801 c446fbe8 00000000 a07aa500 003d17bd 
       c037f0e0 c485aa30 c485ab38 c446fbe8 803dd3bb c446fd50 c446fc50 c030e9fc 
       c446fbe8 803dd3bb c040a448 c040a448 803dd3bb c011e083 c485aa30 c0409540 
Call Trace:
 <c011d801> lock_timer_base+0x20/0x52  <c030e9fc> schedule_timeout+0x45/0x8e
 <c011e083> process_timeout+0x0/0x9  <c01623fe> do_poll+0x5a/0x113
 <c0162468> do_poll+0xc4/0x113  <c0162609> do_sys_poll+0x152/0x224
 <c011d801> lock_timer_base+0x20/0x52  <c011d8ca> __mod_timer+0x97/0xc9
 <c011a677> local_bh_enable+0x39/0x8b  <c89ea7f1> zdcb_check_tcb_avail+0x51/0x90 [zd1211]
 <c89f3fce> SendPkt+0xce/0x1d0 [zd1211]  <c89eef4a> zd_SendPkt+0xfa/0x1f0 [zd1211]
 <c89e3e6f> zd1205_xmit_frame+0x8f/0x490 [zd1211]  <c0161726> __pollwait+0x0/0x4b
 <c01120cc> default_wake_function+0x0/0x12  <c011a677> local_bh_enable+0x39/0x8b
 <c02b421c> dev_queue_xmit+0xc4/0x23b  <c02cafd7> ip_output+0x147/0x215
 <c02cb30f> ip_queue_xmit+0x26a/0x461  <c895270d> snd_complete_urb+0x69/0x87 [snd_usb_audio]
 <c8884553> usb_hcd_giveback_urb+0x19/0x4a [usbcore]  <c8884c40> usb_free_urb+0x13/0x16 [usbcore]
 <c0126f33> autoremove_wake_function+0x0/0x3a  <c8906ae8> scan_periodic+0x1fd/0x27e [ehci_hcd]
 <c02dfaad> tcp_v4_send_check+0x3c/0xc9  <c011d801> lock_timer_base+0x20/0x52
 <c011d8ca> __mod_timer+0x97/0xc9  <c02ae64b> sk_reset_timer+0x12/0x1d
 <c02dc433> tcp_write_xmit+0x17a/0x272  <c02dc54e> __tcp_push_pending_frames+0x23/0x80
 <c02dd1a5> tcp_send_fin+0x40/0xbe  <c02aad4e> sock_destroy_inode+0x13/0x16
 <c01de623> _atomic_dec_and_lock+0x2b/0x48  <c016a131> mntput_no_expire+0x14/0x91
 <c01510d4> __fput+0x157/0x1a3  <c01e296a> copy_to_user+0x30/0x44
 <c016271f> sys_poll+0x44/0x48  <c0102d4f> syscall_call+0x7/0xb
firefox-bin   S 3711C5ED     0  5782   5780         15495  5781 (NOTLB)
       c36abf18 00000f06 c03848e8 3711c5ed 00000f06 00000000 1ba04d00 003d17c0 
       c037f0e0 c485a050 c485a158 c36aa000 c36abf58 00000000 00000000 c030f7d0 
       c36abf58 02fabdb8 00000000 00000001 00000000 c36abf58 00000001 c0129c04 
Call Trace:
 <c030f7d0> do_nanosleep+0x3f/0x67  <c0129c04> hrtimer_nanosleep+0x4c/0x105
 <c0129b89> hrtimer_wakeup+0x0/0x1c  <c01e29b8> copy_from_user+0x3a/0x66
 <c0129d05> sys_nanosleep+0x48/0x4f  <c0102d4f> syscall_call+0x7/0xb
xpdf          S 003D17BF     0  5808   3790                     (NOTLB)
       c23b3b58 c3b4a050 3278afb4 003d17bf c6574520 00000000 77d52600 003d17bf 
       c6574520 c2f830b0 c2f831b8 7fffffff 00000000 00000010 00000000 c030ea43 
       c68fa918 c23b3bd0 c4f20280 00000000 c02aba36 c4f20280 c68fa900 c23b3bd0 
Call Trace:
 <c030ea43> schedule_timeout+0x8c/0x8e  <c02aba36> sock_poll+0x13/0x17
 <c0161a26> do_select+0x1ea/0x355  <c0161726> __pollwait+0x0/0x4b
 <c01120cc> default_wake_function+0x0/0x12  <c8906b36> scan_periodic+0x24b/0x27e [ehci_hcd]
 <c890302d> qh_destroy+0x0/0x78 [ehci_hcd]  <c8906cf0> ehci_work+0x4f/0xb7 [ehci_hcd]
 <c02458ac> dma_pool_alloc+0x10c/0x15a  <c02b4432> netif_rx+0x9f/0xc4
 <c01116d3> activate_task+0x27/0x68  <c01115c9> __activate_task+0x1a/0x26
 <c0111773> try_to_wake_up+0x3e/0xc7  <c0112109> __wake_up_common+0x2b/0x4e
 <c02fbb80> unix_stream_recvmsg+0xe6/0x3dd  <c012a81c> debug_mutex_add_waiter+0x1c/0x2e
 <c02fbb80> unix_stream_recvmsg+0xe6/0x3dd  <c030f1b4> __mutex_unlock_slowpath+0xd7/0x1f7
 <c02fbc88> unix_stream_recvmsg+0x1ee/0x3dd  <c01e29b8> copy_from_user+0x3a/0x66
 <c0161d9d> core_sys_select+0x20c/0x36e  <c0150167> do_sync_read+0xb7/0xf5
 <c02fc07f> unix_ioctl+0x8f/0xce  <c02ab8dc> sock_ioctl+0x96/0x1b6
 <c0161f89> sys_select+0x8a/0x190  <c0119d31> sys_gettimeofday+0x22/0x57
 <c0102d4f> syscall_call+0x7/0xb 
scsi_eh_7     S C030DE2B     0 14599      6         14601  2183 (L-TLB)
       c55b5fb4 c7bfbd6c c55b5fc0 c030de2b c3f80a10 00000000 209a7200 003d1364 
       c3f80a10 c1e44a50 c1e44b58 c6246800 c7bfbd6c c6246800 c0262400 c026247b 
       c55b4000 c0126af9 c6246800 fffffffc 00000001 ffffffff ffffffff c0126a59 
Call Trace:
 <c030de2b> schedule+0x3d5/0x625  <c0262400> scsi_error_handler+0x0/0xa6
 <c026247b> scsi_error_handler+0x7b/0xa6  <c0126af9> kthread+0xa0/0xa7
 <c0126a59> kthread+0x0/0xa7  <c010134d> kernel_thread_helper+0x5/0xb
usb-storage   S 003D17AC     0 14601      6               14599 (L-TLB)
       c7727f34 c5fc9000 05a71600 003d17ac c112c520 00000000 05a71600 003d17ac 
       c112c520 c686aa70 c686ab78 c6246b64 c7726000 00000246 c686aa70 c030fd49 
       00000000 00000001 c686aa70 c01120cc c6246b6c c6246b6c c6246aac c7727f6c 
Call Trace:
 <c030fd49> __down_interruptible+0xad/0x141  <c01120cc> default_wake_function+0x0/0x12
 <c0111809> wake_up_process+0xd/0xf  <c030da3b> __down_failed_interruptible+0x7/0xc
 <c882350e> .text.lock.usb+0xb/0x21 [usb_storage]  <c030de2b> schedule+0x3d5/0x625
 <c8822aa6> usb_stor_control_thread+0x0/0x1b3 [usb_storage]  <c0126af9> kthread+0xa0/0xa7
 <c0126a59> kthread+0x0/0xa7  <c010134d> kernel_thread_helper+0x5/0xb
loop0         S 00000000     0 14969      1                5766 (L-TLB)
       c3371f78 00000000 00000000 00000000 c1e44560 00000000 f5abbc00 003d17a7 
       c1e44560 c2f835a0 c2f836a8 c7484104 c3370000 c3371fbc c3371fd4 c030e408 
       c53047f0 00000000 00000000 c2f835a0 c01120cc 00000000 00000000 c885b1af 
Call Trace:
 <c030e408> wait_for_completion_interruptible+0x9f/0x11f  <c01120cc> default_wake_function+0x0/0x12
 <c885b1af> do_lo_send_aops+0x0/0x1ee [loop]  <c015455a> end_bio_bh_io_sync+0x2d/0x47
 <c01120cc> default_wake_function+0x0/0x12  <c885b9bf> loop_thread+0x5a/0x121 [loop]
 <c885b965> loop_thread+0x0/0x121 [loop]  <c010134d> kernel_thread_helper+0x5/0xb
firefox-bin   S A48F4E45     0 15495   5780                5782 (NOTLB)
       c6bbff18 00000f12 c03848e8 a48f4e45 c485a540 00000000 93aa8100 003d17be 
       c485a540 c32dca70 c32dcb78 c6bbe000 c6bbff58 00000000 00000000 c030f7d0 
       c6bbff58 f8471980 0000000d 00000001 00000000 c6bbff58 00000001 c0129c04 
Call Trace:
 <c030f7d0> do_nanosleep+0x3f/0x67  <c0129c04> hrtimer_nanosleep+0x4c/0x105
 <c0101968> __switch_to+0x1c/0x1ac  <c0129b89> hrtimer_wakeup+0x0/0x1c
 <c01e29b8> copy_from_user+0x3a/0x66  <c0129d05> sys_nanosleep+0x48/0x4f
 <c0102d4f> syscall_call+0x7/0xb 
mplayer       S 003D17C0     0 15525   2523                     (NOTLB)
       c49c1f18 00000f06 1cd17a00 003d17c0 c485a540 00000000 1cd17a00 003d17c0 
       c485a540 c32dc580 c32dc688 c49c0000 c49c1f58 00000000 00000000 c030f7d0 
       c49c1f58 00989680 00000000 00000001 00000000 c49c1f58 00000001 c0129c04 
Call Trace:
 <c030f7d0> do_nanosleep+0x3f/0x67  <c0129c04> hrtimer_nanosleep+0x4c/0x105
 <c023315f> write_chan+0x0/0x1f7  <c0129b89> hrtimer_wakeup+0x0/0x1c
 <c01e29b8> copy_from_user+0x3a/0x66  <c0129d05> sys_nanosleep+0x48/0x4f
 <c0102d4f> syscall_call+0x7/0xb 
script        S 00000000     0 15530   3741 15531               (NOTLB)
       c2ba9ea4 c012a81c c7ad4bc4 00000000 c48e4580 00000000 1c576800 003d17c0 
       c48e4580 c32dc090 c32dc198 7fffffff c7ad4800 c1e07e00 c7ad4800 c030ea43 
       22222222 22222222 22222222 c2ba9f10 c7ad4930 c7ad4800 c0126d33 c7ad480c 
Call Trace:
 <c012a81c> debug_mutex_add_waiter+0x1c/0x2e  <c030ea43> schedule_timeout+0x8c/0x8e
 <c0126d33> add_wait_queue+0x33/0x4e  <c0232df1> read_chan+0x21e/0x58c
 <c01120cc> default_wake_function+0x0/0x12  <c011a331> current_fs_time+0x3c/0x53
 <c01120cc> default_wake_function+0x0/0x12  <c022d95b> tty_ldisc_deref+0x34/0x7d
 <c022e6d0> tty_read+0x9f/0xa6  <c0150230> vfs_read+0x8b/0x11f
 <c0150513> sys_read+0x3b/0x65  <c0102d4f> syscall_call+0x7/0xb
script        S 003D17C0     0 15531  15530 15532               (NOTLB)
       c64bbea4 c012a81c 1c947100 003d17c0 c686a580 00000000 1c947100 003d17c0 
       c686a580 c686a090 c686a198 7fffffff c4c22800 c40d4dc0 c4c22800 c030ea43 
       22222222 22222222 22222222 c64bbf10 c4c22930 c4c22800 c0126d33 c4c2280c 
Call Trace:
 <c012a81c> debug_mutex_add_waiter+0x1c/0x2e  <c030ea43> schedule_timeout+0x8c/0x8e
 <c0126d33> add_wait_queue+0x33/0x4e  <c0232df1> read_chan+0x21e/0x58c
 <c01120cc> default_wake_function+0x0/0x12  <c011a331> current_fs_time+0x3c/0x53
 <c01120cc> default_wake_function+0x0/0x12  <c022d95b> tty_ldisc_deref+0x34/0x7d
 <c022e6d0> tty_read+0x9f/0xa6  <c0150230> vfs_read+0x8b/0x11f
 <c0150513> sys_read+0x3b/0x65  <c0102d4f> syscall_call+0x7/0xb
bash          R running     0 15532  15531                     (NOTLB)

Showing all blocking locks in the system:
S            init:    1 [c112ca10, 115] (not blocked on mutex)
S     ksoftirqd/0:    2 [c112c520, 134] (not blocked on mutex)
S      watchdog/0:    3 [c112c030,   0] (not blocked on mutex)
S        events/0:    4 [c7f88a30, 110] (not blocked on mutex)
S         khelper:    5 [c7f88540, 111] (not blocked on mutex)
S         kthread:    6 [c7f88050, 110] (not blocked on mutex)
S       kblockd/0:    8 [c7f99560, 110] (not blocked on mutex)
S          kacpid:    9 [c7f99070, 110] (not blocked on mutex)
S         kseriod:   77 [c7f99a50, 110] (not blocked on mutex)
S         pdflush:  119 [c7f5e5c0, 115] (not blocked on mutex)
S         pdflush:  120 [c7f5e0d0, 115] (not blocked on mutex)
S         kswapd0:  121 [c7f60ad0, 115] (not blocked on mutex)
S           aio/0:  122 [c7f605e0, 117] (not blocked on mutex)
S           ata/0:  722 [c11dca70, 111] (not blocked on mutex)
S       kpsmoused:  732 [c7f5eab0, 111] (not blocked on mutex)
D           khubd: 1028 [c11ba090, 110] (not blocked on mutex)
S         pccardd: 1471 [c11f0580, 115] (not blocked on mutex)
S     rpc.portmap: 2131 [c11d4520, 115] (not blocked on mutex)
S         syslogd: 2134 [c7f42050, 115] (not blocked on mutex)
R           klogd: 2149 [c7f64a30, 115] (not blocked on mutex)
S           inetd: 2152 [c11f0090, 120] (not blocked on mutex)
S            sshd: 2155 [c7f65070, 121] (not blocked on mutex)
S     rpc.rquotad: 2171 [c11d4a10, 118] (not blocked on mutex)
S            nfsd: 2173 [c7f49a90, 115] (not blocked on mutex)
S            nfsd: 2174 [c7f495a0, 115] (not blocked on mutex)
S            nfsd: 2175 [c7f490b0, 115] (not blocked on mutex)
S            nfsd: 2176 [c11dc580, 115] (not blocked on mutex)
S            nfsd: 2177 [c11ba580, 115] (not blocked on mutex)
S            nfsd: 2178 [c7f64050, 115] (not blocked on mutex)
S            nfsd: 2179 [c7f600f0, 115] (not blocked on mutex)
S            nfsd: 2180 [c11dc090, 115] (not blocked on mutex)
S           lockd: 2182 [c7f65a50, 120] (not blocked on mutex)
S        rpciod/0: 2183 [c7f42540, 111] (not blocked on mutex)
S      rpc.mountd: 2184 [c11f0a70, 118] (not blocked on mutex)
S       rpc.statd: 2187 [c7198110, 120] (not blocked on mutex)
S             lpd: 2370 [c6622070, 116] (not blocked on mutex)
S           crond: 2373 [c65c8540, 116] (not blocked on mutex)
S             atd: 2375 [c11baa70, 116] (not blocked on mutex)
S             gpm: 2382 [c65c8a30, 115] (not blocked on mutex)
S            ntpd: 2386 [c7198600, 115] (not blocked on mutex)
S           rsync: 2387 [c6574030, 121] (not blocked on mutex)
S           loop6: 2512 [c66d7580, 100] (not blocked on mutex)
S            bash: 2523 [c6746a90, 115] (not blocked on mutex)
S            bash: 2524 [c7f65560, 115] (not blocked on mutex)
S            bash: 2532 [c65c8050, 116] (not blocked on mutex)
S          agetty: 2550 [c6622a50, 116] (not blocked on mutex)
S          agetty: 2563 [c537b5e0, 116] (not blocked on mutex)
S          agetty: 2574 [c67460b0, 116] (not blocked on mutex)
S          startx: 2623 [c67465a0, 116] (not blocked on mutex)
S           xinit: 2635 [c66d7090, 116] (not blocked on mutex)
S               X: 2636 [c66d7a70, 114] (not blocked on mutex)
S          fvwm95: 2653 [c6574520, 115] (not blocked on mutex)
S           xlock: 2664 [c3bc3a50, 126] (not blocked on mutex)
S       xautolock: 2665 [c3bc3560, 115] (not blocked on mutex)
S     FvwmButtons: 2666 [c3bc3070, 115] (not blocked on mutex)
S     FvwmTaskBar: 2667 [c3bafa70, 115] (not blocked on mutex)
S       FvwmPager: 2669 [c3b4a540, 115] (not blocked on mutex)
S           xload: 2670 [c537b0f0, 131] (not blocked on mutex)
S           xterm: 2671 [c537bad0, 115] (not blocked on mutex)
S            bash: 2692 [c7f64540, 118] (not blocked on mutex)
S           xterm: 2712 [c3b4a050, 115] (not blocked on mutex)
S            bash: 2714 [c7f42a30, 115] (not blocked on mutex)
S             ssh: 3735 [c48e4a70, 115] (not blocked on mutex)
S           xterm: 3739 [c48e4580, 115] (not blocked on mutex)
S            bash: 3741 [c3baf580, 115] (not blocked on mutex)
S            gaim: 3754 [c6622560, 115] (not blocked on mutex)
S           xterm: 3788 [c6574a10, 115] (not blocked on mutex)
S            bash: 3790 [c3b4aa30, 115] (not blocked on mutex)
S         cardmgr: 4209 [c7855090, 119] (not blocked on mutex)
S         firefox: 5766 [c7855a70, 121] (not blocked on mutex)
S  run-mozilla.sh: 5770 [c7198af0, 123] (not blocked on mutex)
S     firefox-bin: 5775 [c485a540, 115] (not blocked on mutex)
S     firefox-bin: 5780 [c3baf090, 115] (not blocked on mutex)
S     firefox-bin: 5781 [c485aa30, 115] (not blocked on mutex)
S     firefox-bin: 5782 [c485a050, 115] (not blocked on mutex)
S            xpdf: 5808 [c2f830b0, 115] (not blocked on mutex)
S       scsi_eh_7:14599 [c1e44a50, 111] (not blocked on mutex)
S     usb-storage:14601 [c686aa70, 110] (not blocked on mutex)
S           loop0:14969 [c2f835a0, 100] (not blocked on mutex)
S     firefox-bin:15495 [c32dca70, 115] (not blocked on mutex)
S         mplayer:15525 [c32dc580, 115] (not blocked on mutex)
S          script:15530 [c32dc090, 115] (not blocked on mutex)
S          script:15531 [c686a090, 116] (not blocked on mutex)
R            bash:15532 [c686a580, 116] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [c52473c4] {initialize_tty_struct}
.. held by:            agetty: 2550 [c6622a50, 116]
... acquired at:               read_chan+0x531/0x58c

#002:             [c5177bc4] {initialize_tty_struct}
.. held by:            agetty: 2563 [c537b5e0, 116]
... acquired at:               read_chan+0x531/0x58c

#003:             [c51773c4] {initialize_tty_struct}
.. held by:            agetty: 2574 [c67460b0, 116]
... acquired at:               read_chan+0x531/0x58c

#004:             [c37c1bc4] {initialize_tty_struct}
.. held by:              bash: 2692 [c7f64540, 118]
... acquired at:               read_chan+0x531/0x58c

#005:             [c5247bc4] {initialize_tty_struct}
.. held by:              bash: 2532 [c65c8050, 116]
... acquired at:               read_chan+0x531/0x58c

#006:             [c549b3c4] {initialize_tty_struct}
.. held by:              bash: 2524 [c7f65560, 115]
... acquired at:               read_chan+0x531/0x58c

#007:             [c7ad4bc4] {initialize_tty_struct}
.. held by:            script:15530 [c32dc090, 115]
... acquired at:               read_chan+0x531/0x58c

#008:             [c4c22bc4] {initialize_tty_struct}
.. held by:            script:15531 [c686a090, 116]
... acquired at:               read_chan+0x531/0x58c

=============================================


--------------050301030907000309070101--
