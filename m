Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbTIZN67 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 09:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTIZN66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 09:58:58 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:18097 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262225AbTIZN64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 09:58:56 -0400
Date: Fri, 26 Sep 2003 04:53:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jhall@hcs-software.com
Subject: [Bug 1271] New: Kernel panic in network code
Message-ID: <41440000.1064577183@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=1271

           Summary: Kernel panic in network code
    Kernel Version: 2.6.0-test5
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: jhall@hcs-software.com


Problem Description:

Unable to handle kernel NULL pointer dereference at virtual address 00000049
 printing eip:
c030b346
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c030b346>]    Not tainted
EFLAGS: 00010246
EIP is at tcp_v4_get_port+0x3c6/0x3e0
eax: 00000000   ebx: f74ff380   ecx: f667ff40   edx: f667ff50
esi: 00000002   edi: 00002151   ebp: f66097c0   esp: f6b0be68
ds: 007b   es: 007b   ss: 0068
Process perl (pid: 3433, threadinfo=f6b0a000 task=f6b0d900)
Stack: 00000000 00000000 00000000 f66270d0 00000000 00000000 00000001 f6609908 
       00000000 00000000 00000000 00000001 f7c90a88 f66097c0 ffffffea f6609908 
       f6b0bee8 c031f215 f66097c0 00002151 c02d568d 00000003 21511818 f6612740 
Call Trace:
 [<c031f215>] inet_bind+0x1d5/0x300
 [<c02d568d>] move_addr_to_kernel+0x8d/0xa0
 [<c02d6d8b>] sys_bind+0x7b/0xb0
 [<c011c11c>] do_page_fault+0x23c/0x44f
 [<c02d59dc>] sockfd_lookup+0x1c/0x80
 [<c02d74d8>] sys_setsockopt+0x78/0xc0
 [<c02d7be8>] sys_socketcall+0xc8/0x2b0
 [<c01095d9>] sysenter_past_esp+0x52/0x71

Code: 0f b6 40 49 24 20 84 c0 75 97 eb 89 89 14 24 e8 06 51 e1 ff 
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing



Steps to reproduce:

rpmbuild --rebuild --target=athlon mod_perl-1.99_07-5.src.rpm

The kernel panics during the make test stage. I believe the modules/cgi test
is the culprit.

Software Environment:

Linux 2.6.0-test5 #3 SMP Tue Sep 23 15:18:28 GMT+5 2003 i686 athlon i386 GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.11y
mount                  2.11y
module-init-tools      2.4.25
e2fsprogs              1.32
jfsutils               1.0.17
reiserfsprogs          3.6.4
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 2.0.11
Net-tools              1.60
Kbd                    1.08
Sh-utils               4.5.3
Modules Loaded         natsemi crc32

