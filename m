Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVACEqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVACEqN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 23:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVACEqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 23:46:12 -0500
Received: from rdns.37.161.62.64.fre.communitycolo.net ([64.62.161.37]:31127
	"EHLO horizon") by vger.kernel.org with ESMTP id S261376AbVACEpz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 23:45:55 -0500
Message-ID: <41D8CDFE.1010800@ocf.berkeley.edu>
Date: Sun, 02 Jan 2005 20:45:50 -0800
From: Andrey Kislyuk <kislyuk@ocf.berkeley.edu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oopses and panics on 2.6.9+K8T800
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have an ASUS A8V-D (a64 socket 939, VIA K8T800+VT8237, Promise 20378, 
etc. http://usa.asus.com/prog/spec.asp?m=A8V%20Deluxe&langs=09) with a 
PCI video card (S3 VIRGE). I also have software RAID 0 configured. All 
hardware is in stock configuration.

On kernel 2.6.5 x86, everything is fine.

On kernel 2.6.9 x86-64, I get random oopses and panics when spawning new 
processes, of the kind logged below. (The first three messages are 
non-fatal, afterward is a typical panic/oops - happens on various 
processes. When panicking, it stops the interrupt controller. This 
happens on kernels from fedora core 3 and gentoo.)

Any ideas? TIA,
-ak
_____________

Dec 28 01:50:58 dhcppc6 kernel:  <7>Losing some ticks... checking if CPU 
frequency changed.
Dec 28 20:15:32 dhcppc6 kernel: warning: many lost ticks.
...
Dec 29 04:46:33 dhcppc6 kernel:  fs/fs-writeback.c:96: 
spin_lock(fs/inode.c:ffffffff8042ee80) already locked by fs/inode.c/81
0
...
Dec 28 01:47:21 dhcppc6 kernel: Unable to handle kernel paging request 
at 000000010037e799 RIP:
Dec 28 01:47:21 dhcppc6 kernel: <ffffffff802b1766>{cdrom_read_toc+123}
Dec 28 01:47:21 dhcppc6 kernel: PML4 321cf067 PGD 0
Dec 28 01:47:21 dhcppc6 kernel: Oops: 0000 [1]
Dec 28 01:47:21 dhcppc6 kernel: CPU 0
Dec 28 01:47:21 dhcppc6 kernel: Modules linked in: parport_pc lp parport 
autofs4 i2c_dev i2c_core sunrpc ds yenta_socket pcmc
ia_core ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables md5 
ipv6 dm_mod button battery ac ohci1394 ieee1394 uhci_h
cd ehci_hcd snd_via82xx snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm 
snd_timer snd_page_alloc gameport snd_mpu401_uart sn
d_rawmidi snd_seq_device snd soundcore sk98lin ext3 jbd raid0 
sata_promise sata_via libata sd_mod scsi_mod
Dec 28 01:47:21 dhcppc6 kernel: Pid: 2810, comm: hald Not tainted 
2.6.9-1.667
Dec 28 01:47:21 dhcppc6 kernel: RIP: 0010:[<ffffffff802b1766>] 
<ffffffff802b1766>{cdrom_read_toc+123}
Dec 28 01:47:21 dhcppc6 kernel: RSP: 0018:00000100321f1a68  EFLAGS: 00010246
Dec 28 01:47:21 dhcppc6 kernel: RAX: 000000010037e60c RBX: 
0000010037c1f800 RCX: 00000100321f17b0
Dec 28 01:47:21 dhcppc6 kernel: RDX: 0000000000000000 RSI: 
00000100321ef150 RDI: 00000100321f1928
Dec 28 01:47:21 dhcppc6 kernel: RBP: 0000010037e60c00 R08: 
00000100321f0000 R09: ffffffff802a3e6d
Dec 28 01:47:21 dhcppc6 kernel: R10: 00000000fffffffb R11: 
00000100321f1928 R12: ffffffff804e2c88
Dec 28 01:47:21 dhcppc6 kernel: R13: 0000000000000000 R14: 
00000100321f1ac8 R15: 0000010037e60d90
Dec 28 01:47:21 dhcppc6 kernel: FS:  0000002a963abd00(0000) 
GS:ffffffff80503480(0000) knlGS:00000000f70218e0
Dec 28 01:47:21 dhcppc6 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
000000008005003b
Dec 28 01:47:21 dhcppc6 kernel: CR2: 000000010037e799 CR3: 
0000000000101000 CR4: 00000000000006e0
Dec 28 01:47:21 dhcppc6 kernel: Process hald (pid: 2810, threadinfo 
00000100321f0000, task 00000100321ef150)
Dec 28 01:47:21 dhcppc6 kernel: Stack: 0000000000000000 0000000000000004 
0000000000000000 0000000000000000
Dec 28 01:47:21 dhcppc6 kernel:        0000000000000000 0000010031f69980 
ffffffff804528c0 00000000fffffff4
Dec 28 01:47:21 dhcppc6 kernel:        0000000000000000 0000010029a06900
Dec 28 01:47:21 dhcppc6 kernel: Call 
Trace:<ffffffff802b2645>{idecd_revalidate_disk+16} 
<ffffffff801adee9>{__invalidate_devic
e+72}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff8019503e>{check_disk_change+82} <ffffffff802b5f95>{cdrom_open+1895}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff80350f84>{wait_for_completion+380} 
<ffffffff8013374c>{default_wake_function+0
}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff8013374c>{default_wake_function+0} 
<ffffffff802a3e27>{ide_do_drive_cmd+600}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff801f73e3>{avc_has_perm+69} <ffffffff80285782>{exact_match+0}
Dec 28 01:47:21 dhcppc6 kernel:        <ffffffff802857db>{exact_lock+0} 
<ffffffff80210921>{kobject_get+18}
Dec 28 01:47:21 dhcppc6 kernel:        <ffffffff802857b6>{get_disk+44} 
<ffffffff802b2583>{idecd_open+99}
Dec 28 01:47:21 dhcppc6 kernel:        <ffffffff80195617>{do_open+582} 
<ffffffff80195b24>{blkdev_open+33}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff80189478>{dentry_open+205} <ffffffff801895a2>{filp_open+62}
Dec 28 01:47:21 dhcppc6 kernel: 
<ffffffff80214ba1>{strncpy_from_user+74} 
<ffffffff80189661>{get_unused_fd+179}
Dec 28 01:47:21 dhcppc6 kernel:        <ffffffff80189a12>{sys_open+58} 
<ffffffff801107a2>{system_call+126}
Dec 28 01:47:21 dhcppc6 kernel:
Dec 28 01:47:21 dhcppc6 kernel:
Dec 28 01:47:21 dhcppc6 kernel: Code: f6 80 8d 01 00 00 02 0f 85 e2 02 
00 00 48 8d 73 08 48 8d 54
Dec 28 01:47:21 dhcppc6 kernel: RIP 
<ffffffff802b1766>{cdrom_read_toc+123} RSP <00000100321f1a68>
Dec 28 01:47:21 dhcppc6 kernel: CR2: 000000010037e799
