Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319618AbSIMM0B>; Fri, 13 Sep 2002 08:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319620AbSIMM0B>; Fri, 13 Sep 2002 08:26:01 -0400
Received: from ns.net.hu ([195.70.35.4]:26635 "EHLO venus.net.hu")
	by vger.kernel.org with ESMTP id <S319618AbSIMMZ5>;
	Fri, 13 Sep 2002 08:25:57 -0400
Message-ID: <3D81DC85.79769380@hungary.com>
Date: Fri, 13 Sep 2002 14:39:33 +0200
From: Levay Akos <levay@hungary.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible bug in kernel 2.4.19  (fs/stat.c +ext3) 
Content-Type: multipart/mixed;
 boundary="------------950E8B66CBFDD348302918D9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------950E8B66CBFDD348302918D9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------950E8B66CBFDD348302918D9
Content-Type: text/plain; charset=us-ascii;
 name="bug1.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bug1.txt"

Possible bug in kernel 2.4.19  (fs/stat.c +ext3) ?

[1.] One line summary of the problem:    
OOps in messages and after a few hours machine hangs

[2.] Full description of the problem/report:
The same oops appaers in messages, (machine work almost fine. Sometimes load level increases by 1, but this is not fully confirmed
After a few hours!!  the machine hangs. (might be independent problems??)
Nothing on the screen. Answers ping but no TCP. CROND is not writing log file any more.
[3.] Keywords (i.e., modules, networking, kernel):
ext3, raid, SMP
[4.] Kernel version (from /proc/version):
Linux version 2.4.19 (root@venus2) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 SMP Fri Aug 23 18:48:29 CEST 2002 
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Sep 12 16:51:26 mymachine sshd(pam_unix)[24817]: session opened for user
root by (uid=0)
Sep 12 16:51:27 mymachine kernel:  <1>Unable to handle kernel paging
request at virtual address 6c616ba0
Sep 12 16:51:27 mymachine kernel:  printing eip:
Sep 12 16:51:27 mymachine kernel: c013a800
Sep 12 16:51:27 mymachine kernel: *pde = 00000000
Sep 12 16:51:27 mymachine kernel: Oops: 0000
Sep 12 16:51:27 mymachine kernel: CPU:    0
Sep 12 16:51:27 mymachine kernel: EIP:    0010:[<c013a800>]    Not tainted
Sep 12 16:51:27 mymachine kernel: EFLAGS: 00010206
Sep 12 16:51:27 mymachine kernel: eax: 6c616b6c   ebx: 00000000   ecx:
e891c000
edx: d9b601a0
Sep 12 16:51:27 mymachine kernel: esi: d6c83fa4   edi: bfffba70   ebp:
bfffaa08
esp: d6c83f9c
Sep 12 16:51:27 mymachine kernel: ds: 0018   es: 0018   ss: 0018
Sep 12 16:51:27 mymachine kernel: Process rsync (pid: 24819,
stackpage=d6c83000)
Sep 12 16:51:27 mymachine kernel: Stack: d6c82000 bfffca80 d9b601a0
c1c1ef20 00001
000 d6c82000 083eb000 00000008
Sep 12 16:51:27 mymachine kernel:        00000001 c01088b3 bfffba70
bfffca80 42130
30c bfffca80 bfffba70 bfffaa08
Sep 12 16:51:27 mymachine kernel:        000000c4 c010002b 0000002b
000000c4 420d9
ff3 00000023 00000216 bfffaa00
Sep 12 16:51:27 mymachine kernel: Call Trace:    [<c01088b3>]
Sep 12 16:51:27 mymachine kernel:
Sep 12 16:51:27 mymachine kernel: Code: 8b 40 34 85 c0 74 0a 52 ff d0 89
c3 83 c4
04 eb 02 31 db 85
Sep 12 16:51:27 mymachine sshd(pam_unix)[24817]: session closed for user
root


0xc013a7d0 <sys_lstat64>:       sub    $0x1c,%esp
0xc013a7d3 <sys_lstat64+3>:     push   %esi
0xc013a7d4 <sys_lstat64+4>:     push   %ebx
0xc013a7d5 <sys_lstat64+5>:     mov    0x28(%esp,1),%eax
0xc013a7d9 <sys_lstat64+9>:     lea    0x8(%esp,1),%esi
0xc013a7dd <sys_lstat64+13>:    mov    %esi,%ecx
0xc013a7df <sys_lstat64+15>:    mov    $0x8,%edx
0xc013a7e4 <sys_lstat64+20>:    call   0xc013de6c <__user_walk> 352.sor
0xc013a7e9 <sys_lstat64+25>:    mov    %eax,%ebx
0xc013a7eb <sys_lstat64+27>:    test   %ebx,%ebx
0xc013a7ed <sys_lstat64+29>:    jne    0xc013a837 <sys_lstat64+103> 353 ? sor
0xc013a7ef <sys_lstat64+31>:    mov    0x8(%esp,1),%edx
0xc013a7f3 <sys_lstat64+35>:    mov    0x8(%edx),%eax
0xc013a7f6 <sys_lstat64+38>:    mov    0x90(%eax),%eax
0xc013a7fc <sys_lstat64+44>:    test   %eax,%eax 23.sor if( es elso fele)
0xc013a7fe <sys_lstat64+46>:    je     0xc013a811 <sys_lstat64+65>
0xc013a800 <sys_lstat64+48>:    mov    0x34(%eax),%eax
0xc013a803 <sys_lstat64+51>:    test   %eax,%eax 23.sor if( es 2. fele)
0xc013a805 <sys_lstat64+53>:    je     0xc013a811 <sys_lstat64+65>
0xc013a807 <sys_lstat64+55>:    push   %edx
0xc013a808 <sys_lstat64+56>:    call   *%eax 24. sor (dentry) hvasa
0xc013a80a <sys_lstat64+58>:    mov    %eax,%ebx 
0xc013a80c <sys_lstat64+60>:    add    $0x4,%esp
0xc013a80f <sys_lstat64+63>:    jmp    0xc013a813 <sys_lstat64+67>
0xc013a811 <sys_lstat64+65>:    xor    %ebx,%ebx 
0xc013a813 <sys_lstat64+67>:    test   %ebx,%ebx 355.sor
0xc013a815 <sys_lstat64+69>:    jne    0xc013a82e <sys_lstat64+94>
0xc013a817 <sys_lstat64+71>:    mov    0x2c(%esp,1),%eax
0xc013a81b <sys_lstat64+75>:    push   %eax
0xc013a81c <sys_lstat64+76>:    mov    0xc(%esp,1),%eax
0xc013a820 <sys_lstat64+80>:    mov    0x8(%eax),%eax
0xc013a823 <sys_lstat64+83>:    push   %eax
0xc013a824 <sys_lstat64+84>:    call   0xc013a620 <cp_new_stat64> 356. sor
0xc013a829 <sys_lstat64+89>:    mov    %eax,%ebx
0xc013a82b <sys_lstat64+91>:    add    $0x8,%esp
0xc013a82e <sys_lstat64+94>:    push   %esi
0xc013a82f <sys_lstat64+95>:    call   0xc013cd64 <path_release> 357
0xc013a834 <sys_lstat64+100>:   add    $0x4,%esp
0xc013a837 <sys_lstat64+103>:   mov    %ebx,%eax
0xc013a839 <sys_lstat64+105>:   pop    %ebx
0xc013a83a <sys_lstat64+106>:   pop    %esi
0xc013a83b <sys_lstat64+107>:   add    $0x1c,%esp
0xc013a83e <sys_lstat64+110>:   ret
0xc013a83f <sys_lstat64+111>:   nop 

sys_lstat64:
        subl $28,%esp
        pushl %esi
        pushl %ebx
        movl 40(%esp),%eax
        leal 8(%esp),%esi
        movl %esi,%ecx
        movl $8,%edx
        call __user_walk
        movl %eax,%ebx
        testl %ebx,%ebx
        jne .L1415
        movl 8(%esp),%edx
        movl 8(%edx),%eax
        movl 144(%eax),%eax
        testl %eax,%eax
        je .L1416
        movl 52(%eax),%eax
        testl %eax,%eax
        je .L1416
        pushl %edx
        call *%eax
        movl %eax,%ebx
        addl $4,%esp
        jmp .L1417
        .p2align 4,,7
.L1416:
        xorl %ebx,%ebx
.L1417:
        testl %ebx,%ebx
        jne .L1418    
       movl 44(%esp),%eax
        pushl %eax
        movl 12(%esp),%eax
        movl 8(%eax),%eax
        pushl %eax
        call cp_new_stat64
        movl %eax,%ebx
        addl $8,%esp
.L1418:
        pushl %esi
        call path_release
        addl $4,%esp
.L1415:
        movl %ebx,%eax
        popl %ebx
        popl %esi
        addl $28,%esp
        ret
.Lfe12:
        .size    sys_lstat64,.Lfe12-sys_lstat64
        .align 4
.globl sys_fstat64
        .type    sys_fstat64,@function  

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
The kernel I use was compiled on this system:

Linux venus2 2.2.20 #6 Wed Jul 10 19:44:23 CEST 2002 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux
mount                  2.10f
modutils               2.3.11
e2fsprogs              1.18
PPP                    2.3.11
Linux C Library        2.1.3
ldd: version 1.9.11
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0                 

The kernel is running on this system:

Linux                     2.4.19 #1 SMP Fri Aug 23 18:48:29 CEST 2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11        


Current filesystems: everything is ext3.

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 397.340
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 792.98

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 1
cpu MHz         : 397.340
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 792.98  

[7.3.] Module information (from /proc/modules):
No module support

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0c00-0c3f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
0cf8-0cff : PCI conf1
1000-100f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  1000-1007 : ide0
  1008-100f : ide1
1040-105f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
1060-107f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  1060-107f : eepro100
1080-109f : Intel Corp. 82371AB/EB/MB PIIX4 USB
1400-14ff : LSI Logic / Symbios Logic (formerly NCR) 53c875
  1400-147f : sym53c8xx
1800-18ff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
  1800-187f : sym53c8xx                                                    

00000000-0009ebff : System RAM
0009ec00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00245b23 : Kernel code
  00245b24-0029c73f : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
fa000000-fa0fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
fa100000-fa100fff : LSI Logic / Symbios Logic (formerly NCR) 53c875
fa101000-fa101fff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
fa102000-fa102fff : Cirrus Logic GD 5480
fa103000-fa1030ff : LSI Logic / Symbios Logic (formerly NCR) 53c875
fa103400-fa1034ff : LSI Logic / Symbios Logic (formerly NCR) 53c875 (#2)
fa104000-fa104fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  fa104000-fa104fff : eepro100
fa400000-fa7fffff : Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled)
fc000000-fdffffff : Cirrus Logic GD 5480
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved
[7.5.] PCI information ('lspci -vvv' as root)
[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY367J Rev: DDD6
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: IC35L018UCD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: IBM      Model: IC35L018UCD210-0 Rev: S5BS
  Type:   Direct-Access                    ANSI SCSI revision: 03 

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Personalities : [linear] [raid0] [raid1] [raid5]
read_ahead 1024 sectors
md5 : active raid1 hdc3[1] hda3[0]
      39945920 blocks [2/2] [UU]

md1 : active raid1 sdc1[1] sda1[0]
      32000 blocks [2/2] [UU]

md0 : active raid1 sdc2[1] sdb1[0]
      32000 blocks [2/2] [UU]

md3 : active raid1 sdc6[1] sda5[0]
      8578560 blocks [2/2] [UU]

md4 : active raid1 sdc7[1] sdb5[0]
      8578560 blocks [2/2] [UU]

unused devices: <none>       

[X.] Other notes, patches, fixes, workarounds:
Similare hangs were produced using the current reiserfs. 
Than resiserfs were removed from the filesystem and replaced by ext3.

The user space program rsync was compiled on a different system

The machine is originally Redhat 7.3 but the kernel was upgraded
The original kernel was so unstablem could not compile even the kernel(!)).
Also some user-space programs were recompiled.





--------------950E8B66CBFDD348302918D9--

