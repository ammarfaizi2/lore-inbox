Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131854AbRAJOw0>; Wed, 10 Jan 2001 09:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131987AbRAJOwQ>; Wed, 10 Jan 2001 09:52:16 -0500
Received: from cr545978-a.nmkt1.on.wave.home.com ([24.112.25.43]:1284 "HELO
	saturn.tlug.org") by vger.kernel.org with SMTP id <S131854AbRAJOwH>;
	Wed, 10 Jan 2001 09:52:07 -0500
Date: Wed, 10 Jan 2001 09:46:34 -0500 (EST)
From: Mike Frisch <mfrisch@saturn.tlug.org>
To: <linux-kernel@vger.kernel.org>
Subject: [2.2.18] Oops in schedule/reschedule
Message-ID: <Pine.LNX.4.30.0101100938420.20984-100000@gateway.saturn.tlug.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem:

Oops in schedule

[2.] Full description of the problem/report:

I am unsure of the actual cause.  My machine is running Postfix and INN
and both were killed when the oops occurred.  These are the only two tasks
that appear to have died.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, oops, schedule, reschedule

[4.] Kernel version (from /proc/version):

Linux version 2.2.18 (root@gateway) (gcc version 2.7.2.3) #1 Mon Jan 8
01:42:03 EST 2001

[5.] Output of Oops

ksymoops 2.3.7 on i586 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000001
current->tss.cr3 = 023ef000, %cr3 = 023ef000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c010f440>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: 00000001   ebx: c6c4a000   ecx: 00000003   edx: 00000001
esi: c6c4a000   edi: 00000003   ebp: 00000003   esp: c6c4bfb0
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 7716, process nr: 93, stackpage=c6c4b000)
Stack: ea26425b 00000000 c01f4c00 73bf4b97 c0107c3d 3e39d86e c681e5c8 238b04b1
       f754b3f4 ea26425b 73bf4b97 a2f6e117 0000002b 0000002a ffffff00 08071cfe
       00000023 00000203 bf9ffb00 0000002b
Call Trace: [<c0107c3d>]
Code: 00 00 c7 05 00 00 00 00 00 00 00 00 8d 65 ec 5b 5e 5f 89 ec

>>EIP; c010f440 <schedule+264/27c>   <=====
Trace; c0107c3d <reschedule+5/c>
Code;  c010f440 <schedule+264/27c>
00000000 <_EIP>:
Code;  c010f440 <schedule+264/27c>   <=====
   0:   00 00             addb   %al,(%eax)   <=====
Code;  c010f442 <schedule+266/27c>
   2:   c7 05 00 00 00    movl   $0x0,0x0
Code;  c010f447 <schedule+26b/27c>
   7:   00 00 00 00 00
Code;  c010f44c <schedule+270/27c>
   c:   8d 65 ec          leal   0xffffffec(%ebp),%esp
Code;  c010f44f <schedule+273/27c>
   f:   5b                popl   %ebx
Code;  c010f450 <schedule+274/27c>
  10:   5e                popl   %esi
Code;  c010f451 <schedule+275/27c>
  11:   5f                popl   %edi
Code;  c010f452 <schedule+276/27c>
  12:   89 ec             movl   %ebp,%esp


2 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
     problem (if possible)

(not applicable)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux gateway 2.2.18 #1 Mon Jan 8 01:42:03 EST 2001 i586 unknown
Kernel modules         2.4.1
Gnu C                  2.7.2.3
Binutils               2.9.1.0.15
Linux C Library        2.0.7
Dynamic linker         ldd (GNU libc) 2.0.7
Linux C++ Library      2.8.0
Procps                 1.2.9
Mount                  2.10m
Net-tools              1.50
Kbd                    0.96
Sh-utils               1.16
Modules Loaded         nfs ppp slhc ip_masq_irc ip_masq_ftp nfsd lockd  sunrpc 3c509 ne 8390 ncr53c8xx

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 5
model		: 6
model name	: AMD-K6tm w/ multimedia extensions
stepping	: 2
cpu MHz		: 233.867
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mmx
bogomips	: 466.94

[7.3.] Module information (from /proc/modules):

nfs                    71488   1 (autoclean)
ppp                    19728   0 (unused)
slhc                    4384   0 [ppp]
ip_masq_irc             1968   0 (unused)
ip_masq_ftp             2528   0
nfsd                  180432   8 (autoclean)
lockd                  42288   1 (autoclean) [nfs nfsd]
sunrpc                 55488   1 (autoclean) [nfs nfsd lockd]
3c509                   5584   1 (autoclean)
ne                      6208   1 (autoclean)
8390                    6144   0 (autoclean) [ne]
ncr53c8xx              49732   4

[7.4.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST32430N         Rev: 0510
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL_TM2110S Rev: 300N
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST5660N  SUN0535 Rev: 0638
  Type:   Direct-Access                    ANSI SCSI revision: 02


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
