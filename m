Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265893AbRFYSQX>; Mon, 25 Jun 2001 14:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265897AbRFYSQM>; Mon, 25 Jun 2001 14:16:12 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:30221 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S265896AbRFYSP6>;
	Mon, 25 Jun 2001 14:15:58 -0400
Date: Mon, 25 Jun 2001 20:16:12 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Oops in iput
Message-ID: <20010625201612.A701@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
oops in iput - Kernel 2.2.19/i386 + ide-udma patches + ext3 patches (0.0.7a)

Intel BX chipset, SCSI Disks Symbios chipset - The crashing process
is the master process of "postfix" an MTA.

Just before the crash all processes on that machine started to segfault
in nameserver resolution (remote dns server) and after 2-3 minutes
this oops happened.



ksymoops 2.3.4 on i686 2.2.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.19/ (default)
     -m /boot/System.map-2.2.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address 4ed90398
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0133ca7>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 4ed90330   ebx: 00000000   ecx: 00000000   edx: c01eef0c
esi: 4ed90330   edi: ce27ed00   ebp: 00000002   esp: cf04ddac
ds: 0018   es: 0018   ss: 0018
Process master (pid: 297, process nr: 31, stackpage=cf04d000)
Stack: cf1859a0 00000001 cef7db18 cef7db18 cf1859a0 c015882f 4ed90330 00000000 
       ce27ec80 00000002 ced90330 ced90330 ce27ed00 00000002 ceadc0c0 00000000 
       cfce5860 c0158be3 ced903e0 ceeda140 00000000 00000002 ceeda140 ced90330 
Call Trace: [<c015882f>] [<c0158be3>] [<c011b26c>] [<c01262bd>] [<c011d2b5>] [<c012745c>] [<c0127453>] 
       [<c01139bb>] [<c012634b>] [<c011073e>] [<c0113958>] [<c01184f4>] [<c011847d>] [<c0109fbb>] [<c01111b1>] 
       [<c0109583>] [<c010a100>] 
Code: 8b 46 68 85 c0 74 09 8b 40 18 85 c0 74 02 89 c3 85 db 74 10 

>>EIP; c0133ca7 <iput+13/228>   <=====
Trace; c015882f <sock_release+57/60>
Trace; c0158be3 <sock_close+3f/4c>
Trace; c011b26c <clear_page_tables+ac/b4>
Trace; c01262bd <__fput+25/54>
Trace; c011d2b5 <exit_mmap+115/120>
Trace; c012745c <fput+20/54>
Trace; c0127453 <fput+17/54>
Trace; c01139bb <mmput+3f/48>
Trace; c012634b <filp_close+5f/6c>
Trace; c011073e <send_sig_info+182/2c0>
Trace; c0113958 <mm_release+10/34>
Trace; c01184f4 <do_exit+140/2a0>
Trace; c011847d <do_exit+c9/2a0>
Trace; c0109fbb <do_signal+21f/298>
Trace; c01111b1 <sys_kill+61/70>
Trace; c0109583 <sys_sigreturn+b7/e8>
Trace; c010a100 <signal_return+14/18>
Code;  c0133ca7 <iput+13/228>
00000000 <_EIP>:
Code;  c0133ca7 <iput+13/228>   <=====
   0:   8b 46 68                  mov    0x68(%esi),%eax   <=====
Code;  c0133caa <iput+16/228>
   3:   85 c0                     test   %eax,%eax
Code;  c0133cac <iput+18/228>
   5:   74 09                     je     10 <_EIP+0x10> c0133cb7 <iput+23/228>
Code;  c0133cae <iput+1a/228>
   7:   8b 40 18                  mov    0x18(%eax),%eax
Code;  c0133cb1 <iput+1d/228>
   a:   85 c0                     test   %eax,%eax
Code;  c0133cb3 <iput+1f/228>
   c:   74 02                     je     10 <_EIP+0x10> c0133cb7 <iput+23/228>
Code;  c0133cb5 <iput+21/228>
   e:   89 c3                     mov    %eax,%ebx
Code;  c0133cb7 <iput+23/228>
  10:   85 db                     test   %ebx,%ebx
Code;  c0133cb9 <iput+25/228>
  12:   74 10                     je     24 <_EIP+0x24> c0133ccb <iput+37/228>


1 warning issued.  Results may not be reliable.
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?

