Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263211AbUDPOKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 10:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUDPOKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 10:10:25 -0400
Received: from external2.azuro.com ([212.44.26.44]:50104 "EHLO zinc.azuro.com")
	by vger.kernel.org with ESMTP id S263211AbUDPOKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 10:10:18 -0400
Envelope-to: linux-kernel@vger.kernel.org
Date: Fri, 16 Apr 2004 15:10:16 +0100
To: linux-kernel@vger.kernel.org
Subject: NFS oops with 2.6.4 server / Solaris 2.8 client
Message-ID: <20040416141016.GA27316@platinum.azuro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Clay <pete@azuro.com>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "zinc", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  I have this oops with the situation described in the
	subject, using the Solaris automounter in /net to access the Linux
	server. This is repeatable. It doesn't always crash the machine, but
	fairly soon after I end up with all the nfsd processes stuck in 'D'
	state. What other debugging information would help find this problem?
	[...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have this oops with the situation described in the subject, using the Solaris
automounter in /net to access the Linux server. This is repeatable. It doesn't
always crash the machine, but fairly soon after I end up with all the nfsd
processes stuck in 'D' state. What other debugging information would help find
this problem?

(output of dmesg follows)

...
nfs warning: mount version older than kernel
RPC request reserved 0 but used 112
Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c02a91c0
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c02a91c0>]    Not tainted
EFLAGS: 00010287
EIP is at do_tcp_sendpages+0x660/0xbf0
eax: 00000000   ebx: ddc5cb80   ecx: 00000008   edx: 00000000
esi: 00000001   edi: cfd0d9c8   ebp: d0632100   esp: dd0dbe34
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1366, threadinfo=dd0da000 task=dd100d40)
Stack: 000000b0 000000d0 c014d61a dd19670c dd0dbe70 c01c7efd d0632110 00000000
       00000008 00000000 00000000 00000000 000005b4 00007530 00000000 cfd0d800
       00000008 00000000 c02a97d9 cfd0d800 dd0dbeac 00000000 00000008 00000000
Call Trace:
 [<c014d61a>] close_private_file+0x2a/0x30
 [<c01c7efd>] nfsd_close+0x1d/0x40
 [<c02a97d9>] tcp_sendpage+0x89/0xa0
 [<c02e8343>] svc_sendto+0x173/0x2b0
 [<c01d0e28>] encode_post_op_attr+0x1c8/0x260
 [<c02e941c>] svc_tcp_sendto+0x6c/0xc0
 [<c02e9bbc>] svc_send+0xbc/0x100
 [<c02eb828>] svcauth_unix_release+0x58/0x60
 [<c02e7858>] svc_process+0x1b8/0x640
 [<c01c43b0>] nfsd+0x190/0x300
 [<c01c4220>] nfsd+0x0/0x300
 [<c0108c49>] kernel_thread_helper+0x5/0xc

Code: ff 42 04 8b 83 a8 00 00 00 8b 6c 24 28 8d 04 f0 89 68 10 8d

