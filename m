Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTK3Xlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 18:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTK3Xlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 18:41:45 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:23502 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S262115AbTK3Xl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 18:41:28 -0500
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 13:17:46 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.131750.-1591395.3.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Juno-Line-Breaks: 0-40,42,44,46-68,70-95,97,99,101-164
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you try 2.6 with the following patch and send in the 
> resulting
> oops/BUG? Please turn on kallsyms for the run.
> 
> 
> Thanks.
> 
> 
> -- wli
Ok, it took a while to recompile, did you try the test program?
If you have tmpfs mounted at /dev/shm as recommended it crashes
for me on both kernels and it might be easier for you if you can
reproduce it on your machine, I can also send the longer version
of the test program if you are using POSIX shm. I was having
trouble with all the inlines hiding where it is going wrong.

Oops from 2.6.0-test11 + plus wli test patch
ksymoops cant find /proc/ksym I had kallsyms on
but ksymoops did not like it as -k

ksymoops 2.4.9 on i586 2.6.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test11/ (default)
     -m /boot/System.map-2.6.0-test11 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address 00200200
c018a152
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c018a152>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax: 00200200   ebx: c2d19f64   ecx: c2d09f6c   edx: c2d19f64
esi: c2d19f38   edi: 00000000   ebp: c3513f7c   esp: c3513f64
ds: 007b   es: 007b   ss: 0068
Stack: c2d19f38 00000002 00000000 00000000 00000000 c2de9f60 c3513fbc
c0162ba9 
       c2de9f60 00000002 00000000 00000000 00000002 c3513fbc c017879f
00000003 
       c0189f90 ffffffea 00000000 00000003 0804a050 00000002 c3512000
c0109c17 
Call Trace:
 [<c0162ba9>] sys_lseek+0x59/0xb0
 [<c017879f>] sys_fcntl64+0x5f/0x80
 [<c0189f90>] dcache_dir_lseek+0x0/0x2f0
 [<c0109c17>] syscall_call+0x7/0xb
Code: 89 10 81 3d 70 f4 2c c0 3c 4b 24 1d 74 19 68 70 f4 2c c0 6a 


>>EIP; c018a152 <dcache_dir_lseek+1c2/2f0>   <=====

>>eax; 00200200 <__crc___user_walk+3d8ad/9422e>
>>ebx; c2d19f64 <__crc_device_unregister_wait+2144d0/4c44fe>
>>ecx; c2d09f6c <__crc_device_unregister_wait+2044d8/4c44fe>
>>edx; c2d19f64 <__crc_device_unregister_wait+2144d0/4c44fe>
>>esi; c2d19f38 <__crc_device_unregister_wait+2144a4/4c44fe>
>>ebp; c3513f7c <__crc_proc_root_driver+314d45/7e3f13>
>>esp; c3513f64 <__crc_proc_root_driver+314d2d/7e3f13>

Trace; c0162ba9 <sys_lseek+59/b0>
Trace; c017879f <sys_fcntl64+5f/80>
Trace; c0189f90 <dcache_dir_lseek+0/2f0>
Trace; c0109c17 <syscall_call+7/b>
                                                                         
      
Code;  c018a152 <dcache_dir_lseek+1c2/2f0>
00000000 <_EIP>:
Code;  c018a152 <dcache_dir_lseek+1c2/2f0>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c018a154 <dcache_dir_lseek+1c4/2f0>
   2:   81 3d 70 f4 2c c0 3c      cmpl   $0x1d244b3c,0xc02cf470
Code;  c018a15b <dcache_dir_lseek+1cb/2f0>
   9:   4b 24 1d 
Code;  c018a15e <dcache_dir_lseek+1ce/2f0>
   c:   74 19                     je     27 <_EIP+0x27>
Code;  c018a160 <dcache_dir_lseek+1d0/2f0>
   e:   68 70 f4 2c c0            push   $0xc02cf470
Code;  c018a165 <dcache_dir_lseek+1d5/2f0>
  13:   6a 00                     push   $0x0

