Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263819AbUDPVaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbUDPV3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:29:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:19607 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263819AbUDPV2b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:28:31 -0400
Date: Fri, 16 Apr 2004 14:30:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Peter Clay <pete@azuro.com>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: NFS oops with 2.6.4 server / Solaris 2.8 client
Message-Id: <20040416143008.1b775f97.akpm@osdl.org>
In-Reply-To: <20040416141016.GA27316@platinum.azuro.com>
References: <20040416141016.GA27316@platinum.azuro.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Clay <pete@azuro.com> wrote:
>
> I have this oops with the situation described in the subject, using the Solaris
> automounter in /net to access the Linux server. This is repeatable. It doesn't
> always crash the machine, but fairly soon after I end up with all the nfsd
> processes stuck in 'D' state. What other debugging information would help find
> this problem?
> 
> (output of dmesg follows)
> 
> ...
> nfs warning: mount version older than kernel
> RPC request reserved 0 but used 112
> Unable to handle kernel NULL pointer dereference at virtual address 00000004
>  printing eip:
> c02a91c0
> *pde = 00000000
> Oops: 0002 [#1]
> CPU:    0
> EIP:    0060:[<c02a91c0>]    Not tainted
> EFLAGS: 00010287
> EIP is at do_tcp_sendpages+0x660/0xbf0
> eax: 00000000   ebx: ddc5cb80   ecx: 00000008   edx: 00000000
> esi: 00000001   edi: cfd0d9c8   ebp: d0632100   esp: dd0dbe34
> ds: 007b   es: 007b   ss: 0068
> Process nfsd (pid: 1366, threadinfo=dd0da000 task=dd100d40)
> Stack: 000000b0 000000d0 c014d61a dd19670c dd0dbe70 c01c7efd d0632110 00000000
>        00000008 00000000 00000000 00000000 000005b4 00007530 00000000 cfd0d800
>        00000008 00000000 c02a97d9 cfd0d800 dd0dbeac 00000000 00000008 00000000
> Call Trace:
>  [<c014d61a>] close_private_file+0x2a/0x30
>  [<c01c7efd>] nfsd_close+0x1d/0x40
>  [<c02a97d9>] tcp_sendpage+0x89/0xa0
>  [<c02e8343>] svc_sendto+0x173/0x2b0
>  [<c01d0e28>] encode_post_op_attr+0x1c8/0x260
>  [<c02e941c>] svc_tcp_sendto+0x6c/0xc0
>  [<c02e9bbc>] svc_send+0xbc/0x100
>  [<c02eb828>] svcauth_unix_release+0x58/0x60
>  [<c02e7858>] svc_process+0x1b8/0x640
>  [<c01c43b0>] nfsd+0x190/0x300

2.6.4 is a bit old, and knfsd fixes have been applied since then.  Are you in
a position to test 2.6.6-rc1?
