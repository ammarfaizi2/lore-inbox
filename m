Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWHPO3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWHPO3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 10:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWHPO3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 10:29:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:9664 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751135AbWHPO3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 10:29:24 -0400
Subject: Re: 2.6.18-rc4-mm1  BUG null pointer deref while saving a file
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <44E30517.10603@aitel.hist.no>
References: <20060813012454.f1d52189.akpm@osdl.org>
	 <44E30517.10603@aitel.hist.no>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 09:28:46 -0500
Message-Id: <1155738526.9367.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 13:44 +0200, Helge Hafting wrote:
> Aug 16 13:20:30 hh kernel: BUG: unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Aug 16 13:20:30 hh kernel:  printing eip:
> Aug 16 13:20:30 hh kernel: c0468863
> Aug 16 13:20:30 hh kernel: *pde = 00000000
> Aug 16 13:20:30 hh kernel: Oops: 0002 [#1]
> Aug 16 13:20:30 hh kernel: 4K_STACKS
> Aug 16 13:20:30 hh kernel: last sysfs file: 
> /devices/platform/i2c-9191/9191-0290/in0_input
> Aug 16 13:20:30 hh kernel: CPU:    0
> Aug 16 13:20:30 hh kernel: EIP:    0060:[<c0468863>]    Not tainted VLI
> Aug 16 13:20:30 hh kernel: EFLAGS: 00010002   (2.6.18-rc4-mm1 #7)
> Aug 16 13:20:30 hh kernel: EIP is at __down+0x5c/0xed
> Aug 16 13:20:30 hh kernel: eax: 00000000   ebx: d462e7e4   ecx: 
> c14e7e40   edx: dde06f0c
> Aug 16 13:20:30 hh kernel: esi: 00000286   edi: c3365550   ebp: 
> d462e7ec   esp: dde06efc
> Aug 16 13:20:30 hh kernel: ds: 007b   es: 007b   ss: 0068
> Aug 16 13:20:30 hh kernel: Process lyx (pid: 9353, ti=dde06000 
> task=c3365550 task.ti=dde06000)
> Aug 16 13:20:30 hh kernel: Stack: dde06f0c 00000001 c3365550 c0116941 
> d462e7ec 00000000 00000008 d851a9a8
> Aug 16 13:20:30 hh kernel:        d462e7c0 d32a1200 c0466bc7 c14e7e40 
> dde06000 c01ed987 00000008 00000000
> Aug 16 13:20:30 hh kernel:        00000000 00000000 d7a31c00 caf9be0c 
> 00000000 00001dbb d462e7e4 00000008
> Aug 16 13:20:30 hh kernel: Call Trace:
> Aug 16 13:20:30 hh kernel:  [<c0466bc7>] __down_failed+0x7/0xc
> Aug 16 13:20:30 hh kernel: DWARF2 unwinder stuck at __down_failed+0x7/0xc
> Aug 16 13:20:31 hh kernel: Leftover inexact backtrace:
> Aug 16 13:20:31 hh kernel:  [<c01ed987>] .text.lock.file+0x54/0x9d
> Aug 16 13:20:31 hh kernel:  [<c01516bd>] __fput+0xb2/0x163
> Aug 16 13:20:31 hh kernel:  [<c014ee9d>] filp_close+0x3e/0x62
> Aug 16 13:20:31 hh kernel:  [<c0150168>] sys_close+0x5c/0x6b
> Aug 16 13:20:31 hh kernel:  [<c01028c9>] sysenter_past_esp+0x56/0x79

By any chance would you be using cifs?  This looks just like the bug
that is fixed by this patch:
http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/sfrench/cifs-2.6.git;a=commitdiff;h=e466e4876bf39474e15d0572f2204578137ae7f5

> Aug 16 13:20:31 hh kernel:  =======================
> Aug 16 13:20:31 hh kernel: Code: 0c 41 69 11 c0 c7 07 02 00 00 00 9c 5e 
> fa 83 4c 24 04 01 8d 6b 08 8b 45 04 8d 54 24 10 89 14 24 89 55 04 89 6c 
> 24 10 89 44 24 14 <89> 10 8b 43 04 8d 50 01 89 53 04 01 03 0f 98 c0 84 
> c0 74 26 c7
> Aug 16 13:20:31 hh kernel: EIP: [<c0468863>] __down+0x5c/0xed SS:ESP 
> 0068:dde06efc
> 
> The lyx process is a word processor.  I did a save, the window
> disappeared, and this was logged.
> 
> Helge Hafting
-- 
David Kleikamp
IBM Linux Technology Center