Unable to handle kernel paging request at virtual address 00200200
c017d371
*pde = 00000000
Oops: 0002 [#2]
CPU:    0
EIP:    0060:[<c017d371>]    Not tainted
EFLAGS: 00010246
eax: c2d19f64   ebx: c2d19f38   ecx: c2d19f64   edx: 00200200
esi: c10bc194   edi: c2cf8e3c   ebp: c3513de0   esp: c3513dd8
ds: 007b   es: 007b   ss: 0068
Stack: c2de9f60 c10bc194 c3513dec c0189f7f c2d19f38 c3513e0c c0163ef4
c2cf8e3c 
       c2de9f60 c2d09f38 c2de9f60 00000000 c351ce44 c3513e30 c01625b4
c2de9f60 
       c351ce44 c2de9f60 c351ce44 00040001 00000003 c351ce44 c3513e50
c0120787 
Call Trace:
 [<c0189f7f>] dcache_dir_close+0xf/0x20
 [<c0163ef4>] __fput+0xe4/0x100
 [<c01625b4>] filp_close+0x44/0x70
 [<c0120787>] put_files_struct+0x67/0xd0
 [<c01219c5>] do_exit+0x335/0x6e0
 [<c010a599>] die+0x1a9/0x1b0
 [<c0116b36>] do_page_fault+0x2a6/0x576
 [<c017f2c9>] d_alloc+0x19/0x330
 [<c017f2c9>] d_alloc+0x19/0x330
 [<c0147853>] kmem_cache_alloc+0x133/0x1c0
 [<c016f9dd>] cp_new_stat64+0x10d/0x130
 [<c0116890>] do_page_fault+0x0/0x576
 [<c0109e7d>] error_code+0x2d/0x40
 [<c018a152>] dcache_dir_lseek+0x1c2/0x2f0
 [<c0162ba9>] sys_lseek+0x59/0xb0
 [<c017879f>] sys_fcntl64+0x5f/0x80
 [<c0189f90>] dcache_dir_lseek+0x0/0x2f0
 [<c0109c17>] syscall_call+0x7/0xb
Code: 89 02 c7 41 04 00 02 20 00 c7 43 2c 00 01 10 00 a1 ac f4 2c 


>>EIP; c017d371 <dput+d1/550>   <=====

>>eax; c2d19f64 <__crc_device_unregister_wait+2144d0/4c44fe>
>>ebx; c2d19f38 <__crc_device_unregister_wait+2144a4/4c44fe>
>>ecx; c2d19f64 <__crc_device_unregister_wait+2144d0/4c44fe>
>>edx; 00200200 <__crc___user_walk+3d8ad/9422e>
>>esi; c10bc194 <__crc_idle_cpu+2674d7/3833d6>
>>edi; c2cf8e3c <__crc_device_unregister_wait+1f33a8/4c44fe>
>>ebp; c3513de0 <__crc_proc_root_driver+314ba9/7e3f13>
>>esp; c3513dd8 <__crc_proc_root_driver+314ba1/7e3f13>

Trace; c0189f7f <dcache_dir_close+f/20>
Trace; c0163ef4 <__fput+e4/100>
Trace; c01625b4 <filp_close+44/70>
Trace; c0120787 <put_files_struct+67/d0>
Trace; c01219c5 <do_exit+335/6e0>
Trace; c010a599 <die+1a9/1b0>
Trace; c0116b36 <do_page_fault+2a6/576>
Trace; c017f2c9 <d_alloc+19/330>
Trace; c017f2c9 <d_alloc+19/330>
Trace; c0147853 <kmem_cache_alloc+133/1c0>
Trace; c016f9dd <cp_new_stat64+10d/130>
Trace; c0116890 <do_page_fault+0/576>
Trace; c0109e7d <error_code+2d/40>
Trace; c018a152 <dcache_dir_lseek+1c2/2f0>
Trace; c0162ba9 <sys_lseek+59/b0>
Trace; c017879f <sys_fcntl64+5f/80>
Trace; c0189f90 <dcache_dir_lseek+0/2f0>
Trace; c0109c17 <syscall_call+7/b>

Code;  c017d371 <dput+d1/550>
00000000 <_EIP>:
Code;  c017d371 <dput+d1/550>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c017d373 <dput+d3/550>
   2:   c7 41 04 00 02 20 00      movl   $0x200200,0x4(%ecx)
Code;  c017d37a <dput+da/550>
   9:   c7 43 2c 00 01 10 00      movl   $0x100100,0x2c(%ebx)
Code;  c017d381 <dput+e1/550>
  10:   a1 ac f4 2c 00            mov    0x2cf4ac,%eax

1 error issued.  Results may not be reliable.

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
