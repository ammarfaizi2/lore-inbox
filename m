Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264848AbUEPX1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbUEPX1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 19:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbUEPX1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 19:27:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:16537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264848AbUEPX1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 19:27:47 -0400
Date: Sun, 16 May 2004 16:27:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: tmp <skrald@amossen.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel OOPS
Message-Id: <20040516162716.34f3d94a.akpm@osdl.org>
In-Reply-To: <1084709330.743.8.camel@debian>
References: <1084709330.743.8.camel@debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tmp <skrald@amossen.dk> wrote:
>
> I get the attached oops message in syslog on my 2.6.6 kernel. I have
>  also attached the ksymoops output.
> 
>  When the oops has occured, I cannot open any shell (including a login
>  shell).
> 
> 
> 
> [oops1.txt  text/plain (2452 bytes)]
>  May 16 13:29:34 debian kernel: Unable to handle kernel paging request at virtual address 1841b518
>  May 16 13:29:34 debian kernel:  printing eip:
>  May 16 13:29:34 debian kernel: c016c02e
>  May 16 13:29:34 debian kernel: *pde = 00000000
>  May 16 13:29:34 debian kernel: Oops: 0000 [#1]
>  May 16 13:29:34 debian kernel: CPU:    0
>  May 16 13:29:34 debian kernel: EIP:    0060:[proc_get_inode+110/272]    Not tainted
>  May 16 13:29:34 debian kernel: EFLAGS: 00010202   (2.6.6) 
>  May 16 13:29:34 debian kernel: EIP is at proc_get_inode+0x6e/0x110
>  May 16 13:29:34 debian kernel: eax: 00000000   ebx: df107850   ecx: 0114df68   edx: 36013bf9
>  May 16 13:29:34 debian kernel: esi: dffec810   edi: dffdee00   ebp: 00000007   esp: d5037e30
>  May 16 13:29:34 debian kernel: ds: 007b   es: 007b   ss: 0068
>  May 16 13:29:35 debian kernel: Process emacs (pid: 743, threadinfo=d5036000 task=d3ec8030)
>  May 16 13:29:35 debian kernel: Stack: df107850 f0000000 df7f19c0 e0820ead dffec810 c5bef353 dffec863 c016e8e3 
>  May 16 13:29:35 debian kernel:        dffdee00 f0000000 dffec810 ffffffea 00000000 dffdddd0 d5037f70 c5bef2d0 
>  May 16 13:29:35 debian kernel:        c5bef2d0 c016c1d1 dffdddd0 c5bef2d0 d5037f70 fffffff4 dffdde38 dffdddd0 
>  May 16 13:29:35 debian kernel: Call Trace:
>  May 16 13:29:35 debian kernel:  [pg0+541367981/1069707264] unix_stream_sendmsg+0x24d/0x3a0 [unix]
>  May 16 13:29:35 debian kernel:  [proc_lookup+179/192] proc_lookup+0xb3/0xc0
>  May 16 13:29:35 debian kernel:  [proc_root_lookup+49/128] proc_root_lookup+0x31/0x80
>  May 16 13:29:35 debian kernel:  [real_lookup+203/240] real_lookup+0xcb/0xf0
>  May 16 13:29:35 debian kernel:  [do_lookup+150/176] do_lookup+0x96/0xb0
>  May 16 13:29:35 debian kernel:  [link_path_walk+1052/2048] link_path_walk+0x41c/0x800
>  May 16 13:29:35 debian kernel:  [path_lookup+105/272] path_lookup+0x69/0x110
>  May 16 13:29:35 debian kernel:  [open_namei+131/1024] open_namei+0x83/0x400
>  May 16 13:29:35 debian kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
>  May 16 13:29:35 debian kernel:  [filp_open+62/112] filp_open+0x3e/0x70

It's a bit strange that no registers have a value vaguely like
0x1841b518, but at a guess I'd say that you have a bad ->owner
pointer in a /proc inode.

What modules are you using, and had any modules been rmmod'ed prior
to the crash?
