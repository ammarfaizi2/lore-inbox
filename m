Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbSLES54>; Thu, 5 Dec 2002 13:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267372AbSLES54>; Thu, 5 Dec 2002 13:57:56 -0500
Received: from mail006.mail.bellsouth.net ([205.152.58.26]:60751 "EHLO
	imf06bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S267371AbSLES5z>; Thu, 5 Dec 2002 13:57:55 -0500
Date: Thu, 5 Dec 2002 14:04:47 -0500 (EST)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
cc: kai@tp1.ruhr-uni-bochum.de
Subject: 2.5.50-bk5: KALLSYMS shows call trace as all _stext
Message-ID: <Pine.LNX.4.43.0212051357230.10336-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting in 2.5.50-bk5 (it works in bk4), oopses when CONFIG_KALLSYMS
seems to mis-report all functions as _stext.

Call Trace:
 [<c014cec9>] _stext+0x47ec9/0x17ab4e

However, as seen in the System.map,
bwindle@razor:/giant/linux$ grep c014ce System.map
c014ce50 T get_locks_status


Full example oops:

Unable to handle kernel NULL pointer dereference at virtual address
00000008
 printing eip:
c014cbd0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c014cbd0>]    Not tainted
EFLAGS: 00010286
EIP is at _stext+0x47bd0/0x17ab4e
eax: 00000000   ebx: c8b4902f   ecx: 0000002f   edx: 00000002
esi: c13bad5c   edi: 00000000   ebp: c8b61ed8   esp: c8b61ecc
ds: 0068   es: 0068   ss: 0068
Process cat (pid: 263, threadinfo=c8b60000 task=c8cec760)
Stack: c13badd0 c13bad60 c13bad5c c8b61f14 c014cec9 c8b4902f c13bad5c 00000002
       c028a9d3 c8b60000 00000400 00000400 c8b61f0c c8b61f10 00000400 00000002
       c8b4902f 0000002f c8b61f38 c01608fa c8b49000 c8b61f74 00000000 00000400
Call Trace:
 [<c014cec9>] _stext+0x47ec9/0x17ab4e
 [<c01608fa>] _stext+0x5b8fa/0x17ab4e
 [<c015e708>] _stext+0x59708/0x17ab4e
 [<c013a4f7>] _stext+0x354f7/0x17ab4e
 [<c013a7c6>] _stext+0x357c6/0x17ab4e
 [<c0108b03>] _stext+0x3b03/0x17ab4e

Code: 8b 78 08 8b 45 14 50 8b 45 10 50 68 ec a8 28 c0 53 e8 b2 91

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


