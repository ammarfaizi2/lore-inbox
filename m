Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261459AbTC0WVO>; Thu, 27 Mar 2003 17:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261454AbTC0WVN>; Thu, 27 Mar 2003 17:21:13 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:33215 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261459AbTC0WU1>; Thu, 27 Mar 2003 17:20:27 -0500
Date: Thu, 27 Mar 2003 14:21:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 514] New: Oops in mga_vm_shm_close during X shutdown 
Message-ID: <3280000.1048803695@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=514

           Summary: Oops in mga_vm_shm_close during X shutdown
    Kernel Version: 2.5.66
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: dave.beckett@bristol.ac.uk


Distribution: Debian
Hardware Environment: VIA VT8366 & VT8233, Matrox MGAG550 AGP
Software Environment:

Linux foo 2.5.66 #1 Tue Mar 25 08:03:24 GMT 2003 i686 unknown unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
module-init-tools      0.9.10
e2fsprogs              1.32
jfsutils               1.1.1
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.10
Modules Loaded         nls_iso8859_1 loop parport_pc lp parport snd_pcm_oss
snd_mixer_oss snd_ens1371 snd_rawmidi snd_pcm snd_page_alloc snd_timer
snd_ac97_codec snd iptable_mangle iptable_filter ipt_MASQUERADE ip_nat_ftp
iptable_nat ip_conntrack_ftp ip_conntrack 8139too natsemi crc32 uhci_hcd usbcore
raid1 es1371 ac97_codec

  XFree86 Version 4.2.1.1 (Debian 4.2.1-6)

Problem Description: Oops when X is shut down

Steps to reproduce:

Log into X, log out.  Crash somewhere while X shuts down / restarts.
Killing X by hand causes no crash.
                                                                               
Running ksymoops on this complains                                                 
  Warning (Oops_read): Code line not seen, dumping what data is available      
and gives less information.
There is only 1 AGP device, despite the agpgart messages below.
--------------

agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
agpgart: Putting AGP V2 device at 00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 01:00.0 into 4x mode
 printing eip:
c02123bb
Oops: 0000 [#1]                                                                
CPU:    0                                                                      
EIP:    0060:[mga_vm_shm_close+107/480]    Not tainted                         
EFLAGS: 00013286                                                               
EIP is at mga_vm_shm_close+0x6b/0x1e0
eax: 00000002   ebx: ff400f12   ecx: da2f8bc0   edx: ff231417
esi: 00000001   edi: d96e5a00   ebp: d8cedbe8   esp: d8cedbbc
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 965, threadinfo=d8cec000 task=d95f8c80)
Stack: d70e8dc0 0000000c 00000006 c013b92a d96e5d00 dfe5a01c d96e5a00 dfe5a000
       d794a500 d794a400 d8cec000 d8cedc1c c013ffcd d794a500 d794a3c0 00000300
       00000000 ffffffff d8cedc0c c03881ac 000006db d7347c40 d7347c40 db150200
Call Trace:
 [clear_page_tables+170/176] clear_page_tables+0xaa/0xb0
 [exit_mmap+365/400] exit_mmap+0x16d/0x190                                     
 [mmput+85/176] mmput+0x55/0xb0                                                
 [exec_mmap+190/320] exec_mmap+0xbe/0x140                                      
 [flush_old_exec+26/2096] flush_old_exec+0x1a/0x830
 [kernel_read+74/96] kernel_read+0x4a/0x60
 [load_elf_binary+737/3104] load_elf_binary+0x2e1/0xc20
 [file_read_actor+0/272] file_read_actor+0x0/0x110
 [do_IRQ+264/304] do_IRQ+0x108/0x130
 [load_elf_binary+0/3104] load_elf_binary+0x0/0xc20
 [search_binary_handler+188/688] search_binary_handler+0xbc/0x2b0
 [do_execve+386/464] do_execve+0x182/0x1d0
 [sys_execve+77/128] sys_execve+0x4d/0x80
 [syscall_call+7/11] syscall_call+0x7/0xb

Code: 39 7a 3c 0f 44 f0 3b 55 08 0f 84 ff 00 00 00 89 4d e4 85 db

