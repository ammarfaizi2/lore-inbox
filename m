Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVFLNvO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVFLNvO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFLNvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:51:13 -0400
Received: from pooh.kjernsmo.net ([217.77.32.186]:48074 "EHLO
	pooh.kjernsmo.net") by vger.kernel.org with ESMTP id S262586AbVFLNtZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:49:25 -0400
From: Kjetil Kjernsmo <kjetil@kjernsmo.net>
To: linux-kernel@vger.kernel.org
Subject: Debian 2.6.8-16 kernel BUG at fs/jbd/checkpoint.c:618
Date: Sun, 12 Jun 2005 15:48:47 +0200
User-Agent: KMail/1.7.2
OpenPGP: id=0x5AA3F2C5FFBEA046CEEACB6D944FC6A76A6A0BBC; url=http://www.kjetil.kjernsmo.net/pgp.asc
X-FOAF: http://www.kjetil.kjernsmo.net/foaf.rdf
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506121548.48084.kjetil@kjernsmo.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel-hackers!

I've just had a scary experience, they are fortunately rare! :-)
I'm running what is now Debian Stable, a self-compiled but unpatched 
Debian 2.6.8-16 kernel.
 
The first symptom I saw was that Emacs segfaulted on me and while I was 
pondering how scary _that_ was, the whole system froze on me. 
Rebooting, I saw the following in kern.log. Since it shouts it is a 
kernel bug, I took that as invitiation to post here. 

My paste begins before the "cut here", as I just before the crash 
experienced problems when using a PL-2303 converter. I got a new 
USB2/FireWire card in the door yesterday, and there were apparently 
problems with using the pl2303 with it. It still works fine with the 
old USB1 on my mobo. I have no idea if it is relevant, but I thought 
I'd include it. 

I haven't included my .config though, this message is large enough as it 
is, I suppose... It is of course available upon request, but please CC 
any replies, I'm not subscribed.

Here is the kern.log excerpt:

Jun 12 14:52:53 owl kernel: pl2303 1-3.1:1.0: PL-2303 converter detected
Jun 12 14:52:53 owl kernel: usb 1-3.1: PL-2303 converter now attached to 
ttyUSB0
Jun 12 14:52:53 owl usb.agent[4337]:      pl2303: already loaded
Jun 12 14:52:53 owl udev[4361]: configured rule in 
'/etc/udev/rules.d/compat-full.rules[8]' applied, added symlink '%k'
Jun 12 14:52:53 owl udev[4361]: configured rule in 
'/etc/udev/rules.d/devfs.rules[46]' applied, 'ttyUSB0' becomes 
'tts/USB%n'
Jun 12 14:52:53 owl udev[4361]: creating device node '/dev/tts/USB0'
Jun 12 14:53:01 owl /USR/SBIN/CRON[4376]: (mail) CMD (  if 
[ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; 
then /usr/lib/exim/exim3 -q ; fi)
Jun 12 14:53:16 owl kernel: PL-2303 ttyUSB0: pl2303_open - failed 
submitting interrupt urb, error -28
Jun 12 14:53:16 owl kernel: PL-2303 ttyUSB0: PL-2303 converter now 
disconnected from ttyUSB0
Jun 12 14:53:16 owl udev[4382]: removing device node '/dev/tts/USB0'
Jun 12 14:57:15 owl kernel: usb 1-3.1: USB disconnect, address 6
Jun 12 14:57:15 owl kernel: pl2303 1-3.1:1.0: device disconnected
Jun 12 14:57:30 owl kernel: usb 2-2: new full speed USB device using 
address 2
Jun 12 14:57:30 owl kernel: pl2303 2-2:1.0: PL-2303 converter detected
Jun 12 14:57:30 owl kernel: usb 2-2: PL-2303 converter now attached to 
ttyUSB0
Jun 12 14:57:31 owl udev[4509]: configured rule in 
'/etc/udev/rules.d/compat-full.rules[8]' applied, added symlink '%k'
Jun 12 14:57:31 owl udev[4509]: configured rule in 
'/etc/udev/rules.d/devfs.rules[46]' applied, 'ttyUSB0' becomes 
'tts/USB%n'
Jun 12 14:57:31 owl udev[4509]: creating device node '/dev/tts/USB0'
Jun 12 14:57:31 owl usb.agent[4493]:      pl2303: already loaded
Jun 12 14:57:55 owl kernel: Assertion failure in 
__journal_drop_transaction() at fs/jbd/checkpoint.c:618: 
"transaction->t_updates == 0"
Jun 12 14:57:55 owl kernel: ------------[ cut here ]------------
Jun 12 14:57:55 owl kernel: kernel BUG at fs/jbd/checkpoint.c:618!
Jun 12 14:57:55 owl kernel: invalid operand: 0000 [#1]
Jun 12 14:57:55 owl kernel: PREEMPT 
Jun 12 14:57:55 owl kernel: Modules linked in: pl2303 usbserial nfs 
lockd sunrpc ppp_deflate bsd_comp ppp_async crc_ccitt ipv6 ppp_generic 
slhc ipt_MASQUERADE iptable_nat ipt_LOG iptable_filter eth1394 ohci1394 
ieee1394 lp apm 8139too mii sd_mod
Jun 12 14:57:55 owl kernel: CPU:    0
Jun 12 14:57:55 owl kernel: EIP:    0060:
[__journal_drop_transaction+432/899]    Not tainted
Jun 12 14:57:55 owl kernel: EFLAGS: 00010286   
(2.6.8-16.2005-11-06.owl.1.oss.mods) 
Jun 12 14:57:55 owl kernel: EIP is at 
__journal_drop_transaction+0x1b0/0x383
Jun 12 14:57:55 owl kernel: eax: 0000006f   ebx: dfc86860   ecx: 
c03508b8   edx: c03508b8
Jun 12 14:57:55 owl kernel: esi: dffd9c80   edi: dfd98000   ebp: 
cbda2960   esp: dfd99da0
Jun 12 14:57:55 owl kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 14:57:55 owl kernel: Process kjournald (pid: 1079, 
threadinfo=dfd98000 task=c15c0600)
Jun 12 14:57:55 owl kernel: Stack: c03107a0 c02fcdd5 c030f10b 0000026a 
c030f12c dfc86860 dffd9c80 c019716a 
Jun 12 14:57:55 owl kernel:        dffd9c80 dfc86860 d655de6c d6acc7dc 
c019551f d655de6c cbda2960 00000003 
Jun 12 14:57:55 owl kernel:        00001f11 c011f1a2 c011faeb dfd98000 
00000000 0000001c 00000000 00000f94 
Jun 12 14:57:55 owl kernel: Call Trace:
Jun 12 14:57:55 owl kernel:  [__journal_remove_checkpoint+74/144] 
__journal_remove_checkpoint+0x4a/0x90
Jun 12 14:57:55 owl kernel:  [journal_commit_transaction+1823/4544] 
journal_commit_transaction+0x71f/0x11c0
Jun 12 14:57:55 owl kernel:  [signal_wake_up+34/48] 
signal_wake_up+0x22/0x30
Jun 12 14:57:55 owl kernel:  [__group_send_sig_info+171/224] 
__group_send_sig_info+0xab/0xe0
Jun 12 14:57:55 owl kernel:  [it_real_fn+0/96] it_real_fn+0x0/0x60
Jun 12 14:57:55 owl kernel:  [send_group_sig_info+49/96] 
send_group_sig_info+0x31/0x60
Jun 12 14:57:55 owl kernel:  [it_real_fn+35/96] it_real_fn+0x23/0x60
Jun 12 14:57:55 owl kernel:  [kjournald+208/608] kjournald+0xd0/0x260
Jun 12 14:57:55 owl kernel:  [autoremove_wake_function+0/96] 
autoremove_wake_function+0x0/0x60
Jun 12 14:57:55 owl kernel:  [autoremove_wake_function+0/96] 
autoremove_wake_function+0x0/0x60
Jun 12 14:57:55 owl kernel:  [ret_from_fork+6/20] ret_from_fork+0x6/0x14
Jun 12 14:57:55 owl kernel:  [commit_timeout+0/16] 
commit_timeout+0x0/0x10
Jun 12 14:57:55 owl kernel:  [kjournald+0/608] kjournald+0x0/0x260
Jun 12 14:57:55 owl kernel:  [kernel_thread_helper+5/20] 
kernel_thread_helper+0x5/0x14
Jun 12 14:57:55 owl kernel: Code: 0f 0b 6a 02 0b f1 30 c0 e9 fe fe ff ff 
c7 44 24 10 60 34 31 
Jun 12 14:57:55 owl kernel:  <6>note: kjournald[1079] exited with 
preempt_count 2
Jun 12 14:58:08 owl kernel: Uninitialised timer!
Jun 12 14:58:08 owl kernel: This is just a warning.  Your computer is OK
Jun 12 14:58:08 owl kernel: function=0x63986398, data=0x63986398
Jun 12 14:58:08 owl kernel:  [check_timer_failed+97/112] 
check_timer_failed+0x61/0x70
Jun 12 14:58:08 owl kernel:  [__mod_timer+47/368] __mod_timer+0x2f/0x170
Jun 12 14:58:08 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:08 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:08 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:08 owl kernel:  [journal_dirty_metadata+278/432] 
journal_dirty_metadata+0x116/0x1b0
Jun 12 14:58:08 owl kernel:  [journal_stop+417/656] 
journal_stop+0x1a1/0x290
Jun 12 14:58:08 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:08 owl kernel:  [ext3_setattr+354/464] 
ext3_setattr+0x162/0x1d0
Jun 12 14:58:08 owl kernel:  [notify_change+382/432] 
notify_change+0x17e/0x1b0
Jun 12 14:58:08 owl kernel:  [do_truncate+105/176] do_truncate+0x69/0xb0
Jun 12 14:58:08 owl kernel:  [permission+103/128] permission+0x67/0x80
Jun 12 14:58:08 owl kernel:  [may_open+384/480] may_open+0x180/0x1e0
Jun 12 14:58:08 owl kernel:  [open_namei+165/1520] open_namei+0xa5/0x5f0
Jun 12 14:58:08 owl kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Jun 12 14:58:08 owl kernel:  [get_unused_fd+57/224] 
get_unused_fd+0x39/0xe0
Jun 12 14:58:08 owl kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Jun 12 14:58:08 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:08 owl kernel: Unable to handle kernel paging request at 
virtual address 6398639c
Jun 12 14:58:08 owl kernel:  printing eip:
Jun 12 14:58:08 owl kernel: c011d7c4
Jun 12 14:58:08 owl kernel: *pde = 00000000
Jun 12 14:58:08 owl kernel: Oops: 0002 [#2]
Jun 12 14:58:08 owl kernel: PREEMPT 
Jun 12 14:58:08 owl kernel: Modules linked in: pl2303 usbserial nfs 
lockd sunrpc ppp_deflate bsd_comp ppp_async crc_ccitt ipv6 ppp_generic 
slhc ipt_MASQUERADE iptable_nat ipt_LOG iptable_filter eth1394 ohci1394 
ieee1394 lp apm 8139too mii sd_mod
Jun 12 14:58:08 owl kernel: CPU:    0
Jun 12 14:58:08 owl kernel: EIP:    0060:[__mod_timer+164/368]    Not 
tainted
Jun 12 14:58:08 owl kernel: EFLAGS: 00210002   
(2.6.8-16.2005-11-06.owl.1.oss.mods) 
Jun 12 14:58:08 owl kernel: EIP is at __mod_timer+0xa4/0x170
Jun 12 14:58:08 owl kernel: eax: 63986398   ebx: 63986398   ecx: 
c03520ac   edx: 63986398
Jun 12 14:58:08 owl kernel: esi: dfd99fc0   edi: c0408b00   ebp: 
00200282   esp: d8817d5c
Jun 12 14:58:08 owl kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 14:58:08 owl kernel: Process emacs (pid: 3839, 
threadinfo=d8816000 task=c7a541f0)
Jun 12 14:58:08 owl kernel: Stack: dfd99fc0 cabcfefc 00000000 d64656e0 
dffd9c80 d6465738 dffd9c80 c01924a4 
Jun 12 14:58:08 owl kernel:        dfd99fc0 00fb050b 00000000 d8816000 
c019a055 00000000 00000000 c0192598 
Jun 12 14:58:08 owl kernel:        dffd9c80 d64656e0 00000050 00000001 
00000000 d64656e0 00000003 d5da67cc 
Jun 12 14:58:08 owl kernel: Call Trace:
Jun 12 14:58:08 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:08 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:08 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:08 owl kernel:  [journal_dirty_metadata+278/432] 
journal_dirty_metadata+0x116/0x1b0
Jun 12 14:58:08 owl kernel:  [journal_stop+417/656] 
journal_stop+0x1a1/0x290
Jun 12 14:58:08 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:08 owl kernel:  [ext3_setattr+354/464] 
ext3_setattr+0x162/0x1d0
Jun 12 14:58:08 owl kernel:  [notify_change+382/432] 
notify_change+0x17e/0x1b0
Jun 12 14:58:08 owl kernel:  [do_truncate+105/176] do_truncate+0x69/0xb0
Jun 12 14:58:08 owl kernel:  [permission+103/128] permission+0x67/0x80
Jun 12 14:58:08 owl kernel:  [may_open+384/480] may_open+0x180/0x1e0
Jun 12 14:58:08 owl kernel:  [open_namei+165/1520] open_namei+0xa5/0x5f0
Jun 12 14:58:08 owl kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Jun 12 14:58:08 owl kernel:  [get_unused_fd+57/224] 
get_unused_fd+0x39/0xe0
Jun 12 14:58:08 owl kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Jun 12 14:58:08 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:08 owl kernel: Code: 89 50 04 89 02 c7 46 04 00 02 20 00 c7 
06 00 01 10 00 c7 44 
Jun 12 14:58:08 owl kernel:  <6>note: emacs[3839] exited with 
preempt_count 4
Jun 12 14:58:08 owl kernel: bad: scheduling while atomic!
Jun 12 14:58:08 owl kernel:  [schedule+1148/1168] schedule+0x47c/0x490
Jun 12 14:58:08 owl kernel:  [unmap_page_range+75/128] 
unmap_page_range+0x4b/0x80
Jun 12 14:58:08 owl kernel:  [unmap_vmas+428/448] unmap_vmas+0x1ac/0x1c0
Jun 12 14:58:08 owl kernel:  [exit_mmap+131/352] exit_mmap+0x83/0x160
Jun 12 14:58:08 owl kernel:  [mmput+100/144] mmput+0x64/0x90
Jun 12 14:58:08 owl kernel:  [do_exit+338/896] do_exit+0x152/0x380
Jun 12 14:58:08 owl kernel:  [do_page_fault+0/1353] 
do_page_fault+0x0/0x549
Jun 12 14:58:08 owl kernel:  [die+248/256] die+0xf8/0x100
Jun 12 14:58:08 owl kernel:  [do_page_fault+478/1353] 
do_page_fault+0x1de/0x549
Jun 12 14:58:08 owl kernel:  [__call_console_drivers+92/96] 
__call_console_drivers+0x5c/0x60
Jun 12 14:58:08 owl kernel:  [call_console_drivers+101/288] 
call_console_drivers+0x65/0x120
Jun 12 14:58:08 owl kernel:  [release_console_sem+210/224] 
release_console_sem+0xd2/0xe0
Jun 12 14:58:08 owl kernel:  [printk+269/368] printk+0x10d/0x170
Jun 12 14:58:08 owl kernel:  [__kernel_text_address+46/64] 
__kernel_text_address+0x2e/0x40
Jun 12 14:58:08 owl kernel:  [print_context_stack+45/112] 
print_context_stack+0x2d/0x70
Jun 12 14:58:08 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:08 owl kernel:  [do_page_fault+0/1353] 
do_page_fault+0x0/0x549
Jun 12 14:58:08 owl kernel:  [error_code+45/56] error_code+0x2d/0x38
Jun 12 14:58:08 owl kernel:  [__mod_timer+164/368] 
__mod_timer+0xa4/0x170
Jun 12 14:58:08 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:08 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:08 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:08 owl kernel:  [journal_dirty_metadata+278/432] 
journal_dirty_metadata+0x116/0x1b0
Jun 12 14:58:08 owl kernel:  [journal_stop+417/656] 
journal_stop+0x1a1/0x290
Jun 12 14:58:08 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:08 owl kernel:  [ext3_setattr+354/464] 
ext3_setattr+0x162/0x1d0
Jun 12 14:58:08 owl kernel:  [notify_change+382/432] 
notify_change+0x17e/0x1b0
Jun 12 14:58:08 owl kernel:  [do_truncate+105/176] do_truncate+0x69/0xb0
Jun 12 14:58:08 owl kernel:  [permission+103/128] permission+0x67/0x80
Jun 12 14:58:08 owl kernel:  [may_open+384/480] may_open+0x180/0x1e0
Jun 12 14:58:08 owl kernel:  [open_namei+165/1520] open_namei+0xa5/0x5f0
Jun 12 14:58:08 owl kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Jun 12 14:58:08 owl kernel:  [get_unused_fd+57/224] 
get_unused_fd+0x39/0xe0
Jun 12 14:58:08 owl kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Jun 12 14:58:08 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:12 owl kernel: Unable to handle kernel paging request at 
virtual address 6398639c
Jun 12 14:58:12 owl kernel:  printing eip:
Jun 12 14:58:12 owl kernel: c011d7c4
Jun 12 14:58:12 owl kernel: *pde = 00000000
Jun 12 14:58:12 owl kernel: Oops: 0002 [#3]
Jun 12 14:58:12 owl kernel: PREEMPT 
Jun 12 14:58:12 owl kernel: Modules linked in: pl2303 usbserial nfs 
lockd sunrpc ppp_deflate bsd_comp ppp_async crc_ccitt ipv6 ppp_generic 
slhc ipt_MASQUERADE iptable_nat ipt_LOG iptable_filter eth1394 ohci1394 
ieee1394 lp apm 8139too mii sd_mod
Jun 12 14:58:12 owl kernel: CPU:    0
Jun 12 14:58:12 owl kernel: EIP:    0060:[__mod_timer+164/368]    Not 
tainted
Jun 12 14:58:12 owl kernel: EFLAGS: 00010002   
(2.6.8-16.2005-11-06.owl.1.oss.mods) 
Jun 12 14:58:12 owl kernel: EIP is at __mod_timer+0xa4/0x170
Jun 12 14:58:12 owl kernel: eax: 63986398   ebx: 63986398   ecx: 
c93626e0   edx: 63986398
Jun 12 14:58:12 owl kernel: esi: dfd99fc0   edi: c0408b00   ebp: 
00000246   esp: cc4e9c54
Jun 12 14:58:12 owl kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 14:58:12 owl kernel: Process firefox-bin (pid: 2864, 
threadinfo=cc4e8000 task=d2112c70)
Jun 12 14:58:12 owl kernel: Stack: 00000000 dffd9c80 00000000 c93626e0 
dffd9c80 c9362738 dffd9c80 c01924a4 
Jun 12 14:58:12 owl kernel:        dfd99fc0 00fb1398 00000000 cc4e8000 
c019a055 00000000 00000000 c0192598 
Jun 12 14:58:12 owl kernel:        dffd9c80 c93626e0 00000050 00000001 
00000000 c93626e0 00000002 da846bb0 
Jun 12 14:58:12 owl kernel: Call Trace:
Jun 12 14:58:12 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:12 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:12 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:12 owl kernel:  [try_to_wake_up+164/192] 
try_to_wake_up+0xa4/0xc0
Jun 12 14:58:12 owl kernel:  [recalc_task_prio+143/400] 
recalc_task_prio+0x8f/0x190
Jun 12 14:58:12 owl kernel:  [schedule+654/1168] schedule+0x28e/0x490
Jun 12 14:58:12 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:12 owl kernel:  [ext3_dirty_inode+50/144] 
ext3_dirty_inode+0x32/0x90
Jun 12 14:58:12 owl kernel:  [__mark_inode_dirty+426/432] 
__mark_inode_dirty+0x1aa/0x1b0
Jun 12 14:58:12 owl kernel:  [try_to_wake_up+164/192] 
try_to_wake_up+0xa4/0xc0
Jun 12 14:58:12 owl kernel:  [recalc_task_prio+143/400] 
recalc_task_prio+0x8f/0x190
Jun 12 14:58:12 owl kernel:  [inode_update_time+207/224] 
inode_update_time+0xcf/0xe0
Jun 12 14:58:12 owl kernel:  [generic_file_aio_write_nolock+595/2864] 
generic_file_aio_write_nolock+0x253/0xb30
Jun 12 14:58:12 owl kernel:  [kfree_skbmem+36/48] kfree_skbmem+0x24/0x30
Jun 12 14:58:12 owl kernel:  [__kfree_skb+171/320] 
__kfree_skb+0xab/0x140
Jun 12 14:58:12 owl kernel:  [buffered_rmqueue+245/464] 
buffered_rmqueue+0xf5/0x1d0
Jun 12 14:58:12 owl kernel:  [generic_file_aio_write+119/160] 
generic_file_aio_write+0x77/0xa0
Jun 12 14:58:12 owl kernel:  [ext3_file_write+68/224] 
ext3_file_write+0x44/0xe0
Jun 12 14:58:12 owl kernel:  [do_sync_write+132/176] 
do_sync_write+0x84/0xb0
Jun 12 14:58:12 owl kernel:  [schedule_timeout+181/192] 
schedule_timeout+0xb5/0xc0
Jun 12 14:58:12 owl kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
Jun 12 14:58:12 owl kernel:  [do_sync_write+0/176] 
do_sync_write+0x0/0xb0
Jun 12 14:58:12 owl kernel:  [vfs_write+216/320] vfs_write+0xd8/0x140
Jun 12 14:58:12 owl kernel:  [sys_write+81/128] sys_write+0x51/0x80
Jun 12 14:58:12 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:12 owl kernel: Code: 89 50 04 89 02 c7 46 04 00 02 20 00 c7 
06 00 01 10 00 c7 44 
Jun 12 14:58:12 owl kernel:  <6>note: firefox-bin[2864] exited with 
preempt_count 4
Jun 12 14:58:23 owl kernel: Unable to handle kernel paging request at 
virtual address 6398639c
Jun 12 14:58:23 owl kernel:  printing eip:
Jun 12 14:58:23 owl kernel: c011d7c4
Jun 12 14:58:23 owl kernel: *pde = 00000000
Jun 12 14:58:23 owl kernel: Oops: 0002 [#4]
Jun 12 14:58:23 owl kernel: PREEMPT 
Jun 12 14:58:23 owl kernel: Modules linked in: pl2303 usbserial nfs 
lockd sunrpc ppp_deflate bsd_comp ppp_async crc_ccitt ipv6 ppp_generic 
slhc ipt_MASQUERADE iptable_nat ipt_LOG iptable_filter eth1394 ohci1394 
ieee1394 lp apm 8139too mii sd_mod
Jun 12 14:58:23 owl kernel: CPU:    0
Jun 12 14:58:23 owl kernel: EIP:    0060:[__mod_timer+164/368]    Not 
tainted
Jun 12 14:58:23 owl kernel: EFLAGS: 00010002   
(2.6.8-16.2005-11-06.owl.1.oss.mods) 
Jun 12 14:58:23 owl kernel: EIP is at __mod_timer+0xa4/0x170
Jun 12 14:58:23 owl kernel: eax: 63986398   ebx: 63986398   ecx: 
cbda25e0   edx: 63986398
Jun 12 14:58:23 owl kernel: esi: dfd99fc0   edi: c0408b00   ebp: 
00000246   esp: c93bfce4
Jun 12 14:58:23 owl kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 14:58:23 owl kernel: Process amarokapp (pid: 2894, 
threadinfo=c93be000 task=c98aacf0)
Jun 12 14:58:23 owl kernel: Stack: c04034e0 da846bb0 00000000 cbda25e0 
dffd9c80 cbda2638 dffd9c80 c01924a4 
Jun 12 14:58:23 owl kernel:        dfd99fc0 00fb4024 00000000 c93be000 
c019a055 00000000 00000000 c0192598 
Jun 12 14:58:23 owl kernel:        dffd9c80 cbda25e0 00000050 00000001 
00000000 cbda25e0 00000002 df55ada8 
Jun 12 14:58:23 owl kernel: Call Trace:
Jun 12 14:58:23 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:23 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:23 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:23 owl kernel:  [group_send_sig_info+147/160] 
group_send_sig_info+0x93/0xa0
Jun 12 14:58:23 owl kernel:  [recalc_task_prio+143/400] 
recalc_task_prio+0x8f/0x190
Jun 12 14:58:23 owl kernel:  [activate_task+98/128] 
activate_task+0x62/0x80
Jun 12 14:58:23 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:23 owl kernel:  [ext3_dirty_inode+50/144] 
ext3_dirty_inode+0x32/0x90
Jun 12 14:58:23 owl kernel:  [__mark_inode_dirty+426/432] 
__mark_inode_dirty+0x1aa/0x1b0
Jun 12 14:58:23 owl kernel:  [inode_setattr+245/368] 
inode_setattr+0xf5/0x170
Jun 12 14:58:23 owl kernel:  [ext3_setattr+198/464] 
ext3_setattr+0xc6/0x1d0
Jun 12 14:58:23 owl kernel:  [notify_change+382/432] 
notify_change+0x17e/0x1b0
Jun 12 14:58:23 owl kernel:  [do_truncate+105/176] do_truncate+0x69/0xb0
Jun 12 14:58:23 owl kernel:  [permission+103/128] permission+0x67/0x80
Jun 12 14:58:23 owl kernel:  [may_open+384/480] may_open+0x180/0x1e0
Jun 12 14:58:23 owl kernel:  [open_namei+165/1520] open_namei+0xa5/0x5f0
Jun 12 14:58:23 owl kernel:  [filp_open+62/112] filp_open+0x3e/0x70
Jun 12 14:58:23 owl kernel:  [get_unused_fd+57/224] 
get_unused_fd+0x39/0xe0
Jun 12 14:58:23 owl kernel:  [sys_open+91/144] sys_open+0x5b/0x90
Jun 12 14:58:23 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:23 owl kernel: Code: 89 50 04 89 02 c7 46 04 00 02 20 00 c7 
06 00 01 10 00 c7 44 
Jun 12 14:58:23 owl kernel:  <6>note: amarokapp[2894] exited with 
preempt_count 4
Jun 12 14:58:27 owl kernel: Unable to handle kernel paging request at 
virtual address 6398639c
Jun 12 14:58:27 owl kernel:  printing eip:
Jun 12 14:58:27 owl kernel: c011d7c4
Jun 12 14:58:27 owl kernel: *pde = 00000000
Jun 12 14:58:27 owl kernel: Oops: 0002 [#5]
Jun 12 14:58:27 owl kernel: PREEMPT 
Jun 12 14:58:27 owl kernel: Modules linked in: pl2303 usbserial nfs 
lockd sunrpc ppp_deflate bsd_comp ppp_async crc_ccitt ipv6 ppp_generic 
slhc ipt_MASQUERADE iptable_nat ipt_LOG iptable_filter eth1394 ohci1394 
ieee1394 lp apm 8139too mii sd_mod
Jun 12 14:58:27 owl kernel: CPU:    0
Jun 12 14:58:27 owl kernel: EIP:    0060:[__mod_timer+164/368]    Not 
tainted
Jun 12 14:58:27 owl kernel: EFLAGS: 00010002   
(2.6.8-16.2005-11-06.owl.1.oss.mods) 
Jun 12 14:58:27 owl kernel: EIP is at __mod_timer+0xa4/0x170
Jun 12 14:58:27 owl kernel: eax: 63986398   ebx: 63986398   ecx: 
d64650e0   edx: 63986398
Jun 12 14:58:27 owl kernel: esi: dfd99fc0   edi: c0408b00   ebp: 
00000246   esp: d0d11dc0
Jun 12 14:58:27 owl kernel: ds: 007b   es: 007b   ss: 0068
Jun 12 14:58:27 owl kernel: Process kmail (pid: 2844, 
threadinfo=d0d10000 task=d05737d0)
Jun 12 14:58:27 owl kernel: Stack: d6465018 dffeb26c 00000000 d64650e0 
dffd9c80 d6465138 dffd9c80 c01924a4 
Jun 12 14:58:27 owl kernel:        dfd99fc0 00fb4db3 00000000 d0d10000 
c019a055 00000000 00000000 c0192598 
Jun 12 14:58:27 owl kernel:        dffd9c80 d64650e0 00000050 00000001 
00000000 d64650e0 00000002 00000020 
Jun 12 14:58:27 owl kernel: Call Trace:
Jun 12 14:58:27 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:27 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:27 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:27 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:27 owl kernel:  [link_path_walk+2730/3488] 
link_path_walk+0xaaa/0xda0
Jun 12 14:58:27 owl kernel:  [ext3_dirty_inode+50/144] 
ext3_dirty_inode+0x32/0x90
Jun 12 14:58:27 owl kernel:  [__mark_inode_dirty+426/432] 
__mark_inode_dirty+0x1aa/0x1b0
Jun 12 14:58:27 owl kernel:  [cp_new_stat64+253/288] 
cp_new_stat64+0xfd/0x120
Jun 12 14:58:27 owl kernel:  [update_atime+208/224] 
update_atime+0xd0/0xe0
Jun 12 14:58:27 owl kernel:  [generic_file_mmap+60/80] 
generic_file_mmap+0x3c/0x50
Jun 12 14:58:27 owl kernel:  [do_mmap_pgoff+800/1760] 
do_mmap_pgoff+0x320/0x6e0
Jun 12 14:58:27 owl kernel:  [sys_fstat64+55/64] sys_fstat64+0x37/0x40
Jun 12 14:58:27 owl kernel:  [sys_mmap2+120/176] sys_mmap2+0x78/0xb0
Jun 12 14:58:27 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Jun 12 14:58:27 owl kernel: Code: 89 50 04 89 02 c7 46 04 00 02 20 00 c7 
06 00 01 10 00 c7 44 
Jun 12 14:58:27 owl kernel:  <6>note: kmail[2844] exited with 
preempt_count 4
Jun 12 14:58:27 owl kernel: bad: scheduling while atomic!
Jun 12 14:58:27 owl kernel:  [schedule+1148/1168] schedule+0x47c/0x490
Jun 12 14:58:27 owl kernel:  [call_console_drivers+101/288] 
call_console_drivers+0x65/0x120
Jun 12 14:58:27 owl kernel:  [rwsem_down_read_failed+141/384] 
rwsem_down_read_failed+0x8d/0x180
Jun 12 14:58:27 owl kernel:  
[.text.lock.exit+127/229] .text.lock.exit+0x7f/0xe5
Jun 12 14:58:27 owl kernel:  [do_page_fault+0/1353] 
do_page_fault+0x0/0x549
Jun 12 14:58:27 owl kernel:  [die+248/256] die+0xf8/0x100
Jun 12 14:58:27 owl kernel:  [do_page_fault+478/1353] 
do_page_fault+0x1de/0x549
Jun 12 14:58:27 owl kernel:  [recalc_task_prio+143/400] 
recalc_task_prio+0x8f/0x190
Jun 12 14:58:27 owl kernel:  [recalc_task_prio+143/400] 
recalc_task_prio+0x8f/0x190
Jun 12 14:58:27 owl kernel:  [activate_task+98/128] 
activate_task+0x62/0x80
Jun 12 14:58:27 owl kernel:  [try_to_wake_up+164/192] 
try_to_wake_up+0xa4/0xc0
Jun 12 14:58:27 owl kernel:  [do_page_fault+0/1353] 
do_page_fault+0x0/0x549
Jun 12 14:58:27 owl kernel:  [error_code+45/56] error_code+0x2d/0x38
Jun 12 14:58:27 owl kernel:  [__mod_timer+164/368] 
__mod_timer+0xa4/0x170
Jun 12 14:58:27 owl kernel:  [get_transaction+100/192] 
get_transaction+0x64/0xc0
Jun 12 14:58:27 owl kernel:  [__jbd_kmalloc+37/48] 
__jbd_kmalloc+0x25/0x30
Jun 12 14:58:27 owl kernel:  [start_this_handle+152/992] 
start_this_handle+0x98/0x3e0
Jun 12 14:58:27 owl kernel:  [journal_start+169/208] 
journal_start+0xa9/0xd0
Jun 12 14:58:27 owl kernel:  [link_path_walk+2730/3488] 
link_path_walk+0xaaa/0xda0
Jun 12 14:58:27 owl kernel:  [ext3_dirty_inode+50/144] 
ext3_dirty_inode+0x32/0x90
Jun 12 14:58:27 owl kernel:  [__mark_inode_dirty+426/432] 
__mark_inode_dirty+0x1aa/0x1b0
Jun 12 14:58:27 owl kernel:  [cp_new_stat64+253/288] 
cp_new_stat64+0xfd/0x120
Jun 12 14:58:27 owl kernel:  [update_atime+208/224] 
update_atime+0xd0/0xe0
Jun 12 14:58:27 owl kernel:  [generic_file_mmap+60/80] 
generic_file_mmap+0x3c/0x50
Jun 12 14:58:27 owl kernel:  [do_mmap_pgoff+800/1760] 
do_mmap_pgoff+0x320/0x6e0
Jun 12 14:58:27 owl kernel:  [sys_fstat64+55/64] sys_fstat64+0x37/0x40
Jun 12 14:58:27 owl kernel:  [sys_mmap2+120/176] sys_mmap2+0x78/0xb0
Jun 12 14:58:27 owl kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
[at this point I turned the power off]

Cheers,

Kjetil
-- 
Kjetil Kjernsmo
Programmer/Astrophysicist/Skeptic/Ski-orienteer/Orienteer/Mountaineer
kjetil@kjernsmo.net  webmaster@skepsis.no  editor@learn-orienteering.org
Homepage: http://www.kjetil.kjernsmo.net/        OpenPGP KeyID: 6A6A0BBC
