Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLaQiy>; Tue, 31 Dec 2002 11:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263491AbSLaQiy>; Tue, 31 Dec 2002 11:38:54 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:26026 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id <S263362AbSLaQii>; Tue, 31 Dec 2002 11:38:38 -0500
Subject: PROBLEM: X windows crash with kernel oops in syslog (multiple
	times).
From: Michael Barker <mbarker@dsl.pipex.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041352828.1594.38.camel@corona>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 31 Dec 2002 16:40:28 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(Posting from off list, please CC my E. mail address, thanks).

I was running several applications on top an X Windows session, I
noticed the CPU usage at a 100%.  Running top to see what was hogging
all of the CPU showed X windows running at ~50% and top the other %50. 
However top was extremely slow to return and rest of the machine started
crawling to a halt.  X windows then exited killing all of the apps.

Apps running:

Gnome2
Evolution
Galeon
ArgoUML (Java based UML program)
Eclipse
CD Player

Logging back in I looked at the logs and noticed a number of Oops
messages (logs and output from ksymoops below).

Opening evolution to send an E. mail the problem occurred again, this
time the log only seemed to show a partial oops trace and running it
through ksymoops caused a segmenation fault.

This problem occurred 3 more times before I rebooted, which seemed to
alleviate the problem.  I did notice that any program that tried to
access current process information (eg. ps and top) ran extremely slow
(30 secs to 1 min to return) and would use 100% CPU.

I have had a number of problems with this system from kernel versions
2.4.8 to 2.4.19.  Faults such as this where X windows or various other
programs will exit through to hard lockups of the system.  The problem
most commonly seems to occur when the memory usage is very high (around
100%) when the system would start to swap.

I have heard that there have been various problems with AMD CPUs on VIA
chipsets.  I saw a patch available that is intended to improve general
stability of AMD CPUs however it looked like the patch was only for
2.5.x kernels.

Any help, suggestions (even if it is buy an different motherboard and/or
CPU) would be appreciated.

Kind regards,
Mike.


System Info:

CPU:    AMD 1600XP
Mobo:   Asus A7V333 - VIA KT333 chipset
Memory: 1292160KB
OS:     Redhat Linux 8.0
Kernel: 2.4.19 (compiled from kernel.org source)


/proc/version: Linux version 2.4.19 (mike@corona) (gcc version 3.2
20020903 (Red Hat Linux 8.0
3.2-7)) #3 Fri Nov 1 11:00:15 GMT 2002

Log messages:

