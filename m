Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUIWKYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUIWKYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUIWKYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:24:13 -0400
Received: from share.sks3.muni.cz ([147.251.211.22]:30416 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S268368AbUIWKYI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:24:08 -0400
Date: Thu, 23 Sep 2004 12:23:55 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-ID: <20040923102355.GA11902@mail.muni.cz>
References: <20040923100906.GB11230@mail.muni.cz> <20040923031451.56147952.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040923031451.56147952.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 03:14:51AM -0700, Andrew Morton wrote:
> Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> >
> > Sep 23 11:26:24 debian kernel: EIP:    0060:[fn_hash_insert+1039/1159]    Tainted:  P   VLI
> > 
> 
> This might fix it
> 
> --- a/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00
> +++ b/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00

Thanx, I will try it and let you now.

Another issue is with pppd as someone had reported. Unfortunately davem latest
patch seems to be included. Here is report:
Pid: 1597, comm:                 pppd
EIP: 0060:[<c030aabb>] CPU: 0
EIP is at fn_hash_delete+0xf5/0x29c
 EFLAGS: 00000293    Not tainted  (2.6.9-rc2-mm2)
 EAX: ce654428 EBX: ce650360 ECX: 4b01140a EDX: ce654428
 ESI: c1fc5e50 EDI: 00000000 EBP: 00000020 DS: 007b ES: 007b
 CR0: 8005003b CR2: 0813f008 CR3: 033fe000 CR4: 00000690
  [<c0121295>] register_proc_table+0xa3/0x10b
  [<c030824e>] fib_magic+0xe9/0x11c
  [<c03085b5>] fib_del_ifaddr+0x1ae/0x21b
  [<c0308697>] fib_inetaddr_event+0x2b/0x65
  [<c0127d55>] notifier_call_chain+0x27/0x3e
  [<c02ffd38>] inet_del_ifa+0x94/0x146
  [<c030097a>] devinet_ioctl+0x4d8/0x724
  [<c0302afa>] inet_ioctl+0x5e/0x9e
  [<c02bbb99>] sock_ioctl+0xff/0x2a7
  [<c01677c7>] sys_ioctl+0xf9/0x256
  [<c010511f>] syscall_call+0x7/0xb

Which causes endless loop.

-- 
Luká¹ Hejtmánek
