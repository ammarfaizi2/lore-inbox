Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268139AbTBSHAm>; Wed, 19 Feb 2003 02:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbTBSHAm>; Wed, 19 Feb 2003 02:00:42 -0500
Received: from happy.phnet.fi ([62.165.128.129]:28548 "HELO happy.phnet.fi")
	by vger.kernel.org with SMTP id <S268139AbTBSHAl>;
	Wed, 19 Feb 2003 02:00:41 -0500
Message-ID: <3E532DE8.1080303@sci.fi>
Date: Wed, 19 Feb 2003 09:10:32 +0200
From: Janne Heikkinen <jamse@sci.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 oopses with OSS/munmap 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When trying to to use mmap with OSS with kernel version 2.4.20, program 
causes oops
when munmapping takes place (either when calling munmap directly or when 
program is
terminating).   Program that causes this to happen with 2.4.20 seems to 
run just fine with
2.4.19. Most of the time I've been able to reboot system normally after 
this has happened
but few times it has caused system to lock up totally.

---
Feb 19 05:26:07 linux kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Feb 19 05:26:07 linux kernel:  printing eip:
Feb 19 05:26:07 linux kernel: c01329aa
Feb 19 05:26:07 linux kernel: *pde = 00000000
Feb 19 05:26:07 linux kernel: Oops: 0002
Feb 19 05:26:07 linux kernel: CPU:    0
Feb 19 05:26:07 linux kernel: EIP:    0010:[__free_pages_ok+490/640]    
Tainted: P
Feb 19 05:26:07 linux kernel: EFLAGS: 00210096
Feb 19 05:26:07 linux kernel: eax: 00000000   ebx: c1007e9c   ecx: 
c1007ec8   edx: 00000000
Feb 19 05:26:07 linux kernel: esi: c0299100   edi: 000002e1   ebp: 
00001000   esp: d03cfee0
Feb 19 05:26:07 linux kernel: ds: 0018   es: 0018   ss: 0018
Feb 19 05:26:07 linux kernel: Process snd (pid: 987, stackpage=d03cf000)
Feb 19 05:26:07 linux kernel: Stack: c029916c c100001c c1007ec8 c02990e0 
c100001c 00200213 ffffffff 00000170
Feb 19 05:26:07 linux kernel:        00001000 d0841968 00010000 00000002 
c0129308 c1007ec8 d7e2a400 40400000
Feb 19 05:26:07 linux kernel:        d2d3e404 40400000 d2d3e404 40269000 
00000000 c0127dab d78e42c0 d2d3e400
Feb 19 05:26:07 linux kernel: Call Trace:    [zap_pte_range+232/268] 
[zap_page_range+139/240] [exit_mmap+181/320] [mmput+71/160] 
[do_exit+135/576]
Feb 19 05:26:07 linux kernel:   [sys_exit+19/32] [system_call+51/56]
Feb 19 05:26:07 linux kernel:
Feb 19 05:26:07 linux kernel: Code: 89 50 04 89 02 c7 43 04 00 00 00 00 
c7 03 00 00 00 00 d1 6c
...
Feb 19 08:13:47 linux kernel: Creative EMU10K1 PCI Audio Driver, version 
0.20, 22:07:51 Jan 21 2003
Feb 19 08:13:47 linux kernel: PCI: Found IRQ 11 for device 00:0f.0
Feb 19 08:13:47 linux kernel: PCI: Sharing IRQ 11 with 00:0d.0
Feb 19 08:13:47 linux kernel: emu10k1: EMU10K1 rev 4 model 0x20 found, 
IO at 0xe000-0xe01f, IRQ 11
Feb 19 08:13:47 linux kernel: ac97_codec: AC97  codec, id: TRA3(TriTech 
TR28023)
---

Janne Heikkinen

