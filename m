Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVAFAw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVAFAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 19:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVAFAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 19:52:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:3270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262676AbVAFAwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 19:52:53 -0500
Date: Wed, 5 Jan 2005 16:52:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-mm1 panic in sysfs ?
Message-Id: <20050105165241.481473a3.akpm@osdl.org>
In-Reply-To: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
References: <1104946602.4000.22.camel@dyn318077bld.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Hi Andrew,
> 
> I get a panic in sysfs_readdir() while booting 2.6.10-mm1
> kernel. Known fixes ?
> 

It's news to me.

> Unable to handle kernel NULL pointer dereference at virtual address 00000020
>  printing eip:
> c109c8ef
> *pde = 0191c001
> Oops: 0000 [#1]
> SMP
> Modules linked in:
> CPU:    2
> EIP:    0060:[<c109c8ef>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.10-mm1kexec)

What is "2.6.10mm1kexec"?

> EIP is at sysfs_readdir+0xef/0x280
> eax: 00000000   ebx: c15e1160   ecx: 0000000c   edx: 00000020
> esi: c15e1164   edi: c15dd72d   ebp: c1a7df78   esp: c1a7df3c
> ds: 007b   es: 007b   ss: 0068
> Process getcfg (pid: 1927, threadinfo=c1a7c000 task=c2ba3040)

Try to work out what arguments are being passed to `getcfg', then run it by
hand, under strace, to see what /sysfs file is being accessed when it oopses.

> Stack: 00000001 00000000 00000017 00000004 c156d62c 0000000c c15dd720 c21bf324
>        c156d620 c1071f80 c1a7dfa0 c1c837e0 c131caa0 c1c837e0 c1587428 c1a7df94
>        c1071e48 c1a7dfa0 c1071f80 c1a7c000 0804f944 fffffff7 c1a7dfbc c10720aa
> Call Trace:
>  [<c1004dc6>] show_stack+0xa6/0xb0
>  [<c1004f42>] show_registers+0x152/0x1c0
>  [<c100514d>] die+0xed/0x180
>  [<c1018b6d>] do_page_fault+0x45d/0x6e9
>  [<c1004a2b>] error_code+0x2b/0x30
>  [<c1071e48>] vfs_readdir+0x98/0xb0
>  [<c10720aa>] sys_getdents+0x6a/0xd0
>  [<c1003f31>] sysenter_past_esp+0x52/0x75
> Code: eb 89 d8 e8 c4 ea ff ff 89 45 dc b9 ff ff ff ff 31 c0 8b 7d dc f2 ae f7 d1 49 89 4d d8 8b 43 20 85 c0 0f 84 37 01 00 00 8b 40 0c <8b> 50 20 0f b7 43 1c 89 54 24 08 c1 e8 0c 89 44 24 0c 8b 4d f0
>                                          
> 
> 
> 
> 
> 
> 
