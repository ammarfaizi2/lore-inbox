Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130864AbQLFN6N>; Wed, 6 Dec 2000 08:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130856AbQLFN6D>; Wed, 6 Dec 2000 08:58:03 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:27069 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S130864AbQLFN5t>; Wed, 6 Dec 2000 08:57:49 -0500
Message-ID: <3A2E3E91.58CDC011@hq.factor3.com>
Date: Wed, 06 Dec 2000 14:26:41 +0100
From: Florian Wunderlich <fwunderlich@devbrain.de>
Organization: Factor3
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop & isofs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mounting an iso-image through loop, like

mount -t iso9660 -o loop image /mnt

and then reading from a file leads to this:

Dec  6 14:21:31 main kernel: kernel BUG at buffer.c:827!
Dec  6 14:21:31 main kernel: invalid operand: 0000
Dec  6 14:21:31 main kernel: CPU:    0
Dec  6 14:21:31 main kernel: EIP:    0010:[end_buffer_io_async+191/240]
Dec  6 14:21:31 main kernel: EFLAGS: 00010082
Dec  6 14:21:31 main kernel: eax: 0000001c   ebx: c11050c0   ecx:
c02046c8   edx: c560e780
Dec  6 14:21:31 main kernel: esi: c3965440   edi: 00000002   ebp:
c3965488   esp: c37d9de4
Dec  6 14:21:31 main kernel: ds: 0018   es: 0018   ss: 0018
Dec  6 14:21:31 main kernel: Process cat (pid: 390, stackpage=c37d9000)
Dec  6 14:21:31 main kernel: Stack: c01d5065 c01d531a 0000033b c3965440
c6c637c0 00000004 00000001 c0165411
Dec  6 14:21:31 main kernel:        c3965440 00000001 c6c637c0 00000000
c6c637c0 c025c4d8 c88238ad c6c637c0
Dec  6 14:21:31 main kernel:        00000001 c8824867 00000007 00000000
00000004 c025c4d8 c025c4e8 c42a1800
Dec  6 14:21:31 main kernel: Call Trace: [tvecs+12701/39704]
[tvecs+13394/39704] [end_that_request_first+97/192]
[floppy:floppy+75097/4773
4583] [floppy:floppy+79123/47730557] [__make_request+1448/1568]
[generic_make_request+256/272]
Dec  6 14:21:31 main kernel:        [ll_rw_block+333/448]
[block_read_full_page+425/544] [__alloc_pages+229/736]
[floppy:floppy+90555/4771
9125] [floppy:floppy+89980/47719700] [do_generic_file_read+806/1376]
[generic_file_read+91/128] [file_read_actor+0/96]
Dec  6 14:21:31 main kernel:        [sys_read+146/208]
[system_call+51/56]
Dec  6 14:21:31 main kernel: Code: 0f 0b 83 c4 0c 8d 73 28 8d 43 2c 39
43 2c 74 19 b9 01 00 00

This is with linux-2.4.0-test12-pre5.

I am not subscribed to linux-kernel. If you need more information, CC
me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
