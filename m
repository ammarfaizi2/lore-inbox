Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLDJYI>; Mon, 4 Dec 2000 04:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLDJX7>; Mon, 4 Dec 2000 04:23:59 -0500
Received: from www.wen-online.de ([212.223.88.39]:20232 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129387AbQLDJXp>;
	Mon, 4 Dec 2000 04:23:45 -0500
Date: Mon, 4 Dec 2000 09:53:03 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: test12-pre4: BUG at swap.c:271!
Message-ID: <Pine.Linu.4.10.10012040930550.654-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When stressing swap (virgin test12-pre4), I encounter the repeatable
oops below once load builds to heavy.  The vmscan.c:UnlockPage(page)
addition sets it off.  Appears 100% repeatable.



kernel BUG at swap.c:271!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012c144>]
EFLAGS: 00010282
eax: 0000001a   ebx: c120bf30   ecx: 00000000   edx: 00000001
esi: 00000001   edi: c747b084   ebp: c19f22a4   esp: c1fcff0c
ds: 0018   es: 0018   ss: 0018
Process as (pid: 526, stackpage=c1fcf000)
Stack: c0223841 c0223adc 0000010f c120bf30 c012eab5 c120bf30 c120bf30 c012eb7d 
       c120bf30 07b48067 00000025 c01228f5 c120bf30 c1a15f20 0807a000 c44d5d60 
       00054000 0047a000 c747b084 0847a000 00000018 00000000 000ce000 00000000 
Call Trace: [<c0223841>] [<c0223adc>] [<c012eab5>] [<c012eb7d>] [<c01228f5>] [<c0124ee3>] [<c0118f32>] 
       [<c011d1ab>] [<c011d35a>] [<c010afe7>] 
Code: 0f 0b 83 c4 0c 8d b4 26 00 00 00 00 f0 fe 0d c8 45 27 c0 0f 

>>EIP; c012c144 <lru_cache_del+20/4c>   <=====
Trace; c0223841 <tvecs+1f7d/2099c>
Trace; c0223adc <tvecs+2218/2099c>
Trace; c012eab5 <delete_from_swap_cache_nolock+3d/74>
Trace; c012eb7d <free_page_and_swap_cache+55/88>
Trace; c01228f5 <zap_page_range+1b1/244>
Trace; c0124ee3 <exit_mmap+df/134>
Trace; c0118f32 <mmput+16/30>
Trace; c011d1ab <do_exit+ff/284>
Trace; c011d35a <sys_exit+e/10>
Trace; c010afe7 <system_call+33/38>
Code;  c012c144 <lru_cache_del+20/4c>
00000000 <_EIP>:
Code;  c012c144 <lru_cache_del+20/4c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c146 <lru_cache_del+22/4c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012c149 <lru_cache_del+25/4c>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c012c150 <lru_cache_del+2c/4c>
   c:   f0 fe 0d c8 45 27 c0      lock decb 0xc02745c8
Code;  c012c157 <lru_cache_del+33/4c>
  13:   0f 00 00                  sldt   (%eax)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
