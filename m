Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbVEZRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbVEZRpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVEZRpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:45:08 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:40066 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261643AbVEZRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:44:55 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: pharon@gmail.com
Subject: Re: 2.6.12-rc5-mm1 alsa oops
Date: Thu, 26 May 2005 19:44:50 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1117092768.26173.4.camel@localhost>
In-Reply-To: <1117092768.26173.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505261944.50942.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

Andrew,

similar oopses as the one I'm replying to all over the place. At it happens m 
in snd_pcm_mmap_data_close(). Here's a stack trace:

May 26 19:19:14 zmei kernel: [ 9453.397240] Unable to handle kernel paging 
request at virtual address b6514060
May 26 19:19:14 zmei kernel: [ 9453.397247]  printing eip:
May 26 19:19:14 zmei kernel: [ 9453.397249] c0298ef6
May 26 19:19:14 zmei kernel: [ 9453.397250] *pde = 137ef067
May 26 19:19:14 zmei kernel: [ 9453.397252] *pte = 00000000
May 26 19:19:14 zmei kernel: [ 9453.397255] Oops: 0000 [#1]
May 26 19:19:14 zmei kernel: [ 9453.397258] PREEMPT SMP 
May 26 19:19:14 zmei kernel: [ 9453.397261] Modules linked in: nls_iso8859_15 
isofs nfsd exportfs lockd sunrpc pcspkr tuner tvaudio bttv video_buf 
firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev 
rtc
May 26 19:19:14 zmei kernel: [ 9453.397281] CPU:    0
May 26 19:19:14 zmei kernel: [ 9453.397282] EIP:    0060:
[snd_pcm_mmap_data_close+6/18]    Not tainted VLI
May 26 19:19:14 zmei kernel: [ 9453.397284] EFLAGS: 00210286   
(2.6.12-rc5-mm1) 
May 26 19:19:14 zmei kernel: [ 9453.397291] EIP is at 
snd_pcm_mmap_data_close+0x6/0x12
May 26 19:19:14 zmei kernel: [ 9453.397295] eax: b6514000   ebx: df22d714   
ecx: df22d714   edx: c0298ef0
May 26 19:19:14 zmei kernel: [ 9453.397298] esi: df22d744   edi: d160b964   
ebp: c3d6af48   esp: c3d6af48
May 26 19:19:14 zmei kernel: [ 9453.397301] ds: 007b   es: 007b   ss: 0068
May 26 19:19:14 zmei kernel: [ 9453.397304] Process xmms (pid: 5026, 
threadinfo=c3d6a000 task=dc4aa560)
May 26 19:19:14 zmei kernel: [ 9453.397307] Stack: c3d6af60 c01505e5 d61dbd38 
d61dbd38 dcd377f0 dcd377f0 c3d6af70 c0151d69 
May 26 19:19:14 zmei kernel: [ 9453.397317]        fffffff0 00000000 c3d6af80 
c0151d8a b6514000 b6504000 c3d6afa4 c0152137 
May 26 19:19:14 zmei kernel: [ 9453.397327]        b6504000 b6514000 d61dbd38 
d481a11c dcd377f0 dcd37820 00000002 c3d6afb4 
May 26 19:19:14 zmei kernel: [ 9453.397337] Call Trace:
May 26 19:19:14 zmei kernel: [ 9453.397339]  [show_stack+122/144] 
show_stack+0x7a/0x90
May 26 19:19:14 zmei kernel: [ 9453.397345]  [show_registers+342/448] 
show_registers+0x156/0x1c0
May 26 19:19:14 zmei kernel: [ 9453.397350]  [die+244/368] die+0xf4/0x170
May 26 19:19:14 zmei kernel: [ 9453.397355]  [do_page_fault+879/1695] 
do_page_fault+0x36f/0x69f
May 26 19:19:14 zmei kernel: [ 9453.397361]  [error_code+79/84] 
error_code+0x4f/0x54
May 26 19:19:14 zmei kernel: [ 9453.397365]  [remove_vm_struct+149/160] 
remove_vm_struct+0x95/0xa0
May 26 19:19:14 zmei kernel: [ 9453.397371]  [unmap_vma+89/96] 
unmap_vma+0x59/0x60
May 26 19:19:14 zmei kernel: [ 9453.397376]  [unmap_vma_list+26/48] 
unmap_vma_list+0x1a/0x30
May 26 19:19:14 zmei kernel: [ 9453.397381]  [do_munmap+231/288] 
do_munmap+0xe7/0x120
May 26 19:19:14 zmei kernel: [ 9453.397385]  [sys_munmap+78/112] 
sys_munmap+0x4e/0x70
May 26 19:19:14 zmei kernel: [ 9453.397390]  [syscall_call+7/11] 
syscall_call+0x7/0xb
May 26 19:19:14 zmei kernel: [ 9453.397394] Code: 5d c3 8d 76 00 55 8b 40 50 
89 e5 8b 40 60 f0 ff 80 a4 00 00 00 5d c3 8d b4 26 00 00 00 00 8d bc 27 00 00 
00 00 55 8b 40 50 89 e5 <8b> 40 60 f0 ff 88 a4 00 00 00 5d c3 51 52 e8 e7 63 
09 00 5a 59 
May 26 19:20:17 zmei kernel: [ 9453.397447]  <3>kfree_debugcheck: out of range 
ptr b7f24000h.
May 26 19:20:17 zmei kernel: [ 9515.781705] ------------[ cut 
here ]------------
May 26 19:20:17 zmei kernel: [ 9515.781724] kernel BUG at mm/slab.c:1893!
May 26 19:20:17 zmei kernel: [ 9515.781742] invalid operand: 0000 [#2]
May 26 19:20:17 zmei kernel: [ 9515.781758] PREEMPT SMP 
May 26 19:20:17 zmei kernel: [ 9515.781784] Modules linked in: nls_iso8859_15 
isofs nfsd exportfs lockd sunrpc pcspkr tuner tvaudio bttv video_buf 
firmware_class i2c_algo_bit v4l2_common btcx_risc tveeprom i2c_core videodev 
rtc
May 26 19:20:17 zmei kernel: [ 9515.781916] CPU:    0
May 26 19:20:17 zmei kernel: [ 9515.781918] EIP:    0060:
[kfree_debugcheck+112/128]    Not tainted VLI
May 26 19:20:17 zmei kernel: [ 9515.781920] EFLAGS: 00010096   
(2.6.12-rc5-mm1) 
May 26 19:20:17 zmei kernel: [ 9515.781971] EIP is at 
kfree_debugcheck+0x70/0x80
May 26 19:20:17 zmei kernel: [ 9515.781991] eax: 00000031   ebx: 000f7f24   
ecx: c0397dac   edx: 00000001
May 26 19:20:17 zmei kernel: [ 9515.782016] esi: b7f24000   edi: b7f24000   
ebp: df7fbef4   esp: df7fbee4
May 26 19:20:17 zmei kernel: [ 9515.782037] ds: 007b   es: 007b   ss: 0068
May 26 19:20:17 zmei kernel: [ 9515.782056] Process XFree86 (pid: 4718, 
threadinfo=df7fb000 task=daaa7a90)
May 26 19:20:17 zmei kernel: [ 9515.782069] Stack: c034d3a0 b7f24000 b7f24000 
00000000 df7fbf0c c01482cf 00000286 dcc4bf00 
May 26 19:20:17 zmei kernel: [ 9515.782139]        00000000 b7f24000 df7fbf48 
c0216205 b7b24000 df71911c 00000000 da7a9124 
May 26 19:20:17 zmei kernel: [ 9515.782206]        df71911c c014c34e dfced36c 
b7f24000 00000000 c15e82a8 dfced34c dfced37c 
May 26 19:20:17 zmei kernel: [ 9515.782276] Call Trace:
May 26 19:20:17 zmei kernel: [ 9515.782301]  [show_stack+122/144] 
show_stack+0x7a/0x90
May 26 19:20:17 zmei kernel: [ 9515.782326]  [show_registers+342/448] 
show_registers+0x156/0x1c0
May 26 19:20:17 zmei kernel: [ 9515.782350]  [die+244/368] die+0xf4/0x170
May 26 19:20:17 zmei kernel: [ 9515.782372]  [do_trap+159/176] 
do_trap+0x9f/0xb0
May 26 19:20:17 zmei kernel: [ 9515.782395]  [do_invalid_op+169/192] 
do_invalid_op+0xa9/0xc0
May 26 19:20:17 zmei kernel: [ 9515.782418]  [error_code+79/84] 
error_code+0x4f/0x54
May 26 19:20:17 zmei kernel: [ 9515.782441]  [kfree+31/144] kfree+0x1f/0x90
May 26 19:20:17 zmei kernel: [ 9515.782465]  [drm_vm_shm_close+549/704] 
drm_vm_shm_close+0x225/0x2c0
May 26 19:20:17 zmei kernel: [ 9515.782491]  [remove_vm_struct+149/160] 
remove_vm_struct+0x95/0xa0
May 26 19:20:17 zmei kernel: [ 9515.782515]  [unmap_vma+89/96] 
unmap_vma+0x59/0x60
May 26 19:20:17 zmei kernel: [ 9515.782538]  [unmap_vma_list+26/48] 
unmap_vma_list+0x1a/0x30
May 26 19:20:17 zmei kernel: [ 9515.782561]  [do_munmap+231/288] 
do_munmap+0xe7/0x120
May 26 19:20:17 zmei kernel: [ 9515.782584]  [sys_munmap+78/112] 
sys_munmap+0x4e/0x70
May 26 19:20:17 zmei kernel: [ 9515.782607]  [syscall_call+7/11] 
syscall_call+0x7/0xb
May 26 19:20:17 zmei kernel: [ 9515.782630] Code: 04 24 60 d3 34 c0 e8 00 70 
fd ff 0f 0b 6a 07 0a c5 34 c0 eb d6 8d b6 00 00 00 00 89 44 24 04 c7 04 24 a0 
d3 34 c0 e8 e0 6f fd ff <0f> 0b 65 07 0a c5 34 c0 eb a5 8d b6 00 00 00 00 55 
89 e5 57 56 

Regards,
Boris.
