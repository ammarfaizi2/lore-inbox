Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271473AbTGQOoo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271474AbTGQOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:44:44 -0400
Received: from franka.aracnet.com ([216.99.193.44]:643 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S271473AbTGQOog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:44:36 -0400
Date: Thu, 17 Jul 2003 07:59:15 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 942] New: Mounting CIFS filesystem generates an oops
Message-ID: <14330000.1058453955@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=942

           Summary: Mounting CIFS filesystem generates an oops
    Kernel Version: 2.6.0-test1
            Status: NEW
          Severity: high
             Owner: bugme-janitors@lists.osdl.org
         Submitter: janfrode@parallab.no


Distribution: RedHat 9 + 2.6.0-test1.1.25 kernel from
http://people.redhat.com/arjanv/2.5/
Hardware Environment: Dell Optiplex GX260 (single cpu Pentium4, no HT)
Software Environment:
Problem Description:

Trying to mount a remote CIFS filesystem with mount.cifs segfaults and gives an
oops. The cifs and nls_iso8859_1 modules get automatically loaded.

------------[ cut here ]------------
kernel BUG at mm/slab.c:1518!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013b847>]    Not tainted
EFLAGS: 00010002
EIP is at cache_grow+0x17/0x240
eax: f7ffa29c   ebx: 00000015   ecx: f7fff4e0   edx: 00000015
esi: f7fff4fc   edi: f7fff4e0   ebp: f7fff4ec   esp: f4eb7d7c
ds: 007b   es: 007b   ss: 0068
Process mount.cifs (pid: 2441, threadinfo=f4eb6000 task=f4f47880)
Stack: 00000000 00000000 00000082 f4eb7dcc f7fbb21c f7ffe28c f7fff4fc 00000202
       f7fff4ec c013bcb8 f7fff4e0 00000015 f692d000 f4eb7dc8 f7fff4ec f7ffa29c
       00000010 00000000 f7fff4e0 00000202 00000000 c013c2ae f7fff4e0 00000015
Call Trace:
 [<c013bcb8>] cache_alloc_refill+0x248/0x380
 [<c013c2ae>] kmem_cache_alloc+0x15e/0x180
 [<c01a2d97>] strsep+0x27/0x40
 [<f8ab9954>] parse_mount_options+0x254/0x770 [cifs]
 [<f8aba800>] cifs_mount+0x60/0x9a0 [cifs]
 [<c019837f>] load_nls+0x2f/0x60
 [<f8ab3059>] cifs_read_super+0x59/0x180 [cifs]
 [<f8ab3501>] cifs_get_sb+0x81/0xd0 [cifs]
 [<c0157de3>] do_kern_mount+0x63/0x120
 [<c016c09b>] do_add_mount+0x6b/0x180
 [<c016c3fe>] do_mount+0x15e/0x1b0
 [<c016c290>] copy_mount_options+0xe0/0xf0
 [<c016c880>] sys_mount+0xa0/0xf0
 [<c010ab7d>] sysenter_past_esp+0x52/0x71
 
Code: 0f 0b ee 05 f3 02 2b c0 31 c0 f6 c7 20 0f 85 45 01 00 00 c7
 ------------[ cut here ]------------
kernel BUG at mm/slab.c:1518!
invalid operand: 0000 [#2]
CPU:    0
EIP:    0060:[<c013b847>]    Not tainted
EFLAGS: 00010002
EIP is at cache_grow+0x17/0x240
eax: f7ffa29c   ebx: 00000015   ecx: f7fff4e0   edx: 00000015
esi: f7fff4fc   edi: f7fff4e0   ebp: f7fff4ec   esp: f4d4fd7c
ds: 007b   es: 007b   ss: 0068
Process mount.cifs (pid: 2475, threadinfo=f4d4e000 task=f4f46c80)
Stack: 000008c4 f51138c4 f4d4fda0 00000292 f5d99928 f7ffe28c f7fff4fc 00000202
       f7fff4ec c013bcb8 f7fff4e0 00000015 0000001d 00020001 f7fff4ec f7ffa29c
       00000010 00000000 f7fff4e0 00000202 00000000 c013c2ae f7fff4e0 00000015
Call Trace:
 [<c013bcb8>] cache_alloc_refill+0x248/0x380
 [<c013c2ae>] kmem_cache_alloc+0x15e/0x180
 [<c01a2d97>] strsep+0x27/0x40
 [<f8ab9954>] parse_mount_options+0x254/0x770 [cifs]
 [<f8aba800>] cifs_mount+0x60/0x9a0 [cifs]
 [<c0198363>] load_nls+0x13/0x60
 [<f8ab3059>] cifs_read_super+0x59/0x180 [cifs]
 [<f8ab3501>] cifs_get_sb+0x81/0xd0 [cifs]
 [<c0157de3>] do_kern_mount+0x63/0x120
 [<c016c09b>] do_add_mount+0x6b/0x180
 [<c016c3fe>] do_mount+0x15e/0x1b0
 [<c016c290>] copy_mount_options+0xe0/0xf0
 [<c016c880>] sys_mount+0xa0/0xf0
 [<c010ab7d>] sysenter_past_esp+0x52/0x71
 
Code: 0f 0b ee 05 f3 02 2b c0 31 c0 f6 c7 20 0f 85 45 01 00 00 c7
  


Steps to reproduce:


# mount.cifs //cifs.server/share /mnt/share -o username=username,domain=domain

