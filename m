Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKUXdQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbTKUXdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:33:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:5573 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261754AbTKUXdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:33:14 -0500
Date: Fri, 21 Nov 2003 15:33:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pavel Machek <pavel@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       <bug-binutils@gnu.org>
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io
 priorities (fwd)]
In-Reply-To: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0311211529590.13789-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Nov 2003, Linus Torvalds wrote:
> 
> So it definitely _does_ work in some versions, and the bug appears to be 
> new to binutils 2.14, with 2.13 doing the right thing.

It looks like we can work around it with this silly syntactic sugar.. Does 
this work for you?

		Linus

---
===== arch/i386/kernel/entry.S 1.69 vs edited =====
--- 1.69/arch/i386/kernel/entry.S	Wed Oct  1 06:53:17 2003
+++ edited/arch/i386/kernel/entry.S	Fri Nov 21 15:32:00 2003
@@ -49,6 +49,8 @@
 #include <asm/page.h>
 #include "irq_vectors.h"
 
+#define nr_syscalls ((syscall_table_size)/4)
+
 EBX		= 0x00
 ECX		= 0x04
 EDX		= 0x08
@@ -881,4 +883,4 @@
  	.long sys_fadvise64_64
 	.long sys_ni_syscall	/* sys_vserver */
 
-nr_syscalls=(.-sys_call_table)/4
+syscall_table_size=(.-sys_call_table)