<------
Dec 31 11:12:24 corona kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI
HBA DRIVER, Rev 6.2.8
Dec 31 11:12:24 corona kernel:         <Adaptec 2902/04/10/15/20/30C
SCSI adapter>
Dec 31 11:12:24 corona kernel:         aic7850: Single Channel A, SCSI
Id=7, 3/253 SCBs
Dec 31 11:12:24 corona kernel: 
Dec 31 11:12:40 corona kernel:   Vendor: HP        Model: CD-Writer+
9600   Rev: 1.0a
Dec 31 11:12:40 corona kernel:   Type:  
CD-ROM                             ANSI SCSI revision: 04
Dec 31 11:12:40 corona kernel: (scsi0:A:4): 10.000MB/s transfers
(10.000MHz, offset 15)
Dec 31 11:12:42 corona kernel: Attached scsi CD-ROM sr0 at scsi0,
channel 0, id 4, lun 0
Dec 31 11:12:42 corona kernel: sr0: scsi3-mmc drive: 32x/32x writer
cd/rw xa/form2 cdda tray
Dec 31 15:29:14 corona kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000005c
Dec 31 15:29:14 corona kernel:  printing eip:
Dec 31 15:29:14 corona kernel: c0136f80
Dec 31 15:29:14 corona kernel: *pde = 00000000
Dec 31 15:29:14 corona kernel: Oops: 0000
Dec 31 15:29:14 corona kernel: CPU:    0
Dec 31 15:29:14 corona kernel: EIP:    0010:[<c0136f80>]    Tainted: PF
Dec 31 15:29:14 corona kernel: EFLAGS: 00010246
Dec 31 15:29:14 corona kernel: eax: c14ae520   ebx: 00000044   ecx:
000001d2   edx: 000001d2
Dec 31 15:29:14 corona kernel: esi: c14ae520   edi: 00000044   ebp:
c14ae520   esp: f6423d84
Dec 31 15:29:14 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:14 corona kernel: Process multiload-apple (pid: 1536,
stackpage=f6423000)
Dec 31 15:29:14 corona kernel: Stack: 00000000 c14ae520 00009a25
c0244ca0 c012c8ee c14ae520 000001d2 f6422000 
Dec 31 15:29:14 corona kernel:        00000eb9 000001d2 00000020
00000020 000001d2 00000020 00000001 c012cab6 
Dec 31 15:29:15 corona kernel:        00000001 0000006c c0244ca0
00000001 000001d2 c0244ca0 c0244ca0 c012cb14 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012c8ee>] [<c012cab6>]
[<c012cb14>] [<c012d853>] [<c012daa8>]
Dec 31 15:29:15 corona kernel:   [<c0124900>] [<c0124c1d>] [<c0113d78>]
[<c020a516>] [<c020a767>] [<c020a77e>]
Dec 31 15:29:15 corona kernel:   [<c01c20ca>] [<c0113c38>] [<c0108a28>]
[<c0209992>] [<c014eaee>] [<c0133614>]
Dec 31 15:29:15 corona kernel:   [<c0108937>]
Dec 31 15:29:15 corona kernel: 
Dec 31 15:29:15 corona kernel: Code: 8b 53 18 83 e2 06 8b 43 10 09 d0 0f
85 81 00 00 00 8b 5b 28 
Dec 31 15:29:15 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:15 corona kernel:  printing eip:
Dec 31 15:29:15 corona kernel: c012c74f
Dec 31 15:29:15 corona kernel: *pde = 00000000
Dec 31 15:29:15 corona kernel: Oops: 0002
Dec 31 15:29:15 corona kernel: CPU:    0
Dec 31 15:29:15 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:15 corona kernel: EFLAGS: 00013246
Dec 31 15:29:15 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:15 corona kernel: esi: c1427674   edi: 000095d5   ebp:
c0244ca0   esp: d28e9e38
Dec 31 15:29:15 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:15 corona kernel: Process java (pid: 11019,
stackpage=d28e9000)
Dec 31 15:29:15 corona kernel: Stack: d28e8000 00000efb 000001d2
00000020 00000020 000001d2 00000020 00000001 
Dec 31 15:29:15 corona kernel:        c012cab6 00000001 00000070
c0244ca0 00000001 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:15 corona kernel:        c012cb14 00000020 d28e8000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:15 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c012a1a8>]
[<c0129af0>] [<c0129bb8>] [<c0129ee2>]
Dec 31 15:29:15 corona kernel:   [<c0129e35>] [<c0113c38>] [<c0108a28>]
Dec 31 15:29:15 corona kernel: 
Dec 31 15:29:15 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 
Dec 31 15:29:15 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:15 corona kernel:  printing eip:
Dec 31 15:29:15 corona kernel: c012c74f
Dec 31 15:29:15 corona kernel: *pde = 36d56067
Dec 31 15:29:15 corona kernel: *pte = 00000000
Dec 31 15:29:15 corona kernel: Oops: 0002
Dec 31 15:29:15 corona kernel: CPU:    0
Dec 31 15:29:15 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:15 corona kernel: EFLAGS: 00013246
Dec 31 15:29:15 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:15 corona kernel: esi: c1427674   edi: 000019c7   ebp:
c0244bf0   esp: f7fc1f58
Dec 31 15:29:15 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:15 corona kernel: Process kswapd (pid: 5,
stackpage=f7fc1000)
Dec 31 15:29:15 corona kernel: Stack: f7fc0000 00000200 000001d0
00000020 0000001e 000001d0 00000020 00000006 
Dec 31 15:29:15 corona kernel:        c012cab6 00000006 0000006c
c0244bf0 00000006 000001d0 c0244bf0 00000000 
Dec 31 15:29:15 corona kernel:        c012cb14 00000020 c0244bf0
00000001 f7fc0000 c012cbb2 c0244b40 00000000 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012cbb2>] [<c012cc06>] [<c012cd11>]
Dec 31 15:29:15 corona kernel:   [<c0105000>] [<c0106fda>] [<c012cc78>]
Dec 31 15:29:15 corona kernel: 
Dec 31 15:29:15 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 
Dec 31 15:29:23 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:23 corona kernel:  printing eip:
Dec 31 15:29:23 corona kernel: c012c74f
Dec 31 15:29:23 corona kernel: *pde = 00000000
Dec 31 15:29:23 corona kernel: Oops: 0002
Dec 31 15:29:23 corona kernel: CPU:    0
Dec 31 15:29:23 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:23 corona kernel: EFLAGS: 00010246
Dec 31 15:29:23 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:23 corona kernel: esi: c1427674   edi: 000019a7   ebp:
c0244ca0   esp: f692de38
Dec 31 15:29:23 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:23 corona kernel: Process gconfd-2 (pid: 1497,
stackpage=f692d000)
Dec 31 15:29:23 corona kernel: Stack: f692c000 00000200 000001d2
00000020 0000001f 000001d2 00000020 00000006 
Dec 31 15:29:23 corona kernel:        c012cab6 00000006 0000006d
c0244ca0 00000006 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:23 corona kernel:        c012cb14 00000020 f692c000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:23 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:24 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c0146263>]
[<c0125abe>] [<c01258fc>] [<c010d20c>]
Dec 31 15:29:24 corona kernel:   [<c0113c38>] [<c0108a28>]
Dec 31 15:29:24 corona kernel: 
Dec 31 15:29:24 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 
Dec 31 15:29:43 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:43 corona kernel:  printing eip:
Dec 31 15:29:43 corona kernel: c012c74f
Dec 31 15:29:43 corona kernel: *pde = 36d56067
Dec 31 15:29:43 corona kernel: *pte = 00000000
Dec 31 15:29:43 corona kernel: Oops: 0002
Dec 31 15:29:43 corona kernel: CPU:    0
Dec 31 15:29:43 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:43 corona kernel: EFLAGS: 00013246
Dec 31 15:29:43 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:43 corona kernel: esi: c1427674   edi: 000019c4   ebp:
c0244ca0   esp: f6b69e38
Dec 31 15:29:43 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:43 corona kernel: Process X (pid: 1378, stackpage=f6b69000)
Dec 31 15:29:43 corona gpm[845]: oops() invoked from gpm.c(164)
Dec 31 15:29:43 corona kernel: Stack: f6b68000 00000200 000001d2
00000020 00000020 000001d2 00000020 00000006 
Dec 31 15:29:43 corona gpm[845]: /dev/tty0: Input/output error
Dec 31 15:29:43 corona kernel:        c012cab6 00000006 0000006c
c0244ca0 00000006 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:44 corona kernel:        c012cb14 00000020 f6b68000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:44 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:44 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c0125abe>]
[<c011e7f9>] [<c0107304>] [<c0114774>]
Dec 31 15:29:45 corona kernel:   [<c0113c38>] [<c0108a28>]
Dec 31 15:29:45 corona kernel: 
Dec 31 15:29:45 corona gconfd (mike-13600): starting (version 1.2.1),
pid 13600 user 'mike'
Dec 31 15:29:45 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 
Dec 31 15:29:46 corona gconfd (mike-13600): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config
source at position 0
Dec 31 15:29:46 corona gconfd (mike-13600): Resolved address
"xml:readwrite:/home/mike/.gconf" to a writable config source at
position 1
Dec 31 15:29:46 corona gconfd (mike-13600): Resolved address
"xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config
source at position 2
Dec 31 15:29:46 corona gdm(pam_unix)[1377]: session closed for user mike
Dec 31 15:29:47 corona gdm[1377]: gdm_slave_xioerror_handler: Fatal X
error - Restarting :0
Dec 31 15:29:54 corona gdm(pam_unix)[13603]: session opened for user
mike by (uid=0)
Dec 31 15:46:17 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:46:17 corona kernel:  printing eip:
Dec 31 15:46:17 corona kernel: c012c74f
Dec 31 15:46:17 corona kernel: *pde = 00000000
Dec 31 15:46:17 corona kernel: Oops: 0002
Dec 31 15:46:17 corona kernel: CPU:    0
Dec 31 15:46:17 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:46:17 corona kernel: EFLAGS: 00210246
Dec 31 15:46:17 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:46:17 corona kernel: esi: c1427674   edi: 0000172d   ebp:
c0244ca0   esp: e5601ea8
Dec 31 15:46:17 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:46:17 corona kernel: Process evolution-mail (pid: 16697,
stackpage=e5601000)
Dec 31 15:46:17 corona kernel: Stack: e5600000 00000200 000001d2
00000020 00000020 000001d2 00000020 00000006 
Dec 31 15:46:17 corona kernel:        c012cab6 00000006 0000007a
c0244ca0 00000006 000001d2 c0244ca0 c0244ca0 
Dec 31 15:46:17 corona kernel:        c012cb14 00000020 e5600000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:46:17 corona kernel: Call Trace:    [<c01
---->

Ksymoops output:

---->
ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Warning (map_ksym_to_module): cannot match loaded module ext3 to a
unique module object.  Trace may not be reliable.
Dec 31 15:29:14 corona kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000005c
Dec 31 15:29:14 corona kernel: c0136f80
Dec 31 15:29:14 corona kernel: *pde = 00000000
Dec 31 15:29:14 corona kernel: Oops: 0000
Dec 31 15:29:14 corona kernel: CPU:    0
Dec 31 15:29:14 corona kernel: EIP:    0010:[<c0136f80>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 31 15:29:14 corona kernel: EFLAGS: 00010246
Dec 31 15:29:14 corona kernel: eax: c14ae520   ebx: 00000044   ecx:
000001d2   edx: 000001d2
Dec 31 15:29:14 corona kernel: esi: c14ae520   edi: 00000044   ebp:
c14ae520   esp: f6423d84
Dec 31 15:29:14 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:14 corona kernel: Process multiload-apple (pid: 1536,
stackpage=f6423000)
Dec 31 15:29:14 corona kernel: Stack: 00000000 c14ae520 00009a25
c0244ca0 c012c8ee c14ae520 000001d2 f6422000 
Dec 31 15:29:14 corona kernel:        00000eb9 000001d2 00000020
00000020 000001d2 00000020 00000001 c012cab6 
Dec 31 15:29:15 corona kernel:        00000001 0000006c c0244ca0
00000001 000001d2 c0244ca0 c0244ca0 c012cb14 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012c8ee>] [<c012cab6>]
[<c012cb14>] [<c012d853>] [<c012daa8>]
Dec 31 15:29:15 corona kernel:   [<c0124900>] [<c0124c1d>] [<c0113d78>]
[<c020a516>] [<c020a767>] [<c020a77e>]
Dec 31 15:29:15 corona kernel:   [<c01c20ca>] [<c0113c38>] [<c0108a28>]
[<c0209992>] [<c014eaee>] [<c0133614>]
Dec 31 15:29:15 corona kernel:   [<c0108937>]
Dec 31 15:29:15 corona kernel: Code: 8b 53 18 83 e2 06 8b 43 10 09 d0 0f
85 81 00 00 00 8b 5b 28 


>>EIP; c0136f80 <try_to_free_buffers+10/f0>   <=====

>>eax; c14ae520 <_end+11cc7a0/3852b2e0>
>>esi; c14ae520 <_end+11cc7a0/3852b2e0>
>>ebp; c14ae520 <_end+11cc7a0/3852b2e0>
>>esp; f6423d84 <_end+36142004/3852b2e0>

Trace; c012c8ee <shrink_cache+24a/2f4>
Trace; c012cab6 <shrink_caches+4e/7c>
Trace; c012cb14 <try_to_free_pages+30/4c>
Trace; c012d853 <balance_classzone+57/1d4>
Trace; c012daa8 <__alloc_pages+d8/17c>
Trace; c0124900 <do_anonymous_page+5c/124>
Trace; c0124c1d <handle_mm_fault+59/bc>
Trace; c0113d78 <do_page_fault+140/46c>
Trace; c020a516 <vsnprintf+1ea/40c>
Trace; c020a767 <vsprintf+13/18>
Trace; c020a77e <sprintf+12/18>
Trace; c01c20ca <sprintf_stats+6a/8c>
Trace; c0113c38 <do_page_fault+0/46c>
Trace; c0108a28 <error_code+34/3c>
Trace; c0209992 <__generic_copy_to_user+4e/5c>
Trace; c014eaee <proc_file_read+ea/190>
Trace; c0133614 <sys_read+84/f0>
Trace; c0108937 <system_call+33/38>

Code;  c0136f80 <try_to_free_buffers+10/f0>
00000000 <_EIP>:
Code;  c0136f80 <try_to_free_buffers+10/f0>   <=====
   0:   8b 53 18                  mov    0x18(%ebx),%edx   <=====
Code;  c0136f83 <try_to_free_buffers+13/f0>
   3:   83 e2 06                  and    $0x6,%edx
Code;  c0136f86 <try_to_free_buffers+16/f0>
   6:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0136f89 <try_to_free_buffers+19/f0>
   9:   09 d0                     or     %edx,%eax
Code;  c0136f8b <try_to_free_buffers+1b/f0>
   b:   0f 85 81 00 00 00         jne    92 <_EIP+0x92>
Code;  c0136f91 <try_to_free_buffers+21/f0>
  11:   8b 5b 28                  mov    0x28(%ebx),%ebx

Dec 31 15:29:15 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:15 corona kernel: c012c74f
Dec 31 15:29:15 corona kernel: *pde = 00000000
Dec 31 15:29:15 corona kernel: Oops: 0002
Dec 31 15:29:15 corona kernel: CPU:    0
Dec 31 15:29:15 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:15 corona kernel: EFLAGS: 00013246
Dec 31 15:29:15 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:15 corona kernel: esi: c1427674   edi: 000095d5   ebp:
c0244ca0   esp: d28e9e38
Dec 31 15:29:15 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:15 corona kernel: Process java (pid: 11019,
stackpage=d28e9000)
Dec 31 15:29:15 corona kernel: Stack: d28e8000 00000efb 000001d2
00000020 00000020 000001d2 00000020 00000001 
Dec 31 15:29:15 corona kernel:        c012cab6 00000001 00000070
c0244ca0 00000001 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:15 corona kernel:        c012cb14 00000020 d28e8000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:15 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c012a1a8>]
[<c0129af0>] [<c0129bb8>] [<c0129ee2>]
Dec 31 15:29:15 corona kernel:   [<c0129e35>] [<c0113c38>] [<c0108a28>]
Dec 31 15:29:15 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 


