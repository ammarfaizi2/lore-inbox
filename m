Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTDGV01 (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 17:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263672AbTDGV01 (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 17:26:27 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:54660 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263665AbTDGV0Z (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 17:26:25 -0400
Message-ID: <3E92F953.8080401@blue-labs.org>
Date: Tue, 08 Apr 2003 12:31:15 -0400
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030403
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Neil Brown <neilb@cse.unsw.edu.au>, Oleg Drokin <green@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: [OOPS] 100% repeatable OOPS, 2.5.61-66, NFS and reiserfs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.1 build 917; timestamp 2003-04-07 21:25:41, message serial number 894615
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Power loss this morning
2. Fixed filesystems (reiserfstools is fscking useless on root filesystems)
3. Now server OOPSes when nfs client tries to stat/read files/dirs

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010202
EIP is at 0x0
eax: 00000000   ebx: 00000006   ecx: c03efb28   edx: c827be94
esi: c83ad014   edi: dfd16e00   ebp: c827beac   esp: c827be70
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1188, threadinfo=c827a000 task=df3c2740)
Stack: c01ce6b8 dfd16e00 c827bea0 c827be94 c01ad070 dfff04f4 00000006 
c83ad004
       11270000 00000e07 000008dd 0000004d 0002f4f2 00000e07 01214b98 
c827bef4
       c01ad4c7 dfd16e00 c83ad014 00000006 00000006 c01ad070 dfff04f4 
c83ad004
Call Trace:
 [<c01ce6b8>] reiserfs_decode_fh+0xb4/0xc0
 [<c01ad070>] nfsd_acceptable+0x0/0x114
 [<c01ad4c7>] fh_verify+0x343/0x4f8
 [<c01ad070>] nfsd_acceptable+0x0/0x114
 [<c01ae694>] nfsd_access+0x28/0xf4
 [<c01b4ec9>] nfsd3_proc_access+0xc1/0xd0
 [<c01ab4a3>] nfsd_dispatch+0xc3/0x18f
 [<c033b5cd>] svc_process+0x3ed/0x67a
 [<c01ab200>] nfsd+0x23c/0x41c
 [<c01aafc4>] nfsd+0x0/0x41c
 [<c0107145>] kernel_thread_helper+0x5/0xc


Code:  Bad EIP value.
 <1>Unable to handle kernel NULL pointer dereference at virtual address 
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010202
EIP is at 0x0
eax: 00000000   ebx: 00000006   ecx: c03efb28   edx: c8269e94
esi: c83a0014   edi: dfd16e00   ebp: c8269eac   esp: c8269e70
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1189, threadinfo=c8268000 task=df5ba720)
Stack: c01ce6b8 dfd16e00 c8269ea0 c8269e94 c01ad070 dfff04f4 00000006 
c83a0004
       11270000 00000e07 000008dd 0000004d 0002f4f2 00000e07 01214b98 
c8269ef4
       c01ad4c7 dfd16e00 c83a0014 00000006 00000006 c01ad070 dfff04f4 
c83a0004
Call Trace:
 [<c01ce6b8>] reiserfs_decode_fh+0xb4/0xc0
 [<c01ad070>] nfsd_acceptable+0x0/0x114
 [<c01ad4c7>] fh_verify+0x343/0x4f8
 [<c01ad070>] nfsd_acceptable+0x0/0x114
 [<c01ae694>] nfsd_access+0x28/0xf4
 [<c01b4ec9>] nfsd3_proc_access+0xc1/0xd0
 [<c01ab4a3>] nfsd_dispatch+0xc3/0x18f
 [<c033b5cd>] svc_process+0x3ed/0x67a
 [<c01ab200>] nfsd+0x23c/0x41c
 [<c01aafc4>] nfsd+0x0/0x41c
 [<c0107145>] kernel_thread_helper+0x5/0xc

(repeats several times)

Server is now useless and needs to be rebooted.  I've shutdown my NFS 
clients in order to run the server minimally, it's a mail/web server.

Assistance would be appreciated.


