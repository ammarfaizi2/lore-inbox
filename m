Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbTLOJeD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 04:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLOJeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 04:34:03 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.103]:52444 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263448AbTLOJeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 04:34:00 -0500
From: dan carpenter <error27@email.com>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
Date: Sun, 14 Dec 2003 22:31:02 -0800
User-Agent: KMail/1.5.4
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
References: <20031214052516.GA313@vana.vc.cvut.cz> <Pine.LNX.4.58.0312141433520.1481@home.osdl.org> <Pine.LNX.4.58.0312142358210.16392@earth>
In-Reply-To: <Pine.LNX.4.58.0312142358210.16392@earth>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312142230.20952.error27@email.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running the patch from BK and I still get unkillable zombies.  I'm running 
strace on these processes and I don't know if that makes a difference.  
Basically, my program is a modified strace that calls the syscalls as well as 
printing it out...  (I'm trying to test the kernel with bogus syscalls).

When I hit ALT-SYSREQ-T most of the zombie processes look like this.

msgctl09      Z 9FF99D73     0  1503   1465          1505  1500 (L-TLB)
c9fc9f68 00000046 c88b49b0 9ff99d73 00000258 c81cea08 c9fc9f68 c012a65b 
       c81ce9b0 00000011 9ff99d73 00000258 c88b49b0 c11e5bc0 000734f9 a150a7ac 
       00000258 c81ce9b0 cbfa7f38 c81cefc4 cbfe8850 00000000 c81ce9b0 c9fc9f90 
Call Trace:
 [<c012a65b>] exit_notify+0x2eb/0x900
 [<c012b08f>] do_exit+0x41f/0x5c0
 [<c012b3d7>] do_group_exit+0x107/0x190
 [<c010aa8f>] syscall_call+0x7/0xb

There are some process that are stuck but not in zombie state that look like 
this.

mknod09       T 00000001     0  1403      1          1420  1394 (NOTLB)
c73adf80 00000082 c11e5bc0 00000001 00000001 c2e91c28 cbfa3f38 858434c0 
       00000256 c35529b0 c11e5bc0 00000ebe 85843808 c11e5bc0 000004c0 858731ea 
       00000256 c62c39b0 08053000 c73ac000 c73ac000 08053000 c73ac000 c73adfa4 
Call Trace:
 [<c0131209>] ptrace_notify+0x49/0xf6
 [<c015c4ac>] sys_brk+0x2c/0x130
 [<c0110cf8>] do_syscall_trace+0x48/0x73
 [<c010ab01>] syscall_trace_entry+0x11/0x24

The CPU usage is normal.

thanks,
dan carpenter