>>EIP; c012c74f <shrink_cache+ab/2f4>   <=====

>>eax; c0244a78 <inactive_list+0/8>
>>ecx; c1427690 <_end+1145910/3852b2e0>
>>esi; c1427674 <_end+11458f4/3852b2e0>
>>edi; 000095d5 Before first symbol
>>ebp; c0244ca0 <contig_page_data+160/340>
>>esp; d28e9e38 <_end+126080b8/3852b2e0>

Trace; c012cab6 <shrink_caches+4e/7c>
Trace; c012cb14 <try_to_free_pages+30/4c>
Trace; c012d853 <balance_classzone+57/1d4>
Trace; c012daa8 <__alloc_pages+d8/17c>
Trace; c0124900 <do_anonymous_page+5c/124>
Trace; c0124c1d <handle_mm_fault+59/bc>
Trace; c0113d78 <do_page_fault+140/46c>
Trace; c012a1a8 <mprotect_fixup_middle+110/15c>
Trace; c0129af0 <change_protection+64/b8>
Trace; c0129bb8 <mprotect_fixup+74/1e4>
Trace; c0129ee2 <sys_mprotect+1ba/1d4>
Trace; c0129e35 <sys_mprotect+10d/1d4>
Trace; c0113c38 <do_page_fault+0/46c>
Trace; c0108a28 <error_code+34/3c>

