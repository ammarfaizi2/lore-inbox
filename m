Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135609AbREACtj>; Mon, 30 Apr 2001 22:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135911AbREACt3>; Mon, 30 Apr 2001 22:49:29 -0400
Received: from adelphi.physics.adelaide.edu.au ([129.127.36.1]:53771 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S135609AbREACtT>; Mon, 30 Apr 2001 22:49:19 -0400
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200105010249.MAA01383@mercury.physics.adelaide.edu.au>
Subject: CDROM? oops in 2.2.19
To: linux-kernel@vger.kernel.org
Date: Tue, 1 May 2001 12:19:14 +0930 (CST)
Cc: jwoithe@physics.adelaide.edu.au
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

We are currently running 2.2.19 on an 900MHz athlon (not overclocked).  Late
last night one of our users tried to umount a CDROM.  The process hung in
the "D" state, as did subsequent runs of the umount program.  According to
/etc/mtab the drive is still mounted and indeed you can't eject the CD. 
Running "mount" also causes a "D" state mount process.

dmesg reported two oopses associated with these umount and mount actions.
The result of running them through ksymoops are included below.

Some other potentially interesting system info follows.

auster:src>cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 900.068
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips        : 1795.68

The kernel is NOT SMP, and the machine has 512MB RAM and 512MB swap.  The
CDROM is an IDE drive.  I can provide further information as required. 
Also, please CC me followups; I regularly lurk on a mailing list archive,
but it is easy to miss posts.

ksymoops output:

ksymoops 2.4.1 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 0000001c
current->tss.cr3 = 02448000, %cr3 = 02448000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125e8c>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: 00001600   edx: 00001600
esi: 00000e7a   edi: 00000000   ebp: 00000000   esp: cc279f20
ds: 0018   es: 0018   ss: 0018
Process umount (pid: 8526, process nr: 52, stackpage=cc279000)
Stack: 00001600 00000001 00000000 1600d160 c01c2685 00001600 00000000 c0244600 
       d9dfac40 d9dfac40 00001600 00001600 c0197d59 d9dfac40 00000000 c0187c20 
       d9dfac40 00000000 c0244600 d9dfac40 00000000 c0125267 d9dfac40 00000000 
Call Trace: [<c01c2685>] [<c0197d59>] [<c0187c20>] [<c0125267>] [<c01283cc>] [<c012849f>] [<c01284b8>] 
       [<c0109054>] 
Code: 8b 6b 1c 66 8b 54 24 16 66 39 53 0c 75 3c 8b 43 18 a8 04 74 

>>EIP; c0125e8c <__invalidate_buffers+38/98>   <=====
Trace; c01c2685 <cdrom_release+f5/124>
Trace; c0197d59 <ide_cdrom_release+11/18>
Trace; c0187c20 <ide_release+40/4c>
Trace; c0125267 <blkdev_release+23/2c>
Trace; c01283cc <umount_dev+78/a0>
Trace; c012849f <sys_umount+ab/b8>
Trace; c01284b8 <sys_oldumount+c/10>
Trace; c0109054 <system_call+34/38>
Code;  c0125e8c <__invalidate_buffers+38/98>
00000000 <_EIP>:
Code;  c0125e8c <__invalidate_buffers+38/98>   <=====
   0:   8b 6b 1c                  movl   0x1c(%ebx),%ebp   <=====
Code;  c0125e8f <__invalidate_buffers+3b/98>
   3:   66 8b 54 24 16            movw   0x16(%esp,1),%dx
Code;  c0125e94 <__invalidate_buffers+40/98>
   8:   66 39 53 0c               cmpw   %dx,0xc(%ebx)
Code;  c0125e98 <__invalidate_buffers+44/98>
   c:   75 3c                     jne    4a <_EIP+0x4a> c0125ed6 <__invalidate_buffers+82/98>
Code;  c0125e9a <__invalidate_buffers+46/98>
   e:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c0125e9d <__invalidate_buffers+49/98>
  11:   a8 04                     testb  $0x4,%al
Code;  c0125e9f <__invalidate_buffers+4b/98>
  13:   74 00                     je     15 <_EIP+0x15> c0125ea1 <__invalidate_buffers+4d/98>

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
current->tss.cr3 = 11dd5000, %cr3 = 11dd5000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0125e8c>]
EFLAGS: 00010202
eax: 00000000   ebx: 00000000   ecx: c0201fe8   edx: 00001600
esi: 00000ea4   edi: 00000000   ebp: 00000000   esp: dd373ec8
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 8555, process nr: 40, stackpage=dd373000)
Stack: 00001600 08051600 00000000 16001600 c01251e8 00001600 00000001 dffecc20 
       00000000 00001600 c01c2146 00001600 dffecb60 c0244600 c0187b68 c0197d39 
       deb26c40 dd373f68 c0244600 deb26c40 c0187bbc deb26c40 dd373f68 c0244600 
Call Trace: [<c01251e8>] [<c01c2146>] [<c0187b68>] [<c0197d39>] [<c0187bbc>] [<c01289ec>] [<c0187b68>] 
       [<c0109054>] 
Code: 8b 6b 1c 66 8b 54 24 16 66 39 53 0c 75 3c 8b 43 18 a8 04 74 

>>EIP; c0125e8c <__invalidate_buffers+38/98>   <=====
Trace; c01251e8 <check_disk_change+7c/98>
Trace; c01c2146 <cdrom_open+b2/bc>
Trace; c0187b68 <ide_open+0/78>
Trace; c0197d39 <ide_cdrom_open+35/44>
Trace; c0187bbc <ide_open+54/78>
Trace; c01289ec <sys_mount+200/2fc>
Trace; c0187b68 <ide_open+0/78>
Trace; c0109054 <system_call+34/38>
Code;  c0125e8c <__invalidate_buffers+38/98>
00000000 <_EIP>:
Code;  c0125e8c <__invalidate_buffers+38/98>   <=====
   0:   8b 6b 1c                  movl   0x1c(%ebx),%ebp   <=====
Code;  c0125e8f <__invalidate_buffers+3b/98>
   3:   66 8b 54 24 16            movw   0x16(%esp,1),%dx
Code;  c0125e94 <__invalidate_buffers+40/98>
   8:   66 39 53 0c               cmpw   %dx,0xc(%ebx)
Code;  c0125e98 <__invalidate_buffers+44/98>
   c:   75 3c                     jne    4a <_EIP+0x4a> c0125ed6 <__invalidate_buffers+82/98>
Code;  c0125e9a <__invalidate_buffers+46/98>
   e:   8b 43 18                  movl   0x18(%ebx),%eax
Code;  c0125e9d <__invalidate_buffers+49/98>
  11:   a8 04                     testb  $0x4,%al
Code;  c0125e9f <__invalidate_buffers+4b/98>
  13:   74 00                     je     15 <_EIP+0x15> c0125ea1 <__invalidate_buffers+4d/98>


2 warnings issued.  Results may not be reliable.

jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple     *
*   and danced naked on a harpsicord singing 'subtle plans are here again'" *
