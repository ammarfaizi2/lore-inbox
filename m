Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265069AbTGWKHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 06:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264242AbTGWKHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 06:07:34 -0400
Received: from pat.uio.no ([129.240.130.16]:63954 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S265069AbTGWKHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 06:07:31 -0400
To: linux-kernel@vger.kernel.org
Cc: tiwai@suse.de
Subject: Oops with snd_via82xx and oss-emu on 2.6.0-test1
From: Joachim B Haga <cjhaga@student.matnat.uio.no>
Date: Wed, 23 Jul 2003 12:22:27 +0200
Message-ID: <yydjsmoxczks.fsf@atta.ifi.uio.no>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (usg-unix-v)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a via m10000 with integrated via82xx sound, and I get the
following oops when I play through oss emulation. Alsaplayer seems
to work fine when using alsa directly. (This may also be because 
alsaplayer does resampling itself?)

This is with dxs_support=3, without it no oops. But it is necessary,
without it the noise is bad.

The error is easily reproducable, so let me know if any more testing
is needed.

----

Unable to handle kernel paging request at virtual address d0811000
 printing eip:
d09f4f3b
*pde = 0bd6d067
*pte = 00000000
Oops: 0000 [#3]
CPU:    0
EIP:    0060:[<d09f4f3b>]    Not tainted
EFLAGS: 00010202
EIP is at resample_expand+0x34b/0x380 [snd_pcm_oss]
eax: d09f4f3b   ebx: 00000000   ecx: 000007ff   edx: 00000000
esi: d0955166   edi: cb265750   ebp: d0810ffe   esp: c6597e58
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 444, threadinfo=c6596000 task=c65cd3c0)
Stack: d09f21d2 cb2656c0 c77ca5c0 c6597e84 00000000 c747f8a8 ffffffff c02da3ec 
       d09f4d61 d09f4eb2 d09f4f3b cb265730 00000000 00000004 00000004 00000001 
       00000000 000003ee 0000045a 00000400 cb2656c0 c7834e40 d09f542c cb2656c0 
Call Trace:
 [<d09f21d2>] snd_pcm_plug_playback_channels_mask+0x72/0xe0 [snd_pcm_oss]
 [<d09f4d61>] resample_expand+0x171/0x380 [snd_pcm_oss]
 [<d09f4eb2>] resample_expand+0x2c2/0x380 [snd_pcm_oss]
 [<d09f4f3b>] resample_expand+0x34b/0x380 [snd_pcm_oss]
 [<d09f542c>] rate_transfer+0x5c/0x60 [snd_pcm_oss]
 [<d09f25c7>] snd_pcm_plug_write_transfer+0x97/0x100 [snd_pcm_oss]
 [<d09ee400>] snd_pcm_oss_write2+0xd0/0x140 [snd_pcm_oss]
 [<d09ee616>] snd_pcm_oss_write1+0x1a6/0x1d0 [snd_pcm_oss]
 [<d09f06c3>] snd_pcm_oss_write+0x43/0x60 [snd_pcm_oss]
 [<d09f0680>] snd_pcm_oss_write+0x0/0x60 [snd_pcm_oss]
 [<c014fad8>] vfs_write+0xb8/0x130
 [<c014fc02>] sys_write+0x42/0x70
 [<c010909b>] syscall_call+0x7/0xb

Code: 8b 45 00 eb ac 0f b6 45 00 c1 e0 08 eb a3 81 fa 00 80 00 00 


-- 
j.