Code;  c012c74f <shrink_cache+ab/2f4>
00000000 <_EIP>:
Code;  c012c74f <shrink_cache+ab/2f4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012c751 <shrink_cache+ad/2f4>
   2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012c754 <shrink_cache+b0/2f4>
   5:   a1 78 4a 24 c0            mov    0xc0244a78,%eax
Code;  c012c759 <shrink_cache+b5/2f4>
   a:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012c75c <shrink_cache+b8/2f4>
   d:   89 01                     mov    %eax,(%ecx)
Code;  c012c75e <shrink_cache+ba/2f4>
   f:   c7 41 04 78 4a 00 00      movl   $0x4a78,0x4(%ecx)

Dec 31 15:29:15 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:15 corona kernel: c012c74f
Dec 31 15:29:15 corona kernel: *pde = 36d56067
Dec 31 15:29:15 corona kernel: Oops: 0002
Dec 31 15:29:15 corona kernel: CPU:    0
Dec 31 15:29:15 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:15 corona kernel: EFLAGS: 00013246
Dec 31 15:29:15 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:15 corona kernel: esi: c1427674   edi: 000019c7   ebp:
c0244bf0   esp: f7fc1f58
Dec 31 15:29:15 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:15 corona kernel: Process kswapd (pid: 5,
stackpage=f7fc1000)
Dec 31 15:29:15 corona kernel: Stack: f7fc0000 00000200 000001d0
00000020 0000001e 000001d0 00000020 00000006 
Dec 31 15:29:15 corona kernel:        c012cab6 00000006 0000006c
c0244bf0 00000006 000001d0 c0244bf0 00000000 
Dec 31 15:29:15 corona kernel:        c012cb14 00000020 c0244bf0
00000001 f7fc0000 c012cbb2 c0244b40 00000000 
Dec 31 15:29:15 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012cbb2>] [<c012cc06>] [<c012cd11>]
Dec 31 15:29:15 corona kernel:   [<c0105000>] [<c0106fda>] [<c012cc78>]
Dec 31 15:29:15 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 


