Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTGGUmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTGGUmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:42:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60035 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264472AbTGGUmI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:42:08 -0400
Date: Mon, 7 Jul 2003 17:00:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: syscall __NR_mmap2
Message-ID: <Pine.LNX.4.53.0307071655470.22074@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is anybody using __NR_mmap2 function call? It doesn't work in Linux
2.4.20. It returns nice values, but the address returned does not
have any relationship to what's really there!!

write(1, "Addr = 000b8000\n", 16)       = 16
open("/dev/mem", O_RDWR)                = 3
mmap2(0xb8000, 8192, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_FIXED, 3, 0xb8000) = 0xb8000
write(1, "000B8000  FF FF FF FF FF FF FF F"..., 77) = 77
write(1, "000B8010  FF FF FF FF FF FF FF F"..., 77) = 77
write(1, "000B8020  FF FF FF FF FF FF FF F"..., 77) = 77
close(3)                                = 0
munmap(0xb8000, 8192)                   = 0
This should be displaying screen memory (it doesn't).

Does anybody care? Isn't this supposed to replace old_mmap() using
__NR_mmap? `strace` seems to think I have the right values in
the right registers. The returned value is correct, but as a
caddr_t, it doesn't point to what it's supposed to point to.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

