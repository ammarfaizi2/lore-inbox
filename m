Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbUJYQHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbUJYQHv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 12:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUJYQGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 12:06:07 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:49591 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261990AbUJYQAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 12:00:20 -0400
Message-ID: <417D2310.5080902@free.fr>
Date: Mon, 25 Oct 2004 18:00:16 +0200
From: Vince <fuzzy77@free.fr>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG at lib/rwsem-generic.c:688] -RT-2.6.9-mm1-V0.1 + reiser4
References: <417CFD67.3080904@free.fr>
In-Reply-To: <417CFD67.3080904@free.fr>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bug is still there on 2.6.9-mm1-rt-v0.2, but the line number changed 
so I'm sending the current one:

kernel BUG at lib/rwsem-generic.c:705!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: usb_storage scsi_mod ati_remote snd_via82xx 
snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device
snd soundcore ehci_hcd usbhid uhci_hcd usbcore via_agp agpga
rt af_packet lm90 i2c_sensor i2c_viapro i2c_core floppy
CPU:    0
EIP:    0060:[<c01ffd71>]    Not tainted VLI
EFLAGS: 00010296   (2.6.9-mm1-rt-v0.2)
EIP is at up_write+0x41/0x50
eax: 00000020   ebx: dd065da0   ecx: 00000000   edx: df932000
esi: c153a960   edi: c153a960   ebp: c15d8000   esp: df933f94
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process ktxnmgrd (pid: 5569, threadinfo=df932000 task=c15d8000)
Stack: c02efec1 c03014af 000002c1 dd065d9c c01c47f8 dcaeec00 c153a9bc 
c01c595c
        c02e4ab8 dd065d50 c0103e1e dfb99000 c01c58d0 00000000 da11196c 
00000000
        00000000 df932000 da11196c c01c58d0 00000000 00000000 00000000 
c010229d
Call Trace:
  [<c01c47f8>] kcond_broadcast+0x18/0x40 (20)
  [<c01c595c>] ktxnmgrd+0x8c/0x200 (12)
  [<c0103e1e>] ret_from_fork+0x6/0x14 (12)
  [<c01c58d0>] ktxnmgrd+0x0/0x200 (8)
  [<c01c58d0>] ktxnmgrd+0x0/0x200 (28)
  [<c010229d>] kernel_thread_helper+0x5/0x18 (16)
Code: 0e 89 d8 8b 5c 24 0c 83 c4 10 e9 9b fd ff ff c7 44 24 08 c1 02 00 
00 c7 44 24 04 af
14 30 c0 c7 04 24 c1 fe 2e c0 e8 ff a1 f1 ff <0f> 0b c1 02 af 14 30 c0 
eb cc 90 8d 74 26 00 83 ec 0c c7 44 24


Vince wrote:
> Hi,
> 
>  Using 2.6.9-mm1-rt-v0.1, everything seems to be fine until I try to 
> mount a reiser4 partition and get this:
