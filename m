Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTFBU15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbTFBU15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:27:57 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18891 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263861AbTFBU1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:27:36 -0400
Date: Mon, 02 Jun 2003 13:29:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 765] New: smbfs segfault when mounting mountpoint that is in use(?)
Message-ID: <51330000.1054585795@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=765

           Summary: smbfs segfault when mounting mountpoint that is in
                    use(?)
    Kernel Version: 2.5.70-mm1
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: mcd@daviesinc.com


Distribution:Debian
Hardware Environment:Toshiba Satellite Pro 4600, mounting smbfs system from
Debian 2.4.20-xfs-rmap15f machine
Software Environment:xmms, smbfs, xfs filesystem
Problem Description: Kernel segfault when I mount an smbfs mount while the
mountpoint may have a file open

Steps to reproduce:

Package: smbfs
Version: 2.999+3.0.alpha24-3
Severity: normal

I can duplicate this about 60% of the time -- however, once it hangs, anything
dealing with the mounted filesystem will cause the process to hang.  Kill -9
mount.smbfs has no result. (it was mentioned in an old bug report for smbfs
dealing with 2.2/potato)

ls /music and df both hang when accessing the samba partition.

Much harder to duplicate is disconnecting the network connection to the other
machine after it has been mounted, but before any files have been requested.  I
can get it to do that perhaps 1% of the time.

Both errors started after I upgraded from 2.4.20 to 2.5.70-mm1.  According to
the userland utils, no recent updates have been made.

How it happens:

I have a laptop with wifi, and of course the samba filesystem doesn't mount
during bootup (probably a config issue on my part).  I start xmms without 
having the samba filesystem mounted and it starts playing, however every
file in the playlist cannot be found.  While it is going through that, I mount
the filesystem.  When the system is mounted, there is a 60/40 chance that it
will segfault.

In 2.4 it seemed to work fine, however, I do keep somewhat current with apt-get
upgrades, so I don't know if there was a recent samba upgrade that happened
since I upgraded to 2.5.  (NOTE, smbfs guys claim it is a kernel bug, not a
userspace bug)

Error in dmesg:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<00000000>]    Tainted: PF  VLI
EFLAGS: 00010296
EIP is at 0x0
eax: d2c7cf00   ebx: d5aac760   ecx: 00000000   edx: d5aac760
esi: d8983e58   edi: c29752c0   ebp: c29752c0   esp: d8983e24
ds: 007b   es: 007b   ss: 0068
Process xmms (pid: 15041, threadinfo=d8982000 task=c45dd270)
Stack: c01dae00 d5aac760 c29752c0 d8983e58 ffffffdc c29752c0 d8983e58 c01dc413 
       c29752c0 d8983e58 00000003 00000000 00000000 00000000 00000000 00010000 
       000003e8 000003e8 00000000 00000000 00000000 00000000 00000000 00000000 
Call Trace:
 [<c01dae00>] smb_proc_getattr+0x40/0x60
 [<c01dc413>] smb_lookup+0x43/0x150
 [<c016082a>] real_lookup+0xca/0xf0
 [<c0160ace>] do_lookup+0x9e/0xb0
 [<c0160c09>] link_path_walk+0x129/0x8e0
 [<c0161cd6>] open_namei+0x76/0x3f0
 [<c0120973>] exit_notify+0x243/0x720
 [<c01515be>] filp_open+0x3e/0x70
 [<c0151a8b>] sys_open+0x5b/0x90
 [<c01092cb>] syscall_call+0x7/0xb

Code:  Bad EIP value.


-- System Information:
Debian Release: testing/unstable
Architecture: i386
Kernel: Linux mcdlp 2.5.70-mm1 #1 Wed May 28 23:13:10 EDT 2003 i686
Locale: LANG=C, LC_CTYPE=C

Versions of packages smbfs depends on:
ii  e2fsprogs [li 1.33+1.34-WIP-2003.05.21-1 The EXT2 file system utilities and
ii  libc6         2.3.1-17                   GNU C Library: Shared libraries an
pn  libcomerr2                               Not found.
ii  libkrb53      1.2.7-4                    MIT Kerberos runtime libraries
ii  netbase       4.09                       Basic TCP/IP networking system
ii  samba-common  2.999+3.0.alpha24-3        Samba common files used by both th

-- no debconf information


