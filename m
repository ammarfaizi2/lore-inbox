Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUELINz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUELINz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 04:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264996AbUELINz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 04:13:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:40349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264902AbUELINc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 04:13:32 -0400
Date: Wed, 12 May 2004 01:13:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040512011306.74d2fa32.akpm@osdl.org>
In-Reply-To: <409F78FF.9010100@blueyonder.co.uk>
References: <409F78FF.9010100@blueyonder.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sid Boyce <sboyce@blueyonder.co.uk> wrote:
>
> Oops on x86_only, x86_64 is OK.
> 
> ...
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> printing eip:
> c0163921
> *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT DEBUG_PAGEALLOC
>  CPU:    0
>  EIP:    0060:[<c0163921>]    Not tainted VLI
>  EFLAGS: 00010296   (2.6.6-mm1) 
>  EIP is at locks_alloc_lock+0x1/0x20
>  eax: de016f6c   ebx: bffff1e0   ecx: bffff1e0   edx: 00000007
>  esi: bffff1e0   edi: 00000000   ebp: dff7bf90   esp: dff7bf34
>  ds: 007b   es: 007b   ss: 0068
>  Process init (pid: 1, threadinfo=dff7b000 task=dff7ca70)
>  Stack: dff7bf90 c0165856 00000000 00000246 fffbd13f fffbd13f 00000007 de016f6c 
>         dff7bf94 c011a52c ffffffff 000001ff bffff008 fa49babf 00000000 003fffff 
>         00000000 fffbd13f dff7bf9c dff7bfac bffff1e0 ffffffea 00000000 dff7bfa4 
>  Call Trace:
>   [<c01061e6>] show_stack+0xa6/0xb0
>   [<c0106358>] show_registers+0x148/0x1c0
>   [<c0106505>] die+0xa5/0x110
>   [<c0112682>] do_page_fault+0x3b2/0x538
>   [<c0105e55>] error_code+0x2d/0x38
>   [<c01618a5>] generic_file_fcntl+0xd5/0x1e0
>   [<c0161ae0>] sys_fcntl64+0x80/0xa0
>   [<c0105c4b>] syscall_call+0x7/0xb

Is this repeatable?  A null-pointer deref at
locks_alloc_lock+0x1/0x20 seems not possible.

Please send the output of

	nm -n vmlinux | grep -5 locks_alloc_lock


