Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUJ2XNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUJ2XNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263608AbUJ2XIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:08:47 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:47980 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S263536AbUJ2WvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:51:25 -0400
Subject: 2.6.9 kernel oops with openais
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: openais@lists.osdl.org, markh@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1099090282.14581.19.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Oct 2004 15:51:22 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,

Have you seen the following oops in 2.6.x?  I can generate it easily
with two nodes by letting openais run for 15-20 seconds on 2.6.9.

I had to turn mlockall off in order to get openais to run in the first
place, otherwise openais runs out of ram which causes a memset to a null
address in parse.c (we should fix that:).  Have you had problems with
mlock when working with a 2.6 kernel?

 <1>Unable to handle kernel NULL pointer dereference at virtual address
0000000c
 printing eip:
c016dd7b
*pde = 00000000
Oops: 0000 [#2]
PREEMPT SMP
Modules linked in:
CPU:    2
EIP:    0060:[<c016dd7b>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9)
EIP is at dnotify_flush+0x1e/0xad
eax: 00000000   ebx: f6cdfb80   ecx: 00000000   edx: f6cdfb80
esi: 00000000   edi: f7baf880   ebp: f6cdfb80   esp: f6cefd50
ds: 007b   es: 007b   ss: 0068
Process aisexec (pid: 929, threadinfo=f6cee000 task=f7cc2810)
Stack: c0154240 f7224a70 f7cdea80 f6cdfb80 00000000 f7baf880 f7baf880
c0152a6f
       f6cdfb80 f7baf880 00000005 00000007 0000000f c011e344 f6cdfb80
f7baf880
       00000020 00000001 f7baf880 f7cc2d38 f7cc2810 f7a9a0ac c011f11e
f7cc2810
Call Trace:
 [<c0154240>] __fput+0x86/0xd4
 [<c0152a6f>] filp_close+0x46/0x86
 [<c011e344>] put_files_struct+0x87/0xec
 [<c011f11e>] do_exit+0x1a8/0x360
 [<c01070fd>] do_divide_error+0x0/0x13e
 [<c0116640>] do_page_fault+0x251/0x5af
 [<c0108aa3>] do_IRQ+0xd2/0x139
 [<c033b760>] move_addr_to_user+0x5c/0x67
 [<c033d815>] sys_recvmsg+0x21d/0x226
 [<c033f3ec>] release_sock+0x1b/0x71
 [<c033f3a7>] lock_sock+0x17/0x41
 [<c01555d7>] invalidate_inode_buffers+0x1b/0x7e
 [<c01163ef>] do_page_fault+0x0/0x5af
 [<c01068e5>] error_code+0x2d/0x38
 [<c033c550>] sock_poll+0xe/0x31
 [<c01664c1>] do_pollfd+0x8c/0x90
 [<c016652b>] do_poll+0x66/0xc6
 [<c01666cb>] sys_poll+0x140/0x1fd
 [<c0165a45>] __pollwait+0x0/0xc5
 [<c0105e7b>] syscall_call+0x7/0xb


