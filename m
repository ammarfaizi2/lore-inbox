Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUEMVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUEMVlY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264551AbUEMVlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 17:41:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:32654 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264531AbUEMVlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 17:41:21 -0400
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Geoff Mishkin <gmishkin@comcast.net>
Subject: Re: 2.6.5 panic while unloading cisco_ipsec
Date: Thu, 13 May 2004 23:41:17 +0200
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
References: <1084482726.7506.6.camel@amsa>
In-Reply-To: <1084482726.7506.6.camel@amsa>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200405132341.18052.deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geoff,

I don't have a fix for you, but I would propose that you try an open source alternative instead:
http://www.unix-ag.uni-kl.de/~massar/vpnc/

It worked for me like a charm, and the most important issue is, that it's a complete user-space application without any need for kernel modules at all :-)

Best regards,
Helge

On Thursday 13 May 2004 23:12, Geoff Mishkin wrote:
> Please let me know if I'm posting this in the wrong place.  I get a
> kernel panic with kernel 2.6.5 (compiled with gcc 2.95.3) when I try to
> unload the Cisco VPN client's (4.0.3b) cisco_ipsec module.  I know it's
> a binary-only module, so I'm not sure how much help this will be, but
> here's the text I managed to pull off the screen when I tried rmmod'ing
> it:
> 
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
