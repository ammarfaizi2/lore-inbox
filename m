Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261366AbTCGFV4>; Fri, 7 Mar 2003 00:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbTCGFV4>; Fri, 7 Mar 2003 00:21:56 -0500
Received: from franka.aracnet.com ([216.99.193.44]:61629 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261366AbTCGFVw>; Fri, 7 Mar 2003 00:21:52 -0500
Date: Thu, 06 Mar 2003 21:32:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 449] New: Kernel BUG when tun device is closed 
Message-ID: <302800000.1047015141@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://bugme.osdl.org/show_bug.cgi?id=449

           Summary: Kernel BUG when tun device is closed (oops attached)
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: mochel@osdl.org
         Submitter: kpfleming@cox.net


Distribution: heavily modified RedHat 7.3
Hardware Environment: MSI K7T266-Pro2 motherboard, Athlon Thunderbird 1GHz CPU,
(2) WD1600JB disks, etc.
Software Environment: vtund-2.5
Problem Description: vtund works fine normally (is in client mode on this
system). when the server end of the link was shutdown, the client tried to close
its open "tun" device. this action caused the oops below.

kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c0172a2c>]    Not tainted
EFLAGS: 00010246
EIP is at sysfs_remove_dir+0x1c/0x13b
eax: 00000000   ebx: c434e9a8   ecx: 00000000   edx: 00000000
esi: c7d7f900   edi: cfa50000   ebp: 00000000   esp: cfa51f10
ds: 007b   es: 007b   ss: 0068
Process vtund (pid: 757, threadinfo=cfa50000 task=cfa913c0)
Stack: c03bc980 c434e824 c03bf2d4 c434e9a8 c434e824 cfa50000 00000000 c01fb4b3 
       c434e9a8 c434e9a8 c01fb4e3 c434e9a8 c434e824 c02f82ed c434e9a8 00000006 
       c434e824 c434e824 c434e800 c8fc3080 cf8b4500 c0263b2e c434e824 c4e43a40 
Call Trace:
 [<c01fb4b3>] kobject_del+0x13/0x30
 [<c01fb4e3>] kobject_unregister+0x13/0x30
 [<c02f82ed>] unregister_netdevice+0x1ad/0x290
 [<c0263b2e>] tun_chr_close+0x8e/0xa0
 [<c0147d39>] __fput+0xa9/0xb0
 [<c014627d>] filp_close+0x4d/0x80
 [<c0146300>] sys_close+0x50/0x60
 [<c010ade3>] syscall_call+0x7/0xb

Code: 0f 0b 0a 01 a4 6b 36 c0 ff 06 83 4e 04 08 85 f6 0f 84 01 01


