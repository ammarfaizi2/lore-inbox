Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVA2D12@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVA2D12 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 22:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVA2D12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 22:27:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52189 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261420AbVA2D1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 22:27:23 -0500
Date: Fri, 28 Jan 2005 22:27:20 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: slab BUG in FC devel kernel, x86-64
Message-ID: <20050129032720.GA7119@nostromo.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel in question is based on 2.6.11-rc2-bk4, FWIW.

Transcribed by hand. Happened when rsyncing data onto
a LVM-on-RAID1, sata_via controller. (root FS is on generic
VIA IDE).

slab: double free detected in cache 'size-128', objp ffff81000340bba8.
Kernel BUG at slab:2188
invalid operand: 0000 [1]
CPU 0
Modules linked in: md5 ipv6 parport_pc lp parport sunrpc ipt_REJECT ipt_state
 ip-contrack iptable_filter ip_tables dm_mod video button battery ac raid1
 ohci1394 ieee1394 uhci_hcd ehci_hcd i2c_viapro i2c_core snd_via82xx
 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
 gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via_rhine
 mii floppy ext3 jbd sata_via libata sd_mod scsi_mod
Pid: 161, comm: kswapd0 Not tainted 2.6.10-1.1115_FC4
RIP: 0010:[<ffffffff80168e9e>] <ffffffff80168e9e>{free_block+208}
RSP: 0018:ffff81003bde9cd8  EFLAGS: 00010092
RAX: 000000000000004a RBX: ffff81000340b000 RCX: ffffffff8042e010
RDX: ffffffff8042e010 RSI: 0000000000000001 RDI: ffff81003a82a7d0
RBP: ffff81003bfef640 R08: ffffffff8042e010 R09: ffff81001dafdd78
R10: 0000000100000000 R11: 0000ffff8044bd20 R12: ffff81000340bba8
R13: 0000000000000013 R14: ffff81000340b028 R15: 0000000000000013
FS:  00002aaaaaaba3a0(0000) GS:ffffffff8050d880(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaaaaac000 CR3: 000000000b36d000 CR4: 00000000000006e0
Process kswapd0 (pid: 161, threadinfo ffff81003bde8000, task ffff81003bd5d070)
Stack: 0000000000000001 ffff81003bfe9698 000000101a285a78 ffff81003bfef640
       0000000000000010 ffff81003bfe9688 ffff81003bfe9698 0000000000000000
       0000000000000080 ffffffff801690c1
Call Trace:<ffffffff801690c1>{cache_flusharray+242} <ffffffff80168c22>{kfree+156}
       <ffffffff801a4c89>{destroy_inode+41} <ffffffff801a509c>{dispose_list+95}
       <ffffffff801a5e80>{shrink_icache_memory+993} <ffffffff8016c4cb>{shrink_slab+188}
       <ffffffff8016e112>{balance_pgdat+547} <ffffffff8016e331>{kswapd+260}
       <ffffffff801508b1>{autoremove_wake_function+0} <ffffffff801508b1>{autoremove_wake_function+0}
       <ffffffff801508b1>{autoremove_wake_function+0} <ffffffff8012f75b>{schedule_tail+11}
       <ffffffff8010f327>{child_rip+8} <ffffffff8016e22d>{kswapd+0}
       <ffffffff8010f31f>{child_rip+0}

Code: 0f 0b 21 f1 36 80 ff ff ff ff 8c 08 0f b7 43 24 48 89 de 48
RIP <ffffffff80168e9e>{free_block+208} RSP <ffff81003bde9cd8>
