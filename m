Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTGSByg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 21:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270473AbTGSByg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 21:54:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:2700 "EHLO
	VL-MO-MR001.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S270469AbTGSByc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 21:54:32 -0400
Date: Fri, 18 Jul 2003 22:10:12 -0400
From: Simon Boulet <simon.boulet@divahost.net>
Subject: 2.6.0-test1+ Alsa + Intel 82801CA/CAM AC'97 Audio OOPS
To: linux-kernel@vger.kernel.org
Message-id: <20030719021012.GA919@i2650>
MIME-version: 1.0
X-Mailer: Balsa 2.0.12
Content-type: multipart/mixed; boundary="Boundary_(ID_b88nBlyywOdz3/OZr5N3Ng)"
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary_(ID_b88nBlyywOdz3/OZr5N3Ng)
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline

Hello everyone,

In case I am sending this to a list, please CC to me regarding anything 
related to this issue. I am not a member of the list.

I am having a Kernel OOPS with 2.6.0-test1-ac2 (same thing under non-
ac2) using ALSA with OSS compatibily enabled on an Intel 82801CA/CAM 
AC'97 (ICH3 mobile) integrated Audio.

I have activated "Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; 
AMD768/8111" ALSA support and both OSS mixer and PCM compatibility. I 
am attaching the oops.log and the ksymoops.log (not sure if the ksym 
thing is fine, new to this stuff) The non-compatibility mode seems to 
work fine though.

(ALSA driver kernel output bellow)

ALSA device list:
   #0: Intel 82801CA-ICH3 at 0x1c00, irq 10


Also, the OSS (non-ALSA) Intel ICH (i8xx) loads correctly but the sound 
output is  slow (rate or clocking problem?). My sound was fine under 
2.4.21.

(OSS driver kernel output bellow)
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
ac97_codec: AC97 Audio codec, id: 0x8384:0x7600 (SigmaTel STAC????)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not 
present), t
otal channels = 2
i810_audio: setting clocking to 64937

I realy hope you can fix this in the next release and before -test is 
over. Please keep me informed of any patches and dont hesitate to ask 
if I can help.

Simon



--Boundary_(ID_b88nBlyywOdz3/OZr5N3Ng)
Content-type: text/plain; charset=unknown-8bit; NAME=ksymoops.log
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=ksymoops.log

ksymoops 2.4.8 on i686 2.6.0-test1-ac2-acpi20030714.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test1-ac2-acpi20030714/ (default)
     -m /boot/System.map-2.6.0-test1-ac2-acpi20030714 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Error (regular_file): read_system_map stat /boot/System.map-2.6.0-test1-ac2-acpi20030714 failed
Warning (merge_maps): no symbols in merged map
 <1>Unable to handle kernel paging request at virtual address d2877000
c02e5773
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c02e5773>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: c02e5773   ebx: 00000000   ecx: 000007ff   edx: 00000000
esi: d2879166   edi: ce591e10   ebp: d2876ffe   esp: c61cbe54
ds: 007b   es: 007b   ss: 0068
Stack: c02e2bed ce591d80 cf668bc0 c61cbe80 00000000 00000000 cd113ca8 ffffffff
       c02e5597 c02e56eb c02e5773 ce591df0 00000000 00000004 00000004 00000001
       00000000 000003ee 0000045a 00000400 ce591d80 cf76fc00 c02e5c1d ce591d80
Call Trace:
 [<c02e2bed>] snd_pcm_plug_playback_channels_mask+0x72/0xd8
 [<c02e5597>] resample_expand+0x167/0x377
 [<c02e56eb>] resample_expand+0x2bb/0x377
 [<c02e5773>] resample_expand+0x343/0x377
 [<c02e5c1d>] rate_transfer+0x59/0x5d
 [<c02e2fc5>] snd_pcm_plug_write_transfer+0x95/0xf4
 [<c02df092>] snd_pcm_oss_write2+0xd0/0x13c
 [<c02df2a7>] snd_pcm_oss_write1+0x1a9/0x1d0
 [<c02e1193>] snd_pcm_oss_write+0x43/0x5d
 [<c02e1150>] snd_pcm_oss_write+0x0/0x5d
 [<c014e588>] vfs_write+0xb0/0x119
 [<c014e696>] sys_write+0x42/0x63
 [<c010911b>] syscall_call+0x7/0xb
Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00


