Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVGVHrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVGVHrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 03:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVGVHrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 03:47:14 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:43441 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261983AbVGVHrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 03:47:12 -0400
Date: Fri, 22 Jul 2005 09:46:51 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: vamsi krishna <vamsi.krishnak@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Whats in this vaddr segment 0xffffe000-0xfffff000 ---p ?
In-Reply-To: <3faf0568050721232547aa2482@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0507220943550.2093@yvahk01.tjqt.qr>
References: <3faf0568050721232547aa2482@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I found that every process running in this kernel version has a
>virtual address mapping in /proc/<pid>/maps file as follows
><-------------------------------------------------------------------------------------------------->
>ffffe000-ffff000 ---p 00000000 00:00 0
><-------------------------------------------------------------------------------------------------->

If you run e.g. ldd /bin/ls, you get:

        linux-gate.so.1 =>  (0xffffe000)


>on a 64-bit(uname --all == 'Linux host 2.6.5-7.97.smp #1 <time stamp>
>x86_64 x86_64 x86_64 GNU/Linux) machine which is running the same kernel, I
>try to write the contents of the virtual address on to file with (r =
>write(fd,0xffffe000,4096) ). The write on this machine is successful. But
>if I try to write the same segment on 32-bit machine (uname --all == Linux
>host 2.6.5-7.97-smp #1 <timestamp> i686 i686 i386 GNU/Linux).
>
>The write on this 32-bit machine fails with EFAULT(14), but if memcpy
>to a buffer from this virtual address seems to work fine i.e if I do
>'memcpy(buf1,0xffffe000,4096)' it write perfectly the contents of this
>virtual address segment into the buf1.

Normally, you should not be able to read or write from/to there, since the
permission bits are ---.

>PS: BTW I'am running suse distribution and will glibc will have any
>effect on write behaviour ? (I though that since write is a syscall
>the issue might be with the kernel the thus skipping the glibc
>details)

If in doubt, start gdb and read the memory out using gdb (which will use
ptrace). It should also give an error, if the permissions are enforced
correctly.



Jan Engelhardt
-- 