>>EIP; c012c74f <shrink_cache+ab/2f4>   <=====

>>eax; c0244a78 <inactive_list+0/8>
>>ecx; c1427690 <_end+1145910/3852b2e0>
>>esi; c1427674 <_end+11458f4/3852b2e0>
>>edi; 000019c7 Before first symbol
>>ebp; c0244bf0 <contig_page_data+b0/340>
>>esp; f7fc1f58 <_end+37ce01d8/3852b2e0>

Trace; c012cab6 <shrink_caches+4e/7c>
Trace; c012cb14 <try_to_free_pages+30/4c>
Trace; c012cbb2 <kswapd_balance_pgdat+56/98>
Trace; c012cc06 <kswapd_balance+12/28>
Trace; c012cd11 <kswapd+99/b4>
Trace; c0105000 <_stext+0/0>
Trace; c0106fda <kernel_thread+26/30>
Trace; c012cc78 <kswapd+0/b4>

Code;  c012c74f <shrink_cache+ab/2f4>
00000000 <_EIP>:
Code;  c012c74f <shrink_cache+ab/2f4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012c751 <shrink_cache+ad/2f4>
   2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012c754 <shrink_cache+b0/2f4>
   5:   a1 78 4a 24 c0            mov    0xc0244a78,%eax
Code;  c012c759 <shrink_cache+b5/2f4>
   a:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012c75c <shrink_cache+b8/2f4>
   d:   89 01                     mov    %eax,(%ecx)
