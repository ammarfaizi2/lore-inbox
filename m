Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263263AbTCVQil>; Sat, 22 Mar 2003 11:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263380AbTCVQik>; Sat, 22 Mar 2003 11:38:40 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:29509
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263263AbTCVQik>; Sat, 22 Mar 2003 11:38:40 -0500
Date: Sat, 22 Mar 2003 11:46:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: William Lee Irwin III <wli@holomorphy.com>
Subject: RPCSVC_MAXPAGES doesn't account for overhead(?) pages
Message-ID: <Pine.LNX.4.50.0303221116250.18911-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this BUG with a 32k PAGE_SIZE, it looks like we unconditionally 
allocate 2 extra pages on top of requested size so we wouldn't be able to 
service a maximum payload from nfsd.

Is there a more suitable/elegant fix?

------------[ cut here ]------------
kernel BUG at net/sunrpc/svc.c:121!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c03e6baf>]    Not tainted
EFLAGS: 00010202
EIP is at svc_init_buffer+0x2f/0x80
eax: 00000002   ebx: 00000004   ecx: 000000d0   edx: 000001e0
esi: 00000000   edi: cba45948   ebp: fffffff4   esp: c9b99f28
ds: 007b   es: 007b   ss: 0068
Process rpc.nfsd (pid: 762, threadinfo=c9b98000 task=cace0700)
Stack: cba45948 c98bad44 00008400 c03e6d73 cba45948 00008400 c05a2f10 00000007 
       00000000 00000801 c01e31b1 c01e3330 c98bad44 c7c38004 00000008 00000002 
       cb4f7690 c01e3a5c 00000801 00000008 00000008 caf385d4 c7c38000 00000000 
Call Trace:
 [<c03e6d73>] svc_create_thread+0xa3/0xe0
 [<c01e31b1>] nfsd_svc+0xb1/0x230
 [<c01e3330>] nfsd+0x0/0x480
 [<c01e3a5c>] TA_write+0x10c/0x160
 [<c018597a>] sys_nfsservctl+0xba/0x100
 [<c0109477>] syscall_call+0x7/0xb

Code: 0f 0b 79 00 5d 05 48 c0 85 db 74 25 90 8d 74 26 00 31 d2 b9 


-- 
function.linuxpower.ca