>>EIP; c02e5773 No symbols available   <=====

Trace; c02e2bed No symbols available
Trace; c02e5597 No symbols available
Trace; c02e56eb No symbols available
Trace; c02e5773 No symbols available
Trace; c02e5c1d No symbols available
Trace; c02e2fc5 No symbols available
Trace; c02df092 No symbols available
Trace; c02df2a7 No symbols available
Trace; c02e1193 No symbols available
Trace; c02e1150 No symbols available
Trace; c014e588 No symbols available
Trace; c014e696 No symbols available
Trace; c010911b No symbols available

Code;  c02e5773 No symbols available
00000000 <_EIP>:
Code;  c02e5773 No symbols available   <=====
   0:   8b 45 00                  mov    0x0(%ebp),%eax   <=====
Code;  c02e5776 No symbols available
   3:   eb ac                     jmp    ffffffb1 <_EIP+0xffffffb1>
Code;  c02e5778 No symbols available
   5:   0f b6 45 00               movzbl 0x0(%ebp),%eax
Code;  c02e577c No symbols available
   9:   c1 e0 08                  shl    $0x8,%eax
Code;  c02e577f No symbols available
   c:   eb a3                     jmp    ffffffb1 <_EIP+0xffffffb1>
Code;  c02e5781 No symbols available
   e:   81 fa 00 80 00 00         cmp    $0x8000,%edx


2 warnings and 2 errors issued.  Results may not be reliable.

--Boundary_(ID_b88nBlyywOdz3/OZr5N3Ng)
Content-type: text/plain; charset=unknown-8bit; NAME=oops.log
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=oops.log

 <1>Unable to handle kernel paging request at virtual address d2877000
 printing eip:
c02e5773
Oops: 0000 [#6]
CPU:    0
EIP:    0060:[<c02e5773>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x343/0x377
eax: c02e5773   ebx: 00000000   ecx: 000007ff   edx: 00000000
esi: d2879166   edi: ce591e10   ebp: d2876ffe   esp: c61cbe54
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 755, threadinfo=c61ca000 task=c9515380)
Stack: c02e2bed ce591d80 cf668bc0 c61cbe80 00000000 00000000 cd113ca8 ffffffff
       c02e5597 c02e56eb c02e5773 ce591df0 00000000 00000004 00000004 00000001
       00000000 000003ee 0000045a 00000400 ce591d80 cf76fc00 c02e5c1d ce591d80
Call Trace:
 [<c02e2bed>] snd_pcm_plug_playback_channels_mask+0x72/0xd8
 [<c02e5597>] resample_expand+0x167/0x377
 [<c02e56eb>] resample_expand+0x2bb/0x377
 [<c02e5773>] resample_expand+0x343/0x377
 [<c02e5c1d>] rate_transfer+0x59/0x5d
 [<c02e2fc5>] snd_pcm_plug_write_transfer+0x95/0xf4
 [<c02df092>] snd_pcm_oss_write2+0xd0/0x13c
 [<c02df2a7>] snd_pcm_oss_write1+0x1a9/0x1d0
 [<c02e1193>] snd_pcm_oss_write+0x43/0x5d
 [<c02e1150>] snd_pcm_oss_write+0x0/0x5d
 [<c014e588>] vfs_write+0xb0/0x119
 [<c014e696>] sys_write+0x42/0x63
 [<c010911b>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00


--Boundary_(ID_b88nBlyywOdz3/OZr5N3Ng)--
