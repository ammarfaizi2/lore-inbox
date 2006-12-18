Return-Path: <linux-kernel-owner+w=401wt.eu-S1754144AbWLRP0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbWLRP0s (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbWLRP0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:26:48 -0500
Received: from web52913.mail.yahoo.com ([206.190.49.23]:28272 "HELO
	web52913.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754144AbWLRP0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:26:47 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 10:26:46 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bdMsbzcR2BfwX0k47rOmqjSyqNsw2KuUNMon3YQFxx1g8GyNQtVnodoVXycM8e/GHMu1eFHC1Lmslq5SQo6x9xUeeMHNx3MC1Aakx+BkHaJ8iVLb8wZ+gQ4t+jY6An9Vnoiwqw4/i4YxHAGXHEAXTeXiX3Kjy99f4eSLG6vZlR8=  ;
Message-ID: <20061218152006.52617.qmail@web52913.mail.yahoo.com>
X-YMail-OSG: E68uk8kVM1kRRSCJRVS4zNfvCSxfBbCI9GNdZgwz6NA8U8OYFB4vfp7qlS.ZmiUwig--
Date: Mon, 18 Dec 2006 15:20:06 +0000 (GMT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: [BUG] Linux 2.6.19.1 - "page_mapcount(page) went negative (-1)"
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just tripped this bug when compiling xine-lib on 2.6.19.1. This is on a dual P4, SMP and HT, 2
GB RAM, compiled with gcc-4.1.1.

Cheers,
Chris

Eeek! page_mapcount(page) went negative! (-1)
  page->flags = 14
  page->count = 0
  page->mapping = 00000000
------------[ cut here ]------------
kernel BUG at /home/chris/LINUX/linux-2.6.19/mm/rmap.c:578!
invalid opcode: 0000 [#1]
PREEMPT SMP
Modules linked in: radeon drm pwc eeprom cpufreq_ondemand p4_clockmod speedstep_lib nfsd exportfs
ipv6 autofs4 nfs lockd sunrpc af_packet firmware_class binfmt_misc video thermal processor fan
button ac lp parport_pc parport nvram video1394 raw1394 eth1394 compat_ioctl32 videodev
v4l1_compat v4l2_common snd_usb_audio snd_usb_lib snd_intel8x0 snd_emu10k1_synth snd_emux_synth
snd_seq_virmidi snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus
snd_seq_dummy snd_seq_oss ohci1394 snd_seq_midi_event snd_seq ieee1394 snd_pcm_oss snd_mixer_oss
snd_pcm ehci_hcd e7xxx_edac serio_raw snd_seq_device uhci_hcd edac_mc e1000 psmouse snd_timer
snd_page_alloc snd_util_mem snd_hwdep ide_cd cdrom snd soundcore pcspkr intel_agp i2c_i801
i2c_core agpgart usbcore ext3 jbd
CPU:    0
EIP:    0060:[<c0145fa0>]    Not tainted VLI
EFLAGS: 00010282   (2.6.19.1 #1)
EIP is at page_remove_rmap+0x70/0x8f
eax: 0000001e   ebx: c100f500   ecx: ebd0c000   edx: 00000002
esi: 00000020   edi: 08665000   ebp: eac11994   esp: ebd0cee0
ds: 007b   es: 007b   ss: 0068
Process cc1 (pid: 24220, ti=ebd0c000 task=ed5b3a90 task.ti=ebd0c000)
Stack: c0284bf0 00000000 c100f500 c0140c39 00000000 edb60518 ebd0cf54 00000000
       00000001 08696000 ec3f3084 f798f040 c200f0c0 fffffff9 ffffffff c155822c
       ec3f3084 08696000 00000000 00000000 ebd0cf54 ecfab5c0 f798f040 00000001
Call Trace:
 [<c0140c39>] unmap_vmas+0x24d/0x4df
 [<c01436ac>] exit_mmap+0x7e/0x10e
 [<c011717d>] mmput+0x1d/0x78
 [<c011bb94>] do_exit+0x1a9/0x77c
 [<c0111c2f>] do_page_fault+0x281/0x51a
 [<c0150689>] vfs_write+0xfc/0x13b
 [<c011c1dd>] sys_exit_group+0x0/0xd
 [<c0102b9d>] sysenter_past_esp+0x56/0x79
 =======================
Code: 74 03 8b 53 0c 8b 42 04 89 44 24 04 c7 04 24 d9 4b 28 c0 e8 52 3c fd ff 8b 43 10 89 44 24 04
c7 04 24 f0 4b 28 c0 e8 3f 3c fd ff <0f> 0b 42 02 66 4b 28 c0 8b 53 10 83 f2 01 83 e2 01 89 d8 5b
59
EIP: [<c0145fa0>] page_remove_rmap+0x70/0x8f SS:ESP 0068:ebd0cee0
 <1>Fixing recursive fault but reboot is needed!
BUG: scheduling while atomic: cc1/0x00000002/24220
 [<c026d6cf>] __sched_text_start+0x4f/0x900
 [<c019ed40>] cfq_free_io_context+0x57/0xbb
 [<c0140068>] sys_madvise+0x168/0x3a4
 [<c011bad9>] do_exit+0xee/0x77c
 [<c0140068>] sys_madvise+0x168/0x3a4
 [<c0140068>] sys_madvise+0x168/0x3a4
 [<c0103fc7>] die+0x2a5/0x2cc
 [<c010486c>] do_invalid_op+0x0/0xab
 [<c010490e>] do_invalid_op+0xa2/0xab
 [<c0145fa0>] page_remove_rmap+0x70/0x8f
 [<c0119b85>] vprintk+0x2b9/0x313
 [<c0119b8f>] vprintk+0x2c3/0x313
 [<c013a59c>] __pagevec_free+0x18/0x22
 [<c026ff79>] error_code+0x39/0x40
 [<c0145fa0>] page_remove_rmap+0x70/0x8f
 [<c0140c39>] unmap_vmas+0x24d/0x4df
 [<c01436ac>] exit_mmap+0x7e/0x10e
 [<c011717d>] mmput+0x1d/0x78
 [<c011bb94>] do_exit+0x1a9/0x77c
 [<c0111c2f>] do_page_fault+0x281/0x51a
 [<c0150689>] vfs_write+0xfc/0x13b
 [<c011c1dd>] sys_exit_group+0x0/0xd
 [<c0102b9d>] sysenter_past_esp+0x56/0x79
 =======================



Send instant messages to your online friends http://uk.messenger.yahoo.com 
