Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbUJYNTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUJYNTj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUJYNTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:19:39 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:53161 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261167AbUJYNTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:19:37 -0400
Message-ID: <417CFD67.3080904@free.fr>
Date: Mon, 25 Oct 2004 15:19:35 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [BUG at lib/rwsem-generic.c:688] -RT-2.6.9-mm1-V0.1 + reiser4
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Using 2.6.9-mm1-rt-v0.1, everything seems to be fine until I try to 
mount a reiser4 partition and get this:

------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:688!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage scsi_mod ati_remote snd_via82xx 
snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer 
snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore 
usbhid ehci_hcd uhci_hcd usbcore via_agp agpga
rt af_packet lm90 i2c_sensor i2c_viapro i2c_core floppy
CPU:    0
EIP:    0060:[<c0200b31>]    Not tainted VLI
EFLAGS: 00010296   (2.6.9-mm1-rt-v0.1)
EIP is at up_write+0x41/0x50
eax: 00000020   ebx: da253db0   ecx: 00000000   edx: da2c6000
esi: dd2b4d60   edi: dd2b4d60   ebp: df92faa0   esp: da2c7f94
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ktxnmgrd (pid: 5513, threadinfo=da2c6000 task=df92faa0)
Stack: c02f1481 c03029ef 000002b0 da253dac c01c52a8 de044200 dd2b4db0 
c01c641c
        c02e6078 da253d60 c0103e9e df92f000 c01c6390 00000000 da2ec958 
00000000
        00000000 da2c6000 da2ec958 c01c6390 00000000 00000000 00000000 
c010229d
Call Trace:
  [<c01c52a8>] kcond_broadcast+0x18/0x40 (20)
  [<c01c641c>] ktxnmgrd+0x8c/0x1f0 (12)
  [<c0103e9e>] ret_from_fork+0x6/0x14 (12)
  [<c01c6390>] ktxnmgrd+0x0/0x1f0 (8)
  [<c01c6390>] ktxnmgrd+0x0/0x1f0 (28)
  [<c010229d>] kernel_thread_helper+0x5/0x18 (16)
Code: 0e 89 d8 8b 5c 24 0c 83 c4 10 e9 bb fd ff ff c7 44 24 08 b0 02 00 
00 c7 44 24 04 ef 29 30 c0 c7 04 24 81
14 2f c0 e8 0f 96 f1 ff <0f> 0b b0 02 ef 29 30 c0 eb cc 90 8d 74 26 00 
55 57 56 89 c6 53

