Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265612AbTGICJI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 22:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265613AbTGICJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 22:09:08 -0400
Received: from twinlark.arctic.org ([168.75.98.6]:53696 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S265612AbTGICI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 22:08:59 -0400
Date: Tue, 8 Jul 2003 19:23:35 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 won't boot with keyboard plugged in
In-Reply-To: <Pine.LNX.4.53.0306211430280.26771@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.53.0307081920240.4605@twinlark.arctic.org>
References: <Pine.LNX.4.53.0306211430280.26771@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.53.0307081920242.4605@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi -- i've done some more debugging on this and i've discovered i can get
this system to boot (with working keyboard and mouse) if i add
"i8042_nomux" to the kernel args.  this at least seems like a workaround,
but this system works fine in 2.4 so it seems something is wrong in 2.5.

-dean

On Sat, 21 Jun 2003, dean gaudet wrote:

> i've got a system which boots to this point:
>
> ...
> Uniform CD-ROM driver Revision: 3.12
> mice: PS/2 mouse device common for all mice
> i8042.c: Detected active multiplexing controller, rev 1.1.
> serio: i8042 AUX0 port at 0x60,0x64 irq 12
> serio: i8042 AUX1 port at 0x60,0x64 irq 12
> atkbd.c: frame/parity error: 02
> atkbd.c: frame/parity error: 02
> atkbd.c: frame/parity error: 02
> atkbd.c: frame/parity error: 02
>
> that message repeats dozens of times then it gets into a crash oops loop,
> printing oops after oops after oops, which i'm not sure contain any useful
> data, but i've included the first oops below.
>
> the system boots fine if i unplug the keyboard & mouse.
>
> any ideas?
>
> i attached the non-comments portion of the config.
>
> -dean
>
> <1>Unable to handle kernel NULL pointer dereference at virtual address 0000005c
>  printing eip:
> c011367d
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c011367d>]    Not tainted
> EFLAGS: 00010013
> EIP is at do_page_fault+0x3d/0x3f4
> eax: dde3e000   ebx: 00000000   ecx: 0000007b   edx: 0000007b
> esi: 00000000   edi: 0000005c   ebp: dde8a028   esp: dde3e094
> ds: 007b   es: 007b   ss: 0068
> Process  (pid: -571573688, threadinfo=dde3c000 task=ddee79cc)
> Stack: c14d2304 00000032 00000001 000041ed 00000003 00000000 00000000 00000000
>        00000000 00000000 3e25f0bc 0d394db0 3e25f0bc 0d394db0 3e25f0bc 0d394db0
>        0000000c 00001000 00000000 00000000 00000000 00000001 00000000 dde3e0f0
> Call Trace:
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c01a9774>] pci_release_dev+0x0/0xc
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c01a9774>] pci_release_dev+0x0/0xc
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>  [<c0113640>] do_page_fault+0x0/0x3f4
>  [<c01090d9>] error_code+0x2d/0x38
>  [<c011367d>] do_page_fault+0x3d/0x3f4
>
>
