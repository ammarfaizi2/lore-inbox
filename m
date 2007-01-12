Return-Path: <linux-kernel-owner+w=401wt.eu-S1161175AbXALXyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161175AbXALXyX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 18:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161176AbXALXyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 18:54:23 -0500
Received: from ext-nj2ut-12.online-age.net ([64.14.54.245]:30445 "EHLO
	ext-nj2ut-12.online-age.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161175AbXALXyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 18:54:21 -0500
X-Greylist: delayed 1201 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2007 18:54:21 EST
Date: Sat, 13 Jan 2007 00:34:00 +0100
From: Karl Kiniger <karl.kiniger@med.ge.com>
To: linux-kernel@vger.kernel.org
Subject: list_del corruption with fedora 6 kernels (fc5 was ok)
Message-ID: <20070112233400.GA17470@wszip-kinigka.euro.med.ge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-GEHealthcare-MailScanner: Found to be clean
X-GEHealthcare-MailScanner-From: karl.kiniger@med.ge.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

these trigger about 1-2 times per week at random times. I dont see a
pattern, one time it happened after plugging in the USB headphone, another
time it happened while the machine was more or less idle.

machine does not reboot automatically ( /proc/sys/kernel/panic is set to 20)

most of the time the panic does not make it into the syslog but I have been lucky
three times.

how to track this down?

Greetings,
Karl


NB: the v4l/bt848 stuff is not being used at all.

/var/log/messages.3:Dec 19 11:58:38 wszip-kinigka kernel: list_del corruption. next->prev should be c6e1f2c0, but was 000035b0
/var/log/messages.4:Dec 13 15:57:07 wszip-kinigka kernel: list_del corruption. next->prev should be c9a24be0, but was c1284fe0
(backtraces are essentially the same)

from today:

Jan 12 10:57:23 wszip-kinigka kernel: list_del corruption. prev->next should be ea24aa20, but was ea240080
Jan 12 10:57:23 wszip-kinigka kernel: ------------[ cut here ]------------
Jan 12 10:57:23 wszip-kinigka kernel: kernel BUG at lib/list_debug.c:65!
Jan 12 10:57:23 wszip-kinigka kernel: invalid opcode: 0000 [#1]
Jan 12 10:57:23 wszip-kinigka kernel: SMP 
Jan 12 10:57:23 wszip-kinigka kernel: last sysfs file: /class/net/lo/ifindex
Jan 12 10:57:23 wszip-kinigka kernel: Modules linked in: snd_usb_audio vfat fat hfsplus nls_utf8 cifs sbp2 sg usb_storage tun snd_usb_lib autofs4 hidp rfcomm l2cap bluetooth vmnet(U) vmmon(U) sunrpc ib_iser rdma_cm ib_addr ib_cm ib_sa ib_mad ib_core iscsi_tcp libiscsi scsi_transport_iscsi ipv6 reiserfs loop dm_multipath parport_pc lp parport bt878 snd_bt87x snd_cmipci tuner tvaudio snd_seq_dummy gameport snd_seq_oss snd_opl3_lib bttv video_buf ir_common snd_hwdep snd_seq_midi_event nvidia(U) snd_mpu401_uart snd_seq compat_ioctl32 snd_pcm_oss i2c_algo_bit snd_rawmidi btcx_risc snd_mixer_oss snd_seq_device snd_pcm tveeprom snd_timer videodev ide_cd ohci1394 3c59x v4l1_compat v4l2_common snd i2c_core ieee1394 snd_page_alloc cdrom floppy mii soundcore serio_raw pcspkr dm_snapshot dm_zero dm_mirror dm_mod aic7xxx scsi_transport_spi sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Jan 12 10:57:23 wszip-kinigka kernel: CPU:    0
Jan 12 10:57:23 wszip-kinigka kernel: EIP:    0060:[<c04e99ab>]    Tainted: P      VLI
Jan 12 10:57:23 wszip-kinigka kernel: EFLAGS: 00010096   (2.6.18-1.2869.fc6 #1) 
Jan 12 10:57:23 wszip-kinigka kernel: EIP is at list_del+0x23/0x6c
Jan 12 10:57:23 wszip-kinigka kernel: eax: 00000048   ebx: ea24aa20   ecx: c067e1d0   edx: 00000092
Jan 12 10:57:23 wszip-kinigka kernel: esi: f7ffd6c0   edi: cb841000   ebp: f7fffe80   esp: f7fefef8
Jan 12 10:57:23 wszip-kinigka kernel: ds: 007b   es: 007b   ss: 0068
Jan 12 10:57:23 wszip-kinigka kernel: Process events/0 (pid: 5, ti=f7fef000 task=f7d80030 task.ti=f7fef000)
Jan 12 10:57:23 wszip-kinigka kernel: Stack: c0641c4f ea24aa20 ea240080 ea24aa20 c046b553 f7f7a1c0 00000005 00000004 
Jan 12 10:57:23 wszip-kinigka kernel:        f7ffdef0 f7ffdee0 00000005 f7ffdec0 00000000 c046b656 00000000 00000000 
Jan 12 10:57:23 wszip-kinigka kernel:        f7fffe80 f7ffd6e4 f7ffd6c0 f7fffe80 c18fd340 00000282 c046ca7a 00000000 
Jan 12 10:57:23 wszip-kinigka kernel: Call Trace:
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046b553>] free_block+0x63/0xdc
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046b656>] drain_array+0x8a/0xb5
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046ca7a>] cache_reap+0x53/0x117
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0433c18>] run_workqueue+0x83/0xc5
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0434508>] worker_thread+0xd9/0x10d
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04369db>] kthread+0xc0/0xed
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0404dab>] kernel_thread_helper+0x7/0x10
Jan 12 10:57:23 wszip-kinigka kernel: DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10
Jan 12 10:57:23 wszip-kinigka kernel: Leftover inexact backtrace:
Jan 12 10:57:23 wszip-kinigka kernel:  =======================
Jan 12 10:57:23 wszip-kinigka kernel: Code: 00 00 89 c3 eb e8 90 90 53 89 c3 83 ec 0c 8b 40 04 8b 00 39 d8 74 1c 89 5c 24 04 89 44 24 08 c7 04 24 4f 1c 64 c0 e8 2b be f3 ff <0f> 0b 41 00 8c 1c 64 c0 8b 03 8b 40 04 39 d8 74 1c 89 5c 24 04 
Jan 12 10:57:23 wszip-kinigka kernel: EIP: [<c04e99ab>] list_del+0x23/0x6c SS:ESP 0068:f7fefef8
Jan 12 10:57:23 wszip-kinigka kernel:  <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Jan 12 10:57:23 wszip-kinigka kernel: in_atomic():0, irqs_disabled():1
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04051db>] dump_trace+0x69/0x1af
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0405339>] show_trace_log_lvl+0x18/0x2c
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04058ed>] show_trace+0xf/0x11
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04059ea>] dump_stack+0x15/0x17
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0439482>] down_read+0x12/0x20
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04315e1>] blocking_notifier_call_chain+0xe/0x29
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0427638>] do_exit+0x1b/0x776
Jan 12 10:57:23 wszip-kinigka kernel:  [<c040588e>] die+0x29d/0x2c2
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0405fd3>] do_invalid_op+0xa2/0xab
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0404b85>] error_code+0x39/0x40
Jan 12 10:57:23 wszip-kinigka kernel: DWARF2 unwinder stuck at error_code+0x39/0x40
Jan 12 10:57:23 wszip-kinigka kernel: Leftover inexact backtrace:
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04e99ab>] list_del+0x23/0x6c
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046b553>] free_block+0x63/0xdc
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046b656>] drain_array+0x8a/0xb5
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046ca7a>] cache_reap+0x53/0x117
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0433c18>] run_workqueue+0x83/0xc5
Jan 12 10:57:23 wszip-kinigka kernel:  [<c046ca27>] cache_reap+0x0/0x117
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0434508>] worker_thread+0xd9/0x10d
Jan 12 10:57:23 wszip-kinigka kernel:  [<c041fdbd>] default_wake_function+0x0/0xc
Jan 12 10:57:23 wszip-kinigka kernel:  [<c043442f>] worker_thread+0x0/0x10d
Jan 12 10:57:23 wszip-kinigka kernel:  [<c04369db>] kthread+0xc0/0xed
Jan 12 10:57:23 wszip-kinigka kernel:  [<c043691b>] kthread+0x0/0xed
Jan 12 10:57:23 wszip-kinigka kernel:  [<c0404dab>] kernel_thread_helper+0x7/0x10
Jan 12 10:57:23 wszip-kinigka kernel:  =======================



-- 
Karl Kiniger   mailto:karl.kiniger@med.ge.com
GE Medical Systems Kretztechnik GmbH & Co OHG
Tiefenbach 15       Tel: (++43) 7682-3800-710
A-4871 Zipf Austria Fax: (++43) 7682-3800-47
