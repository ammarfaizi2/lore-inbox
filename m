Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284711AbRLJVgA>; Mon, 10 Dec 2001 16:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284710AbRLJVc4>; Mon, 10 Dec 2001 16:32:56 -0500
Received: from mail1.arcor-ip.de ([145.253.2.10]:49360 "EHLO mail1.arcor-ip.de")
	by vger.kernel.org with ESMTP id <S284731AbRLJVc0>;
	Mon, 10 Dec 2001 16:32:26 -0500
Message-ID: <3C1529E3.8070108@arcormail.de>
Date: Mon, 10 Dec 2001 22:32:19 +0100
From: Hartmut Holz <hartmut.holz@arcormail.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.17-pre6: mjpeg/lavtools and a kernel freeze
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I am using lavrec the kernel becomes unusable. Freeze isn't the right word.
There is still some live.

Example:

1.) lavrec ... movie.avi (via bttv and emu10k, about 18 min);
2.) lavplay moive.avi    (after a short time segmentation fault)
3.) It is possible to login from another machine, w dosen't work, shutdown doesn't work:

/var/log/messsage:
------------------

Dec 10 21:35:17 woodpecker kernel: invalid operand: 0000
Dec 10 21:35:17 woodpecker kernel: CPU:    0
Dec 10 21:35:17 woodpecker kernel: EIP:    0010:[rmqueue+408/480]    Tainted: P
Dec 10 21:35:17 woodpecker kernel: EIP:    0010:[<c012e598>]    Tainted: P
Dec 10 21:35:17 woodpecker kernel: EFLAGS: 00210202
Dec 10 21:35:17 woodpecker kernel: eax: 00000040   ebx: c100b3c0   ecx: c0289400   edx: 000002cf
Dec 10 21:35:17 woodpecker kernel: esi: 00001000   edi: c1000000   ebp: c0289400   esp: d6a8be88
Dec 10 21:35:17 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 21:35:17 woodpecker kernel: Process lavplay (pid: 1637, stackpage=d6a8b000)
Dec 10 21:35:17 woodpecker kernel: Stack: 000002cf 00200286 00000000 c0289400 c0289620 0000023f 00000000 c1789c78
Dec 10 21:35:17 woodpecker kernel:        c012e7f1 c02894a8 c0289618 000001d2 c1019400 c9027130 0000105d 00001071
Dec 10 21:35:17 woodpecker kernel:        c1789c78 c0126fa9 c6579920 00000014 0000105d c6579920 00000020 c0127605
Dec 10 21:35:17 woodpecker kernel: Call Trace: [__alloc_pages+65/384] [page_cache_read+121/192] [generic_file_readahead+245/304] 
[do_generic_file_read+504/1120] [generic_file_read+124/304]
Dec 10 21:35:17 woodpecker kernel: Call Trace: [<c012e7f1>] [<c0126fa9>] [<c0127605>] [<c0127878>] [<c0127d9c>]
Dec 10 21:35:17 woodpecker kernel:    [file_read_actor+0/96] [sys_read+150/208] [sys_llseek+252/272] [system_call+51/56]
Dec 10 21:35:17 woodpecker kernel:    [<c0127cc0>] [<c0134446>] [<c013439c>] [<c0106f3b>]
Dec 10 21:35:17 woodpecker kernel:
Dec 10 21:35:17 woodpecker kernel: Code: 0f 0b 8b 43 18 a9 80 00 00 00 74 02 0f 0b 89 d8 eb 23 8d b6
Dec 10 21:35:17 woodpecker kernel:  invalid operand: 0000
Dec 10 21:35:17 woodpecker kernel: CPU:    1
Dec 10 21:35:17 woodpecker kernel: EIP:    0010:[rmqueue+408/480]    Tainted: P
Dec 10 21:35:17 woodpecker kernel: EIP:    0010:[<c012e598>]    Tainted: P
Dec 10 21:35:17 woodpecker kernel: EFLAGS: 00013202
Dec 10 21:35:17 woodpecker kernel: eax: 00000040   ebx: c100b380   ecx: c0289400   edx: 000002ce
Dec 10 21:35:17 woodpecker kernel: esi: 00001000   edi: c1000000   ebp: c0289400   esp: d7025bc0
Dec 10 21:35:17 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 21:35:17 woodpecker kernel: Process lavplay (pid: 1636, stackpage=d7025000)
Dec 10 21:35:17 woodpecker kernel: Stack: 000002ce 00003286 00000000 c0289400 c0289620 00000120 00000000 00000010
Dec 10 21:35:17 woodpecker kernel:        c012e86d c02894a8 c0289618 000001d2 00004100 00000000 c17c0bd4 00000265
Dec 10 21:35:17 woodpecker kernel:        00000000 c0129859 d7025c30 00001000 00000000 00001000 fffffff4 00000000
Dec 10 21:35:18 woodpecker kernel: Call Trace: [__alloc_pages+189/384] [generic_file_write+1049/1664] [get_user_pages+252/384] 
[dump_write+26/48] [elf_core_dump+2298/2432]
Dec 10 21:35:18 woodpecker kernel: Call Trace: [<c012e86d>] [<c0129859>] [<c0123ebc>] [<c014c3fa>] [<c014ce3a>]
Dec 10 21:35:18 woodpecker kernel:    [do_coredump+272/336] [dequeue_signal+109/176] [do_signal+491/688] 
[scsi_bottom_half_handler+192/560] [schedule+1097/1280] [signal_return+20/24]
Dec 10 21:35:18 woodpecker kernel:    [<c013c660>] [<c011f23d>] [<c0106d8b>] [<c019a910>] [<c0114269>] [<c0106f74>]
Dec 10 21:35:18 woodpecker kernel:
Dec 10 21:35:18 woodpecker kernel: Code: 0f 0b 8b 43 18 a9 80 00 00 00 74 02 0f 0b 89 d8 eb 23 8d b6
Dec 10 21:35:53 woodpecker kernel:  invalid operand: 0000
Dec 10 21:35:53 woodpecker kernel: CPU:    1
Dec 10 21:35:53 woodpecker kernel: EIP:    0010:[rmqueue+408/480]    Tainted: P
Dec 10 21:35:53 woodpecker kernel: EIP:    0010:[<c012e598>]    Tainted: P
Dec 10 21:35:53 woodpecker kernel: EFLAGS: 00210202
Dec 10 21:35:53 woodpecker kernel: eax: 00000040   ebx: c100b340   ecx: c0289400   edx: 000002cd
Dec 10 21:35:53 woodpecker kernel: esi: 00001000   edi: c1000000   ebp: c0289400   esp: ce521e40
Dec 10 21:35:53 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 21:35:53 woodpecker kernel: Process gnome-terminal (pid: 1641, stackpage=ce521000)
Dec 10 21:35:53 woodpecker kernel: Stack: 000002cd 00200282 00000000 c0289400 c0289620 0000023f 00000000 c1004100
Dec 10 21:35:53 woodpecker kernel:        c012e7f1 c02894a8 c0289618 000001d2 c5119218 00000000 00000000 00000001
Dec 10 21:35:53 woodpecker kernel:        c1004100 c012467b c4253720 c5119218 00000000 0808601c c56d25c0 08086000
Dec 10 21:35:53 woodpecker kernel: Call Trace: [__alloc_pages+65/384] [do_wp_page+187/416] [handle_mm_fault+141/208] 
[do_mmap_pgoff+1057/1264] [do_mmap_pgoff+1075/1264]
Dec 10 21:35:53 woodpecker kernel: Call Trace: [<c012e7f1>] [<c012467b>] [<c0124d2d>] [<c01256f1>] [<c0125703>]
Dec 10 21:35:53 woodpecker kernel:    [do_page_fault+442/1280] [sys_brk+186/240] [sys_munmap+51/80] [do_page_fault+0/1280] 
[error_code+52/60]
Dec 10 21:35:53 woodpecker kernel:    [<c011333a>] [<c012505a>] [<c0125f73>] [<c0113180>] [<c010702c>]
Dec 10 21:35:53 woodpecker kernel:
Dec 10 21:35:53 woodpecker kernel: Code: 0f 0b 8b 43 18 a9 80 00 00 00 74 02 0f 0b 89 d8 eb 23 8d b6
Dec 10 21:36:01 woodpecker kernel:  invalid operand: 0000
Dec 10 21:36:01 woodpecker kernel: CPU:    1
Dec 10 21:36:01 woodpecker kernel: EIP:    0010:[rmqueue+408/480]    Tainted: P
Dec 10 21:36:01 woodpecker kernel: EIP:    0010:[<c012e598>]    Tainted: P
Dec 10 21:36:01 woodpecker kernel: EFLAGS: 00210202
Dec 10 21:36:01 woodpecker kernel: eax: 00000040   ebx: c100b300   ecx: c0289400   edx: 000002cc
Dec 10 21:36:01 woodpecker kernel: esi: 00001000   edi: c1000000   ebp: c0289400   esp: d9257e28
Dec 10 21:36:01 woodpecker kernel: ds: 0018   es: 0018   ss: 0018
Dec 10 21:36:01 woodpecker kernel: Process gnome-terminal (pid: 1643, stackpage=d9257000)
Dec 10 21:36:01 woodpecker kernel: Stack: 000002cc 00200286 00000000 c0289400 c0289620 0000023f 00000000 c6578e60
Dec 10 21:36:01 woodpecker kernel:        c012e7f1 c02894a8 c0289618 000001d2 000000d9 00000000 c56d2520 00104025
Dec 10 21:36:01 woodpecker kernel:        c6578e60 c0124aea c5ca51dc 00000001 00000001 c6578e60 c0124b94 c56d2520
Dec 10 21:36:01 woodpecker kernel: Call Trace: [__alloc_pages+65/384] [do_anonymous_page+58/176] [do_no_page+52/320] 
[handle_mm_fault+98/208] [do_mmap_pgoff+1057/1264]
Dec 10 21:36:01 woodpecker kernel: Call Trace: [<c012e7f1>] [<c0124aea>] [<c0124b94>] [<c0124d02>] [<c01256f1>]
Dec 10 21:36:01 woodpecker kernel:    [do_page_fault+442/1280] [sys_brk+186/240] [do_page_fault+0/1280] [error_code+52/60]
Dec 10 21:36:01 woodpecker kernel:    [<c011333a>] [<c012505a>] [<c0113180>] [<c010702c>]
Dec 10 21:36:01 woodpecker kernel:


