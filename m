Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUEEPsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUEEPsV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbUEEPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:48:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52976 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264704AbUEEPsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:48:11 -0400
Date: Wed, 05 May 2004 08:47:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: jos.dehaes@bigfoot.com
Subject: [Bug 2642] New: Oops when mounting a smb filesystem
Message-ID: <479820000.1083772076@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2642

           Summary: Oops when mounting a smb filesystem
    Kernel Version: Linux knudde.be.ubizen.com 2.6.5 #20 Fri Apr 30 17:19:26
                    CEST 20
            Status: NEW
          Severity: normal
             Owner: fs_samba-smb@kernel-bugs.osdl.org
         Submitter: jos.dehaes@bigfoot.com


Distribution: Gentoo Linux
Hardware Environment: x86, dell optiplex gx1, ati mach64
Software Environment: Linux 2.6.5 vanilla preempt + supermount patch, glibc
2.3.2 NPTL, gcc 2.3.3, samba 3.0.2a

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.8
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.0
Modules Loaded         vmnet vmmon binfmt_misc sd_mod usb_storage scsi_mod
uhci_hcd usbcore


Problem Description: Sometimes smb mount gives oops in syslog, but not always.
The offending process is always nautilus (version 2.6.1). After that that
accessing the mount point gives processes in uninterruptable sleep. 


oops:
smb_lookup: find //.Trash-jos failed, error=-5
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<00000000>]    Not tainted
EFLAGS: 00010246   (2.6.5)
EIP is at 0x0
eax: d9f94c20   ebx: d68a3f30   ecx: c015e7c0   edx: d81c4ae0
esi: d68a3fa0   edi: c1329600   ebp: d44d85e0   esp: d68a3efc
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 6808, threadinfo=d68a2000 task=d6d1cd60)
Stack: c01c16d6 d44d85e0 d68a3fa0 c015e7c0 d68a3f30 00000000 00000002 00000004
       d43c4ec4 00000000 d43c0000 d81c4ae0 d4ac8b60 00000000 fffe7b2a d44d85e0
       00000000 00000000 d43c0000 00000002 00000000 00000000 00000001 00000004
Call Trace:
 [<c01c16d6>] smb_readdir+0x3f6/0x5a0
 [<c015e7c0>] filldir64+0x0/0x120
 [<c015e489>] vfs_readdir+0x89/0xa0
 [<c015e7c0>] filldir64+0x0/0x120
 [<c015e94e>] sys_getdents64+0x6e/0xaa
 [<c015e7c0>] filldir64+0x0/0x120
 [<c0107009>] sysenter_past_esp+0x52/0x71
 
Code:  Bad EIP value.

Steps to reproduce:
mount an smb filesystem.
Doesn't happen allways, but has bitten me at least 5 times the last weeks. To
reproduce for this bugreport, it happened on the first try.


