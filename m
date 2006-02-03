Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWBCMC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWBCMC6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWBCMC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:02:58 -0500
Received: from mail-gw-1.br-online.de ([195.37.215.43]:51144 "EHLO
	mail-gw-1.br-online.de") by vger.kernel.org with ESMTP
	id S1750708AbWBCMC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:02:58 -0500
Message-ID: <43E34662.1000704@ii-consult.com>
Date: Fri, 03 Feb 2006 13:02:42 +0100
From: Badri Pillai <badri@ii-consult.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Problem summary: after upgrading to from 2.6.15.1 -> 2.6.15.2
the system dumps following trace, when trying to reboot through KDE 3.5:

- ------------[ cut here ]------------
kernel BUG at mm/swap.c:49!
invalid operand: 0000 [#2]
SMP
Modules linked in: nls_utf8 ntfs snd_rtctimer ipv6 fglrx ata_piix libata
radeonfb scsi_mod i2c_algo_bit ipw2100 ieee80211 ehci_hcd
ieee80211_crypt 8139cp i8xx_tco joydev snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device
snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus snd_pcm snd_timer
snd soundcore snd_page_alloc i2c_i801 i2c_core shpchp yenta_socket
rsrc_nonstatic ohci1394 ieee1394 video dm_mod iptable_filter
ipt_multiport ipt_state ip_conntrack nfnetlink ipt_LOG ip_tables sunrpc
pcmcia pcmcia_core autofs4 lp parport_pc parport 8139too mii
CPU:    0
EIP:    0060:[<c013fbce>]    Tainted: P    B VLI
EFLAGS: 00013256   (2.6.15.2_DL6)
EIP is at put_page+0x4a/0x66
eax: 00000000   ebx: c1471b48   ecx: c1471b48   edx: c1471b48
esi: c15849c0   edi: da1e69e8   ebp: 00000020   esp: db55eec8
ds: 007b   es: 007b   ss: 0068
Process X (pid: 1682, threadinfo=db55e000 task=c17fe570)
Stack: c0143a8b c147d394 00000000 ffffffff dd49aa40 db1480cc b7a7b000
dd4b5b78
       dd4b5b78 00000000 c0143bf8 b7a7a000 b7a7b000 db55ef48 00000000
b7a7b000
       dd4b5b78 db1480cc c15849c0 db55ef70 00000001 b7a7b000 b7a7a000
c0143d48
Call Trace:
 [<c0143a8b>] zap_pte_range+0x172/0x236
 [<c0143bf8>] unmap_page_range+0xa9/0xf8
 [<c0143d48>] unmap_vmas+0x101/0x1e2
 [<c0147606>] unmap_region+0x92/0xf8
 [<c0147877>] do_munmap+0xd9/0xef
 [<c01478dd>] sys_munmap+0x50/0x68
 [<c0102717>] sysenter_past_esp+0x54/0x75
Code: 0b 29 00 24 39 31 c0 f0 83 42 04 ff 0f 98 c0 84 c0 74 33 89 d0 ff
52 48 c3 8b 02 89 d1 f6 c4 40 74 03 8b 4a 0c 8b
41 04 40 75 08 <0f> 0b 31 00 24 39 31 c0 f0 83 42 04 ff 0f 98 c0 84 c0
74 07 89
 <3>Debug: sleeping function called from invalid context at
include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0118710>] __might_sleep+0x8a/0x94
 [<c011b6f4>] profile_task_exit+0x18/0x48
 [<c011cf34>] do_exit+0x17/0x34a
 [<c0103862>] do_divide_error+0x0/0x88
 [<c01039b0>] do_invalid_op+0x0/0x8b
 [<c0103a2f>] do_invalid_op+0x7f/0x8b
 [<c013fbce>] put_page+0x4a/0x66
 [<c01ba078>] avc_has_perm_noaudit+0x37/0xe3
 [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
 [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
 [<c0103273>] error_code+0x4f/0x54
 [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
 [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
 [<c013fbce>] put_page+0x4a/0x66
 [<c0143a8b>] zap_pte_range+0x172/0x236
 [<c0143bf8>] unmap_page_range+0xa9/0xf8
 [<c0143d48>] unmap_vmas+0x101/0x1e2
 [<c0147606>] unmap_region+0x92/0xf8
 [<c0147877>] do_munmap+0xd9/0xef
 [<c01478dd>] sys_munmap+0x50/0x68
 [<c0102717>] sysenter_past_esp+0x54/0x75
note: X[1682] exited with preempt_count 1
scheduling while atomic: X/0x00000001/1682
 [<c02f512f>] schedule+0x43/0x601
 [<c0102717>] sysenter_past_esp+0x54/0x75
 [<c0102717>] sysenter_past_esp+0x54/0x75
 [<c011af90>] printk+0xe/0x11
 [<c02f6207>] rwsem_down_read_failed+0x143/0x162
 [<c011dfca>] .text.lock.exit+0x27/0x85
 [<c011d095>] do_exit+0x178/0x34a
 [<c0103862>] do_divide_error+0x0/0x88
 [<c01039b0>] do_invalid_op+0x0/0x8b
 [<c0103a2f>] do_invalid_op+0x7f/0x8b
 [<c013fbce>] put_page+0x4a/0x66
 [<c01ba078>] avc_has_perm_noaudit+0x37/0xe3
 [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
 [<e1c93717>] drm_free+0xb7/0x150 [fglrx]
 [<c0103273>] error_code+0x4f/0x54
 [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
 [<e1c9007b>] FGLDRM__vm_info+0xa0/0x16b [fglrx]
 [<c013fbce>] put_page+0x4a/0x66
 [<c0143a8b>] zap_pte_range+0x172/0x236
 [<c0143bf8>] unmap_page_range+0xa9/0xf8
 [<c0143d48>] unmap_vmas+0x101/0x1e2
 [<c0147606>] unmap_region+0x92/0xf8
 [<c0147877>] do_munmap+0xd9/0xef
 [<c01478dd>] sys_munmap+0x50/0x68
 [<c0102717>] sysenter_past_esp+0x54/0x75
usb 1-2: USB disconnect, address 4

- ---------------------------------
- -------------sh scripts/ver_linux output
Linux laptop 2.6.15.2_DL6 #1 SMP Wed Feb 1 10:40:33 CET 2006 i686 i686
i386 GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.91.0.2
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Linux C++ Library      6.0.2
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   075
Modules Loaded         nls_utf8 ntfs snd_rtctimer ipv6 fglrx ata_piix
libata radeonfb scsi_mod i2c_algo_bit ipw2100 ieee80211 ehci_hcd
ieee80211_crypt 8139cp i8xx_tco joydev snd_pcm_oss snd_mixer_oss
snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device
snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus snd_pcm snd_timer
snd soundcore snd_page_alloc i2c_i801 i2c_core shpchp yenta_socket
rsrc_nonstatic ohci1394 ieee1394 video dm_mod iptable_filter
ipt_multiport ipt_state ip_conntrack nfnetlink ipt_LOG ip_tables sunrpc
pcmcia pcmcia_core autofs4 lp parport_pc parport 8139too mii
- -----------------------------------


Well sure I can down grade the kernel, but may be this is of interest to
you.


Kind Regards,

Badri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD40ZigNsg6g2ylScRAvnxAJ0SW6BDaieFlA2q1ZM3JiLyElovHQCeNwzj
MRweF3GbgoBZBJUo6+3dAFw=
=K+6L
-----END PGP SIGNATURE-----
