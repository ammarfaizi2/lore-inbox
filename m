Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbUBCUxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266157AbUBCUxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:53:38 -0500
Received: from web80409.mail.yahoo.com ([66.218.79.64]:9383 "HELO
	web80409.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266146AbUBCUve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:51:34 -0500
Message-ID: <20040203205133.49654.qmail@web80409.mail.yahoo.com>
Date: Tue, 3 Feb 2004 12:51:33 -0800 (PST)
From: matthew patton <pattonme@yahoo.com>
Subject: kernel BUG at smpboot.c:1098 on 2.4.24 kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please cc: me on responses and follow-ups since I'm not subscribed. I
am willing and able to test patches. I searched the archives but
haven't really seen anything about this.

I have a number of Compaq DL3x0 machines which are SMP PentiumIII's in
single and dual-cpu configurations. With 2.4.23 sources I built SMP
kernels and booted them just fine on UP boxes. Apparently no more. This
is the output I get upon SMP kernel load on a UP box:

<begin>
Wierd, boot CPU (#15) not listed by the BIOS
enabled ExtINT on CPU #0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Kernel BUG at smpboot.c:1098!
invalid operand: 0000
CPU:0
EIP:0010:[<c02c0812>] not tainted
EFlags: 00010293
eax: 03 ebx: 04 ecx: 01 edx: c02a0c60 esi: 9b800 edi: c0105000
ebp: 8e000 esp: c02b7fb8 ds: 18 es: 18 ss: 18
stack: c02716c0 0f 24 8e000 c011bca0 04 9b800 c0105000 8e000
 c02b8658 9b800 c0105000 c02b87d7 c026c140 c0304300 0 c0304200 c01001c9
call trace: <c011bca0> <c0105000> <c0105000>
code: 0f 0b 4a 04 b3 dc 26 c0 31 db 81 fb ff 00 00 00 74 2b 2b 1d
<0> Kernel Panic: attempted to kill the idle task!
<end>

Looking at arch/i386/kernel/smpboot.c line 1098'ish seems to imply that
the code hasn't detected that this is a UP box up about a dozen lines
where "if (!max_cpus) ... smp_num_cpus = 1; goto smp_done" if not
rather earlier in the process.

The only way I got a kernel that would work is if I set SMP=n and built
a UP-only kernel. Enabling UP-APIC was not a problem. I booted the ROM
setup to check bios settings and everything checked out on that end.

=====
* A successful marriage isn't finding the right person; it's being 
the right person.

* To forgive is to set the prisoner free and then discover the 
prisoner was you.

* Liberalism always generates the exact opposite of its stated intent.
  - Jim Quinn (WRRK)
