Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269753AbUJGIZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269753AbUJGIZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269754AbUJGIZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:25:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:14005 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269753AbUJGIZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:25:42 -0400
Date: Thu, 7 Oct 2004 01:23:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: marian.eichholz@freenet-ag.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 does not like diablo news reader daemon
Message-Id: <20041007012353.237c5e6f.akpm@osdl.org>
In-Reply-To: <20041007071930.GB27228@urmel.freenet-ag.de>
References: <20041007071930.GB27228@urmel.freenet-ag.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marian Eichholz <marian.eichholz@freenet-ag.de> wrote:
>
> the kernel 2.6.9-rc3 tends to crash when executing our NNTP
>  reader daemon (dreaderd from diablo).
> 
>  2.6.3-rc1 runs on the sibling machine like a charm.

Impressive.

>  [...]
>  Oct  6 22:48:39 newsread5 kernel: c0132eb1
>  Oct  6 22:48:39 newsread5 kernel: *pde = 00000000
>  Oct  6 22:48:39 newsread5 kernel: Oops: 0002 [#1]
>  Oct  6 22:48:39 newsread5 kernel: SMP 
>  Oct  6 22:48:39 newsread5 kernel: CPU:    0
>  Oct  6 22:48:39 newsread5 kernel: EIP:    0060:[<c0132eb1>]    Not tainted VLI
>  Oct  6 22:48:39 newsread5 kernel: EFLAGS: 00010246   (2.6.9-rc3) 
>  Oct  6 22:48:39 newsread5 kernel: EIP is at generic_file_aio_write_nolock+0x1d1/0x500
>  Oct  6 22:48:39 newsread5 kernel: eax: 00014c38   ebx: 00000000   ecx: 00000000   edx: 00000000
>  Oct  6 22:48:39 newsread5 kernel: esi: de8fe000   edi: 00014c38   ebp: 00000000   esp: de8ffe38
>  Oct  6 22:48:39 newsread5 kernel: ds: 007b   es: 007b   ss: 0068
>  Oct  6 22:48:39 newsread5 kernel: Process dreaderd (pid: 166, threadinfo=de8fe000 task=de86d000)
>  Oct  6 22:48:39 newsread5 kernel: Stack: 00014c38 00000040 00000000 de8ffe48 00000000 ca258200 de8ffee0 c02a8f05 
>  Oct  6 22:48:39 newsread5 kernel:        de8ffee0 00000001 de8ffe8c ffffffff df37f3ec 00000000 00000000 df37f3ec 
>  Oct  6 22:48:39 newsread5 kernel:        00000048 df37f490 de961560 00000048 00014c38 00000000 de8ffeb4 de961560 
>  Oct  6 22:48:39 newsread5 kernel: Call Trace:
>  Oct  6 22:48:39 newsread5 kernel:  [<c02a8f05>] sock_aio_read+0xf5/0x110
>  Oct  6 22:48:39 newsread5 kernel:  [<c013328a>] generic_file_write_nolock+0xaa/0xd0
>  Oct  6 22:48:39 newsread5 kernel:  [<c0118460>] autoremove_wake_function+0x0/0x60
>  Oct  6 22:48:39 newsread5 kernel:  [<c0133406>] generic_file_write+0x56/0xd0
>  Oct  6 22:48:39 newsread5 kernel:  [<c01333b0>] generic_file_write+0x0/0xd0
>  Oct  6 22:48:39 newsread5 kernel:  [<c014f738>] vfs_write+0xb8/0x130
>  Oct  6 22:48:39 newsread5 kernel:  [<c014f881>] sys_write+0x51/0x80
>  Oct  6 22:48:39 newsread5 kernel:  [<c010422f>] syscall_call+0x7/0xb

It got a null-pointer deref right in the heart of the write(2) syscall. 
Everybody is using that all the time.  So I'd say that either there's
something unusual about your setup or your hardware is failing.

- Are the oopses always the same?  Please send some more.

- What types of filesytem are in use?

- Are you using any unusual mount options?

- Are you using any uncommon hardware?

- Does the application do anything unusual such as O_DIRECT I/O?

- Are any other machines running the same application and kernel?  If so,
  are they failing?  If not, are you able to use a different machine with
  2.6.9-rc3?  That'll help us work out whether it's a hardware or software
  failure.

