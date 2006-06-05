Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751033AbWFEMV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWFEMV2 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbWFEMV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:21:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:65213 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751033AbWFEMV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:21:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=B854/7I/rOwUevaRM9ge0G1BmPdRV5LdL9QVQ3YYJdfPS0+iFhJye0L7oSpVIyrbsw+MflX5uX+moJ7lHwTf1tfBHrKgGmbEWd4WwISc0Ie/+ex/YFxpY1i0e7oOuAZOPzR4cH6r5mqLKuasljWmgtYbQeu16Z8AHoMFxuqgpcQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Oops with 2.6.17-rc5-mm2+hotfixes when loading snd modules
Date: Mon, 5 Jun 2006 14:22:31 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Takashi Iwai <tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606051422.32276.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following Oops at boot when loading my sound modules :

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000044
 printing eip:
f8e18121
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
last sysfs file: /class/vc/vcsa1/dev
Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart
CPU:    1
EIP:    0060:[<f8e18121>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc5-mm2 #2)
EIP is at snd_seq_client_use_ptr+0x71/0x170 [snd_seq]
eax: 00000000   ebx: 00000000   ecx: c03baa50   edx: 00000000
esi: 00000001   edi: 00000282   ebp: f3a01ddc   esp: f3a01dc8
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 2430, threadinfo=f3a01000 task=f3fdf5c0)
Stack: f3a01ddc c0218a4a 00000000 f3a01de4 f69e0f38 f3a01eb0 f8e1a907 00000001
       00000002 74737953 00006d65 00000000 00000000 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace:
 <f8e1a907> snd_seq_ioctl_query_next_client+0x47/0xb0 [snd_seq]  <f8e1aa8f> snd_seq_do_ioctl+0x6f/0x80 [snd_seq]
 <f8e1ad83> snd_seq_kernel_client_ctl+0x43/0x60 [snd_seq]  <f8bd632e> snd_seq_oss_midi_lookup_ports+0x4e/0xa8 [snd_seq_oss]
 <f8bd621a> snd_seq_oss_create_client+0x7a/0x130 [snd_seq_oss]  <f8bd6024> alsa_seq_oss_init+0x24/0x70 [snd_seq_oss]
 <c0148897> sys_init_module+0x177/0x280  <c0349743> syscall_call+0x7/0xb
 <b7e79a7e> 0xb7e79a7e
Code: 00 00 00 b8 20 54 e2 f8 89 fa e8 7b 0f 53 c7 b8 00 f0 ff ff 21 e0 f7 40 14 00 ff ff 0f 0f 85 97 00 00 00 8b 00 8b 80 40 04 00 00 <8b> 40 44 85 c0 0f 84 84 00 00 00 83 fe 0f 0f 8f 88 00 00 00 80
EIP: [<f8e18121>] snd_seq_client_use_ptr+0x71/0x170 [snd_seq] SS:ESP 0068:f3a01dc8

This is with 2.6.17-rc5-mm2 + the first 3 hotfixes released by Andrew.
# uname -a
Linux dragon 2.6.17-rc5-mm2 #2 SMP PREEMPT Thu Jun 1 23:51:19 CEST 2006 i686 athlon-4 i386 GNU/Linux

Complete config, dmesg, lspci, cpuinfo, ver_linux output and more can be 
found here:
   http://www.kernel.org/pub/linux/kernel/people/juhl/2.6.17-rc5-mm2+hotfixes/
Let me know if more info is needed.


 / Jesper Juhl