Code;  c012c75e <shrink_cache+ba/2f4>
   f:   c7 41 04 78 4a 00 00      movl   $0x4a78,0x4(%ecx)

Dec 31 15:29:23 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:23 corona kernel: c012c74f
Dec 31 15:29:23 corona kernel: *pde = 00000000
Dec 31 15:29:23 corona kernel: Oops: 0002
Dec 31 15:29:23 corona kernel: CPU:    0
Dec 31 15:29:23 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:23 corona kernel: EFLAGS: 00010246
Dec 31 15:29:23 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:23 corona kernel: esi: c1427674   edi: 000019a7   ebp:
c0244ca0   esp: f692de38
Dec 31 15:29:23 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:23 corona kernel: Process gconfd-2 (pid: 1497,
stackpage=f692d000)
Dec 31 15:29:23 corona kernel: Stack: f692c000 00000200 000001d2
00000020 0000001f 000001d2 00000020 00000006 
Dec 31 15:29:23 corona kernel:        c012cab6 00000006 0000006d
c0244ca0 00000006 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:23 corona kernel:        c012cb14 00000020 f692c000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:23 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:24 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c0146263>]
[<c0125abe>] [<c01258fc>] [<c010d20c>]
Dec 31 15:29:24 corona kernel:   [<c0113c38>] [<c0108a28>]
Dec 31 15:29:24 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 


