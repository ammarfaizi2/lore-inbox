Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbUKKNiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbUKKNiC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 08:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUKKNiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 08:38:01 -0500
Received: from kenga.kmv.ru ([217.13.212.5]:45015 "EHLO kenga.kmv.ru")
	by vger.kernel.org with ESMTP id S262228AbUKKNhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 08:37:43 -0500
Date: Thu, 11 Nov 2004 16:37:31 +0300
Message-Id: <200411111337.iABDbVts000788@blacklife.kmv.ru>
From: Andrey Melnikoff <temnota+news@kmv.ru>
To: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.28-rc1] process stuck in release_task() call
In-Reply-To: <20041111083312.GE783@alpha.home.local>
X-Newsgroups: gmane.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.6-rc1 (i686))
X-AV-Scanned: Clamav!
X-Data-Status: msg.XX8m0VPG:32400@kenga.kmv.ru
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Willy Tarreau!
 In article <20041111083312.GE783@alpha.home.local> you wrote:

> > > >>EIP; c012073d <release_task+1fd/230>   <=====
> (...)
> > > c0120540 <release_task>:
> > > c0120540:       55                      push   %ebp
> > > ....
> > > c0120736:       89 d8                   mov    %ebx,%eax
> > > c0120738:       e8 73 dd 01 00          call   c013e4b0 <free_pages> <= here
> > 
> > is this release_task+1fd?  Can you send me the full disassemble of release_task?

> Yes it is because the next instruction after call will be at c0120738+5 =
> c012073d = release_task+1fd. (the return address on the stack is the
> address of the next instruction after the call).

> > It can't be blocked here, its a "call" instruction. 

> Seems rather strange indeed ! Perhaps this is not the disassembled function
> of the *running* kernel ? 

This is also strange for me. Stack trace should point into __free_pages_ok() 
address space. Only this function work with lock's.

> it would be good to disassemble vmlinux and ensure that it is exactly 
> the one currently running. 

This is code from vmlinux-2.4.28-rc1.

> I too have already lost lots of time searching a wrong bug because I 
> disassembled the wrong kernel, so I'm certain it can happen even when 
> we're very careful :-(

[skipp]

PS: Please, keep CC: to me.
