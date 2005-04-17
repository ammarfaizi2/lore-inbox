Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVDQDrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVDQDrw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 23:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDQDrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 23:47:52 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:33242 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261246AbVDQDrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 23:47:49 -0400
Message-ID: <4261DC62.1070300@lab.ntt.co.jp>
Date: Sun, 17 Apr 2005 12:47:46 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
This patch add function called "Live patching" which is defined on
OSDL's carrier grade linux requiremnt definition to linux 2.6.11.7 kernel.
The live patching allows process to patch on-line (without restarting
process) on i386 and x86_64 architectures, by overwriting jump assembly
code on entry point of functions which you want to fix, to patched
functions.
The live patching function is very common on high-availability system
such as carrier system, and this patch realize it also on linux.
(Patch & process restart time is very critical on such high-availability
system, live patch allows you to milliseconds order process stopping
time to apply new patch.)

The basis is below:
1. Live patch command loads the patch modules to target process's memory
area,
2. Live patch command resolve patch symbol.
3. Live patch command overwrite jump code to the entry point of function
which you want to fix, to the patch module's symbol.

Kernel patch and user mode tools are required, and both of them are
available at http://pannus.sourceforge.net
Please take a look and give us comments!

This patch add following system calls and function.
o mmap3: maps patch to target process's memory area with security check.
o accesspvm: access(read/write) target process's memory area.
o init_pend: initialization of live patch sequence on target process.
o rt_handlereturn: run initialize root of each patch (same as signal
handler).
o check_init: check that the initialization is finished or not.
o munmap3: unmap patch from target process's memory area.


---
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp


