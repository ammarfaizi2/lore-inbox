Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVBJAb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVBJAb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVBJAb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:31:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:65459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261987AbVBJAbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:31:21 -0500
Date: Wed, 9 Feb 2005 16:36:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Cc: linux-kernel@vger.kernel.org, admin@list.net.ru
Subject: Re: 2.6.10 devfs oops without devfs mounted at all
Message-Id: <20050209163624.44557750.akpm@osdl.org>
In-Reply-To: <200502082013.50959.rathamahata@ehouse.ru>
References: <200502082013.50959.rathamahata@ehouse.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@ehouse.ru> wrote:
>
> Here is an oops I've just get on my smp system:
> 
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
>  printing eip:
> c01afe5b
> *pde = 00000000
> Oops: 0000 [#1]
> PREEMPT SMP
> Modules linked in: ipt_REJECT ipt_state ip_conntrack iptable_filter
> CPU:    2
> EIP:    0060:[<c01afe5b>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.10)
> EIP is at devfsd_close+0x1b/0xc8
> eax: f7440a00   ebx: 00000000   ecx: c01afe40   edx: ed395280
> esi: 00000000   edi: f7f17800   ebp: f74f96c8   esp: cdc70f84
> ds: 007b   es: 007b   ss: 0068
> Process megamgr.bin (pid: 12844, threadinfo=cdc70000 task=dd81e520)
> Stack: ed395280 ed395280 00000000 f7f17800 c0150c76 ee9e87f8 ed395280 00000000
>        f1985c80 cdc70000 c014f50f 00000003 00000003 080caa60 00000000 c01024df
>        00000003 080cc700 bfffe4f8 080caa60 00000000 bfffe4fc 00000006 0000007b
> Call Trace:
>  [<c0150c76>] __fput+0x106/0x120
>  [<c014f50f>] filp_close+0x4f/0x80
>  [<c01024df>] syscall_call+0x7/0xb

Can you work out what file is being closed?  One way of doing that would be
to work out how megamgr.bin is being invoked and to then run it by hand:

	strace -f -o log megamgr.bin <args>

and we can then use the strace output to work out the pathname of the
offending file.
