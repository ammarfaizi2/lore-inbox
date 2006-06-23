Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWFWVaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWFWVaL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWFWVaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:30:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWFWVaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:30:09 -0400
Date: Fri, 23 Jun 2006 14:30:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1
Message-Id: <20060623143004.6af78d68.akpm@osdl.org>
In-Reply-To: <449C3FCA.5080501@mbligh.org>
References: <449C3FCA.5080501@mbligh.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:23:54 -0700
Martin Bligh <mbligh@mbligh.org> wrote:

> On 16x NUMA-Q, got a panic running dbench across different fs's.
> 
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 
> 00000000
>   printing eip:
> c0154030
> *pde = 2589f001
> *pte = 00000000
> Oops: 0000 [#1]
> 8K_STACKS SMP
> last sysfs file: /devices/pci0000:00/0000:00:0a.0/resource
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c0154030>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.17-mm1-autokern1 #1)
> EIP is at s_show+0xe5/0x28e
> eax: c038efe0   ebx: e744ef60   ecx: 00000000   edx: 00000000
> esi: c038efe0   edi: 00000000   ebp: e744b2c0   esp: e67aff14
> ds: 007b   es: 007b   ss: 0068
> Process cp (pid: 7295, ti=e67ae000 task=e1521570 task.ti=e67ae000)
> Stack: 00000000 00000000 00000000 00000072 00000c66 e64a78c0 e744b2c0 
> 00000000
>         00001000 c01724e5 e64a78c0 e744b2c0 0000087e 00000000 0000005c 
> 00000000
>         0000005b 00000000 e6754720 bfc8afa0 e67affa4 00001000 c0156e80 
> e6754720
> Call Trace:
>   [<c01724e5>] seq_read+0x195/0x262
>   [<c0156e80>] vfs_read+0x88/0x11e
>   [<c0157160>] sys_read+0x3b/0x63
>   [<c036d07f>] syscall_call+0x7/0xb
> Code: 10 3b 8d d4 00 00 00 75 0a 85 f6 b8 a0 ef 38 c0 0f 44 f0 85 c9 75 
> 0a 85 f6 b8 e0 ef 38 c0 0f 44 f0 01 4c 24 10 ff 44 24 0c 8b 12 <8b> 02 
> 0f 18 00 90 39 da 75 c9 8b 53 10 8b 02 0f 18 00 90 8d 43
> EIP: [<c0154030>] s_show+0xe5/0x28e SS:ESP 0068:e67aff14

That's a null-pointer deref

> Got a very similar panic on a flat SMP box too:
> 
> BUG: unable to handle kernel paging request at virtual address 00100100
>   printing eip:
> c0154030
> *pde = 2f2fa001
> *pte = 00000000
> Oops: 0000 [#1]
> 8K_STACKS SMP
> last sysfs file: /devices/pci0000:00/0000:00:0a.0/resource
> Modules linked in:
> CPU:    1
> EIP:    0060:[<c0154030>]    Not tainted VLI
> EFLAGS: 00010006   (2.6.17-mm1-autokern1 #1)
> EIP is at s_show+0xe5/0x28e
> eax: c038efe0   ebx: dffead60   ecx: 00000000   edx: 00100100
> esi: c038efe0   edi: 00000000   ebp: dffe7660   esp: f69a7f14
> ds: 007b   es: 007b   ss: 0068
> Process cp (pid: 7190, ti=f69a6000 task=f64dc570 task.ti=f69a6000)
> Stack: 00000000 00000000 00000000 0000003f 00000328 f650a620 dffe7660 
> 00000000
>         00001000 c01724e5 f650a620 dffe7660 00000909 00000000 0000005d 
> 00000000
>         0000005c 00000000 ed4d3200 bff47a70 f69a7fa4 00001000 c0156e80 
> ed4d3200
> Call Trace:
>   [<c01724e5>] seq_read+0x195/0x262
>   [<c0156e80>] vfs_read+0x88/0x11e
>   [<c0157160>] sys_read+0x3b/0x63
>   [<c036d07f>] syscall_call+0x7/0xb
> Code: 10 3b 8d d4 00 00 00 75 0a 85 f6 b8 a0 ef 38 c0 0f 44 f0 85 c9 75 
> 0a 85 f6 b8 e0 ef 38 c0 0f 44 f0 01 4c 24 10 ff 44 24 0c 8b 12 <8b> 02 
> 8d 74 26 00 39 da 75 c9 8b 53 10 8b 02 8d 74 26 00 8d 43
> EIP: [<c0154030>] s_show+0xe5/0x28e SS:ESP 0068:f69a7f14

And that's LIST_POISON1.

The only s_show()s I can see are in slab and in kallsyms.

It would help if you could gdb these guys, work out file-n-line.

And it would be super-good if you could revert
slab-stop-using-list_for_each.patch and retest.  


