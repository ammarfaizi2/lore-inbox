Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWGTG7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWGTG7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 02:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWGTG7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 02:59:37 -0400
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59]:31971 "EHLO
	rzcomm12.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S964813AbWGTG7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 02:59:36 -0400
Message-ID: <44BF29CD.1000809@l4x.org>
Date: Thu, 20 Jul 2006 08:59:25 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: xfs-masters@oss.sgi.com, xfs@oss.sgi.com
Subject: XFS Bug null pointer dereference in xfs_free_ag_extent
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got the following oops from xfs. Afterwards lots of processes in D
state, probably trying to read the partition in question. Kernel
2.6.18-rc2

[196027.687020] BUG: unable to handle kernel NULL pointer dereference at 
virtual address 00000060
[196027.687216]  printing eip:
[196027.687273] c01acc00
[196027.687275] *pde = 00000000
[196027.687337] Oops: 0000 [#1]
[196027.687395] SMP
[196027.687458] Modules linked in: rfcomm l2cap bluetooth nfsd exportfs 
lockd nfs_acl sunrpc pppoe pppox ipv6 ppp_generic slhc twofish serpent 
aes blowfish sha256 crypto_null ipt_LOG ipt_recent ipt_TCPMSS xt_tcpmss 
xt_tcpudp xt_state iptable_filter ipt_MASQUERADE iptable_nat ip_tables 
x_tables dm_mod ip_nat_ftp ip_nat ip_conntrack_ftp ip_conntrack 
nfnetlink tun vfat fat loop lp eeprom i2c_dev i2c_isa usb_storage button 
processor ac e100 snd_seq_dummy snd_seq_oss snd_seq_midi 
snd_seq_midi_event snd_seq cx88_dvb cx88_vp3054_i2c mt352 dvb_pll 
or51132 video_buf_dvb dvb_core nxt200x isl6421 zl10353 cx24123 lgdt330x 
cx22702 cx8802 snd_via82xx firmware_class snd_ac97_codec cx2341x 
snd_ac97_bus cx88xx snd_pcm_oss ir_common snd_mixer_oss video_buf 
tveeprom compat_ioctl32 snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
via_agp btcx_risc snd_rawmidi snd_seq_device videodev agpgart 
v4l1_compat snd ehci_hcd via_rhine v4l2_common uhci_hcd soundcore 
usbcore parport_pc parport floppy rtc
[196027.690285] CPU:    0
[196027.690286] EIP:    0060:[<c01acc00>]    Not tainted VLI
[196027.690288] EFLAGS: 00210293   (2.6.18-rc2-ds666-via #9)
[196027.690545] EIP is at xfs_btree_init_cursor+0x2f/0x171
[196027.690645] eax: d42b3834   ebx: de835000   ecx: d42b3834   edx: 
0000008c
[196027.690771] esi: 00000000   edi: cb701038   ebp: 00000000   esp: 
cfb20c68
[196027.690896] ds: 007b   es: 007b   ss: 0068
[196027.690978] Process imap (pid: 14978, ti=cfb20000 task=d4d5a570 
task.ti=cfb20000)
[196027.691119] Stack: 00000000 00000017 cb701038 00000017 c0193c67 
00000005 00000000 00000000
[196027.691389]        00000000 00000005 00000000 cb701038 cd848f04 
de835000 0000007a 00000000
[196027.692097]        0004e1d8 df2e18e0 de835000 df2e18e0 c01c9645 
00000000 00000017 cb701038
[196027.692805] Call Trace:
[196027.693104]  [<c0193c67>] xfs_free_ag_extent+0x32/0x5e2
[196027.693445]  [<c01c9645>] xlog_grant_push_ail+0x30/0xfe
[196027.693771]  [<c01954a7>] xfs_free_extent+0xbc/0xd9
[196027.694094]  [<c01c9773>] xfs_log_reserve+0x60/0x5a8
[196027.694436]  [<c01b9376>] xfs_efd_init+0x2f/0x5a
[196027.694741]  [<c01a35c8>] xfs_bmap_finish+0xe6/0x167
[196027.695070]  [<c01d19ab>] xfs_rename+0x866/0xa33
[196027.695412]  [<c01e3d2d>] xfs_vn_rename+0x24/0x64
[196027.695707]  [<c0162d39>] mntput_no_expire+0x11/0x5d
[196027.696029]  [<c01594d1>] link_path_walk+0xb3/0xbd
[196027.696356]  [<c013979b>] pagevec_lookup_tag+0x1b/0x22
[196027.696681]  [<c013bd2a>] kstrdup+0x26/0x60
[196027.696993]  [<c01580bb>] vfs_rename+0x1b6/0x2ef
[196027.697313]  [<c015834d>] __lookup_hash+0x4a/0xc5
[196027.697632]  [<c01599a0>] sys_renameat+0x155/0x1b9
[196027.697961]  [<c013979b>] pagevec_lookup_tag+0x1b/0x22
[196027.698281]  [<c013493b>] wait_on_page_writeback_range+0xa6/0xf1
[196027.698637]  [<c01e1ba5>] xfs_file_fsync+0x3f/0x48
[196027.698953]  [<c0159a15>] sys_rename+0x11/0x15
[196027.699265]  [<c0102795>] sysenter_past_esp+0x56/0x79
[196027.699600] Code: 89 d7 ba 01 00 00 00 56 53 89 c3 8b 74 24 18 a1 c8 
86 4a c0 e8 2b 13 03 00 83 fe 02 89 c1 74 16 72 09 31 c0 83 fe 03 75 78 
eb 51 <8b> 45 60 8b 44 b0 1c 0f c8 eb 6b 83 7c 24 20 00 75 09 8b 44 24
[196027.701445] EIP: [<c01acc00>] xfs_btree_init_cursor+0x2f/0x171 
SS:ESP 0068:cfb20c68
[196027.705801]

Jan