>>EIP; c012c74f <shrink_cache+ab/2f4>   <=====

>>eax; c0244a78 <inactive_list+0/8>
>>ecx; c1427690 <_end+1145910/3852b2e0>
>>esi; c1427674 <_end+11458f4/3852b2e0>
>>edi; 000019a7 Before first symbol
>>ebp; c0244ca0 <contig_page_data+160/340>
>>esp; f692de38 <_end+3664c0b8/3852b2e0>

Trace; c012cab6 <shrink_caches+4e/7c>
Trace; c012cb14 <try_to_free_pages+30/4c>
Trace; c012d853 <balance_classzone+57/1d4>
Trace; c012daa8 <__alloc_pages+d8/17c>
Trace; c0124900 <do_anonymous_page+5c/124>
Trace; c0124c1d <handle_mm_fault+59/bc>
Trace; c0113d78 <do_page_fault+140/46c>
Trace; c0146263 <inode_setattr+6f/d8>
Trace; c0125abe <get_unmapped_area+be/110>
Trace; c01258fc <do_mmap_pgoff+428/52c>
Trace; c010d20c <sys_mmap2+54/78>
Trace; c0113c38 <do_page_fault+0/46c>
Trace; c0108a28 <error_code+34/3c>

Code;  c012c74f <shrink_cache+ab/2f4>
00000000 <_EIP>:
Code;  c012c74f <shrink_cache+ab/2f4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012c751 <shrink_cache+ad/2f4>
   2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012c754 <shrink_cache+b0/2f4>
   5:   a1 78 4a 24 c0            mov    0xc0244a78,%eax
Code;  c012c759 <shrink_cache+b5/2f4>
   a:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012c75c <shrink_cache+b8/2f4>
   d:   89 01                     mov    %eax,(%ecx)
Code;  c012c75e <shrink_cache+ba/2f4>
   f:   c7 41 04 78 4a 00 00      movl   $0x4a78,0x4(%ecx)

Dec 31 15:29:43 corona kernel:  <1>Unable to handle kernel NULL pointer
dereference at virtual address 00000000
Dec 31 15:29:43 corona kernel: c012c74f
Dec 31 15:29:43 corona kernel: *pde = 36d56067
Dec 31 15:29:43 corona kernel: Oops: 0002
Dec 31 15:29:43 corona kernel: CPU:    0
Dec 31 15:29:43 corona kernel: EIP:    0010:[<c012c74f>]    Tainted: PF
Dec 31 15:29:43 corona kernel: EFLAGS: 00013246
Dec 31 15:29:43 corona kernel: eax: c0244a78   ebx: 00000000   ecx:
c1427690   edx: 00000000
Dec 31 15:29:43 corona kernel: esi: c1427674   edi: 000019c4   ebp:
c0244ca0   esp: f6b69e38
Dec 31 15:29:43 corona kernel: ds: 0018   es: 0018   ss: 0018
Dec 31 15:29:43 corona kernel: Process X (pid: 1378, stackpage=f6b69000)
Dec 31 15:29:43 corona kernel: Stack: f6b68000 00000200 000001d2
00000020 00000020 000001d2 00000020 00000006 
Dec 31 15:29:43 corona kernel:        c012cab6 00000006 0000006c
c0244ca0 00000006 000001d2 c0244ca0 c0244ca0 
Dec 31 15:29:44 corona kernel:        c012cb14 00000020 f6b68000
00000000 00000000 c012d853 00000000 00000000 
Dec 31 15:29:44 corona kernel: Call Trace:    [<c012cab6>] [<c012cb14>]
[<c012d853>] [<c012daa8>] [<c0124900>]
Dec 31 15:29:44 corona kernel:   [<c0124c1d>] [<c0113d78>] [<c0125abe>]
[<c011e7f9>] [<c0107304>] [<c0114774>]
Dec 31 15:29:45 corona kernel:   [<c0113c38>] [<c0108a28>]
Dec 31 15:29:45 corona kernel: Code: 89 02 89 50 04 a1 78 4a 24 c0 89 48
04 89 01 c7 41 04 78 4a 


