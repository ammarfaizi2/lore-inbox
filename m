Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbUANOLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 09:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUANOLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 09:11:50 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:18962 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261539AbUANOLq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 09:11:46 -0500
Message-ID: <400550EF.3090207@aitel.hist.no>
Date: Wed, 14 Jan 2004 15:23:43 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm3 sound oops
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened to mozilla:

Unable to handle kernel paging request at virtual address e295f000
 printing eip:
c02985b3
*pde = 1fe08067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02985b3>]    Not tainted VLI
EFLAGS: 00010202
EIP is at resample_expand+0x169/0x333
eax: c02985b3   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: e295b5a2   ebp: e295effe   esp: d8ffbe2c
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 798, threadinfo=d8ffa000 task=d9c7c080)
Stack: c0298676 c02985b3 dfc87310 dfc872f0 00000000 00000004 00000004 00000001 
       00000000 0000023d 00001169 00000800 dfc87280 d9292880 c0298bc6 dfc87280 
       d9292d00 d9292880 00000800 00001169 dfc87280 00000800 00001169 d6193680 
Call Trace:
 [<c0298676>] resample_expand+0x22c/0x333
 [<c02985b3>] resample_expand+0x169/0x333
 [<c0298bc6>] rate_transfer+0x34/0x3e
 [<c02963d6>] snd_pcm_plug_write_transfer+0x8b/0xbd
 [<c0292b67>] snd_pcm_oss_write2+0xce/0x116
 [<c0293088>] snd_pcm_oss_sync1+0x49/0xdb
 [<c0118417>] default_wake_function+0x0/0x12
 [<c02a228c>] snd_pcm_format_set_silence+0x69/0x176
 [<c029321c>] snd_pcm_oss_sync+0x102/0x197
 [<c02941e6>] snd_pcm_oss_release+0x22/0x6d
 [<c01420ea>] __fput+0x37/0x9b
 [<c0140f28>] filp_close+0x59/0x62
 [<c0140f76>] sys_close+0x45/0x50
 [<c0360847>] syscall_call+0x7/0xb
 [<c036007b>] direct_csum_partial_copy_generic+0xf33/0x15b8

Code: 22 8b 44 24 10 ff 4c 24 10 85 c0 0f 8e 80 00 00 00 8b 44 24 04 ff e0 0f b6 45 00 eb 07 0f b6 45 00 83 f0 80 89 c6 c1 e6 08 eb 5d <8b> 75 00 eb 58 8b 75 00 eb 34 eb 39 eb 3d 8b 45 00 89 c6 c1 ee 

I use ALSA with oss emulation, and the following hw driver:
Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; AMD768/8111
The kernel is monolithic and optimized for size.

The machine survived just fine, only mozilla got stuck and had to be killed.

Helge Hafting

