Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUAYEeE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 23:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263107AbUAYEeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 23:34:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:4575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbUAYEeA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 23:34:00 -0500
Date: Sat, 24 Jan 2004 20:34:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: David =?ISO-8859-1?B?UG9zcO1fX2ls?= <foton2@post.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 Unable to handle kernel paging request
Message-Id: <20040124203400.6dde63d0.akpm@osdl.org>
In-Reply-To: <200401250424.21533.foton2@post.cz>
References: <200401250424.21533.foton2@post.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Pospí__il <foton2@post.cz> wrote:
>
> I was only listening the radio via internet, when computer totaly crashed. I 
>  had to restart (my uptime was 9 days :-(  )

This is ugly.

>  Xfree, KDE, KMail, Mozilla, mplayer (radio),XMMS,mc and karamba were running.
>  This is my syslog : 
>  Jan 25 03:51:02 foton2 kernel: Unable to handle kernel paging request at 
>  virtual address 00200204
>  Jan 25 03:51:02 foton2 kernel:  printing eip:
>  Jan 25 03:51:02 foton2 kernel: c013bb35
>  Jan 25 03:51:02 foton2 kernel: *pde = 00000000
>  Jan 25 03:51:02 foton2 kernel: Oops: 0000 [#1]
>  Jan 25 03:51:02 foton2 kernel: CPU:    0
>  Jan 25 03:51:02 foton2 kernel: EIP:    0060:[<c013bb35>]    Tainted: P
>  Jan 25 03:51:02 foton2 kernel: EFLAGS: 00010006
>  Jan 25 03:51:02 foton2 kernel: EIP is at free_block+0x43/0xcb
>  Jan 25 03:51:02 foton2 kernel: eax: 00672c30   ebx: 00200200   ecx: e944e20c   
>  edx: c1000000
>  Jan 25 03:51:02 foton2 kernel: esi: eff3f840   edi: 00000002   ebp: eff3f84c   
>  esp: e21e5e98
>  Jan 25 03:51:02 foton2 kernel: ds: 007b   es: 007b   ss: 0068
>  Jan 25 03:51:02 foton2 kernel: Process karamba (pid: 844, threadinfo=e21e4000 
>  task=e29d2cc0)
>  Jan 25 03:51:02 foton2 kernel: Stack: 00000200 e21e5fc4 eff3f85c eff3d350 
>  d6128000 00000286 eff3e3e0 c013bcb2
>  Jan 25 03:51:02 foton2 kernel:        eff3f840 eff3d350 00000004 00000001 
>  00000001 e21e5ee0 00000004 eff3d340
>  Jan 25 03:51:02 foton2 kernel:        d6128000 00000286 00000000 c013be10 
>  eff3f840 eff3d340 c7362080 c7362080
>  Jan 25 03:51:02 foton2 kernel: Call Trace:
>  Jan 25 03:51:02 foton2 kernel:  [<c013bcb2>] cache_flusharray+0xf5/0xfa
>  Jan 25 03:51:02 foton2 kernel:  [<c013be10>] kfree+0x5e/0x62
>  Jan 25 03:51:02 foton2 kernel:  [<c011a6c4>] free_task+0x16/0x2f
>  Jan 25 03:51:02 foton2 kernel:  [<c011d8a9>] release_task+0x18c/0x1f3
>  Jan 25 03:51:02 foton2 kernel:  [<c011f161>] wait_task_zombie+0x151/0x1e4
>  Jan 25 03:51:02 foton2 kernel:  [<c011f5ca>] sys_wait4+0x237/0x27e
>  Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
>  Jan 25 03:51:02 foton2 kernel:  [<c0119411>] default_wake_function+0x0/0x12
>  Jan 25 03:51:02 foton2 kernel:  [<c0108fef>] syscall_call+0x7/0xb

Looks like a double-free of a kernel stack.  Do you have slab debugging
enabled?  Preempt?  SMP?
