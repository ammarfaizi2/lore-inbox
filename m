Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265186AbUEMWMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265186AbUEMWMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265190AbUEMWMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:12:08 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:14091 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265186AbUEMWME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:12:04 -0400
Subject: Re: 2.6.5 panic while unloading cisco_ipsec
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Geoff Mishkin <gmishkin@comcast.net>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1084482726.7506.6.camel@amsa>
References: <1084482726.7506.6.camel@amsa>
Content-Type: text/plain
Message-Id: <1084486322.1729.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Fri, 14 May 2004 00:12:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-13 at 23:12, Geoff Mishkin wrote:
> Please let me know if I'm posting this in the wrong place.  I get a
> kernel panic with kernel 2.6.5 (compiled with gcc 2.95.3) when I try to
> unload the Cisco VPN client's (4.0.3b) cisco_ipsec module.  I know it's
> a binary-only module, so I'm not sure how much help this will be, but
> here's the text I managed to pull off the screen when I tried rmmod'ing
> it:

I'm thinking the new register arguments syscall convention is the
culprit. Please, make sure you compile the kernel with CONFIG_REGPARMS
set to NO. You can check that by grepping into the .config file before
starting the build.

> (Not sure if there is anything above this, this is all that fit on the
> screen, and I didn't find anything in the logs)
> PREEMPT
> CPU:	0
> EIP:	0060:[<c02a9d26>]    Tainted: PF
> EFLAGS:	00010202   (2.6.5)
> EIP is at qdisc_destroy+0x6/0xc4
> eax: 00000064	ebx: c6daa000	ecx: c6dabf20	edx: c6dabf28
> esi: 00000064	edi: ce5fd028	ebp: c6dabf6c	esp: c6dabf28
> ds: 007b   es: 007b   ss:0068
> Process rmmod (pid: 7134, threadinfo=c6daa000 task=c6db19c0)
> Stack: c6daa000 d0abb600 c02a9ff3 00000064 d0abb600 d0abb600 c02a1426
> d0abb600
>        d0abb600 00000000 c0398a9c c02440c8 d0abb600 d0ae8f80 d0a99aec
> d0abb600
>        d0ae8f80 c6daa000 c012f724 bffff730 00000000 bffff730 00000000
> 63736963
> Call Trace:
>  [<c02a9ff3>] dev_shutdown+0x57/0xe4
>  [<c02a1426>] unregister_netdevice+0x192/0x288
>  [<c02440c8>] unregister_netdev+0x10/0x28
>  [<d0a99aec>] cleanup_module+0x1c/0x30 [cisco_ipsec]
>  [<c012f724>] sys_delete_module+0x140/0x174
>  [<c0143803>] sys_munmap+0x37/0x54
>  [<c0108f2f>] syscall_call+0x7/0xb
> 
> Code: 8b 5e 0c ff 4e 18 0f 94 c0 84 c0 0f 84 a8 00 00 00 8b 56 2c
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
> 
> 			--Geoff Mishkin <gmishkin@comcast.net>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

