Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbTDIACe (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 20:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTDIACe (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 20:02:34 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:57540 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262624AbTDIACc (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 20:02:32 -0400
Date: Wed, 9 Apr 2003 01:13:51 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: akpm@digeo.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: convert_fxsr_from_user
Message-ID: <20030409001344.GA20353@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>, akpm@digeo.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 A while back you optimised this routine to not do lots of memory
copies.  I've noticed it does no checking on the validity of the
addresses it dereferences from userspace.

Looks like we need to...

		Dave

Unable to handle kernel paging request at virtual address 08048514
 printing eip:
c0114490
*pde = 05ad8067
*pte = 0586a025
Oops: 0003 [#1]
CPU:    0
EIP:    0060:[<c0114490>]    Not tainted
EFLAGS: 00010246
EIP is at convert_fxsr_from_user+0xe0/0x150
eax: e9000000   ebx: 08048514   ecx: c5be1d40   edx: 00000000
esi: c56d4000   edi: 00000000   ebp: c56d5f1c   esp: c56d5ee4
ds: 007b   es: 007b   ss: 0068
Process a.out (pid: 638, threadinfo=c56d4000 task=c5be1980)
Stack: c56d5ef0 080484f8 0000001c 83e58955 51e808ec e8000001 000001ac 0007cbe8 
       00c3c900 90f435ff c6165d70 c5be1980 c5be1d20 080484f8 c56d5f3c c0114711 
       c5be1d20 080484f8 00000200 080484f8 00000000 00000000 c56d5f54 c01147a0 
Call Trace:
 [<c0114711>] restore_i387_fxsave+0x81/0x90
 [<c01147a0>] restore_i387+0x80/0x90
 [<c01092b8>] restore_sigcontext+0x128/0x140
 [<c010972c>] sys_rt_sigreturn+0x1bc/0x2e0
 [<c016ba65>] sys_write+0x45/0x60
 [<c010a457>] syscall_call+0x7/0xb

Code: 89 03 85 d2 75 2e 8b 41 04 89 43 04 85 d2 75 24 66 8b 41 08

