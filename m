Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTI2Oat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263442AbTI2Oas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:30:48 -0400
Received: from bay7-f67.bay7.hotmail.com ([64.4.11.67]:33032 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S263441AbTI2OaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:30:14 -0400
X-Originating-IP: [212.39.68.18]
X-Originating-Email: [ndnikolov@hotmail.com]
From: "Nikolay Nikolov" <ndnikolov@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 alsa sound bug
Date: Mon, 29 Sep 2003 14:30:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F67hOY4l6Etx5300009dc0@hotmail.com>
X-OriginalArrivalTime: 29 Sep 2003 14:30:13.0763 (UTC) FILETIME=[31F17530:01C38696]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have i810 motherboard with onboard sound card. When I play some sound file 
with play for the first time after the boot, the kernel module snd_pcm_oss 
crashes. The file is played normally.
It happens when closing the /dev/dsp0
After that the /dev/dsp0 can not be opened. After that any program that 
tries to opne /dev/dsp0 sleeps on open(/dev/dsp0,...).
Here is the Oops:

Unable to handle kernel paging request at virtual address d4971000
printing eip:
d4991e1d
*pde = 01329067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<d4991e1d>]    Not tainted
EFLAGS: 00210206
EIP is at snd_pcm_format_set_silence+0x7d/0x1a0 [snd_pcm]
eax: 00000000   ebx: 0000171c   ecx: 0000078e   edx: 00002e38
esi: 00000002   edi: d4971000   ebp: c6146380   esp: ce4c3f18
ds: 007b   es: 007b   ss: 0068
Process sox (pid: 1850, threadinfo=ce4c2000 task=cedd19a0)
Stack: 00000001 ce4c2000 0000171c ce7bf000 ceb08ee0 d497a9bc 00000002 
d4970000
       0000171c ce42e8a0 c6146380 cec8d800 ce42e8a0 d497bbcc c6146380 
ce42e8a0
       cfed4260 cf10c9b8 cf31ed60 c014a10a cf10c9b8 ce42e8a0 c013f74a 
cfed7cf0
Call Trace:
[<d497a9bc>] snd_pcm_oss_sync+0x9c/0x140 [snd_pcm_oss]
[<d497bbcc>] snd_pcm_oss_release+0x1c/0x90 [snd_pcm_oss]
[<c014a10a>] __fput+0x3a/0xd0
[<c013f74a>] unmap_vma_list+0x1a/0x30
[<c0148d2c>] filp_close+0x5c/0x70
[<c0148d85>] sys_close+0x45/0x60
[<c010a7eb>] syscall_call+0x7/0xb

Code: f3 ab f6 c2 02 74 02 66 ab f6 c2 01 74 01 aa e9 05 01 00 00

play uses sox which version is 12.17.1
The kernel is 2.6.0-test6. With 2.6.0-test5 this dos not happpen.
When i use aplay this does not happend.

Here is the out from lsmod:
Module                  Size  Used by
iptable_filter          2464  1
ip_tables              14624  1 iptable_filter
snd_pcm_oss            48324  0
snd_mixer_oss          14896  1 snd_pcm_oss
snd_intel8x0           20772  0
snd_ac97_codec       46212  1 snd_intel8x0
snd_pcm                80224  2 snd_pcm_oss,snd_intel8x0
snd_timer              19872  1 snd_pcm
snd_page_alloc          9092  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         5392  1 snd_intel8x0
snd_rawmidi            18816  1 snd_mpu401_uart
snd_seq_device          6452  1 snd_rawmidi
snd                    40676  9 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device

After the crash snd_pcm_oss and snd_intel8x0 are used.

Module                  Size  Used by
iptable_filter          2464  1
ip_tables              14624  1 iptable_filter
snd_pcm_oss            48324  1
snd_mixer_oss          14896  1 snd_pcm_oss
snd_intel8x0           20772  1
snd_ac97_codec         46212  1 snd_intel8x0
snd_pcm                80224  2 snd_pcm_oss,snd_intel8x0
snd_timer              19872  1 snd_pcm
snd_page_alloc          9092  2 snd_intel8x0,snd_pcm
snd_mpu401_uart         5392  1 snd_intel8x0
snd_rawmidi            18816  1 snd_mpu401_uart
snd_seq_device          6452  1 snd_rawmidi
snd                    40676  9 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,snd_seq_device


If someone needs additional information I will be glad to help.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

