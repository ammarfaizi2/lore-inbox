Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTKSWKX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTKSWKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 17:10:23 -0500
Received: from gprs149-211.eurotel.cz ([160.218.149.211]:25217 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264137AbTKSWKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 17:10:20 -0500
Date: Wed, 19 Nov 2003 23:10:31 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Oops when trying to play 22kHz .mp3 on via vt8223
Message-ID: <20031119221031.GA10100@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got few oopses while trying to play .mp3... I'm afraid I can
reproduce this one at will...

								Pavel

Unable to handle kernel paging request at virtual address d18d3000
 printing eip:
c035776f
*pde = 0fdec067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c035776f>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x2ff/0x340
eax: c035776f   ebx: 00000001   ecx: d18d72ce   edx: 00000000
esi: cf22a0f0   edi: cf22a110   ebp: d18d2ffe   esp: c47a7e1c
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 10091, threadinfo=c47a6000 task=c77126a0)
Stack: c47a0000 ffffffff 000003e8 00001000 c03576e1 c035776f 00000000 00000004 
       00000004 00000001 00000000 00000348 000008b5 00000400 cf22a080 ccea22c0 
       c0357c70 cf22a080 ccea2180 ccea22c0 00000400 000008b5 cf22a080 ccea2180 
Call Trace:
 [<c03576e1>] resample_expand+0x271/0x340
 [<c035776f>] resample_expand+0x2ff/0x340
 [<c0357c70>] rate_transfer+0x40/0x50
 [<c03550d1>] snd_pcm_plug_write_transfer+0x81/0xf0
 [<c0350c87>] snd_pcm_oss_write2+0xc7/0x130
 [<c03512a8>] snd_pcm_oss_sync1+0x58/0x120
 [<c011d9a0>] default_wake_function+0x0/0x20
 [<c0363bdb>] snd_pcm_format_set_silence+0x7b/0x1b0
 [<c035141b>] snd_pcm_oss_sync+0xab/0x1b0
 [<c035280d>] snd_pcm_oss_release+0x1d/0xd0
 [<c0155184>] __fput+0x104/0x120
 [<c01539c3>] filp_close+0x43/0x70
 [<c0153a43>] sys_close+0x53/0x80
 [<c0109267>] syscall_call+0x7/0xb

Code: 8b 45 00 e9 76 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb 
 <1>Unable to handle kernel paging request at virtual address d18da000
 printing eip:
c035776f
*pde = 0fdec067
*pte = 00000000
Oops: 0000 [#2]
CPU:    0
EIP:    0060:[<c035776f>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x2ff/0x340
eax: c035776f   ebx: 00000001   ecx: d18de2ce   edx: 00000000
esi: cf22a1f0   edi: cf22a210   ebp: d18d9ffe   esp: c47a7e1c
ds: 007b   es: 007b   ss: 0068
Process mpg123 (pid: 10095, threadinfo=c47a6000 task=c77126a0)
Stack: c47a0000 ffffffff 000003e8 00001010 c03576e1 c035776f 00000000 00000004 
       00000004 00000001 00000000 00000348 000008b5 00000400 cf22a180 ccea2cc0 
       c0357c70 cf22a180 ccea21c0 ccea2cc0 00000400 000008b5 cf22a180 ccea21c0 
Call Trace:
 [<c03576e1>] resample_expand+0x271/0x340
 [<c035776f>] resample_expand+0x2ff/0x340
 [<c0357c70>] rate_transfer+0x40/0x50
 [<c03550d1>] snd_pcm_plug_write_transfer+0x81/0xf0
 [<c0350c87>] snd_pcm_oss_write2+0xc7/0x130
 [<c03512a8>] snd_pcm_oss_sync1+0x58/0x120
 [<c011d9a0>] default_wake_function+0x0/0x20
 [<c0363bdb>] snd_pcm_format_set_silence+0x7b/0x1b0
 [<c035141b>] snd_pcm_oss_sync+0xab/0x1b0
 [<c035280d>] snd_pcm_oss_release+0x1d/0xd0
 [<c0155184>] __fput+0x104/0x120
 [<c01539c3>] filp_close+0x43/0x70
 [<c0153a43>] sys_close+0x53/0x80
 [<c0109267>] syscall_call+0x7/0xb

Code: 8b 45 00 e9 76 fe ff ff 8a 45 00 83 f0 80 89 c2 c1 e2 08 eb 
 spurious 8259A interrupt: IRQ7.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]




