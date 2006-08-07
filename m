Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750928AbWHGCuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbWHGCuV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 22:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWHGCuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 22:50:20 -0400
Received: from ms-smtp-02.socal.rr.com ([66.75.162.134]:42381 "EHLO
	ms-smtp-02.socal.rr.com") by vger.kernel.org with ESMTP
	id S1750926AbWHGCuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 22:50:20 -0400
Message-ID: <44D6AA67.4080603@san.rr.com>
Date: Sun, 06 Aug 2006 19:50:15 -0700
From: "James G. Sack (jim)" <jgsack@san.rr.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "James G. Sack (jim) -rr" <jgsack@san.rr.com>
Subject: invalid opcode, recursive fault, 2.6.17
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got this oops report while (essentially) idle, although I
note it occurred immediately following a syslogd restart.

I am running a stock FC5 kernel on an AMD Athlon(tm) XP 1500+
 (which _may_ have other hardware problems, eg with ide interface)
 (memtest86+ has recently run without any errors)

---oops-report---
Aug  6 12:40:26 localhost syslogd 1.4.1: restart.
Aug  6 18:09:16 localhost kernel: invalid opcode: 0000 [#1]
Aug  6 18:09:16 localhost kernel: last sysfs file: /block/hda/hda1/size
Aug  6 18:09:16 localhost kernel: Modules linked in: ipv6 autofs4
w83627hf hwmon_vid hwmon eeprom i2c_isa hidp rfcomm l2cap bluetooth
sunrpc sr_mod sg ide_scsi video button battery ac lp parport_pc parport
uhci_hcd ehci_hcd snd_via82xx gameport floppy snd_ac97_codec
snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
i2c_viapro i2c_core snd_pcm_oss snd_mixer_oss via_ircc snd_pcm 8139too
irda 8139cp mii crc_ccitt snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore dm_snapshot dm_zero dm_mirror
dm_mod ext3 jbd sym53c8xx scsi_transport_spi sd_mod scsi_mod
Aug  6 18:09:16 localhost kernel: CPU:    0
Aug  6 18:09:16 localhost kernel: EIP:    0060:[<ca05768d>]    Not
tainted VLI
Aug  6 18:09:16 localhost kernel: EFLAGS: 00210213   (2.6.17-1.2157_FC5 #1)
Aug  6 18:09:16 localhost kernel: EIP is at 0xca05768d
Aug  6 18:09:16 localhost kernel: eax: efe6dae0   ebx: efe6dae0   ecx:
ca057671   edx: 00000000
Aug  6 18:09:16 localhost kernel: esi: 00000020   edi: f6612e98   ebp:
f6612e98   esp: f6612c28
Aug  6 18:09:16 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 18:09:16 localhost kernel: Process mixer_applet2 (pid: 2356,
threadinfo=f6612000 task=f2515000)
Aug  6 18:09:16 localhost kernel: Stack: c046c760 f6612fb0 09714ea8
09714ef8 f6612e98 f6612e98 f6612e98 00000000
Aug  6 18:09:16 localhost kernel:        0000000a f6612ea0 00000000
00000000 c046d27b 00000000 00000000 0000000a
Aug  6 18:09:16 localhost kernel:        efe6dae0 00000000 f2515000
c04186d5 f0af3c10 f0af3c10 f0af3c00 efe6d2c0
Aug  6 18:09:16 localhost kernel: Call Trace:
Aug  6 18:09:16 localhost kernel:  <c046c760> do_sys_poll+0x1ac/0x343
<c046d27b> __pollwait+0x0/0xb1
Aug  6 18:09:16 localhost kernel:  <c04186d5>
default_wake_function+0x0/0xc  <c04186d5> default_wake_function+0x0/0xc
Aug  6 18:09:16 localhost last message repeated 4 times
Aug  6 18:09:17 localhost kernel:  <c0418857> __wake_up+0x2a/0x3d
<c05fce5b> unix_write_space+0x4a/0x74
Aug  6 18:09:17 localhost kernel:  <c0601816>
__mutex_unlock_slowpath+0x1e7/0x1ef  <c05fb9db>
unix_stream_recvmsg+0x3a8/0x458
Aug  6 18:09:17 localhost kernel:  <c05a2420> do_sock_read+0xba/0xc2
<c05a29e2> sock_aio_read+0x5e/0x6a
Aug  6 18:09:17 localhost kernel:  <c06024bd> _spin_unlock_irq+0x5/0x7
<f88f3e9d> snd_ctl_read+0x1e4/0x1fe [snd]
Aug  6 18:09:17 localhost kernel:  <c05fab85> unix_ioctl+0xa3/0xac
<c05a2cd3> sock_ioctl+0x1ae/0x1cd
Aug  6 18:09:17 localhost kernel:  <c05a2b25> sock_ioctl+0x0/0x1cd
<c046be3d> do_ioctl+0x19/0x4d
Aug  6 18:09:17 localhost kernel:  <c04d86a2> copy_to_user+0x54/0x6a
<c046c93b> sys_poll+0x44/0x47
Aug  6 18:09:17 localhost kernel:  <c0402cb3> syscall_call+0x7/0xb
Aug  6 18:09:17 localhost kernel: Code: 00 00 d2 5c b5 44 00 00 00 00 0c
00 00 00 00 d0 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
00 00 00 ad 4e ad de ff <ff> ff ff ff ff ff ff 01 00 00 00 01 00 00 00
ad 4e ad de ff ff
Aug  6 18:09:17 localhost kernel: EIP: [<ca05768d>] 0xca05768d SS:ESP
0068:f6612c28
Aug  6 18:09:17 localhost kernel:  <1>BUG: unable to handle kernel
paging request at virtual address 0e090827
Aug  6 18:09:17 localhost kernel:  printing eip:
Aug  6 18:09:17 localhost kernel: 0e090827
Aug  6 18:09:17 localhost kernel: *pde = 00000000
Aug  6 18:09:17 localhost kernel: Oops: 0000 [#2]
Aug  6 18:09:18 localhost kernel: last sysfs file: /block/hda/hda1/size
Aug  6 18:09:18 localhost kernel: Modules linked in: ipv6 autofs4
w83627hf hwmon_vid hwmon eeprom i2c_isa hidp rfcomm l2cap bluetooth
sunrpc sr_mod sg ide_scsi video button battery ac lp parport_pc parport
uhci_hcd ehci_hcd snd_via82xx gameport floppy snd_ac97_codec
snd_ac97_bus snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq
i2c_viapro i2c_core snd_pcm_oss snd_mixer_oss via_ircc snd_pcm 8139too
irda 8139cp mii crc_ccitt snd_timer snd_page_alloc snd_mpu401_uart
snd_rawmidi snd_seq_device snd soundcore dm_snapshot dm_zero dm_mirror
dm_mod ext3 jbd sym53c8xx scsi_transport_spi sd_mod scsi_mod
Aug  6 18:09:18 localhost kernel: CPU:    0
Aug  6 18:09:18 localhost kernel: EIP:    0060:[<0e090827>]    Not
tainted VLI
Aug  6 18:09:18 localhost kernel: EFLAGS: 00210206   (2.6.17-1.2157_FC5 #1)
Aug  6 18:09:18 localhost kernel: EIP is at 0xe090827
Aug  6 18:09:18 localhost kernel: eax: efe6dae0   ebx: efe6dae0   ecx:
efe6dae0   edx: 0e090827
Aug  6 18:09:18 localhost kernel: esi: 00000044   edi: f7e332a0   ebp:
f3aa3ee0   esp: f6612a98
Aug  6 18:09:18 localhost kernel: ds: 007b   es: 007b   ss: 0068
Aug  6 18:09:18 localhost kernel: Process mixer_applet2 (pid: 2356,
threadinfo=f6612000 task=f2515000)
Aug  6 18:09:18 localhost kernel: Stack: c045a799 00000506 f7e332a0
00000044 00007fff c041d90c 00000000 00000000
Aug  6 18:09:18 localhost kernel:        f25154b8 f2515000 f7e332a0
0000000b c041e9d3 f6612afc c052912f c0617efe
Aug  6 18:09:19 localhost kernel:        00000004 c06bad62 00000001
0000000f f6612bf4 c0400068 f6612000 f6612bf4
Aug  6 18:09:19 localhost kernel: Call Trace:
Aug  6 18:09:19 localhost kernel:  <c045a799> filp_close+0x33/0x59
<c041d90c> put_files_struct+0x63/0xa5
Aug  6 18:09:19 localhost kernel:  <c041e9d3> do_exit+0x1f8/0x768
<c052912f> do_unblank_screen+0x2a/0x127
Aug  6 18:09:19 localhost kernel:  <c04042c0> die+0x27b/0x2a0
<c04048a5> do_invalid_op+0x0/0xab
Aug  6 18:09:19 localhost kernel:  <c0404947> do_invalid_op+0xa2/0xab
<c0405047> do_IRQ+0x75/0x80
Aug  6 18:09:19 localhost kernel:  <c04134a1>
smp_apic_timer_interrupt+0x32/0x39  <c04036f2> common_interrupt+0x1a/0x20
Aug  6 18:09:19 localhost kernel:  <c06024bd> _spin_unlock_irq+0x5/0x7
<c060043c> schedule+0x526/0x582
Aug  6 18:09:19 localhost kernel:  <c04037df> error_code+0x4f/0x54
<c046c760> do_sys_poll+0x1ac/0x343
Aug  6 18:09:19 localhost kernel:  <c046d27b> __pollwait+0x0/0xb1
<c04186d5> default_wake_function+0x0/0xc
Aug  6 18:09:19 localhost kernel:  <c04186d5>
default_wake_function+0x0/0xc  <c04186d5> default_wake_function+0x0/0xc
Aug  6 18:09:20 localhost last message repeated 3 times
Aug  6 18:09:20 localhost kernel:  <c04186d5>
default_wake_function+0x0/0xc  <c0418857> __wake_up+0x2a/0x3d
Aug  6 18:09:20 localhost kernel:  <c05fce5b> unix_write_space+0x4a/0x74
 <c0601816> __mutex_unlock_slowpath+0x1e7/0x1ef
Aug  6 18:09:20 localhost kernel:  <c05fb9db>
unix_stream_recvmsg+0x3a8/0x458  <c05a2420> do_sock_read+0xba/0xc2
Aug  6 18:09:20 localhost kernel:  <c05a29e2> sock_aio_read+0x5e/0x6a
<c06024bd> _spin_unlock_irq+0x5/0x7
Aug  6 18:09:20 localhost kernel:  <f88f3e9d> snd_ctl_read+0x1e4/0x1fe
[snd]  <c05fab85> unix_ioctl+0xa3/0xac
Aug  6 18:09:20 localhost kernel:  <c05a2cd3> sock_ioctl+0x1ae/0x1cd
<c05a2b25> sock_ioctl+0x0/0x1cd
Aug  6 18:09:21 localhost kernel:  <c046be3d> do_ioctl+0x19/0x4d
<c04d86a2> copy_to_user+0x54/0x6a
Aug  6 18:09:21 localhost kernel:  <c046c93b> sys_poll+0x44/0x47
<c0402cb3> syscall_call+0x7/0xb
Aug  6 18:09:21 localhost kernel: Code:  Bad EIP value.
Aug  6 18:09:21 localhost kernel: EIP: [<0e090827>] 0xe090827 SS:ESP
0068:f6612a98
Aug  6 18:09:21 localhost kernel:  <1>Fixing recursive fault but reboot
is needed!
Aug  6 18:11:23 localhost shutdown[5797]: shutting down for system reboot
---end-of-oops---

Please cc replies to jgsack@san.rr.com

Regards,
..jim


