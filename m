Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274962AbTHFXMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274967AbTHFXMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:12:16 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:65437 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S274962AbTHFXLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:11:21 -0400
Date: Wed, 06 Aug 2003 16:14:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: chaboisseau@bigfoot.com
Subject: [Bug 1051] New: kernel oops when trying to play a sound (alsa / via AC97) 
Message-ID: <740760000.1060211698@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1051

           Summary: kernel oops when trying to play a sound (alsa / via
                    AC97)
    Kernel Version: 2.6.0-test2
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: chaboisseau@bigfoot.com


Distribution: Debian GNU/Linux 3.0 (sid/unstable)

Hardware Environment:

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm)
stepping        : 1
cpu MHz         : 802.250
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1576.96

384MB RAM
3 HDDs
2 NICs (8139too + Intel OEM i82557/i82558)
VGA : ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE]
Via chipsets :
$ lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master
IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio
Controller (rev 20)
00:0a.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 05)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon
8500 LE]


Software Environment:

$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18 2003
UTC).
Compiled on Jul 28 2003 for kernel 2.6.0-test2.


Problem Description:

whenever I try to play a sound (aplay, mpg321, mplayer, xmms...) I got a
segfault with the following messages in dmesg (/var/log/kern.log) :


Unable to handle kernel paging request at virtual address dd157000
 printing eip:
d8da2f7b
*pde = 0f25c067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<d8da2f7b>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d8da2f7b   ebx: 00000000   ecx: fffff11b   edx: 00290024
esi: dd166166   edi: d4f24290   ebp: dd156ffe   esp: c4277e58
ds: 007b   es: 007b   ss: 0068
Process mpg321 (pid: 3085, threadinfo=c4276000 task=d43c9280)
Stack: d8da0212 d4f24200 d36c1fe0 c4277e84 00000027 c4276000 ffffffff d76263c0
       d8da2da1 d8da2ef2 d8da2f7b d4f24270 00000000 00000004 00000004 00000001
       00240024 000003ee 0000045a 00000400 d4f24200 d3721ec0 d8da346c d4f24200
Call Trace:
 [<d8da0212>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
 [<d8da2da1>] resample_expand+0x171/0x380 [snd_pcm_oss]
 [<d8da2ef2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
 [<d8da2f7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d8da346c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
 [<d8da0607>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
 [<d8d9c3e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
 [<d8d9c58a>] snd_pcm_oss_write1+0x12a/0x1d0 [snd_pcm_oss]
 [<d8d9e6c3>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
 [<d8d9e680>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
 [<c0149fc8>] vfs_write+0xd8/0x140
 [<c014a0e2>] sys_write+0x42/0x70
 [<c0109087>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00
 <1>Unable to handle kernel paging request at virtual address dd157000
 printing eip:
d8da2f7b
*pde = 0f25c067
*pte = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<d8da2f7b>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d8da2f7b   ebx: 00000000   ecx: fffff11b   edx: 00290024
esi: dd166166   edi: d4f24290   ebp: dd156ffe   esp: c4277b98
ds: 007b   es: 007b   ss: 0068
Process mpg321 (pid: 3085, threadinfo=c4276000 task=d43c9280)
Stack: d8da0212 d4f24200 d36c1fe0 c4277bc4 00000027 00009928 ffffffff 00000002
       d8da2da1 d8da2ef2 d8da2f7b d4f24270 00000000 00000004 00000004 00000001
       00240024 000003ee 0000045a 00000400 d4f24200 d3721ec0 d8da346c d4f24200
Call Trace:
 [<d8da0212>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
 [<d8da2da1>] resample_expand+0x171/0x380 [snd_pcm_oss]
 [<d8da2ef2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
 [<d8da2f7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d8da346c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
 [<d8da0607>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
 [<d8d9c3e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
 [<c012119f>] do_timer+0xdf/0xf0
 [<d8d9ca1b>] snd_pcm_oss_sync+0xbb/0x1c0 [snd_pcm_oss]
 [<c0115df0>] default_wake_function+0x0/0x30
 [<d8d9de82>] snd_pcm_oss_release+0x22/0xc0 [snd_pcm_oss]
 [<d8d9de60>] snd_pcm_oss_release+0x0/0xc0 [snd_pcm_oss]
 [<c014af5e>] __fput+0x10e/0x120
 [<c014954d>] filp_close+0x4d/0x80
 [<c011a8e4>] put_files_struct+0x54/0xc0
 [<c011b462>] do_exit+0x152/0x3f0
 [<c0114420>] do_page_fault+0x0/0x451
 [<c01098a1>] die+0xe1/0xf0
 [<c011454c>] do_page_fault+0x12c/0x451
 [<c0115377>] try_to_wake_up+0xa7/0x150
 [<c0121280>] process_timeout+0x0/0x10
 [<c0115446>] wake_up_process+0x26/0x30
 [<c012100a>] run_timer_softirq+0x10a/0x1b0
 [<c012119f>] do_timer+0xdf/0xf0
 [<c0115b98>] schedule+0x1a8/0x3b0
 [<c010acfc>] do_IRQ+0xfc/0x130
 [<c0114420>] do_page_fault+0x0/0x451
 [<c0109231>] error_code+0x2d/0x38
 [<d8da2f7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d8da2f7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d8da0212>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
 [<d8da2da1>] resample_expand+0x171/0x380 [snd_pcm_oss]
 [<d8da2ef2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
 [<d8da2f7b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d8da346c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
 [<d8da0607>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
 [<d8d9c3e0>] snd_pcm_oss_write2+0xd0/0x150 [snd_pcm_oss]
 [<d8d9c58a>] snd_pcm_oss_write1+0x12a/0x1d0 [snd_pcm_oss]
 [<d8d9e6c3>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
 [<d8d9e680>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
 [<c0149fc8>] vfs_write+0xd8/0x140
 [<c014a0e2>] sys_write+0x42/0x70
 [<c0109087>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00

Steps to reproduce:

compile kernel, reboot play sound (with the same hardware conf)

always reproducible

the problems might have been introduced in late 60's (2.5.6x w/ x > 6)
(I'm not completely sure about this one)

