Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSEaMST>; Fri, 31 May 2002 08:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315042AbSEaMSS>; Fri, 31 May 2002 08:18:18 -0400
Received: from smtp01.web.de ([194.45.170.210]:27680 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S314529AbSEaMSR>;
	Fri, 31 May 2002 08:18:17 -0400
Date: Fri, 31 May 2002 14:18:12 +0200
From: Moritz Breit <moritz.breit@web.de>
To: linux-kernel@vger.kernel.org
Subject: Strange problems with 2.5.17-2.5.19
Message-Id: <20020531141812.3515f2ac.moritz.breit@web.de>
X-Mailer: Sylpheed version 0.7.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I am having some problems when running 2.5.17/2.5.18/2.5.19.
This never happend with any 2.4.x kernel.
The problems appear when my computer has been running
for a few hours and I compiled gnome2 or the kernel.
It start with some strange display errors.
Or one time, all qt3-applications did not start.
Segfault. Yesterday, it was nedit which gave me
a segfault everytime I wanted to start it.

One time, with kernel 2.5.17, I got the following mail
from my local scandetd:
------8<--------
From: Scandetd@localhost
To: root@localhost
Subject: Mail notification disabled for a minute.
Date: Fri, 24 May 2002 22:01:58 +0200

Possible TCP port scanning from 224.5.0.20 to 32.186.31.212,
I've counted -736109024 connections.

First connection was made to 52225 port at Wed Sep  4 06:58:40 1946
Last connection was made to 32 port at Tue Oct  5 09:16:20 1982

Probably it was a SYN scan (402653780 FIN flags and -736100864 SYN flags)
------>8--------
This is very strange, because scandetd has nothing to do with
"Mail notification" and I have no idea, where this subject
comes from. Please also look to the number ob connections
and the date of the first/last connection. VERY strange...

A few seconds after that, I got an oops and nothing
worked any more, even the SysRq-key was not usable.
Here is the output of ksymoops:
------8<--------
May 24 22:03:41 moritz kernel: kernel BUG at page_alloc.c:103!
May 24 22:03:41 moritz kernel: invalid operand: 0000
May 24 22:03:41 moritz kernel: CPU: 0
May 24 22:03:41 moritz kernel: EIP: 0010:[__free_pages_ok+19/624] Not tainted
May 24 22:03:41 moritz kernel: EFLAGS: 00010202
May 24 22:03:41 moritz kernel: eax: 0000100c ebx: c100ff44 ecx: c100ff44 edx: 00000000
May 24 22:03:41 moritz kernel: esi: 00000000 edi: c100ff44 ebp: c6ecd228 esp: c1161eac
May 24 22:03:41 moritz kernel: ds: 0018 es: 0018 ss: 0018
May 24 22:03:41 moritz kernel: Stack: c100ff44 c100ff44 00850200 c6ecd228 c10198d4 c10198d4 c02a73c0 c012fca5
May 24 22:03:41 moritz kernel: c02a7280 00000004 00000840 c10198d4 c0128985 c012a04c 00000001 c0128d40
May 24 22:03:41 moritz kernel: c02a7534 c109f7f4 00000017 0000078e 08448000 c1161f48 0808b000 c6ecd22c
May 24 22:03:41 moritz kernel: Call Trace: [__set_page_dirty_buffers+181/192] [lru_cache_del+5/16] [page_cache_release+44/48] [swap_out+944/1392] [shrink_cache+638/752]
May 24 22:03:41 moritz kernel: Code: 0f 0b 67 00 41 53 25 c0 83 7f 08 00 74 08 0f 0b 69 00 41 53
Using defaults from ksymoops -t elf32-i386 -a i386


>>eax; 0000100c Before first symbol
>>ebx; c100ff44 <_end+cdf390/851744c>
>>ecx; c100ff44 <_end+cdf390/851744c>
>>edi; c100ff44 <_end+cdf390/851744c>
>>ebp; c6ecd228 <_end+6b9c674/851744c>
>>esp; c1161eac <_end+e312f8/851744c>

Code; 00000000 Before first symbol
00000000 <_EIP>:
Code; 00000000 Before first symbol
0: 0f 0b ud2a
Code; 00000002 Before first symbol
2: 67 00 41 53 addr16 add %al,83(%bx,%di)
Code; 00000006 Before first symbol
6: 25 c0 83 7f 08 and $0x87f83c0,%eax
Code; 0000000b Before first symbol
b: 00 74 08 0f add %dh,0xf(%eax,%ecx,1)
Code; 0000000f Before first symbol
f: 0b 69 00 or 0x0(%ecx),%ebp
Code; 00000012 Before first symbol
12: 41 inc %ecx
Code; 00000013 Before first symbol
13: 53 push %ebx
------>8--------

I am not getting these oops with 2.5.18 or 2.5.19,
but the problems are still there.

If this could be helpful, I am using debian/woody
with a few packages from sid,
and I have one AMD Duron processor and a board with
a VIA-chipset.

I hope I didn't forget to mention something and
that this can be helpful.
Moritz

-- 
Moritz Breit          Jabber:  mo42@amessage.de       
Karl-Wehrhan-Str. 17  Email:   moritz.breit@web.de
32758 Detmold         WWW:     I'm working on it ;)
Germany               Tel:     +49 5231 8785135
