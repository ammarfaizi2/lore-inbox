Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUASKsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 05:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUASKsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 05:48:55 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:44301 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264505AbUASKsx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 05:48:53 -0500
Message-ID: <400BB8EB.2070500@aitel.hist.no>
Date: Mon, 19 Jan 2004 12:00:59 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.1-mm4 same sound oops as mm3
References: <20040115225948.6b994a48.akpm@osdl.org>
In-Reply-To: <20040115225948.6b994a48.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.1-mm4 gets the same sound oops as I reported for mm3.
mm4 is compiled with regparm=3, that doesn't seem to make
anything worse or better.
I'm using alsa and this driver:
 Intel i8x0/MX440, SiS 7012; Ali 5455; NForce Audio; AMD768/8111

Helge Hafting


Unable to handle kernel paging request at virtual address e295f000
 printing eip:
c02986cb
*pde = 1fe09067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02986cb>]    Not tainted VLI
EFLAGS: 00010202
EIP is at resample_expand+0x169/0x333
eax: c02986cb   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: e295b5a2   ebp: e295effe   esp: ddde1e2c
ds: 007b   es: 007b   ss: 0068
Process mozilla-bin (pid: 29173, threadinfo=ddde0000 task=da9aace0)
Stack: c029878e c02986cb df150b10 df150af0 00000000 00000004 00000004 00000001 
       00000000 0000023d 00001169 00000800 df150a80 dae9b1c0 c0298cde df150a80 
       dae9b680 dae9b1c0 00000800 00001169 df150a80 00000800 00001169 daa81a00 
Call Trace:
 [<c029878e>] resample_expand+0x22c/0x333
 [<c02986cb>] resample_expand+0x169/0x333
 [<c0298cde>] rate_transfer+0x34/0x3e
 [<c02964ee>] snd_pcm_plug_write_transfer+0x8b/0xbd
 [<c0292c7f>] snd_pcm_oss_write2+0xce/0x116
 [<c02931a0>] snd_pcm_oss_sync1+0x49/0xdb
 [<c0118422>] default_wake_function+0x0/0x12
 [<c02a23a4>] snd_pcm_format_set_silence+0x69/0x176
 [<c0293334>] snd_pcm_oss_sync+0x102/0x197
 [<c02942fe>] snd_pcm_oss_release+0x22/0x6d
 [<c0142082>] __fput+0x37/0x9b
 [<c0140ec0>] filp_close+0x59/0x62
 [<c0140f0e>] sys_close+0x45/0x50
 [<c036095f>] syscall_call+0x7/0xb
 [<c036007b>] direct_csum_partial_copy_generic+0xe1b/0x15b8

Code: 22 8b 44 24 10 ff 4c 24 10 85 c0 0f 8e 80 00 00 00 8b 44 24 04 ff e0 0f b6 45 00 eb 07 0f b6 45 00 83 f0 80 89 c6 c1 e6 08 eb 5d <8b> 75 00 eb 58 8b 75 00 eb 34 eb 39 eb 3d 8b 45 00 89 c6 c1 ee 

