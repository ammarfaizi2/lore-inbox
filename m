Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVCUUz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVCUUz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCUUxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:53:25 -0500
Received: from heisenberg.zen.co.uk ([212.23.3.141]:40867 "EHLO
	heisenberg.zen.co.uk") by vger.kernel.org with ESMTP
	id S261895AbVCUUtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:49:04 -0500
Message-Id: <200503212049.j2LKn0h2003231@StraightRunning.com>
From: "Colin Harrison" <colin.harrison@virgin.net>
To: <linux-kernel@vger.kernel.org>
Subject: Supermount patch oops with 2.6.12-rc1-bk1 in drivers/cdrom.c
Date: Mon, 21 Mar 2005 20:49:09 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Copyright: Copyright (c) 2005 Colin Harrison
X-Domain: StraightRunning.com
X-Admin: colin@straightrunning.com
X-Originating-Heisenberg-IP: [62.3.107.196]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using 2.6.12-rc1-bk1 with ck's supermount patch
(supermount-ng208-2611.diff) and am getting the following oops with 'find .
-name fred' from '/' when a disk is in my dvdrom drive:-

Kernel 2.6.12-rc1-bk1 on an i686 / ttyS0
chamonix.straightrunning.com login: Unable to handle kernel NULL pointer
dereference at virtual address 00000108
 printing eip:
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in: parport_pc lp parport floppy natsemi supermount
nls_iso8859_15 ntfs mga_vid fusion intel_agp agpgart snd_seq_oss x
CPU:    0
EIP:    0060:[<c021ea2f>]    Not tainted VLI
EFLAGS: 00010286   (2.6.12colin)
EIP is at cdrom_mediactl+0x16/0xbf
eax: 00000108   ebx: 00000108   ecx: 000004d3   edx: dfb7d300
esi: 000004d3   edi: 000004d3   ebp: d5998e58   esp: d5998e48
ds: 007b   es: 007b   ss: 0068
Process find (pid: 1727, threadinfo=d5998000 task=d909d520)
Stack: dfb7d300 dfb7d300 dfb7d300 000004d3 d5998e68 c021347b 00000000
c02de7a0
       d5998e80 e2a1b6fc 00000000 00000000 d5d906e0 df5bc200 d5998e9c
e2a1dc80
       d5d906e0 00000000 df5bc200 df5bc200 dfce6e14 d5998ea8 e2a1de8e
df5bc200
Call Trace:
 [<c0102cdf>] show_stack+0xa9/0xb1
 [<c0102e4d>] show_registers+0x14d/0x1c1
 [<c0103037>] die+0xe9/0x188
 [<c010e1bc>] do_page_fault+0x437/0x635
 [<c0102937>] error_code+0x2b/0x30
 [<c021347b>] idecd_mediactl+0x23/0x29
 [<e2a1b6fc>] supermount_mediactl+0xb4/0x13c [supermount]
 [<e2a1dc80>] subfs_mount+0xd0/0x11c [supermount]
 [<e2a1de8e>] check_and_remount_subfs+0x38/0x5d [supermount]
 [<e2a1e4cf>] subfs_go_online+0x36/0x102 [supermount]
 [<e2a1c8ea>] supermount_permission+0x47/0xf7 [supermount]
 [<c0157d02>] permission+0x96/0xac
 [<c015979f>] may_open+0x5f/0x1b6
 [<c0159dba>] open_namei+0x4c4/0x597
 [<c014a509>] filp_open+0x29/0x48
 [<c014a949>] sys_open+0x4d/0x87
 [<c01026c7>] sysenter_past_esp+0x54/0x75
Code: 89 44 24 08 8b 45 dc 89 44 24 04 e8 eb 48 ef ff e9 38 ff ff ff 55 89
e5 83 ec 10 89 5d f4 89 75 f8 89 55 f0 89 7d fc 89 c3 89

Entering kdb (current=0xd909d520, pid 1727) Oops: Oops
due to oops @ 0xc021ea2f
eax = 0x00000108 ebx = 0x00000108 ecx = 0x000004d3 edx = 0xdfb7d300
esi = 0x000004d3 edi = 0x000004d3 esp = 0xd5998e48 eip = 0xc021ea2f
ebp = 0xd5998e58 xss = 0xc0220068 xcs = 0x00000060 eflags = 0x00010286
xds = 0xdfb7007b xes = 0x0000007b origeax = 0xffffffff &regs = 0xd5998e14
kdb>

More info. can be supplied as required and I'll look further myself.

Thanks

Colin Harrison

