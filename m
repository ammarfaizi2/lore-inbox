Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136446AbREDQWR>; Fri, 4 May 2001 12:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136445AbREDQWI>; Fri, 4 May 2001 12:22:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:57355 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S136446AbREDQV4>; Fri, 4 May 2001 12:21:56 -0400
Date: Fri, 4 May 2001 12:23:11 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@fonzie.nine.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.4-ac4 - oops on unload "cdrom" module
Message-ID: <Pine.LNX.4.33.0105041213520.2827-100000@fonzie.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This oops happens when I run "rmmod cdrom" on a 2.4.4-ac4 kernel with
CONFIG_SYSCTL enabled. It doesn't happen if CONFIG_SYSCTL is disabled.

Full .config is here:
http://www.red-bean.com/~proski/linux/config

sr_mod isn't loaded at this point. Reference to sd_mod looks weird. After
this oops the "cdrom" module remains in memory in the "deleted" state.

$ /sbin/lsmod
Module                  Size  Used by
hid                    11760   0 (unused)
keybdev                 1632   0 (unused)
mga                    85312   1
agpgart                13136   3
mousedev                3936   1 (autoclean)
input                   3296   0 (autoclean) [hid keybdev mousedev]
nfsd                   67504   8 (autoclean)
lockd                  48752   1 (autoclean) [nfsd]
sunrpc                 56800   1 (autoclean) [nfsd lockd]
3c59x                  24320   1 (autoclean)
ipx                    14496   1 (autoclean)
ramfs                   3728   1 (autoclean)
cdrom                  28864   0 (deleted)

ksymoops 2.3.4 on i686 2.4.4-ac4.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac4/ (default)
     -m System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000008
c0118051
Oops: 0000
CPU:    0
EIP:    0010:[<c0118051>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: d08c9000   edx: 00000000
esi: d08c9000   edi: 00000000   ebp: bfffe968   esp: c181bf80
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 11303, stackpage=c181b000)
Stack: d08c9000 d08cd92f 00000000 d08cd97a 00000000 d08cf5c0 c01157eb d08c9000
       fffffff0 c62dc000 c0114c87 d08c9000 00000000 c181a000 bffffb47 00000001
       c0106af7 bffffb47 0805eee8 00000100 bffffb47 00000001 bfffe968 00000081
Call Trace: [<d08c9000>] [<d08cd92f>] [<d08cd97a>] [<d08cf5c0>] [<c01157eb>]
   [<d08c9000>] [<c0114c87>] [<d08c9000>] [<c0106af7>]
Code: 8b 53 08 8b 43 04 89 50 04 89 02 a1 a0 46 27 c0 50 8b 03 50

>>EIP; c0118051 <unregister_sysctl_table+5/2c>   <=====
Trace; d08c9000 <[sd_mod]__module_using_checksums+18cb/192b>
Trace; d08cd92f <[cdrom]cdrom_sysctl_unregister+b/10>
Trace; d08cd97a <[cdrom]cdrom_exit+1a/28>
Trace; d08cf5c0 <[cdrom].rodata.start+1a00/1a22>
Trace; c01157eb <free_module+1b/a0>
Trace; d08c9000 <[sd_mod]__module_using_checksums+18cb/192b>
Trace; c0114c87 <sys_delete_module+f3/1b0>
Trace; d08c9000 <[sd_mod]__module_using_checksums+18cb/192b>
Trace; c0106af7 <system_call+33/38>
Code;  c0118051 <unregister_sysctl_table+5/2c>
00000000 <_EIP>:
Code;  c0118051 <unregister_sysctl_table+5/2c>   <=====
   0:   8b 53 08                  mov    0x8(%ebx),%edx   <=====
Code;  c0118054 <unregister_sysctl_table+8/2c>
   3:   8b 43 04                  mov    0x4(%ebx),%eax
Code;  c0118057 <unregister_sysctl_table+b/2c>
   6:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c011805a <unregister_sysctl_table+e/2c>
   9:   89 02                     mov    %eax,(%edx)
Code;  c011805c <unregister_sysctl_table+10/2c>
   b:   a1 a0 46 27 c0            mov    0xc02746a0,%eax
Code;  c0118061 <unregister_sysctl_table+15/2c>
  10:   50                        push   %eax
Code;  c0118062 <unregister_sysctl_table+16/2c>
  11:   8b 03                     mov    (%ebx),%eax
Code;  c0118064 <unregister_sysctl_table+18/2c>
  13:   50                        push   %eax


-- 
Regards,
Pavel Roskin

