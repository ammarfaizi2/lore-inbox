Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHIUOV>; Fri, 9 Aug 2002 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSHIUOV>; Fri, 9 Aug 2002 16:14:21 -0400
Received: from [63.204.6.12] ([63.204.6.12]:22226 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S315717AbSHIUOU>;
	Fri, 9 Aug 2002 16:14:20 -0400
Date: Fri, 9 Aug 2002 16:18:02 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: pcihpfs problems in 2.4.19
Message-ID: <Pine.LNX.4.33.0208091547280.32159-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just started testing the cPCI hotplug driver I'm working on against
2.4.19 after upgrading the kernel in SOMA's in-house distribution,
and I'm now getting the attached oops code when trying to access the
pcihpfs (e.g. with ls) after mounting it.  I backed out the couple of
changes I made last night that might have been remotely connected
(added hardware_test and get_power_status hotplug ops in my driver),
and I'm still getting it in the same place, so it looks like maybe a
VFS change somewhere in 2.4.19 broke pcihpfs.  Any ideas?

Thanks,

Scott


ksymoops 2.4.4 on i686 2.4.19.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/ (specified)
     -m /boot/System.map (default)

Unable to handle kernel NULL pointer dereference at virtual address 00000024
c013d0d2
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d0d2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: cf341488   ebx: cf341460   ecx: 0805a495   edx: 00000018
esi: 00000020   edi: c13eaf60   ebp: cfe19f54   esp: cfe19f44
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 372, stackpage=cfe19000)
Stack: cfdd8b80 cfdd8bfc cfdd8be8 cf341488 cfe19f74 c013ce80 c13eaf60 cfe19fac
       c013d3d0 fffffff7 00000000 00000003 cfe19fbc c013d571 c13eaf60 c013d3d0
       cfe19fac cfe18000 00000000 00000003 c13eaf60 cffacc78 cfe19fbc c0122ecc
Call Trace:    [<c013ce80>] [<c013d3d0>] [<c013d571>] [<c013d3d0>] [<c0122ecc>]
  [<c010890b>]
Code: 8b 46 04 8b 16 89 42 04 89 10 8b 43 28 89 70 04 89 06 8b 55

>>EIP; c013d0d2 <dcache_readdir+a2/134>   <=====
Trace; c013ce80 <vfs_readdir+60/80>
Trace; c013d3d0 <filldir64+0/154>
Trace; c013d571 <sys_getdents64+4d/100>
Trace; c013d3d0 <filldir64+0/154>
Trace; c0122ecc <sys_brk+c0/ec>
Trace; c010890b <system_call+33/38>
Code;  c013d0d2 <dcache_readdir+a2/134>
00000000 <_EIP>:
Code;  c013d0d2 <dcache_readdir+a2/134>   <=====
   0:   8b 46 04                  mov    0x4(%esi),%eax   <=====
Code;  c013d0d5 <dcache_readdir+a5/134>
   3:   8b 16                     mov    (%esi),%edx
Code;  c013d0d7 <dcache_readdir+a7/134>
   5:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c013d0da <dcache_readdir+aa/134>
   8:   89 10                     mov    %edx,(%eax)
Code;  c013d0dc <dcache_readdir+ac/134>
   a:   8b 43 28                  mov    0x28(%ebx),%eax
Code;  c013d0df <dcache_readdir+af/134>
   d:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c013d0e2 <dcache_readdir+b2/134>
  10:   89 06                     mov    %eax,(%esi)
Code;  c013d0e4 <dcache_readdir+b4/134>
  12:   8b 55 00                  mov    0x0(%ebp),%edx


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


