Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129385AbQK3KdR>; Thu, 30 Nov 2000 05:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129797AbQK3KdG>; Thu, 30 Nov 2000 05:33:06 -0500
Received: from 213-120-136-24.btconnect.com ([213.120.136.24]:12293 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129385AbQK3KdB>;
        Thu, 30 Nov 2000 05:33:01 -0500
Date: Thu, 30 Nov 2000 10:04:34 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: load_elf_interp()->padzero()->clear_user() + page_fault = hang.
Message-ID: <Pine.LNX.4.21.0011301003000.846-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Interesting stack trace I got here on a 4way SMP machine by just running
ps -ef which hangs. Any ideas?

Stack traceback for pid 1078
    EBP       EIP         Function(args)
0x40016000 0xc0127fe8 handle_mm_fault+0x204 (0xc7798a80, 0xe9d776a0,
0x40016848, 0x1, 0xd015c000)
                               kernel .text 0xc0100000 0xc0127de4
0xc01281d8
0xd015dbc8 0xc0115b42 do_page_fault+0x18a (0xd015dbd8, 0x2, 0x7b8, 0x1ee,
0x1ee)
                               kernel .text 0xc0100000 0xc01159b8
0xc0115fa0
           0xc010c7c0 error_code+0x34
                               kernel .text 0xc0100000 0xc010c78c
0xc010c7c8
Interrupt registers:
eax = 0x00000000 ebx = 0x000007b8 ecx = 0x000001ee edx = 0x000001ee
esi = 0x00000000 edi = 0x40016848 esp = 0xd015dc0c eip = 0xc02270e7 
ebp = 0xd015dc1c xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010246
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xd015dbd8
           0xc02270e7 clear_user+0x37 (0x40016848, 0x7b8)
                               kernel .text 0xc0100000 0xc02270b0
0xc02270fc
0xd015dc2c 0xc014f84e padzero+0x1e (0x40016848, 0x0)
                               kernel .text 0xc0100000 0xc014f830
0xc014f854
0xd015dc78 0xc014fdac load_elf_interp+0x24c (0xd015dda8, 0xf71050e0,
0xd015dd78, 0xc0302ca0, 0xc014ff20)
                               kernel .text 0xc0100000 0xc014fb60
0xc014fdfc
0xd015de10 0xc01507a7 load_elf_binary+0x887 (0xd015de68, 0xd015dfc4,
0xd015de68)
                               kernel .text 0xc0100000 0xc014ff20
0xc0150af8
0xd015de48 0xc0142918 search_binary_handler+0x68 (0xd015de68, 0xd015dfc4)
                               kernel .text 0xc0100000 0xc01428b0
0xc0142a60
0xd015df9c 0xc0142ba8 do_execve+0x148 (0xc972c000, 0x80f7bcc, 0x80d760c,
0xd015dfc4)
                               kernel .text 0xc0100000 0xc0142a60
0xc0142bfc
0xd015dfbc 0xc010af6f sys_execve+0x2f (0x80f7aac, 0x80f7bcc, 0x80d760c,
0x80f7aac, 0x80f7aac)
                               kernel .text 0xc0100000 0xc010af40
0xc010af9c
           0xc010c68b system_call+0x33
                               kernel .text 0xc0100000 0xc010c658
0xc010c690



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
