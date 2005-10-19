Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVJSRhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJSRhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJSRhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:37:42 -0400
Received: from mail.cnsp.com ([208.3.80.17]:55742 "EHLO mail.cnsp.com")
	by vger.kernel.org with ESMTP id S1751187AbVJSRhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:37:41 -0400
Message-ID: <43568451.5020301@pihost.us>
Date: Wed, 19 Oct 2005 11:37:21 -0600
From: Anthony Martinez <pi@pihost.us>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: BUG report: mm/slab.c:2839! ; also ReiserFS NULL deref in reiserfs_free_jh
 - simultaneously.
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I captured this log message with a serial console this time. I still can't
reproduce it though, which is annoying.

After rebooting from this one, /bin/mkdir and /bin/zsh were hosed.  Udev doesn't
like starting up without the ability to make directories.

This looks like one problem causing the other - but, I don't know enough to
tell. Any assistance would be appreciated :)

If you need any more information about this, I'm on both lkml and reiserfs-list,
or you can email me.

Thanks,
Anthony Martinez

BUG:
------------[ cut here ]------------
kernel BUG at mm/slab.c:2839!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: rfcomm l2cap bluetooth ipt_state ip_conntrack iptable_filter
ip_tables tun nsc_ircc lp thermal fan button processor ac battery
hostap_crypt_wep mousedev evdev irtty_sir sir_dev irda crc_ccitt parport_pc
parport pcspkr hostap_pci hostap snd_intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
i2c_i801 hw_random uhci_hcd usbcore e100 mii ohci1394 yenta_socket
rsrc_nonstatic befs nls_iso8859_1 nls_cp437 sr_mod sbp2 scsi_mod ieee1394
psmouse nvram thinkpad cpufreq_userspace speedstep_ich freq_table speedstep_lib
CPU:    0
EIP:    0060:[<c0138b82>]    Not tainted VLI
EFLAGS: 00010002   (2.6.13.4-coffee)
EIP is at cache_reap+0xba/0x182
eax: dff6f89c   ebx: dff6f880   ecx: 00000005   edx: 00000003
esi: c6873fc0   edi: 00000002   ebp: dff29f70   esp: dff29f60
ds: 007b   es: 007b   ss: 0068
Process events/0 (pid: 3, threadinfo=dff28000 task=dff52020)
Stack: dff6f8f0 c043e9c4 00000297 c043e9c0 dff29fc0 c01256d7 00000000 c0138ac8
       00000000 00000001 00000000 dff52148 00010000 00000000 00000000 dff52020
       c0114b3f 00100100 00200200 ffffffff ffffffff dff28000 dff1ff60 dff6b680
Call Trace:
 [<c0103bd1>] show_stack+0x78/0x83
 [<c0103d26>] show_registers+0x130/0x1a2
 [<c0103ee4>] die+0xcc/0x14e
 [<c0103fd4>] do_trap+0x6e/0x8a
 [<c010421f>] do_invalid_op+0x84/0x8e
 [<c010384b>] error_code+0x4f/0x54
 [<c01256d7>] worker_thread+0x178/0x20b
 [<c0128d18>] kthread+0x6d/0x9b
 [<c01012f5>] kernel_thread_helper+0x5/0xb
Code: 00 00 00 00 e9 81 00 00 00 6b 4b 3c 05 8b 53 40 01 ca 4a 89 d0 31 d2 f7 f1
89 c7 8b 73 1c 8d 43 1c 39 c6 74 65 83 7e 10 00 74 08 <0f> 0b 17 0b d7 1d 31 c0
8b 16 8b 46 04 89 42 04 89 10 c7 06 00
 <6>note: events/0[3] exited with preempt_count 1
Unable to handle kernel NULL pointer dereference at virtual address 00000001
 printing eip:
