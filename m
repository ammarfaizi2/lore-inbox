Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278475AbRJOXnr>; Mon, 15 Oct 2001 19:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278478AbRJOXnh>; Mon, 15 Oct 2001 19:43:37 -0400
Received: from t11-12.ra.uc.edu ([129.137.228.252]:56963 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S278475AbRJOXna>;
	Mon, 15 Oct 2001 19:43:30 -0400
Date: Mon, 15 Oct 2001 19:46:19 -0400
To: linux-kernel@vger.kernel.org
Subject: file w/ 'invalid mode 00' on reiserfs, cannot remove + oops
Message-ID: <20011015194619.A25653@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

earlier i was trying to update my system when dpkg failed. when i went to check
things out, this is what i found...
/sbin/depmod somehow turned into some invalid type of file, with a ctime and atime
equal to the epoch.

first, how can i remove this file?  i still need to update modutils.
second, poking on this file causes a oops.

i would be more than happy to help out with solving this issue, just let me know.
please cc me, i can only handle the digest form of this list.
thanks,
rob.

the file in question is on a reiserfs 3.6 partition mounted on /

my system:
athlon, IBM-DTLA-307045 disk,
Linux version 2.4.10 (root@cartman) (gcc version 2.95.4 20010902 (Debian prerelease))

other info:
running 'rm /sbin/depmod' seg faults because of the oops

running 'ls --full-time /sbin/depmod'
?---------  1000 rob      root            0 Wed Dec 31 19:00:00 1969 /sbin/depmod

running 'file /sbin/depmod'
/sbin/depmod: file: invalid mode 00.

My oops ->
ksymoops 2.4.1 on i686 2.4.10.  Options used
     -V (default)
     -k oops.syms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /boot/System.map-2.4.10 (default)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000410
c013802d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013802d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 000003e8   ebx: 00000000   ecx: 00000002   edx: cfbb6180
esi: cfbb6180   edi: 00000002   ebp: ce115f8c   esp: ce115f28
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 11035, stackpage=ce115000)
Stack: ffffffeb cfbb6180 00008202 c013813a cfbb6180 00000002 c01391cc cfbb6180 
       00000002 00000000 cfe33000 00008201 bffff4bc cff5fc70 00000000 00000002 
       cffecd40 c012d67b cfe33000 00008202 00000000 ce115f8c 00000004 cfe33000 
Call Trace: [<c013813a>] [<c01391cc>] [<c012d67b>] [<c012d9d6>] [<c0106c4b>] 
Code: f6 40 28 01 74 23 89 d8 25 00 f0 ff ff 66 3d 00 80 74 0c 66 

>>EIP; c013802d <vfs_permission+1d/100>   <=====
Trace; c013813a <permission+2a/30>
Trace; c01391cc <open_namei+2dc/500>
Trace; c012d67b <filp_open+3b/60>
Trace; c012d9d6 <sys_open+36/a0>
Trace; c0106c4b <system_call+33/38>
Code;  c013802d <vfs_permission+1d/100>
00000000 <_EIP>:
Code;  c013802d <vfs_permission+1d/100>   <=====
   0:   f6 40 28 01               testb  $0x1,0x28(%eax)   <=====
Code;  c0138031 <vfs_permission+21/100>
   4:   74 23                     je     29 <_EIP+0x29> c0138056 <vfs_permission+46/100>
Code;  c0138033 <vfs_permission+23/100>
   6:   89 d8                     mov    %ebx,%eax
Code;  c0138035 <vfs_permission+25/100>
   8:   25 00 f0 ff ff            and    $0xfffff000,%eax
Code;  c013803a <vfs_permission+2a/100>
   d:   66 3d 00 80               cmp    $0x8000,%ax
Code;  c013803e <vfs_permission+2e/100>
  11:   74 0c                     je     1f <_EIP+0x1f> c013804c <vfs_permission+3c/100>
Code;  c0138040 <vfs_permission+30/100>
  13:   66                        data16

