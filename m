Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSGHPWU>; Mon, 8 Jul 2002 11:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSGHPWU>; Mon, 8 Jul 2002 11:22:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56325 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S316965AbSGHPWS>;
	Mon, 8 Jul 2002 11:22:18 -0400
Date: Mon, 8 Jul 2002 08:16:25 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bruno Pujol <pujol@isty-info.uvsq.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: system call
In-Reply-To: <20020708121535.A6642@romuald.isty-info.uvsq.fr>
Message-ID: <Pine.LNX.4.33L2.0207080808310.7622-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002, Bruno Pujol wrote:

| Do someone know how to add a system call for the kernel 2.4.8 ?

There are _many_ examples of adding syscalls on the web.
Try searching with www.google.com if you haven't already.

I expect that the real problem is that a patch that works for
2.4.8 won't work for 2.4.18 and vice versa, e.g., due to the
method used for defining the end/size of the syscall table.

| I did know how to do it for an older version (2.0.35) :
| - add a line in the file : /usr/src/linux/include/asm/unistd.h
| 	#define __NR_my_systemcall	XXXX (where XXXX is the number
| for my new system call)
|
| - modify the file /usr/src/linux/arch/i386/kernel/entry.S
| 	- add my system call
| 		.long SYMBOL_NAME (my_systemcall) at the end of the system callslist
| 	- modify le last line of the file :
| 		.space (NR_syscalls-166)*4   <= replace the 166 by 167

That's very close to working.
Here's how I did it for 2.4.18, but like I said above, it won't
apply cleanly to 2.4.8.  You'll have to use just a small amount of
gray matter to fix it:
  http://www.xenotime.net/linux/syscall_ex/
contains a howto, kernel patch, and test program.

| After this changes, I only needed to recompile the kernel and reboot
| with it... and a user's program could use the new system call...
| But with my new kernel, this manupilation doesn't still work.

You should modify the new syscall number to a value to is not used,
and modify your userspace program to use that new syscall number.

-- 
~Randy