c019bde6
*pde = 00000000
Oops: 0002 [#2]
PREEMPT
Modules linked in: rfcomm l2cap bluetooth ipt_state ip_conntrack iptable_filter
ip_tables tun nsc_ircc lp thermal fan button processor ac battery
hostap_crypt_wep mousedev evdev irtty_sir sir_dev irda crc_ccitt parport_pc
parport pcspkr hostap_pci hostap snd_intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
i2c_i801 hw_random uhci_hcd usbcore e100 mii ohci1394 yenta_socket
rsrc_nonstatic befs nls_iso8859_1 nls_cp437 sr_mod sbp2 scsi_mod ieee1394
psmouse nvram thinkpad cpufreq_userspace speedstep_ich freq_table speedstep_lib
CPU:    0
EIP:    0060:[<c019bde6>]    Not tainted VLI
EFLAGS: 00010282   (2.6.13.4-coffee)
EIP is at reiserfs_free_jh+0x29/0x59
eax: dcd559c4   ebx: dcd559bc   ecx: c10c9c00   edx: 00000001
esi: c6873f60   edi: e08510d4   ebp: c2139d6c   esp: c2139d64
ds: 007b   es: 007b   ss: 0068
Process pdflush (pid: 16521, threadinfo=c2138000 task=c6417a20)
Stack: c6873f60 00000000 c2139e10 c019c0b7 c6873f60 c483fadc c2139d9c c01312bd
       dff60b88 c2139d9c c0131308 c10f0ee0 c10f0ee0 00000050 c2139dbc 00000046
       00000000 00001000 c2139de8 c014c673 d4dc514c d4dc514c dd54ea1c dd54ea4c
Call Trace:
 [<c0103bd1>] show_stack+0x78/0x83
 [<c0103d26>] show_registers+0x130/0x1a2
 [<c0103ee4>] die+0xcc/0x14e
 [<c01134df>] do_page_fault+0x447/0x5ca
 [<c010384b>] error_code+0x4f/0x54
 [<c019c0b7>] write_ordered_buffers+0x105/0x1fc
 [<c019c390>] flush_commit_list+0xeb/0x38f
 [<c01a015b>] do_journal_end+0x7c1/0x7e9
 [<c019f278>] journal_end_sync+0x5e/0x65
 [<c0190bc1>] reiserfs_sync_fs+0x32/0x58
 [<c0190bf4>] reiserfs_write_super+0xd/0x11
 [<c014fb1a>] sync_supers+0x79/0xf2
 [<c0136431>] wb_kupdate+0x24/0xda
 [<c0136c6e>] __pdflush+0x102/0x1cb
 [<c0136d56>] pdflush+0x1f/0x21
 [<c0128d18>] kthread+0x6d/0x9b
 [<c01012f5>] kernel_thread_helper+0x5/0xb
Code: c9 c3 55 89 e5 56 53 8b 75 08 8b 5e 24 85 db 74 43 c7 46 24 00 00 00 00 c7
43 04 00 00 00 00 8d 43 08 8b 4b 08 8b 50 04 89 51 04 <89> 0a 89 43 08 89 40 04
53 e8 00 ca f9 ff a1 a4 0d 44 c0 5b 85
 Badness in do_exit at kernel/exit.c:787
 [<c0103bf2>] dump_stack+0x16/0x1a
 [<c0119d1f>] do_exit+0x3c/0x3ba
 [<c0103f66>] do_trap+0x0/0x8a
 [<c01134df>] do_page_fault+0x447/0x5ca
 [<c010384b>] error_code+0x4f/0x54
 [<c019c0b7>] write_ordered_buffers+0x105/0x1fc
 [<c019c390>] flush_commit_list+0xeb/0x38f
 [<c01a015b>] do_journal_end+0x7c1/0x7e9
 [<c019f278>] journal_end_sync+0x5e/0x65
 [<c0190bc1>] reiserfs_sync_fs+0x32/0x58
 [<c0190bf4>] reiserfs_write_super+0xd/0x11
 [<c014fb1a>] sync_supers+0x79/0xf2
 [<c0136431>] wb_kupdate+0x24/0xda
 [<c0136c6e>] __pdflush+0x102/0x1cb
 [<c0136d56>] pdflush+0x1f/0x21
 [<c0128d18>] kthread+0x6d/0x9b
 [<c01012f5>] kernel_thread_helper+0x5/0xb
note: pdflush[16521] exited with preempt_count 1


ver_linux:Linux coffeehost 2.6.13.4-coffee #1 Sat Oct 15 19:22:20 MDT 2005 i686
GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
reiserfsprogs          3.6.19
reiser4progs           line
pcmcia-cs              3.2.8
PPP                    2.4.3
nfs-utils              1.0.7
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   070
Modules Loaded         rfcomm l2cap bluetooth ipt_state ip_conntrack
iptable_filter ip_tables tun nsc_ircc lp thermal fan button processor ac battery
hostap_crypt_wep mousedev evdev irtty_sir sir_dev irda crc_ccitt parport_pc
parport pcspkr hostap_pci hostap snd_intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc
i2c_i801 hw_random uhci_hcd usbcore e100 mii ohci1394 yenta_socket
rsrc_nonstatic befs nls_iso8859_1 nls_cp437 sr_mod sbp2 scsi_mod ieee1394
psmouse nvram thinkpad cpufreq_userspace speedstep_ich freq_table speedstep_lib


