Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbTLaTyQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 14:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265254AbTLaTyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 14:54:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:45452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265251AbTLaTyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 14:54:15 -0500
Date: Wed, 31 Dec 2003 11:54:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robert Gadsdon <robert@gadsdon.giointernet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1-mm1 - ieee1394 broken again?
Message-Id: <20031231115442.24df8501.akpm@osdl.org>
In-Reply-To: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk>
References: <3FF2EFF3.6010001@gadsdon.giointernet.co.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Gadsdon <robert@gadsdon.giointernet.co.uk> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
>    printing eip:
>  c028301e
>  *pde = 00000000
>  Oops: 0000 [#1]
>  PREEMPT SMP
>  CPU:    1
>  EIP:    0060:[<c028301e>]    Not tainted VLI
>  EFLAGS: 00010282
>  EIP is at vt_ioctl+0x1e/0x1ec0
>  eax: 00000000   ebx: 00005401   ecx: bffffbec   edx: bffffbec
>  esi: c0283000   edi: cfb5b000   ebp: cf53b2c0   esp: cfb31eb0
>  ds: 007b   es: 007b   ss: 0068
>  Process rc (pid: 1467, threadinfo=cfb30000 task=cfb426c0)
>  Stack: cfb31f70 cffe6220 00000000 00000000 cf06ece0 cfd0c600 00000001 
>  cfb30000
>          cf0354f0 cf036cc0 4f106e70 c01520df cf036cc0 cf9e44a0 4f106e70 
>  00000000
>          cf0a7418 cf0354f0 00008802 cf036cc0 cf036ce0 cf9e44a0 cfb426c0 
>  c011beac
>  Call Trace:
>    [<c01520df>] handle_mm_fault+0x10f/0x1c0
>    [<c011beac>] do_page_fault+0x33c/0x530
>    [<c0160564>] dentry_open+0x1e4/0x230
>    [<c0283000>] vt_ioctl+0x0/0x1ec0
>    [<c027d9a0>] tty_ioctl+0x480/0x590
>    [<c01756a7>] sys_ioctl+0x117/0x2c0

aargh, sorry.  You need to revert

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1-rc1/2.6.1-rc1-mm1/broken-out/sysfs-add-vc-class.patch

This is the totally weird tty oops which Greg and I have been starting
at bemusedly for a few days.