>>EIP; c012c74f <shrink_cache+ab/2f4>   <=====

>>eax; c0244a78 <inactive_list+0/8>
>>ecx; c1427690 <_end+1145910/3852b2e0>
>>esi; c1427674 <_end+11458f4/3852b2e0>
>>edi; 000019c4 Before first symbol
>>ebp; c0244ca0 <contig_page_data+160/340>
>>esp; f6b69e38 <_end+368880b8/3852b2e0>

Trace; c012cab6 <shrink_caches+4e/7c>
Trace; c012cb14 <try_to_free_pages+30/4c>
Trace; c012d853 <balance_classzone+57/1d4>
Trace; c012daa8 <__alloc_pages+d8/17c>
Trace; c0124900 <do_anonymous_page+5c/124>
Trace; c0124c1d <handle_mm_fault+59/bc>
Trace; c0113d78 <do_page_fault+140/46c>
Trace; c0125abe <get_unmapped_area+be/110>
Trace; c011e7f9 <update_process_times+1d/88>
Trace; c0107304 <__switch_to+84/b8>
Trace; c0114774 <schedule+1e4/318>
Trace; c0113c38 <do_page_fault+0/46c>
Trace; c0108a28 <error_code+34/3c>

Code;  c012c74f <shrink_cache+ab/2f4>
00000000 <_EIP>:
Code;  c012c74f <shrink_cache+ab/2f4>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c012c751 <shrink_cache+ad/2f4>
   2:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c012c754 <shrink_cache+b0/2f4>
   5:   a1 78 4a 24 c0            mov    0xc0244a78,%eax
Code;  c012c759 <shrink_cache+b5/2f4>
   a:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012c75c <shrink_cache+b8/2f4>
   d:   89 01                     mov    %eax,(%ecx)
Code;  c012c75e <shrink_cache+ba/2f4>
   f:   c7 41 04 78 4a 00 00      movl   $0x4a78,0x4(%ecx)


2 warnings and 2 errors issued.  Results may not be reliable.
<------


ver_linux:
------>
Linux corona 2.4.19 #3 Fri Nov 1 11:00:15 GMT 2002 i686 athlon i386
GNU/Linux

Gnu C                  gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
Copyrigh
t (C) 2002 Free Software Foundation, Inc. This is free software; see the
source
for copying conditions. There is NO warranty; not even for
MERCHANTABILITY or FI
TNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         aic7xxx sr_mod scsi_mod ide-cd cdrom cmpci
soundcore w837
81d i2c-proc i2c-viapro i2c-core vmnet parport_pc parport vmmon autofs
3c59x ipt
able_filter ip_tables mousedev keybdev input hid usb-uhci ehci-hcd
usbcore ext3
jbd
<------

/proc/cpuinfo

----->
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP 1600+
stepping        : 2
cpu MHz         : 1401.738
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2798.38
<------


/proc/modules:

----->
aic7xxx               123092   0 (autoclean)
sr_mod                 16280   0 (autoclean)
scsi_mod              100324   2 (autoclean) [aic7xxx sr_mod]
ide-cd                 30660   0 (autoclean)
cdrom                  30208   0 (autoclean) [sr_mod ide-cd]
cmpci                  33256   0 (autoclean)
soundcore               5924   4 (autoclean) [cmpci]
w83781d                21392   0 (unused)
i2c-proc                8976   0 [w83781d]
i2c-viapro              4752   0 (unused)
i2c-core               20452   0 [w83781d i2c-proc i2c-viapro]
vmnet                  25760   6
parport_pc             17092   0
parport                33184   0 [parport_pc]
vmmon                  24340   0 (unused)
autofs                 11812   0 (autoclean) (unused)
3c59x                  28048   1
iptable_filter          2284   1 (autoclean)
ip_tables              13592   1 [iptable_filter]
mousedev                5076   1
keybdev                 2656   0 (unused)
input                   5376   0 [mousedev keybdev]
hid                    10484   0 (unused)
usb-uhci               23564   0 (unused)
ehci-hcd               15464   0 (unused)
usbcore                69632   1 [hid usb-uhci ehci-hcd]
ext3                   61088   3
jbd                    46128   3 [ext3]
<------



-- 
Michael Barker <mbarker@dsl.pipex.com>

