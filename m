Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVJ2JJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVJ2JJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 05:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVJ2JJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 05:09:27 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:49102 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750794AbVJ2JJ0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 05:09:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kPPG0hLhwGiZrC6cvR5McHkcJI+Tn920/6kIMVyhjDKKU7B0xGYRF7msCoWW9dPV9N6zY7AN/eRdi4ccTCmSWszlwQv8obX0T8pTBiTrqiG84pxLLCPcqKiUMEHNwb4CYK1zPpsjMvrA0cRJ8pj68CjavQ+j4DeU3Zxs9dBqXzM=
Message-ID: <b2992ee70510290209h26c1fd6ex92fd137cd2c9d747@mail.gmail.com>
Date: Sat, 29 Oct 2005 11:09:25 +0200
From: Patrick Useldinger <uselpa@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: segmentation fault when accessing /proc/ioports
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

according to "oops-tracing.txt", I send you this problem report.

This is a problem I have been experiencing with all kernels I have
tried later than 2.6.11.12, currently with 2.6.13.4. I am using the
Slackware 10.2 distribution.

The system is working normally and completely stable. When I shutdown
or restart, however, I have the following message:

[code]
Oct 29 10:32:33 slackw kernel: mtrr: 0xd0000000,0x4000000 overlaps
existing 0xd0000000,0x2000000
Oct 29 10:32:45 slackw kernel: Unable to handle kernel paging request
at virtual address f8ce5a0a
Oct 29 10:32:45 slackw kernel:  printing eip:
Oct 29 10:32:45 slackw kernel: c01dbcfe
Oct 29 10:32:45 slackw kernel: *pde = 36523067
Oct 29 10:32:45 slackw kernel: *pte = 00000000
Oct 29 10:32:45 slackw kernel: Oops: 0000 [#1]
Oct 29 10:32:45 slackw kernel: PREEMPT
Oct 29 10:32:45 slackw kernel: Modules linked in: vmnet vmmon sch_sfq
snd_pcm_oss snd_mixer_oss ipv6 ipt_state ipt_REJECT ipt_LOG
ip_conntrack_ftp ip_conntrack iptable_filter ip_tables uhci_hcd
sis_agp shpchp i2c_sis96x i2c_core snd_intel8x0 snd_ac97_codec snd_pcm
snd_timer snd soundcore snd_page_alloc ohci_hcd ehci_hcd ohci1394
ieee1394 8139too mii pcmcia firmware_class yenta_socket rsrc_nonstatic
pcmcia_core dm_mod evdev agpgart lp parport_pc parport psmouse
Oct 29 10:32:45 slackw kernel: CPU:    0
Oct 29 10:32:45 slackw kernel: EIP:    0060:[<c01dbcfe>]    Tainted: P      VLI
Oct 29 10:32:45 slackw kernel: EFLAGS: 00010297   (2.6.13.4)
Oct 29 10:32:45 slackw kernel: EIP is at vsnprintf+0x35e/0x4f0
Oct 29 10:32:45 slackw kernel: eax: f8ce5a0a   ebx: 0000000a   ecx:
f8ce5a0a   edx: fffffffe
Oct 29 10:32:45 slackw kernel: esi: ee123134   edi: 00000000   ebp:
ee123fff   esp: ee257eb4
Oct 29 10:32:45 slackw kernel: ds: 007b   es: 007b   ss: 0068
Oct 29 10:32:45 slackw kernel: Process grep (pid: 5996,
threadinfo=ee256000 task=e91b6530)
Oct 29 10:32:45 slackw kernel: Stack: ee12312d ee123fff 000003e1
00000000 00000010 00000004 00000002 00000001
Oct 29 10:32:45 slackw kernel:        ffffffff ffffffff f5ceb9c0
c0350234 f5ceb9c0 00000128 c017be67 ee123128
Oct 29 10:32:45 slackw kernel:        00000ed8 c0355e66 ee257f2c
c0355e54 c011fb04 f5ceb9c0 c0355e54 00000000
Oct 29 10:32:45 slackw kernel: Call Trace:
Oct 29 10:32:45 slackw kernel:  [<c017be67>] seq_printf+0x37/0x60
Oct 29 10:32:45 slackw kernel:  [<c011fb04>] r_show+0x84/0x90
Oct 29 10:32:45 slackw kernel:  [<c017b966>] seq_read+0x1d6/0x2d0
Oct 29 10:32:45 slackw kernel:  [<c0159306>] vfs_read+0xb6/0x180
Oct 29 10:32:45 slackw kernel:  [<c01596b1>] sys_read+0x51/0x80
Oct 29 10:32:45 slackw kernel:  [<c01031a5>] syscall_call+0x7/0xb
Oct 29 10:32:45 slackw kernel: Code: 00 83 cf 01 89 44 24 24 eb bb 8b
44 24 48 8b 54 24 20 83 44 24 48 04 8b 08 b8 8c 24 36 c0 81 f9 ff 0f
00 00 0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8
83 e7 10 89 c3 75 20
Oct 29 10:32:45 slackw kernel:  <6>note: grep[5996] exited with preempt_count 1
[/code]

Before, it says something about a segmentation fault in line 54 of rc.6.
I have tracked this down to the following command in line 44:
[code] if ! grep -q -w rtc /proc/ioports ; then[/code]
and a simple [code]cat /proc/ioports[/code] gives me a segmentation
fault every time.

I have read on the kernel mailing lists that this is due to drivers
not properly unloading, so I won't post an lsmod.

Thanks for your attention,
-pu
