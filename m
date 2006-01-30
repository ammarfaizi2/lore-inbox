Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWA3UEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWA3UEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWA3UEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:04:43 -0500
Received: from iona.labri.fr ([147.210.8.143]:8842 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S964940AbWA3UEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:04:43 -0500
Message-ID: <43DE710F.9020408@labri.fr>
Date: Mon, 30 Jan 2006 21:03:27 +0100
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ASLR] Better control on Randomization
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I would like to have a way to enable/disable randomization of the stack
independently of the randomization of the dynamic library loading.

I mean, in recent Linux kernel, thanks to the ASLR, we have a
randomization of the stack:

[fleury@carioca programs]$ ./testASLR
str= 0xbf8e3a3c (/bin/sh), envp= 0xbf8e18ec, argv= 0xbf8e18e4
[fleury@carioca programs]$ ./testASLR
str= 0xbfedda3c (/bin/sh), envp= 0xbfedd75c, argv= 0xbfedd754
[fleury@carioca programs]$ ./testASLR
str= 0xbfe3ba3c (/bin/sh), envp= 0xbfe3a10c, argv= 0xbfe3a104

(testASLR just output the address of the envp and the argv variables).

And randomization of the dynamic library:
[fleury@carioca programs]$ cat /proc/self/maps | grep libc
b7e01000-b7f2e000 r-xp 00000000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f2e000-b7f33000 r--p 0012d000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f33000-b7f36000 rw-p 00132000 03:02 328183     /lib/tls/libc-2.3.5.so
[fleury@carioca programs]$ cat /proc/self/maps | grep libc
b7e59000-b7f86000 r-xp 00000000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f86000-b7f8b000 r--p 0012d000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f8b000-b7f8e000 rw-p 00132000 03:02 328183     /lib/tls/libc-2.3.5.so
[fleury@carioca programs]$ cat /proc/self/maps | grep libc
b7de4000-b7f11000 r-xp 00000000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f11000-b7f16000 r--p 0012d000 03:02 328183     /lib/tls/libc-2.3.5.so
b7f16000-b7f19000 rw-p 00132000 03:02 328183     /lib/tls/libc-2.3.5.so

When setting /proc/sys/kernel/randomize_va_space to 0, both
randomization stop (see in linux/arch/i386/kernel/process.c).

Would it be possible to tweak them independently from each other ?
(still via procfs)

Regards
-- 
Emmanuel Fleury

The highest goal of computer science is to automate that
which can be automated.
  -- D. L. VerLee
