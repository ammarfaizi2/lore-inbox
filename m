Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282582AbRKZVgL>; Mon, 26 Nov 2001 16:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282580AbRKZVgF>; Mon, 26 Nov 2001 16:36:05 -0500
Received: from plotnick.chek.com ([208.197.227.116]:27409 "HELO
	mailrelay1.chek.com") by vger.kernel.org with SMTP
	id <S282581AbRKZVfy>; Mon, 26 Nov 2001 16:35:54 -0500
Date: 26 Nov 2001 21:35:28 -0000
Message-ID: <20011126213528.14089.qmail@purina.chek.com>
From: "Hitokage Nishino" <seijuurou@dragonslave.com>
To: linux-kernel@vger.kernel.org
X-Originating-IP: [24.25.94.188]
Subject: PROBLEM: 2.4.15 oops when mounting /proc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Trying to do this by-the-book ;)]

I run a K6-II on a PCChips M560 mb with Redhat 7.2. Recently downloaded 2.4.15 and applied Al Viro's inode.c patch, configured, compiled... and although the kernel will boot fine, it will crash when init starts with "Mounting proc filesystem". init will continue to run, but as soon as it has to remount root, it fails as /proc/partitions is not available(obviously, /proc fails to mount), thus sending me to single user mode. Any attempts to mount filesystems(to save dmesg) leads to a system freeze. Of course, I had to copy the Oops output by hand *ugh*, slight possibility of error.

Oops with symbols resolved:

Unable to handle kernel NULL pointer dereference at virtual address 00000008
*pde = 00000000
CPU: 0
EIP: 0010:[<c0144c68>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx:c1205360      ecx:00000000 edx:00000000
esi: c7e45f68   edi:c7e45f64      ebp:00000000 esp:c7e45000
ds: 0018        es: 0018       ss: 0018
Process mount (pid: 24, stackpage=c7e45000)
Stack:        c7e45f64 c0145cf7 c7e45f64 c7dca000 00000000 00000000 c7dc9000 00000000
        00000000 c7ff9840 c1205320 00000000 000004e0 c7dc9000 00000009 00000001
Call Trace: [<c0145a9e>] [<c01123d0>] [<c0106ee4>] [<c0145cf7>] [<c0145b5e>] [<c0145d94>] [<c0106dd37>]
Code:   8b 42 08 39 d0 75 f7 3b 15 f4

>>EIP; c0144c68 <check_mnt+8/20>   <=====
Trace; c0145a9e <do_add_mount+6e/d0>
Trace; c01123d0 <do_page_fault+0/4f0>
Trace; c0106ee4 <error_code+34/40>
Trace; c0145cf7 <do_mount+137/160>
Trace; c0145b5e <copy_mount_options+5e/c0>
Trace; c0145d94 <sys_mount+74/c0>
Trace; c0106dd37 <END_OF_CODE+b3877b257/????>
Code;  c0144c68 <check_mnt+8/20>
00000000 <_EIP>:
Code;  c0144c68 <check_mnt+8/20>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c0144c6b <check_mnt+b/20>
   3:   39 d0                     cmp    %edx,%eax
Code;  c0144c6d <check_mnt+d/20>
   5:   75 f7                     jne    fffffffe <_EIP+0xfffffffe> c0144c66 <check_mnt+6/20>
Code;  c0144c6f <check_mnt+f/20>
   7:   3b 15 f4 00 00 00         cmp    0xf4,%edx

ver_linux output:
Linux localhost 2.4.12-0.1 #1 Sat Oct 20 14:49:52 EDT 2001 i586 unknown

Gnu C                  2.96  **2.96-98
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.12
e2fsprogs              1.23
reiserfsprogs          3.x.0j
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         tdfx autofs tulip ipt_REJECT iptable_filter ip_tables ide-scsi scsi_mod ide-cd cdrom nls_iso8859-1 nls_cp437 vfat fat sb sb_lib uart401 sound soundcore ext3 jbd

/proc/cpuinfo output:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 399.822
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow k6_mtrr
bogomips        : 797.90

