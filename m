Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161369AbWASTcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161369AbWASTcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161373AbWASTcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:32:41 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:57456 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161369AbWASTck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:32:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=GrodpyL5V7RT6fsLLTh3rHrv19Tazt6kwUzoSmwqVttIyQJWbCvQf1ijv7mfgqHozNEwAXgGDrUmp/OQp4JRQWL714cwlzWKvR+aI2o+pBoR42iS6H/vlVNjuyUL+puCtXkAwOumejB+Ja+Sq72Ed6WxXFx0f41O+ohMl1aKhfk=
Date: Thu, 19 Jan 2006 20:31:45 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops with current linus' git tree
Message-Id: <20060119203145.a2e22017.diegocg@gmail.com>
In-Reply-To: <43CDB49D.3040305@yahoo.com.au>
References: <20060116191556.bd3f551c.diegocg@gmail.com>
	<43CC7094.9040404@yahoo.com.au>
	<20060117141725.d80a1221.diegocg@gmail.com>
	<20060118012029.db6bf538.diegocg@gmail.com>
	<43CDB49D.3040305@yahoo.com.au>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 18 Jan 2006 14:23:09 +1100,
Nick Piggin <nickpiggin@yahoo.com.au> escribió:

> > I've been running kaffeine for hours and i didn't triggered it, it's
> > hard to reproduce :/
> > 
> 
> That's what I feared. Thanks for trying though.

Ok, I've got another oops when closing amarok. This doesn't seem to hit 
your debug checks, but I though it could be related. After the fisrt
oops I enabled the ECC event logging in the bios and it hasn't recorded
anything, so I doubt the problem is faulty ram (this is plain 2.6.16-rc1)



Eeek! page_mapcount(page) went negative! (-1)
  page->flags = 400
  page->count = 1
  page->mapping = 00000000
------------[ cut here ]------------
kernel BUG at mm/rmap.c:524!
invalid opcode: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: ipt_REJECT xt_tcpudp radeon lp thermal fan button processor ac ipt_MASQUERADE iptable_nat ip_nat ip_conntrack iptable_filt
er ip_tables x_tables usbhid ohci_hcd parport_pc parport usbcore pcspkr floppy ide_cd e100 cdrom unix
CPU:    0
EIP:    0060:[<c014ac11>]    Not tainted VLI
EFLAGS: 00010286   (2.6.16-rc1)
EIP is at page_remove_rmap+0x67/0x81
eax: ffffffff   ebx: c1000000   ecx: c03214f8   edx: 00000001
esi: 00000000   edi: b6208000   ebp: e7172ee8   esp: e7172ee4
ds: 007b   es: 007b   ss: 0068
Process amarokapp (pid: 5475, threadinfo=e7172000 task=e7197ac0)
Stack: <0>c1000000 e7172f44 c0145bcd b60ff000 de9832b0 e7172f64 00005ef9 00000000
       00000000 b62cc000 ee834b60 ee834b60 ee834b60 ee818e54 ffffffff ffffffff
       debdf820 c170a680 ee818e04 b62cc000 00000000 c170a680 ee818e04 e44bf440
Call Trace:
 [<c0103e58>] show_stack_log_lvl+0xaa/0xb5
 [<c0103f95>] show_registers+0x132/0x19e
 [<c01042ca>] die+0x168/0x1ed
 [<c010454e>] do_trap+0x7c/0x96
 [<c01047ad>] do_invalid_op+0x89/0x93
 [<c01038e3>] error_code+0x4f/0x54
 [<c0145bcd>] unmap_vmas+0x22d/0x487
 [<c0148900>] unmap_region+0x92/0x116
 [<c0148e97>] do_munmap+0x144/0x19a
 [<c0148f3b>] sys_munmap+0x4e/0x67
 [<c0102d87>] sysenter_past_esp+0x54/0x75
Code: 40 74 03 8b 53 0c 8b 42 04 40 50 68 0f 02 2e c0 e8 52 34 fd ff ff 73 10 68 26 02 2e c0 e8 45 34 fd ff 83 c4 10 8b 43 08 40 79 08 <0f> 0
b 0c 02 bb 01 2e c0 83 ca ff b8 10 00 00 00 e8 e7 45 ff ff
 <3>Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c010401d>] show_trace+0xd/0xf
 [<c0104034>] dump_stack+0x15/0x17
 [<c0116ce5>] __might_sleep+0x86/0x90
 [<c011e6f3>] profile_task_exit+0x1b/0x47
 [<c011f96a>] do_exit+0x1c/0x72e
 [<c010434f>] do_simd_coprocessor_error+0x0/0x183
 [<c010454e>] do_trap+0x7c/0x96
 [<c01047ad>] do_invalid_op+0x89/0x93
 [<c01038e3>] error_code+0x4f/0x54
 [<c0145bcd>] unmap_vmas+0x22d/0x487
 [<c0148900>] unmap_region+0x92/0x116
 [<c0148e97>] do_munmap+0x144/0x19a
 [<c0148f3b>] sys_munmap+0x4e/0x67
 [<c0102d87>] sysenter_past_esp+0x54/0x75
note: amarokapp[5475] exited with preempt_count 2
scheduling while atomic: amarokapp/0x00000002/5475
 [<c010401d>] show_trace+0xd/0xf
 [<c0104034>] dump_stack+0x15/0x17
 [<c02c1b31>] schedule+0x43/0x7d1
 [<c02c3708>] rwsem_down_read_failed+0x166/0x185
 [<c0132cad>] .text.lock.futex+0x73/0xe6
 [<c0132c2b>] sys_futex+0xa2/0xb1
 [<c011b277>] mm_release+0x5a/0x65
 [<c011eeca>] exit_mm+0x16/0x139
 [<c011face>] do_exit+0x180/0x72e
 [<c010434f>] do_simd_coprocessor_error+0x0/0x183
 [<c010454e>] do_trap+0x7c/0x96
 [<c01047ad>] do_invalid_op+0x89/0x93
 [<c01038e3>] error_code+0x4f/0x54
 [<c0145bcd>] unmap_vmas+0x22d/0x487
 [<c0148900>] unmap_region+0x92/0x116
 [<c0148e97>] do_munmap+0x144/0x19a
 [<c0148f3b>] sys_munmap+0x4e/0x67
 [<c0102d87>] sysenter_past_esp+0x54/0x75
