Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268964AbTCARiR>; Sat, 1 Mar 2003 12:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268965AbTCARiQ>; Sat, 1 Mar 2003 12:38:16 -0500
Received: from static-b2-191.highspeed.eol.ca ([64.56.236.191]:519 "EHLO
	TMA-1.brad-x.com") by vger.kernel.org with ESMTP id <S268964AbTCARiM>;
	Sat, 1 Mar 2003 12:38:12 -0500
Message-ID: <3E60F26E.5000402@brad-x.com>
Date: Sat, 01 Mar 2003 12:48:30 -0500
From: Brad Laue <brad@brad-x.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030223
X-Accept-Language: en-us, en, zh-cn, zh-hk, zh-sg,
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: airo.o + kfree_skb crash - 2.4.20
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the kernel PCMCIA and airo.o module. This occurred after 90
minutes of use, where the card was streaming under a megabit of traffic
at all times. Lost control of everything but video and the USB bus.

Cisco AiroNet 350 card. Several protocols in use at the time including
HTTP/SSH/NFS.

Linux Odyssey.brad-x.com 2.4.20 #10 Fri Feb 28 10:57:59 EST 2003 i686

KSymoops:

Feb 28 11:01:15 Odyssey kernel: cs: IO port probe 0x0a00-0x0aff: clean.
Feb 28 11:01:15 Odyssey kernel: ac97_codec: AC97 Audio codec, id:
\203\204v9(SigmaTel STAC9721/23)
Feb 28 14:59:22 Odyssey kernel: cs: memory probe 0xa0000000-0xa0ffffff:
clean.
Feb 28 16:16:08 Odyssey kernel: Warning: kfree_skb passed an skb still
on a list (from c01201ba).
Feb 28 16:16:08 Odyssey kernel: kernel BUG at skbuff.c:315!
Feb 28 16:16:08 Odyssey kernel: invalid operand: 0000
Feb 28 16:16:08 Odyssey kernel: CPU:    0
Feb 28 16:16:08 Odyssey kernel: EIP:    0010:[start_request+164/528]
Tainted: P
Feb 28 16:16:08 Odyssey kernel: EIP:    0010:[<c01dca24>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 28 16:16:08 Odyssey kernel: EFLAGS: 00010286
Feb 28 16:16:08 Odyssey kernel: eax: 00000045   ebx: c8c504a0   ecx:
cec36000
edx: cec37f7c
Feb 28 16:16:08 Odyssey kernel: esi: c12f1f84   edi: 00000000   ebp:
c12f0000
esp: c12f1f6c
Feb 28 16:16:08 Odyssey kernel: ds: 0018   es: 0018   ss: 0018
Feb 28 16:16:08 Odyssey kernel: Process keventd (pid: 2, stackpage=c12f1000)
Feb 28 16:16:08 Odyssey kernel: Stack: c0244620 c01201ba 00000000
c12f1f84 c01201ba c8c504a0 ca2dc2e4 ca2dc2e4
Feb 28 16:16:08 Odyssey kernel:        00000000 00000000 c0128df3
c0256d70 c12f1fb0 00000000 c12f0560 c12f0570
Feb 28 16:16:08 Odyssey kernel:        c12f0000 00000001 00000000
c0253fa0 00010000 00000000 00000700 c0128cc0
Feb 28 16:16:08 Odyssey kernel: Call Trace:
[sys_old_getrlimit+42/224] [sys_old_getrlimit+42/224]
[vmalloc_area_pages+243/368] [vmfree_area_pages+320/384] [rest_init+0/40]
Feb 28 16:16:08 Odyssey kernel: Call Trace:    [<c01201ba>] [<c01201ba>]
[<c0128df3>] [<c0128cc0>] [<c0105000>]
Feb 28 16:16:08 Odyssey kernel:   [<c01057ce>] [<c0128cc0>]
Feb 28 16:16:08 Odyssey kernel: Code: 0f 0b 3b 01 b1 38 24 c0 8b 5c 24
14 e9 0e
ff ff ff 8d 74 26


  >>EIP; c01dca24 <__kfree_skb+f4/110>   <=====

  >>ebx; c8c504a0 <___strtok+897dc6c/1062382c>
  >>ecx; cec36000 <___strtok+e9637cc/1062382c>
  >>edx; cec37f7c <___strtok+e965748/1062382c>
  >>esi; c12f1f84 <___strtok+101f750/1062382c>
  >>ebp; c12f0000 <___strtok+101d7cc/1062382c>
  >>esp; c12f1f6c <___strtok+101f738/1062382c>

Trace; c01201ba <__run_task_queue+5a/140>
Trace; c01201ba <__run_task_queue+5a/140>
Trace; c0128df3 <schedule_task+1a3/230>
Trace; c0128cc0 <schedule_task+70/230>
Trace; c0105000 <empty_zero_page+1000/1380>
Trace; c01057ce <kernel_thread+2e/240>
Trace; c0128cc0 <schedule_task+70/230>

Code;  c01dca24 <__kfree_skb+f4/110>
00000000 <_EIP>:
Code;  c01dca24 <__kfree_skb+f4/110>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c01dca26 <__kfree_skb+f6/110>
    2:   3b 01                     cmp    (%ecx),%eax
Code;  c01dca28 <__kfree_skb+f8/110>
    4:   b1 38                     mov    $0x38,%cl
Code;  c01dca2a <__kfree_skb+fa/110>
    6:   24 c0                     and    $0xc0,%al
Code;  c01dca2c <__kfree_skb+fc/110>
    8:   8b 5c 24 14               mov    0x14(%esp,1),%ebx
Code;  c01dca30 <__kfree_skb+100/110>
    c:   e9 0e ff ff ff            jmp    ffffff1f <_EIP+0xffffff1f>
Code;  c01dca35 <__kfree_skb+105/110>
   11:   8d 74 26 00               lea    0x0(%esi,1),%esi

-- 
// -- http://www.BRAD-X.com/ -- //


