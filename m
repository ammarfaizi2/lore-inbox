Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUC0NHj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 08:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbUC0NHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 08:07:39 -0500
Received: from gw.c9x.org ([213.41.131.17]:31637 "HELO b.mx.42-networks.com")
	by vger.kernel.org with SMTP id S261689AbUC0NHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 08:07:37 -0500
Date: Sat, 27 Mar 2004 14:07:35 +0100
From: Jedi/Sector One <fdenis@skyrock.fr>
To: linux-kernel@vger.kernel.org
Subject: nfsd oops with 2.6.5-rc2-mm4
Message-ID: <20040327130757.GA6760@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.
  
  I got a reproducible oops after a few minutes with a 2.6.5-rc2-mm4 kernel.
  
  /etc/exports :
/mnt/data 10.42.42.0/24(rw,async,no_subtree_check,root_squash,
                        anonuid=10000,anongid=10000)

  Clients are 2.6.5-rc2-mm2 kernels, filesystem is ReiserFS 3, data=writeback.
  Exports are mounted with tcp,nolock,soft,timeo=600,retrans=2,actimeo=30,
rsize=32768,wsize=32768.

  Once the oops has happened, no client can access the mount point any more.
  
  Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c029fd35
*pde = 00000000
Oops: 0002 [#1]
SMP
CPU:    0
EIP:    0060:[<c029fd35>]    Not tainted VLI
EFLAGS: 00010287   (2.6.5-rc2-mm4)
EIP is at do_tcp_sendpages+0x197/0xa79
eax: d1d24108   ebx: f5e3fd80   ecx: 00000008   edx: 00000000
esi: 00000001   edi: d1d24100   ebp: f72391ec   esp: f6283e34
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 3330, threadinfo=f6283000 task=f62962b0)
Stack: 000000d0 000000d0 00000000 00000000 15270000 c01e6a8d d1d24110 f7239064
       00000008 00000000 00000000 00000000 000005b4 00007530 00000000 f7239000
       00000008 00000000 c02a069f f7239000 f6283eac 00000000 00000008 00000000
Call Trace:
 [<c01e6a8d>] nfsd_readdir+0x69/0xe8
 [<c02a069f>] tcp_sendpage+0x88/0x96
 [<c02d8ed4>] svc_sendto+0x16a/0x29e
 [<c01ed0d5>] encode_post_op_attr+0x1c9/0x241
 [<c02d9f40>] svc_tcp_sendto+0x53/0xa8
 [<c02da6f8>] svc_send+0xb9/0xfc
 [<c02dc384>] svcauth_unix_release+0x57/0x59
 [<c02d838c>] svc_process+0x187/0x611
 [<c01e0de5>] nfsd+0x1ea/0x3b6
 [<c01e0bfb>] nfsd+0x0/0x3b6
 [<c0104e01>] kernel_thread_helper+0x5/0xb

Code: 4c 24 20 85 f6 74 17 8d 04 f7 8d 50 08 89 54 24 18 8b 54 24 28 3b 50 08 0f 84 80 08 00 00 83 fe 11 0f 87 25 04 00 00 8b 54 24 28 <f0> ff 42 04 8b 7c 24 28 8b 83 98 00 00 00 8d 04 f0 89 78 10 8d

  Best regards,
  
       -Frank.
       
