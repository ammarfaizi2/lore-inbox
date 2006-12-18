Return-Path: <linux-kernel-owner+w=401wt.eu-S1751497AbWLRBzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWLRBzZ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 20:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWLRBzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 20:55:25 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:47778 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbWLRBzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 20:55:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:content-type:content-transfer-encoding:date:message-id:mime-version:x-mailer;
        b=iffAX1jmu9VLbqUcrq+2wTUqZS5Rg6SDr9CnSW9Pon+wl8bPneibTTQSeFKEgE2eRLz0b2nftm2PseGhgd/c6HAVZYCU5gVPLe6jNgBCUh/1CSzWRDs/er7KoJIMprMPFxcEjFlSqeJrdcPNMlkcS7HaJEXmYwXKMaLPY9xUesQ=
Subject: BUG on 2.6.20-rc1 when using gdb
From: "Andrew J. Barr" <andrew.james.barr@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 17 Dec 2006 20:55:18 -0500
Message-Id: <1166406918.17143.5.camel@r51.oakcourt.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I was using gdb to debug xchat-gnome, I got a kernel BUG and stack
trace as the program was running (e.g. I had typed 'run' in gdb):

WARNING at kernel/softirq.c:137 local_bh_enable()
 [<c0103cd6>] dump_trace+0x68/0x1d9
 [<c0103e5f>] show_trace_log_lvl+0x18/0x2c
 [<c01044d3>] show_trace+0xf/0x11
 [<c010455e>] dump_stack+0x12/0x14
 [<c011cc7d>] local_bh_enable+0x44/0x94
 [<c02871b9>] unix_release_sock+0x6e/0x1fe
 [<c02887eb>] unix_stream_connect+0x3b4/0x3cf
 [<c0232dee>] sys_connect+0x82/0xad
 [<c0233641>] sys_socketcall+0xac/0x261
 [<c0102d38>] syscall_call+0x7/0xb
 [<b7f70822>] 0xb7f70822
 =======================
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1235!
invalid opcode: 0000 [#1]
PREEMPT
Modules linked in: binfmt_misc rfcomm l2cap i915 drm bluetooth nfs nfsd
exportfs lockd nfs_acl sunrpc nvram uinput ipv6 ppdev lp button ac
battery dm_crypt dm_snapshot dm_mirror dm_mod fuse cpufreq_conservative
cpufreq_ondemand cpufreq_performance cpufreq_powersave
speedstep_centrino freq_table ibm_acpi loop snd_intel8x0m snd_pcm_oss
snd_mixer_oss snd_intel8x0 snd_ac97_codec pcmcia ac97_bus irtty_sir
sir_dev ipw2200 snd_pcm snd_timer irda ieee80211 ieee80211_crypt
crc_ccitt rtc parport_pc parport 8250_pnp snd soundcore 8250_pci 8250
serial_core firmware_class i2c_i801 yenta_socket rsrc_nonstatic
pcmcia_core snd_page_alloc i2c_core intel_agp agpgart evdev tsdev joydev
ext3 jbd mbcache ide_cd cdrom ide_disk ide_generic e100 mii generic piix
ide_core ehci_hcd uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c0179266>]    Not tainted VLI
EFLAGS: 00010046   (2.6.20-rc1 #1)
EIP is at __find_get_block+0x1c/0x16f
eax: 00000086   ebx: 00000000   ecx: 00000000   edx: 0088a800
esi: 0088a800   edi: 00000000   ebp: dfffd040   esp: cad2dd30
ds: 007b   es: 007b   ss: 0068
Process xchat-gnome (pid: 4322, ti=cad2c000 task=d0cd3ab0
task.ti=cad2c000)
Stack: cad2dd58 c02caa0b 00000002 0000000e 0000000b 00000001 e8836580
0088a800
       00000000 00000000 e8836610 00000000 c01793dc 00001000 c03ab3e0
f3cadd80
       00000086 c90d41b0 0088a800 00000000 dfffd040 00008000 00000000
00000002
Call Trace:
 [<c01793dc>] __getblk+0x23/0x268
 [<f040d4c6>] ext3_getblk+0x10b/0x244 [ext3]
 [<f040e364>] ext3_bread+0x19/0x70 [ext3]
 [<f04106f3>] dx_probe+0x43/0x2c9 [ext3]
 [<f04119b3>] ext3_htree_fill_tree+0x99/0x1ba [ext3]
 [<f040ab77>] ext3_readdir+0x1d4/0x5ed [ext3]
 [<c0167b29>] vfs_readdir+0x63/0x8d
 [<c0167bb6>] sys_getdents64+0x63/0xa5
 [<c0102d38>] syscall_call+0x7/0xb
 [<b7f70822>] 0xb7f70822
 =======================
Code: 8b 40 08 a8 08 74 05 e8 02 2f 11 00 5b 5e c3 55 89 c5 57 89 cf 56
89 d6 53 83 ec 20 9c 58 90 8d b4 26 00 00 00 00 f6 c4 02 75 04 <0f> 0b
eb fe 89 e0 25 00 e0 ff ff ff 40 14 31 c9 8b 1c 8d a0 74
EIP: [<c0179266>] __find_get_block+0x1c/0x16f SS:ESP 0068:cad2dd30

This happens on 2.6.20-rc1 but not 2.6.19.

Andrew Barr
andrew.james.barr@gmail.com
