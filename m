Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132425AbRDBFHP>; Mon, 2 Apr 2001 01:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRDBFHF>; Mon, 2 Apr 2001 01:07:05 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:1430 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S132425AbRDBFG6>; Mon, 2 Apr 2001 01:06:58 -0400
Date: Mon, 2 Apr 2001 00:06:09 -0500
From: Peter Fales <psfales@lucent.com>
To: linux-kernel@vger.kernel.org
Cc: peter@fales.com
Subject: PROBLEM:  Kernel 2.4.3 oops when hard linking UMSDOS files
Message-ID: <20010402000609.A1443@lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1.  Kernel 2.4.3 oops when hard linking UMSDOS files

2.  I can consistently generate a kernel oops by creating a file on 
    a UMSDOS file system, and attempting to create a hard link to it.
    The same procedure has always worked fine on the 2.2 seriels
    kernels.

3. umsdos, link, hard-link

4. Kernel version 2.4.3, umsdos loaded as a module

5. 

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c013f1d6
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013f1d6>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 00000000   ebx: 00000fff   ecx: c31f7040   edx: c31f7ce0
esi: c79b65a0   edi: c31f7ce0   ebp: c314effe   esp: c3169c6c
ds: 0018   es: 0018   ss: 0018
Process ln (pid: 1380, stackpage=c3169000)
Stack: c1234320 c31f7ce0 c31f7ce0 c3169f40 c314efff c1227e6c c905aa90 c31f7ce0 
       00000000 c79b65a0 00000000 c314e000 00001000 c31f7be0 c31f7ce0 c31f7ce0 
       c3169f40 c905cb58 c31f7ce0 c314e000 00001000 c382c800 c382c080 ffffffff 
Call Trace: [<c905aa90>] [<c905cb58>] [<c905a9ca>] [<c905f86d>] [<c905d5ab>] [<c905f86d>] [<c905ae32>] 
       [<c905ae4c>] [<c013ebc8>] [<c905a8ae>] [<c905aa0a>] [<c013e677>] [<c905c1cc>] [<c905a83e>] [<c0110444>] 
       [<c0128078>] [<c0121861>] [<c0137142>] [<c0137a5a>] [<c0139eab>] [<c0137142>] [<c01391c6>] [<c01392c6>] 
       [<c01350a6>] [<c0106e73>] 
Code: 3b 50 04 74 0b 8b 72 0c 89 74 24 14 39 f2 75 1a 8b 7c 24 20 

>>EIP; c013f1d6 <__d_path+ba/128>   <=====
Trace; c905aa90 <[umsdos]umsdos_d_path+58/98>
Trace; c905cb58 <[umsdos]UMSDOS_link+340/418>
Trace; c905a9ca <[umsdos]umsdos_lookup_dentry+52/c0>
Trace; c905f86d <[umsdos]start_ind_dev.493+916/a67>
Trace; c905d5ab <[umsdos]umsdos_get_emd_dentry+13/18>
Trace; c905f86d <[umsdos]start_ind_dev.493+916/a67>
Trace; c905ae32 <[umsdos]umsdos_set_dirinfo_new+2a/30>
Trace; c905ae4c <[umsdos]umsdos_patch_dentry_inode+14/80>
Trace; c013ebc8 <d_alloc+18/170>
Trace; c905a8ae <[umsdos]UMSDOS_lookup+12/38>
Trace; c905aa0a <[umsdos]umsdos_lookup_dentry+92/c0>
Trace; c013e677 <dput+127/144>
Trace; c905c1cc <[umsdos]umsdos_endlookup+40/44>
Trace; c905a83e <[umsdos]umsdos_lookup_x+1ca/228>
Trace; c0110444 <do_page_fault+0/40c>
Trace; c0128078 <inactive_shortage+34/7c>
Trace; c0121861 <__find_get_page+2d/68>
Trace; c0137142 <cached_lookup+2e/54>
Trace; c0137a5a <path_walk+6f6/7bc>
Trace; c0139eab <vfs_follow_link+e7/150>
Trace; c0137142 <cached_lookup+2e/54>
Trace; c01391c6 <vfs_link+aa/e0>
Trace; c01392c6 <sys_link+ca/12c>
Trace; c01350a6 <sys_lstat64+16/70>
Trace; c0106e73 <system_call+33/40>
Code;  c013f1d6 <__d_path+ba/128>
00000000 <_EIP>:
Code;  c013f1d6 <__d_path+ba/128>   <=====
   0:   3b 50 04                  cmp    0x4(%eax),%edx   <=====
Code;  c013f1d9 <__d_path+bd/128>
   3:   74 0b                     je     10 <_EIP+0x10> c013f1e6 <__d_path+ca/128>
Code;  c013f1db <__d_path+bf/128>
   5:   8b 72 0c                  mov    0xc(%edx),%esi
Code;  c013f1de <__d_path+c2/128>
   8:   89 74 24 14               mov    %esi,0x14(%esp,1)
Code;  c013f1e2 <__d_path+c6/128>
   c:   39 f2                     cmp    %esi,%edx
Code;  c013f1e4 <__d_path+c8/128>
   e:   75 1a                     jne    2a <_EIP+0x2a> c013f200 <__d_path+e4/128>
Code;  c013f1e6 <__d_path+ca/128>
  10:   8b 7c 24 20               mov    0x20(%esp,1),%edi


6. # /usr1 is a UMSDOS file system
   date > /usr1/jnk1
   ln /usr1/jnk1 /usr1/jnk2

7. AFAIK environment configuration is not critical, other than using
   a UMSDOS file system.


-- 
Peter Fales
peter@fales.com or psfales@lucent.com
