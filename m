Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTDUWgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 18:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbTDUWgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 18:36:22 -0400
Received: from mail8.kc.rr.com ([24.94.162.176]:4365 "EHLO mail8.kc.rr.com")
	by vger.kernel.org with ESMTP id S262621AbTDUWfT (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Apr 2003 18:35:19 -0400
Date: Mon, 21 Apr 2003 17:47:19 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.redhat.com>
Subject: Unable to handle kernel paging request -- 2.4.21-pre7
Message-ID: <20030421224719.GA20818@glitch.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been getting the following oops with 2.4.21-pre[67] on a fairly
regular basis... generally within 48 hours of powering on.  I think it
was occurring with 2.4.20 as well, but am not completely certain as I
was unable to capture the necessary information.  Any idea what's
occurring?

The machine in question is a fairly unremarkable single-CPU Athlon
system, which is currently running Debian sid.  I've tried building
with gcc 2.95 and 3.2.3 (latest .config attached), and have attempted
to back out all of the non-kernel modules... Alsa was still present
during the last occurrence, but that should be it.


ksymoops 2.4.8 on i686 2.4.21-pre7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre7/ (default)
     -m /boot/System.map-2.4.21-pre7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Apr 20 06:25:08 glitch kernel: Unable to handle kernel paging request at virtual address 8596e4e0
Apr 20 06:25:08 glitch kernel: c013062a
Apr 20 06:25:08 glitch kernel: *pde = 00000000
Apr 20 06:25:08 glitch kernel: Oops: 0000
Apr 20 06:25:08 glitch kernel: CPU:    0
Apr 20 06:25:08 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 20 06:25:08 glitch kernel: EFLAGS: 00010082
Apr 20 06:25:08 glitch kernel: eax: e95f3132   ebx: e95f3132   ecx: e01a2000   edx: 00000000
Apr 20 06:25:08 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: c270fe64
Apr 20 06:25:08 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:08 glitch kernel: Process find (pid: 15567, stackpage=c270f000)
Apr 20 06:25:08 glitch kernel: Stack: 00000058 df9644c0 00000000 c1cbc7b8 f7909800 c1cbc7b8 c014cd5f c1c0ff84 
Apr 20 06:25:08 glitch kernel:        000001f0 00000001 00000000 c1cbc7b8 f7909800 c014d943 f7909800 00000001 
Apr 20 06:25:08 glitch kernel:        00000000 df9644c0 f7909800 00000000 c1cbc7b8 000232b7 f7909800 c014dc50 
Apr 20 06:25:08 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d943>] [<c014dc50>] [<c0162d0c>] [<c0142dd7>]
Apr 20 06:25:08 glitch kernel:   [<c01434ca>] [<c0143797>] [<c0143a29>] [<c014028f>] [<c010737f>]
Apr 20 06:25:08 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>eax; e95f3132 <_end+29324ee2/38576e30>
>>ebx; e95f3132 <_end+29324ee2/38576e30>
>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; c270fe64 <_end+2441c14/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d943 <get_new_inode+23/160>
Trace; c014dc50 <iget4+e0/f0>
Trace; c0162d0c <ext3_lookup+7c/b0>
Trace; c0142dd7 <real_lookup+c7/f0>
Trace; c01434ca <link_path_walk+59a/6b0>
Trace; c0143797 <path_lookup+37/40>
Trace; c0143a29 <__user_walk+49/60>
Trace; c014028f <sys_lstat64+1f/80>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 06:25:08 glitch kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
Apr 20 06:25:08 glitch kernel: c01163fb
Apr 20 06:25:08 glitch kernel: *pde = 00000000
Apr 20 06:25:08 glitch kernel: Oops: 0000
Apr 20 06:25:08 glitch kernel: CPU:    0
Apr 20 06:25:08 glitch kernel: EIP:    0010:[<c01163fb>]    Not tainted
Apr 20 06:25:08 glitch kernel: EFLAGS: 00010082
Apr 20 06:25:08 glitch kernel: eax: 86b0383e   ebx: 00000000   ecx: 00000001   edx: 00000003
Apr 20 06:25:08 glitch kernel: esi: 86b0383e   edi: 00000003   ebp: e0563e4c   esp: e0563e30
Apr 20 06:25:08 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:08 glitch kernel: Process ifconfig (pid: 15575, stackpage=e0563000)
Apr 20 06:25:08 glitch kernel: Stack: c1c1b400 c014cd03 00000001 00000282 00000000 86b037aa c1c1b400 c1c8cf78 
Apr 20 06:25:08 glitch kernel:        c014da65 86b037aa 00001018 c1c8cf78 00000000 00000000 00000000 c1c8cf78 
Apr 20 06:25:08 glitch kernel:        00001018 c1c1b400 c014dc50 c1c1b400 00001018 c1c8cf78 00000000 00000000 
Apr 20 06:25:08 glitch kernel: Call Trace:    [<c014cd03>] [<c014da65>] [<c014dc50>] [<c0154e0f>] [<c0156e37>]
Apr 20 06:25:08 glitch kernel:   [<c0154fe5>] [<c0142dd7>] [<c01434ca>] [<c0143797>] [<c0143a29>] [<c01374ad>]
Apr 20 06:25:08 glitch kernel:   [<c012827d>] [<c010737f>]
Apr 20 06:25:08 glitch kernel: Code: 8b 13 0f 0d 02 39 c3 74 16 8b 4b fc 8b 01 85 c7 75 19 8b 02 


>>EIP; c01163fb <__wake_up+1b/70>   <=====

>>ebp; e0563e4c <_end+20295bfc/38576e30>
>>esp; e0563e30 <_end+20295be0/38576e30>

Trace; c014cd03 <alloc_inode+c3/150>
Trace; c014da65 <get_new_inode+145/160>
Trace; c014dc50 <iget4+e0/f0>
Trace; c0154e0f <proc_get_inode+3f/120>
Trace; c0156e37 <proc_lookup+d7/e0>
Trace; c0154fe5 <proc_root_lookup+25/70>
Trace; c0142dd7 <real_lookup+c7/f0>
Trace; c01434ca <link_path_walk+59a/6b0>
Trace; c0143797 <path_lookup+37/40>
Trace; c0143a29 <__user_walk+49/60>
Trace; c01374ad <sys_access+7d/140>
Trace; c012827d <sys_brk+fd/130>
Trace; c010737f <system_call+33/38>

Code;  c01163fb <__wake_up+1b/70>
00000000 <_EIP>:
Code;  c01163fb <__wake_up+1b/70>   <=====
   0:   8b 13                     mov    (%ebx),%edx   <=====
Code;  c01163fd <__wake_up+1d/70>
   2:   0f 0d 02                  prefetch (%edx)
Code;  c0116400 <__wake_up+20/70>
   5:   39 c3                     cmp    %eax,%ebx
Code;  c0116402 <__wake_up+22/70>
   7:   74 16                     je     1f <_EIP+0x1f>
Code;  c0116404 <__wake_up+24/70>
   9:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx
Code;  c0116407 <__wake_up+27/70>
   c:   8b 01                     mov    (%ecx),%eax
Code;  c0116409 <__wake_up+29/70>
   e:   85 c7                     test   %eax,%edi
Code;  c011640b <__wake_up+2b/70>
  10:   75 19                     jne    2b <_EIP+0x2b>
Code;  c011640d <__wake_up+2d/70>
  12:   8b 02                     mov    (%edx),%eax

Apr 20 06:25:08 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 201a213a
Apr 20 06:25:08 glitch kernel: c014e022
Apr 20 06:25:08 glitch kernel: *pde = 00000000
Apr 20 06:25:08 glitch kernel: Oops: 0002
Apr 20 06:25:08 glitch kernel: CPU:    0
Apr 20 06:25:08 glitch kernel: EIP:    0010:[<c014e022>]    Not tainted
Apr 20 06:25:08 glitch kernel: EFLAGS: 00010212
Apr 20 06:25:08 glitch kernel: eax: 00000000   ebx: 00000000   ecx: 0000002c   edx: 201a213a
Apr 20 06:25:08 glitch kernel: esi: 201a202a   edi: 201a213a   ebp: c1cc3290   esp: c289fe44
Apr 20 06:25:08 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:08 glitch kernel: Process logrotate (pid: 15572, stackpage=c289f000)
Apr 20 06:25:08 glitch kernel: Stack: 00000000 f7e73a00 c014cd83 201a213a 00000000 000000b0 00000000 c1cc3290 
Apr 20 06:25:08 glitch kernel:        f7e73a00 c014d943 f7e73a00 00000001 00000000 da4e8940 f7e73a00 00000000 
Apr 20 06:25:08 glitch kernel:        c1cc3290 0000e58a f7e73a00 c014dc50 f7e73a00 0000e58a c1cc3290 00000000 
Apr 20 06:25:08 glitch kernel: Call Trace:    [<c014cd83>] [<c014d943>] [<c014dc50>] [<c0162d0c>] [<c0142dd7>]
Apr 20 06:25:08 glitch kernel:   [<c01434ca>] [<c014348f>] [<c0143797>] [<c0143b90>] [<c0137c23>] [<c0137fe3>]
Apr 20 06:25:08 glitch kernel:   [<c010737f>]
Apr 20 06:25:08 glitch kernel: Code: f3 ab eb ae c1 e9 02 89 d7 f3 ab aa eb a4 55 57 56 53 83 ec 


>>EIP; c014e022 <__constant_c_and_count_memset+72/80>   <=====

>>ebp; c1cc3290 <_end+19f5040/38576e30>
>>esp; c289fe44 <_end+25d1bf4/38576e30>

Trace; c014cd83 <alloc_inode+143/150>
Trace; c014d943 <get_new_inode+23/160>
Trace; c014dc50 <iget4+e0/f0>
Trace; c0162d0c <ext3_lookup+7c/b0>
Trace; c0142dd7 <real_lookup+c7/f0>
Trace; c01434ca <link_path_walk+59a/6b0>
Trace; c014348f <link_path_walk+55f/6b0>
Trace; c0143797 <path_lookup+37/40>
Trace; c0143b90 <open_namei+70/550>
Trace; c0137c23 <filp_open+43/70>
Trace; c0137fe3 <sys_open+53/a0>
Trace; c010737f <system_call+33/38>

Code;  c014e022 <__constant_c_and_count_memset+72/80>
00000000 <_EIP>:
Code;  c014e022 <__constant_c_and_count_memset+72/80>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c014e024 <__constant_c_and_count_memset+74/80>
   2:   eb ae                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e026 <__constant_c_and_count_memset+76/80>
   4:   c1 e9 02                  shr    $0x2,%ecx
Code;  c014e029 <__constant_c_and_count_memset+79/80>
   7:   89 d7                     mov    %edx,%edi
Code;  c014e02b <__constant_c_and_count_memset+7b/80>
   9:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  c014e02d <__constant_c_and_count_memset+7d/80>
   b:   aa                        stos   %al,%es:(%edi)
Code;  c014e02e <__constant_c_and_count_memset+7e/80>
   c:   eb a4                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e030 <__sync_one+0/142>
   e:   55                        push   %ebp
Code;  c014e031 <__sync_one+1/142>
   f:   57                        push   %edi
Code;  c014e032 <__sync_one+2/142>
  10:   56                        push   %esi
Code;  c014e033 <__sync_one+3/142>
  11:   53                        push   %ebx
Code;  c014e034 <__sync_one+4/142>
  12:   83 ec 00                  sub    $0x0,%esp

Apr 20 06:25:08 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:25:08 glitch kernel: c014dc15
Apr 20 06:25:08 glitch kernel: *pde = 00000000
Apr 20 06:25:08 glitch kernel: Oops: 0002
Apr 20 06:25:08 glitch kernel: CPU:    0
Apr 20 06:25:08 glitch kernel: EIP:    0010:[<c014dc15>]    Not tainted
Apr 20 06:25:08 glitch kernel: EFLAGS: 00010246
Apr 20 06:25:08 glitch kernel: eax: 86b037b2   ebx: dc11cac0   ecx: dc11cc88   edx: dc11cac8
Apr 20 06:25:08 glitch kernel: esi: c1cfe9f8   edi: 00015c77   ebp: f7e73a00   esp: f7657ec4
Apr 20 06:25:08 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:08 glitch kernel: Process run-parts (pid: 15527, stackpage=f7657000)
Apr 20 06:25:08 glitch kernel: Stack: f7e73a00 00015c77 c1cfe9f8 00000000 00000000 00015c77 ed04f1c0 e3796e40 
Apr 20 06:25:08 glitch kernel:        ed04f1c0 c0162d0c f7e73a00 00015c77 00000000 00000000 eecf6070 fffffff4 
Apr 20 06:25:08 glitch kernel:        e3796ea8 c0142dd7 e3796e40 ed04f1c0 00000000 dae7e016 00000000 f7657f98 
Apr 20 06:25:08 glitch kernel: Call Trace:    [<c0162d0c>] [<c0142dd7>] [<c01434ca>] [<c0143797>] [<c0143a29>]
Apr 20 06:25:08 glitch kernel:   [<c014020f>] [<c0138bd9>] [<c010737f>]
Apr 20 06:25:08 glitch kernel: Code: 89 50 04 89 43 08 c7 42 04 a0 23 25 c0 89 15 a0 23 25 c0 ff 


>>EIP; c014dc15 <iget4+a5/f0>   <=====

>>ebx; dc11cac0 <_end+1be4e870/38576e30>
>>ecx; dc11cc88 <_end+1be4ea38/38576e30>
>>edx; dc11cac8 <_end+1be4e878/38576e30>
>>esi; c1cfe9f8 <_end+1a307a8/38576e30>
>>ebp; f7e73a00 <_end+37ba57b0/38576e30>
>>esp; f7657ec4 <_end+37389c74/38576e30>

Trace; c0162d0c <ext3_lookup+7c/b0>
Trace; c0142dd7 <real_lookup+c7/f0>
Trace; c01434ca <link_path_walk+59a/6b0>
Trace; c0143797 <path_lookup+37/40>
Trace; c0143a29 <__user_walk+49/60>
Trace; c014020f <sys_stat64+1f/80>
Trace; c0138bd9 <sys_write+e9/130>
Trace; c010737f <system_call+33/38>

Code;  c014dc15 <iget4+a5/f0>
00000000 <_EIP>:
Code;  c014dc15 <iget4+a5/f0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c014dc18 <iget4+a8/f0>
   3:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c014dc1b <iget4+ab/f0>
   6:   c7 42 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%edx)
Code;  c014dc22 <iget4+b2/f0>
   d:   89 15 a0 23 25 c0         mov    %edx,0xc02523a0
Code;  c014dc28 <iget4+b8/f0>
  13:   ff 00                     incl   (%eax)

Apr 20 06:25:08 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:25:08 glitch kernel: c014d8ec
Apr 20 06:25:08 glitch kernel: *pde = 00000000
Apr 20 06:25:08 glitch kernel: Oops: 0002
Apr 20 06:25:08 glitch kernel: CPU:    0
Apr 20 06:25:08 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:25:08 glitch kernel: EFLAGS: 00010206
Apr 20 06:25:08 glitch kernel: eax: e660ec88   ebx: c7eae000   ecx: e660ec80   edx: 86b037b2
Apr 20 06:25:08 glitch kernel: esi: effddd40   edi: bffff820   ebp: ffffffe9   esp: c7eaff34
Apr 20 06:25:08 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:08 glitch kernel: Process cron (pid: 15524, stackpage=c7eaf000)
Apr 20 06:25:08 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 c7eae000 c0142621 00000018 3ea28394 000000c5 
Apr 20 06:25:08 glitch kernel:        c96cb840 c014dfab ef68d640 00000001 ee8f2ac0 c0141d0c ee8f2ac0 cba19000 
Apr 20 06:25:08 glitch kernel:        000000c5 c7eae000 ee8f2b28 000000c5 c1c18340 f0f933c0 000000c5 c7eae000 
Apr 20 06:25:08 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c014dfab>] [<c0141d0c>] [<c010cd57>]
Apr 20 06:25:08 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:25:08 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; e660ec88 <_end+26340a38/38576e30>
>>ebx; c7eae000 <_end+7bdfdb0/38576e30>
>>ecx; e660ec80 <_end+26340a30/38576e30>
>>esi; effddd40 <_end+2fd0faf0/38576e30>
>>esp; c7eaff34 <_end+7be1ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c014dfab <update_atime+6b/70>
Trace; c0141d0c <pipe_read+4c/200>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:25:10 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:25:10 glitch kernel: c014e10f
Apr 20 06:25:10 glitch kernel: *pde = 00000000
Apr 20 06:25:10 glitch kernel: Oops: 0002
Apr 20 06:25:10 glitch kernel: CPU:    0
Apr 20 06:25:10 glitch kernel: EIP:    0010:[<c014e10f>]    Not tainted
Apr 20 06:25:10 glitch kernel: EFLAGS: 00010202
Apr 20 06:25:10 glitch kernel: eax: 86b037b2   ebx: ea46b040   ecx: c02523a0   edx: f7e73a60
Apr 20 06:25:10 glitch kernel: esi: 00000001   edi: ea46b048   ebp: 00000000   esp: f7eedf98
Apr 20 06:25:10 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:25:10 glitch kernel: Process kupdated (pid: 6, stackpage=f7eed000)
Apr 20 06:25:10 glitch kernel: Stack: ea46b0e4 00000000 f7e73a58 f7e73a00 f7eec000 f7eec000 c014d115 ea46b040 
Apr 20 06:25:10 glitch kernel:        00000000 f7eec560 f7eec570 c013d0a8 f7eec570 f7eec000 c013d37c c025b6b0 
Apr 20 06:25:10 glitch kernel:        0008e000 00000000 00010f00 c1c15fa0 c0105000 0008e000 c01057be c02a18c0 
Apr 20 06:25:10 glitch kernel: Call Trace:    [<c014d115>] [<c013d0a8>] [<c013d37c>] [<c0105000>] [<c01057be>]
Apr 20 06:25:10 glitch kernel:   [<c013d2b0>]
Apr 20 06:25:10 glitch kernel: Code: 89 78 04 89 43 08 89 4f 04 89 39 83 c4 08 8d 83 94 00 00 00 


>>EIP; c014e10f <__sync_one+df/142>   <=====

>>ebx; ea46b040 <_end+2a19cdf0/38576e30>
>>ecx; c02523a0 <inode_in_use+0/8>
>>edx; f7e73a60 <_end+37ba5810/38576e30>
>>edi; ea46b048 <_end+2a19cdf8/38576e30>
>>esp; f7eedf98 <_end+37c1fd48/38576e30>

Trace; c014d115 <sync_unlocked_inodes+35/50>
Trace; c013d0a8 <sync_old_buffers+8/50>
Trace; c013d37c <kupdate+cc/100>
Trace; c0105000 <_stext+0/0>
Trace; c01057be <arch_kernel_thread+2e/40>
Trace; c013d2b0 <kupdate+0/100>

Code;  c014e10f <__sync_one+df/142>
00000000 <_EIP>:
Code;  c014e10f <__sync_one+df/142>   <=====
   0:   89 78 04                  mov    %edi,0x4(%eax)   <=====
Code;  c014e112 <__sync_one+e2/142>
   3:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c014e115 <__sync_one+e5/142>
   6:   89 4f 04                  mov    %ecx,0x4(%edi)
Code;  c014e118 <__sync_one+e8/142>
   9:   89 39                     mov    %edi,(%ecx)
Code;  c014e11a <__sync_one+ea/142>
   b:   83 c4 08                  add    $0x8,%esp
Code;  c014e11d <__sync_one+ed/142>
   e:   8d 83 94 00 00 00         lea    0x94(%ebx),%eax

Apr 20 06:30:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:30:01 glitch kernel: c014d8ec
Apr 20 06:30:01 glitch kernel: *pde = 00000000
Apr 20 06:30:01 glitch kernel: Oops: 0002
Apr 20 06:30:01 glitch kernel: CPU:    0
Apr 20 06:30:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:30:01 glitch kernel: EFLAGS: 00010202
Apr 20 06:30:01 glitch kernel: eax: ee8f2ac8   ebx: ca584000   ecx: ee8f2ac0   edx: 86b037b2
Apr 20 06:30:01 glitch kernel: esi: f0eef2c0   edi: 401379d8   ebp: ffffffe9   esp: ca585f34
Apr 20 06:30:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:30:01 glitch kernel: Process cron (pid: 15577, stackpage=ca585000)
Apr 20 06:30:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 ca584000 c0142621 c0123086 00000011 ca584568 
Apr 20 06:30:01 glitch kernel:        00000000 bffff1e0 efcb8640 c0123408 bffff150 ca585f70 00000014 0804a078 
Apr 20 06:30:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 f34f8e40 ca584000 
Apr 20 06:30:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:30:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:30:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; ee8f2ac8 <_end+2e624878/38576e30>
>>ebx; ca584000 <_end+a2b5db0/38576e30>
>>ecx; ee8f2ac0 <_end+2e624870/38576e30>
>>esi; f0eef2c0 <_end+30c21070/38576e30>
>>esp; ca585f34 <_end+a2b7ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:30:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:30:01 glitch kernel: c014d8ec
Apr 20 06:30:01 glitch kernel: *pde = 00000000
Apr 20 06:30:01 glitch kernel: Oops: 0002
Apr 20 06:30:01 glitch kernel: CPU:    0
Apr 20 06:30:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:30:01 glitch kernel: EFLAGS: 00010206
Apr 20 06:30:01 glitch kernel: eax: ee8f23c8   ebx: efcf4000   ecx: ee8f23c0   edx: 86b037b2
Apr 20 06:30:01 glitch kernel: esi: f2a31ac0   edi: 401379d8   ebp: ffffffe9   esp: efcf5f34
Apr 20 06:30:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:30:01 glitch kernel: Process cron (pid: 15578, stackpage=efcf5000)
Apr 20 06:30:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 efcf4000 c0142621 c0123086 00000011 efcf4568 
Apr 20 06:30:01 glitch kernel:        00000000 bffff1e0 f0d22f40 c0123408 bffff150 efcf5f70 00000014 0804a078 
Apr 20 06:30:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 efb5b1c0 efcf4000 
Apr 20 06:30:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:30:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:30:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; ee8f23c8 <_end+2e624178/38576e30>
>>ebx; efcf4000 <_end+2fa25db0/38576e30>
>>ecx; ee8f23c0 <_end+2e624170/38576e30>
>>esi; f2a31ac0 <_end+32763870/38576e30>
>>esp; efcf5f34 <_end+2fa27ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:35:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 86b037b6
Apr 20 06:35:01 glitch kernel: c014d8ec
Apr 20 06:35:01 glitch kernel: *pde = 00000000
Apr 20 06:35:01 glitch kernel: Oops: 0002
Apr 20 06:35:01 glitch kernel: CPU:    0
Apr 20 06:35:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:35:01 glitch kernel: EFLAGS: 00010206
Apr 20 06:35:01 glitch kernel: eax: ccfec588   ebx: ca584000   ecx: ccfec580   edx: 86b037b2
Apr 20 06:35:01 glitch kernel: esi: ef761c40   edi: 401379d8   ebp: ffffffe9   esp: ca585f34
Apr 20 06:35:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:35:01 glitch kernel: Process cron (pid: 15579, stackpage=ca585000)
Apr 20 06:35:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 ca584000 c0142621 c0123086 00000011 ca584568 
Apr 20 06:35:01 glitch kernel:        00000000 bffff1e0 f1603e40 c0123408 bffff150 ca585f70 00000014 0804a078 
Apr 20 06:35:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 f34f84c0 ca584000 
Apr 20 06:35:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:35:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:35:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; ccfec588 <_end+cd1e338/38576e30>
>>ebx; ca584000 <_end+a2b5db0/38576e30>
>>ecx; ccfec580 <_end+cd1e330/38576e30>
>>esi; ef761c40 <_end+2f4939f0/38576e30>
>>esp; ca585f34 <_end+a2b7ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:35:15 glitch kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Apr 20 06:35:15 glitch kernel: c014c1fc
Apr 20 06:35:15 glitch kernel: *pde = 00000000
Apr 20 06:35:15 glitch kernel: Oops: 0002
Apr 20 06:35:15 glitch kernel: CPU:    0
Apr 20 06:35:15 glitch kernel: EIP:    0010:[<c014c1fc>]    Not tainted
Apr 20 06:35:15 glitch kernel: EFLAGS: 00210282
Apr 20 06:35:15 glitch kernel: eax: 00000000   ebx: ad54422a   ecx: c5f82f70   edx: ad54423a
Apr 20 06:35:15 glitch kernel: esi: c5f82f40   edi: e8543f2e   ebp: 0000000c   esp: e8543f0c
Apr 20 06:35:15 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:35:15 glitch kernel: Process nmbd (pid: 1459, stackpage=e8543000)
Apr 20 06:35:15 glitch kernel: Stack: c5f82f40 f028eac0 c01d0c22 c5f82f40 ad54422a 00112ffb 3231315b 35393336 
Apr 20 06:35:15 glitch kernel:        ad54005d 00000000 e8542000 00000000 00000000 00000286 e8543f24 00000009 
Apr 20 06:35:15 glitch kernel:        00112ffb c1c0f4f8 00000000 080adda0 bfffeb90 bfffeb48 c01d187d ad54433a 
Apr 20 06:35:15 glitch kernel: Call Trace:    [<c01d0c22>] [<c01d187d>] [<c01d2772>] [<c0122a53>] [<c010737f>]
Apr 20 06:35:15 glitch kernel: Code: 89 48 04 89 46 30 89 51 04 89 4b 10 89 5e 08 8b 74 24 04 8b 


>>EIP; c014c1fc <d_instantiate+2c/50>   <=====

>>ecx; c5f82f70 <_end+5cb4d20/38576e30>
>>esi; c5f82f40 <_end+5cb4cf0/38576e30>
>>edi; e8543f2e <_end+28275cde/38576e30>
>>esp; e8543f0c <_end+28275cbc/38576e30>

Trace; c01d0c22 <sock_map_fd+f2/180>
Trace; c01d187d <sys_socket+3d/60>
Trace; c01d2772 <sys_socketcall+72/260>
Trace; c0122a53 <sys_rt_sigprocmask+143/190>
Trace; c010737f <system_call+33/38>

Code;  c014c1fc <d_instantiate+2c/50>
00000000 <_EIP>:
Code;  c014c1fc <d_instantiate+2c/50>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c014c1ff <d_instantiate+2f/50>
   3:   89 46 30                  mov    %eax,0x30(%esi)
Code;  c014c202 <d_instantiate+32/50>
   6:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c014c205 <d_instantiate+35/50>
   9:   89 4b 10                  mov    %ecx,0x10(%ebx)
Code;  c014c208 <d_instantiate+38/50>
   c:   89 5e 08                  mov    %ebx,0x8(%esi)
Code;  c014c20b <d_instantiate+3b/50>
   f:   8b 74 24 04               mov    0x4(%esp,1),%esi
Code;  c014c20f <d_instantiate+3f/50>
  13:   8b 00                     mov    (%eax),%eax

Apr 20 06:38:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:38:01 glitch kernel: c014d8ec
Apr 20 06:38:01 glitch kernel: *pde = 00000000
Apr 20 06:38:01 glitch kernel: Oops: 0002
Apr 20 06:38:01 glitch kernel: CPU:    0
Apr 20 06:38:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:38:01 glitch kernel: EFLAGS: 00010202
Apr 20 06:38:01 glitch kernel: eax: eda3e3c8   ebx: e8542000   ecx: eda3e3c0   edx: ad544232
Apr 20 06:38:01 glitch kernel: esi: f59097c0   edi: 401379d8   ebp: ffffffe9   esp: e8543f34
Apr 20 06:38:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:38:01 glitch kernel: Process cron (pid: 15580, stackpage=e8543000)
Apr 20 06:38:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 
Apr 20 06:38:01 glitch kernel:        00000000 bffff1e0 f6761ec0 c0123408 bffff150 e8543f70 00000014 0804a078 
Apr 20 06:38:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 efb5b240 e8542000 
Apr 20 06:38:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:38:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:38:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; eda3e3c8 <_end+2d770178/38576e30>
>>ebx; e8542000 <_end+28273db0/38576e30>
>>ecx; eda3e3c0 <_end+2d770170/38576e30>
>>esi; f59097c0 <_end+3563b570/38576e30>
>>esp; e8543f34 <_end+28275ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:38:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:38:01 glitch kernel: c014d8ec
Apr 20 06:38:01 glitch kernel: *pde = 00000000
Apr 20 06:38:01 glitch kernel: Oops: 0002
Apr 20 06:38:01 glitch kernel: CPU:    0
Apr 20 06:38:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:38:01 glitch kernel: EFLAGS: 00010202
Apr 20 06:38:01 glitch kernel: eax: eda3e208   ebx: ca584000   ecx: eda3e200   edx: ad544232
Apr 20 06:38:01 glitch kernel: esi: f6761c40   edi: 401379d8   ebp: ffffffe9   esp: ca585f34
Apr 20 06:38:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:38:01 glitch kernel: Process cron (pid: 15581, stackpage=ca585000)
Apr 20 06:38:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 ca584000 c0142621 c0123086 00000011 ca584568 
Apr 20 06:38:01 glitch kernel:        00000000 bffff1e0 f6761840 c0123408 bffff150 ca585f70 00000014 0804a078 
Apr 20 06:38:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 efb5b240 ca584000 
Apr 20 06:38:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:38:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:38:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; eda3e208 <_end+2d76ffb8/38576e30>
>>ebx; ca584000 <_end+a2b5db0/38576e30>
>>ecx; eda3e200 <_end+2d76ffb0/38576e30>
>>esi; f6761c40 <_end+364939f0/38576e30>
>>esp; ca585f34 <_end+a2b7ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:40:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:40:01 glitch kernel: c014d8ec
Apr 20 06:40:01 glitch kernel: *pde = 00000000
Apr 20 06:40:01 glitch kernel: Oops: 0002
Apr 20 06:40:01 glitch kernel: CPU:    0
Apr 20 06:40:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:40:01 glitch kernel: EFLAGS: 00010206
Apr 20 06:40:01 glitch kernel: eax: dc34ec88   ebx: e8542000   ecx: dc34ec80   edx: ad544232
Apr 20 06:40:01 glitch kernel: esi: f67619c0   edi: 401379d8   ebp: ffffffe9   esp: e8543f34
Apr 20 06:40:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:40:01 glitch kernel: Process cron (pid: 15582, stackpage=e8543000)
Apr 20 06:40:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 
Apr 20 06:40:01 glitch kernel:        00000000 bffff1e0 f6761b40 c0123408 bffff150 e8543f70 00000014 0804a078 
Apr 20 06:40:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 f66e79c0 e8542000 
Apr 20 06:40:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:40:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:40:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; dc34ec88 <_end+1c080a38/38576e30>
>>ebx; e8542000 <_end+28273db0/38576e30>
>>ecx; dc34ec80 <_end+1c080a30/38576e30>
>>esi; f67619c0 <_end+36493770/38576e30>
>>esp; e8543f34 <_end+28275ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:45:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:45:01 glitch kernel: c014d8ec
Apr 20 06:45:01 glitch kernel: *pde = 00000000
Apr 20 06:45:01 glitch kernel: Oops: 0002
Apr 20 06:45:01 glitch kernel: CPU:    0
Apr 20 06:45:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:45:01 glitch kernel: EFLAGS: 00010206
Apr 20 06:45:01 glitch kernel: eax: dc34eac8   ebx: e8542000   ecx: dc34eac0   edx: ad544232
Apr 20 06:45:01 glitch kernel: esi: f048c640   edi: 401379d8   ebp: ffffffe9   esp: e8543f34
Apr 20 06:45:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:45:01 glitch kernel: Process cron (pid: 15583, stackpage=e8543000)
Apr 20 06:45:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 
Apr 20 06:45:01 glitch kernel:        00000000 bffff1e0 f66d96c0 c0123408 bffff150 e8543f70 00000014 0804a078 
Apr 20 06:45:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 f66e79c0 e8542000 
Apr 20 06:45:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:45:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:45:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; dc34eac8 <_end+1c080878/38576e30>
>>ebx; e8542000 <_end+28273db0/38576e30>
>>ecx; dc34eac0 <_end+1c080870/38576e30>
>>esi; f048c640 <_end+301be3f0/38576e30>
>>esp; e8543f34 <_end+28275ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:47:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:47:01 glitch kernel: c014d8ec
Apr 20 06:47:01 glitch kernel: *pde = 00000000
Apr 20 06:47:01 glitch kernel: Oops: 0002
Apr 20 06:47:01 glitch kernel: CPU:    0
Apr 20 06:47:01 glitch kernel: EIP:    0010:[<c014d8ec>]    Not tainted
Apr 20 06:47:01 glitch kernel: EFLAGS: 00010202
Apr 20 06:47:01 glitch kernel: eax: dc34e908   ebx: e8542000   ecx: dc34e900   edx: ad544232
Apr 20 06:47:01 glitch kernel: esi: f7413440   edi: 401379d8   ebp: ffffffe9   esp: e8543f34
Apr 20 06:47:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:47:01 glitch kernel: Process cron (pid: 15584, stackpage=e8543000)
Apr 20 06:47:01 glitch kernel: Stack: c1c1bc00 c0142567 c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 
Apr 20 06:47:01 glitch kernel:        00000000 bffff1e0 f04182c0 c0123408 bffff150 e8543f70 00000014 0804a078 
Apr 20 06:47:01 glitch kernel:        14000000 4004e9d8 00010000 00000000 00001000 40013000 f66e79c0 e8542000 
Apr 20 06:47:01 glitch kernel: Call Trace:    [<c0142567>] [<c0142621>] [<c0123086>] [<c0123408>] [<c010cd57>]
Apr 20 06:47:01 glitch kernel:   [<c0115280>] [<c010737f>]
Apr 20 06:47:01 glitch kernel: Code: 89 42 04 89 51 08 c7 40 04 a0 23 25 c0 a3 a0 23 25 c0 a1 08 


>>EIP; c014d8ec <new_inode+2c/60>   <=====

>>eax; dc34e908 <_end+1c0806b8/38576e30>
>>ebx; e8542000 <_end+28273db0/38576e30>
>>ecx; dc34e900 <_end+1c0806b0/38576e30>
>>esi; f7413440 <_end+371451f0/38576e30>
>>esp; e8543f34 <_end+28275ce4/38576e30>

Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014d8ec <new_inode+2c/60>
00000000 <_EIP>:
Code;  c014d8ec <new_inode+2c/60>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c014d8ef <new_inode+2f/60>
   3:   89 51 08                  mov    %edx,0x8(%ecx)
Code;  c014d8f2 <new_inode+32/60>
   6:   c7 40 04 a0 23 25 c0      movl   $0xc02523a0,0x4(%eax)
Code;  c014d8f9 <new_inode+39/60>
   d:   a3 a0 23 25 c0            mov    %eax,0xc02523a0
Code;  c014d8fe <new_inode+3e/60>
  12:   a1 08 00 00 00            mov    0x8,%eax

Apr 20 06:50:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 201a213a
Apr 20 06:50:01 glitch kernel: c014e022
Apr 20 06:50:01 glitch kernel: *pde = 00000000
Apr 20 06:50:01 glitch kernel: Oops: 0002
Apr 20 06:50:01 glitch kernel: CPU:    0
Apr 20 06:50:01 glitch kernel: EIP:    0010:[<c014e022>]    Not tainted
Apr 20 06:50:01 glitch kernel: EFLAGS: 00010212
Apr 20 06:50:01 glitch kernel: eax: 00000000   ebx: 00000000   ecx: 0000002c   edx: 201a213a
Apr 20 06:50:01 glitch kernel: esi: 201a202a   edi: 201a213a   ebp: ffffffe9   esp: e8543f0c
Apr 20 06:50:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:50:01 glitch kernel: Process cron (pid: 15585, stackpage=e8543000)
Apr 20 06:50:01 glitch kernel: Stack: e8542000 c1c1bc00 c014cd83 201a213a 00000000 000000b0 e8542000 f6761d40 
Apr 20 06:50:01 glitch kernel:        401379d8 c014d8d7 c1c1bc00 c0142567 c1c1bc00 e8542000 c0142621 c0123086 
Apr 20 06:50:01 glitch kernel:        00000011 e8542568 00000000 bffff1e0 f0d22c40 c0123408 bffff150 e8543f70 
Apr 20 06:50:01 glitch kernel: Call Trace:    [<c014cd83>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 06:50:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 06:50:01 glitch kernel: Code: f3 ab eb ae c1 e9 02 89 d7 f3 ab aa eb a4 55 57 56 53 83 ec 


>>EIP; c014e022 <__constant_c_and_count_memset+72/80>   <=====

>>esp; e8543f0c <_end+28275cbc/38576e30>

Trace; c014cd83 <alloc_inode+143/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c014e022 <__constant_c_and_count_memset+72/80>
00000000 <_EIP>:
Code;  c014e022 <__constant_c_and_count_memset+72/80>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c014e024 <__constant_c_and_count_memset+74/80>
   2:   eb ae                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e026 <__constant_c_and_count_memset+76/80>
   4:   c1 e9 02                  shr    $0x2,%ecx
Code;  c014e029 <__constant_c_and_count_memset+79/80>
   7:   89 d7                     mov    %edx,%edi
Code;  c014e02b <__constant_c_and_count_memset+7b/80>
   9:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  c014e02d <__constant_c_and_count_memset+7d/80>
   b:   aa                        stos   %al,%es:(%edi)
Code;  c014e02e <__constant_c_and_count_memset+7e/80>
   c:   eb a4                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e030 <__sync_one+0/142>
   e:   55                        push   %ebp
Code;  c014e031 <__sync_one+1/142>
   f:   57                        push   %edi
Code;  c014e032 <__sync_one+2/142>
  10:   56                        push   %esi
Code;  c014e033 <__sync_one+3/142>
  11:   53                        push   %ebx
Code;  c014e034 <__sync_one+4/142>
  12:   83 ec 00                  sub    $0x0,%esp

Apr 20 06:53:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 06:53:01 glitch kernel: c013062a
Apr 20 06:53:01 glitch kernel: *pde = 00000000
Apr 20 06:53:01 glitch kernel: Oops: 0000
Apr 20 06:53:01 glitch kernel: CPU:    0
Apr 20 06:53:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 06:53:01 glitch kernel: EFLAGS: 00010086
Apr 20 06:53:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 06:53:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: e8543efc
Apr 20 06:53:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:53:01 glitch kernel: Process cron (pid: 15586, stackpage=e8543000)
Apr 20 06:53:01 glitch kernel: Stack: 4013a940 f7ad14dc e8542000 f5b552c0 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 06:53:01 glitch kernel:        000001f0 00000000 e8542000 f5b552c0 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 06:53:01 glitch kernel:        c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 00000000 bffff1e0 
Apr 20 06:53:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 06:53:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 06:53:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; e8543efc <_end+28275cac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 06:53:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 06:53:01 glitch kernel: c013062a
Apr 20 06:53:01 glitch kernel: *pde = 00000000
Apr 20 06:53:01 glitch kernel: Oops: 0000
Apr 20 06:53:01 glitch kernel: CPU:    0
Apr 20 06:53:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 06:53:01 glitch kernel: EFLAGS: 00010082
Apr 20 06:53:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 06:53:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: ca585efc
Apr 20 06:53:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:53:01 glitch kernel: Process cron (pid: 15587, stackpage=ca585000)
Apr 20 06:53:01 glitch kernel: Stack: 4013a940 f7ad1d5c ca584000 efcb8940 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 06:53:01 glitch kernel:        000001f0 00000000 ca584000 efcb8940 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 06:53:01 glitch kernel:        c1c1bc00 ca584000 c0142621 c0123086 00000011 ca584568 00000000 bffff1e0 
Apr 20 06:53:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 06:53:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 06:53:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; ca585efc <_end+a2b7cac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 06:55:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 06:55:01 glitch kernel: c013062a
Apr 20 06:55:01 glitch kernel: *pde = 00000000
Apr 20 06:55:01 glitch kernel: Oops: 0000
Apr 20 06:55:01 glitch kernel: CPU:    0
Apr 20 06:55:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 06:55:01 glitch kernel: EFLAGS: 00010082
Apr 20 06:55:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 06:55:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: e8543efc
Apr 20 06:55:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:55:01 glitch kernel: Process cron (pid: 15588, stackpage=e8543000)
Apr 20 06:55:01 glitch kernel: Stack: 4013a940 f7ad1d5c e8542000 f66b3dc0 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 06:55:01 glitch kernel:        000001f0 00000000 e8542000 f66b3dc0 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 06:55:01 glitch kernel:        c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 00000000 bffff1e0 
Apr 20 06:55:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 06:55:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 06:55:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; e8543efc <_end+28275cac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 06:55:40 glitch kernel:  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
Apr 20 06:55:40 glitch kernel: c014c1fc
Apr 20 06:55:40 glitch kernel: *pde = 00000000
Apr 20 06:55:40 glitch kernel: Oops: 0002
Apr 20 06:55:40 glitch kernel: CPU:    0
Apr 20 06:55:40 glitch kernel: EIP:    0010:[<c014c1fc>]    Not tainted
Apr 20 06:55:40 glitch kernel: EFLAGS: 00210282
Apr 20 06:55:40 glitch kernel: eax: 00000000   ebx: ad54422a   ecx: d6621970   edx: ad54423a
Apr 20 06:55:40 glitch kernel: esi: d6621940   edi: c3aedf2e   ebp: 00000014   esp: c3aedf0c
Apr 20 06:55:40 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:55:40 glitch kernel: Process smbd (pid: 14710, stackpage=c3aed000)
Apr 20 06:55:40 glitch kernel: Stack: d6621940 f0d978c0 c01d0c22 d6621940 ad54422a 00113000 3231315b 30303436 
Apr 20 06:55:40 glitch kernel:        ad54005d 00000000 00200292 c1c0fcfc f63d5140 40306000 c3aedf24 00000009 
Apr 20 06:55:40 glitch kernel:        00113000 f66e72c0 00000000 bffff200 bffff170 bffff108 c01d187d ad54433a 
Apr 20 06:55:40 glitch kernel: Call Trace:    [<c01d0c22>] [<c01d187d>] [<c01d2772>] [<c010737f>]
Apr 20 06:55:40 glitch kernel: Code: 89 48 04 89 46 30 89 51 04 89 4b 10 89 5e 08 8b 74 24 04 8b 


>>EIP; c014c1fc <d_instantiate+2c/50>   <=====

>>ecx; d6621970 <_end+16353720/38576e30>
>>esi; d6621940 <_end+163536f0/38576e30>
>>edi; c3aedf2e <_end+381fcde/38576e30>
>>esp; c3aedf0c <_end+381fcbc/38576e30>

Trace; c01d0c22 <sock_map_fd+f2/180>
Trace; c01d187d <sys_socket+3d/60>
Trace; c01d2772 <sys_socketcall+72/260>
Trace; c010737f <system_call+33/38>

Code;  c014c1fc <d_instantiate+2c/50>
00000000 <_EIP>:
Code;  c014c1fc <d_instantiate+2c/50>   <=====
   0:   89 48 04                  mov    %ecx,0x4(%eax)   <=====
Code;  c014c1ff <d_instantiate+2f/50>
   3:   89 46 30                  mov    %eax,0x30(%esi)
Code;  c014c202 <d_instantiate+32/50>
   6:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c014c205 <d_instantiate+35/50>
   9:   89 4b 10                  mov    %ecx,0x10(%ebx)
Code;  c014c208 <d_instantiate+38/50>
   c:   89 5e 08                  mov    %ebx,0x8(%esi)
Code;  c014c20b <d_instantiate+3b/50>
   f:   8b 74 24 04               mov    0x4(%esp,1),%esi
Code;  c014c20f <d_instantiate+3f/50>
  13:   8b 00                     mov    (%eax),%eax

Apr 20 06:57:02 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 201a213a
Apr 20 06:57:02 glitch kernel: c014e022
Apr 20 06:57:02 glitch kernel: *pde = 00000000
Apr 20 06:57:02 glitch kernel: Oops: 0002
Apr 20 06:57:02 glitch kernel: CPU:    0
Apr 20 06:57:02 glitch kernel: EIP:    0010:[<c014e022>]    Not tainted
Apr 20 06:57:02 glitch kernel: EFLAGS: 00210212
Apr 20 06:57:02 glitch kernel: eax: 00000000   ebx: 00000000   ecx: 0000002c   edx: 201a213a
Apr 20 06:57:02 glitch kernel: esi: 201a202a   edi: 201a213a   ebp: bfffecf8   esp: c3aedee0
Apr 20 06:57:02 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:57:02 glitch kernel: Process smbd (pid: 15589, stackpage=c3aed000)
Apr 20 06:57:02 glitch kernel: Stack: c028a524 c1c1b800 c014cd83 201a213a 00000000 000000b0 c028a524 00000001 
Apr 20 06:57:02 glitch kernel:        00000001 c014d8d7 c1c1b800 c01d0d47 c1c1b800 4020ced0 00000000 c3aedf24 
Apr 20 06:57:02 glitch kernel:        00000000 c028a524 c01d1786 00000000 00030002 000081a4 00000001 00000000 
Apr 20 06:57:02 glitch kernel: Call Trace:    [<c014cd83>] [<c014d8d7>] [<c01d0d47>] [<c01d1786>] [<c01d186b>]
Apr 20 06:57:02 glitch kernel:   [<c01d2772>] [<c0115280>] [<c0107470>] [<c010737f>]
Apr 20 06:57:02 glitch kernel: Code: f3 ab eb ae c1 e9 02 89 d7 f3 ab aa eb a4 55 57 56 53 83 ec 


>>EIP; c014e022 <__constant_c_and_count_memset+72/80>   <=====

>>esp; c3aedee0 <_end+381fc90/38576e30>

Trace; c014cd83 <alloc_inode+143/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c01d0d47 <sock_alloc+17/a0>
Trace; c01d1786 <sock_create+66/120>
Trace; c01d186b <sys_socket+2b/60>
Trace; c01d2772 <sys_socketcall+72/260>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Trace; c010737f <system_call+33/38>

Code;  c014e022 <__constant_c_and_count_memset+72/80>
00000000 <_EIP>:
Code;  c014e022 <__constant_c_and_count_memset+72/80>   <=====
   0:   f3 ab                     repz stos %eax,%es:(%edi)   <=====
Code;  c014e024 <__constant_c_and_count_memset+74/80>
   2:   eb ae                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e026 <__constant_c_and_count_memset+76/80>
   4:   c1 e9 02                  shr    $0x2,%ecx
Code;  c014e029 <__constant_c_and_count_memset+79/80>
   7:   89 d7                     mov    %edx,%edi
Code;  c014e02b <__constant_c_and_count_memset+7b/80>
   9:   f3 ab                     repz stos %eax,%es:(%edi)
Code;  c014e02d <__constant_c_and_count_memset+7d/80>
   b:   aa                        stos   %al,%es:(%edi)
Code;  c014e02e <__constant_c_and_count_memset+7e/80>
   c:   eb a4                     jmp    ffffffb2 <_EIP+0xffffffb2>
Code;  c014e030 <__sync_one+0/142>
   e:   55                        push   %ebp
Code;  c014e031 <__sync_one+1/142>
   f:   57                        push   %edi
Code;  c014e032 <__sync_one+2/142>
  10:   56                        push   %esi
Code;  c014e033 <__sync_one+3/142>
  11:   53                        push   %ebx
Code;  c014e034 <__sync_one+4/142>
  12:   83 ec 00                  sub    $0x0,%esp

Apr 20 06:57:02 glitch kernel:  <1>Unable to handle kernel paging request at virtual address ad544236
Apr 20 06:57:02 glitch kernel: c014de6e
Apr 20 06:57:02 glitch kernel: *pde = 00000000
Apr 20 06:57:02 glitch kernel: Oops: 0002
Apr 20 06:57:02 glitch kernel: CPU:    0
Apr 20 06:57:02 glitch kernel: EIP:    0010:[<c014de6e>]    Not tainted
Apr 20 06:57:02 glitch kernel: EFLAGS: 00210246
Apr 20 06:57:02 glitch kernel: eax: ec8c1908   ebx: ec8c1900   ecx: cd82fac8   edx: ad544232
Apr 20 06:57:02 glitch kernel: esi: c0287a60   edi: c1c1b800   ebp: e024a240   esp: c3aedd44
Apr 20 06:57:02 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 06:57:02 glitch kernel: Process smbd (pid: 15589, stackpage=c3aed000)
Apr 20 06:57:02 glitch kernel: Stack: 00000000 ec8c1a10 c1c1d200 e024a240 ec8c1900 ec8c1900 c014b9e0 ec8c1900 
Apr 20 06:57:02 glitch kernel:        f621f0c0 f621f0c0 c1c1d200 c01399d5 e024a240 f621f0c0 f621f0c0 f67153c0 
Apr 20 06:57:02 glitch kernel:        00000000 00000001 c01380ad f621f0c0 f67153c0 001effff 00000005 f67153c0 
Apr 20 06:57:02 glitch kernel: Call Trace:    [<c014b9e0>] [<c01399d5>] [<c01380ad>] [<c011bb4d>] [<c011c238>]
Apr 20 06:57:02 glitch kernel:   [<c01079f2>] [<c0115534>] [<c0168d4b>] [<c0161aef>] [<c01686d5>] [<c012baf8>]
Apr 20 06:57:02 glitch kernel:   [<c0115280>] [<c0107470>] [<c014e022>] [<c014cd83>] [<c014d8d7>] [<c01d0d47>]
Apr 20 06:57:02 glitch kernel:   [<c01d1786>] [<c01d186b>] [<c01d2772>] [<c0115280>] [<c0107470>] [<c010737f>]
Apr 20 06:57:02 glitch kernel: Code: 89 4a 04 89 11 89 40 04 83 8b f8 00 00 00 10 89 43 08 ff 0d 


>>EIP; c014de6e <iput+19e/210>   <=====

>>eax; ec8c1908 <_end+2c5f36b8/38576e30>
>>ebx; ec8c1900 <_end+2c5f36b0/38576e30>
>>ecx; cd82fac8 <_end+d561878/38576e30>
>>esi; c0287a60 <sockfs_ops+0/50>
>>edi; c1c1b800 <_end+194d5b0/38576e30>
>>ebp; e024a240 <_end+1ff7bff0/38576e30>
>>esp; c3aedd44 <_end+381faf4/38576e30>

Trace; c014b9e0 <dput+a0/150>
Trace; c01399d5 <fput+d5/130>
Trace; c01380ad <filp_close+4d/80>
Trace; c011bb4d <put_files_struct+5d/d0>
Trace; c011c238 <do_exit+a8/240>
Trace; c01079f2 <die+72/80>
Trace; c0115534 <do_page_fault+2b4/4df>
Trace; c0168d4b <journal_dirty_metadata+13b/1d0>
Trace; c0161aef <ext3_do_update_inode+16f/3e0>
Trace; c01686d5 <journal_get_write_access+55/80>
Trace; c012baf8 <filemap_nopage+198/210>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Trace; c014e022 <__constant_c_and_count_memset+72/80>
Trace; c014cd83 <alloc_inode+143/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c01d0d47 <sock_alloc+17/a0>
Trace; c01d1786 <sock_create+66/120>
Trace; c01d186b <sys_socket+2b/60>
Trace; c01d2772 <sys_socketcall+72/260>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c0107470 <error_code+34/3c>
Trace; c010737f <system_call+33/38>

Code;  c014de6e <iput+19e/210>
00000000 <_EIP>:
Code;  c014de6e <iput+19e/210>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c014de71 <iput+1a1/210>
   3:   89 11                     mov    %edx,(%ecx)
Code;  c014de73 <iput+1a3/210>
   5:   89 40 04                  mov    %eax,0x4(%eax)
Code;  c014de76 <iput+1a6/210>
   8:   83 8b f8 00 00 00 10      orl    $0x10,0xf8(%ebx)
Code;  c014de7d <iput+1ad/210>
   f:   89 43 08                  mov    %eax,0x8(%ebx)
Code;  c014de80 <iput+1b0/210>
  12:   ff 0d 00 00 00 00         decl   0x0

Apr 20 07:00:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 07:00:01 glitch kernel: c013062a
Apr 20 07:00:01 glitch kernel: *pde = 00000000
Apr 20 07:00:01 glitch kernel: Oops: 0000
Apr 20 07:00:01 glitch kernel: CPU:    0
Apr 20 07:00:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 07:00:01 glitch kernel: EFLAGS: 00010082
Apr 20 07:00:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 07:00:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: c3aedefc
Apr 20 07:00:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 07:00:01 glitch kernel: Process cron (pid: 15590, stackpage=c3aed000)
Apr 20 07:00:01 glitch kernel: Stack: 4013a940 f7ad155c c3aec000 f621f0c0 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 07:00:01 glitch kernel:        000001f0 00000000 c3aec000 f621f0c0 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 07:00:01 glitch kernel:        c1c1bc00 c3aec000 c0142621 c0123086 00000011 c3aec568 00000000 bffff1e0 
Apr 20 07:00:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 07:00:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 07:00:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; c3aedefc <_end+381fcac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 07:00:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 07:00:01 glitch kernel: c013062a
Apr 20 07:00:01 glitch kernel: *pde = 00000000
Apr 20 07:00:01 glitch kernel: Oops: 0000
Apr 20 07:00:01 glitch kernel: CPU:    0
Apr 20 07:00:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 07:00:01 glitch kernel: EFLAGS: 00010086
Apr 20 07:00:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 07:00:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: e8543efc
Apr 20 07:00:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 07:00:01 glitch kernel: Process cron (pid: 15591, stackpage=e8543000)
Apr 20 07:00:01 glitch kernel: Stack: 4013a940 f7ad1d5c e8542000 f048c8c0 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 07:00:01 glitch kernel:        000001f0 00000000 e8542000 f048c8c0 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 07:00:01 glitch kernel:        c1c1bc00 e8542000 c0142621 c0123086 00000011 e8542568 00000000 bffff1e0 
Apr 20 07:00:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 07:00:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 07:00:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; e8543efc <_end+28275cac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)

Apr 20 07:02:01 glitch kernel:  <1>Unable to handle kernel paging request at virtual address 5ccaa4f8
Apr 20 07:02:01 glitch kernel: c013062a
Apr 20 07:02:01 glitch kernel: *pde = 00000000
Apr 20 07:02:01 glitch kernel: Oops: 0000
Apr 20 07:02:01 glitch kernel: CPU:    0
Apr 20 07:02:01 glitch kernel: EIP:    0010:[<c013062a>]    Not tainted
Apr 20 07:02:01 glitch kernel: EFLAGS: 00010082
Apr 20 07:02:01 glitch kernel: eax: 9f2c2138   ebx: 9f2c2138   ecx: e01a2000   edx: 00000000
Apr 20 07:02:01 glitch kernel: esi: c1c0ff84   edi: 00000246   ebp: 000001f0   esp: c3aedefc
Apr 20 07:02:01 glitch kernel: ds: 0018   es: 0018   ss: 0018
Apr 20 07:02:01 glitch kernel: Process cron (pid: 15592, stackpage=c3aed000)
Apr 20 07:02:01 glitch kernel: Stack: 4013a940 f7ad1d5c c3aec000 f75f0140 c1c1bc00 ffffffe9 c014cd5f c1c0ff84 
Apr 20 07:02:01 glitch kernel:        000001f0 00000000 c3aec000 f75f0140 401379d8 c014d8d7 c1c1bc00 c0142567 
Apr 20 07:02:01 glitch kernel:        c1c1bc00 c3aec000 c0142621 c0123086 00000011 c3aec568 00000000 bffff1e0 
Apr 20 07:02:01 glitch kernel: Call Trace:    [<c014cd5f>] [<c014d8d7>] [<c0142567>] [<c0142621>] [<c0123086>]
Apr 20 07:02:01 glitch kernel:   [<c0123408>] [<c010cd57>] [<c0115280>] [<c010737f>]
Apr 20 07:02:01 glitch kernel: Code: 8b 44 81 18 0f af 5e 18 89 41 14 03 59 0c 40 74 18 57 9d 89 


>>EIP; c013062a <__kmem_cache_alloc+4a/f0>   <=====

>>ecx; e01a2000 <_end+1fed3db0/38576e30>
>>esi; c1c0ff84 <_end+1941d34/38576e30>
>>esp; c3aedefc <_end+381fcac/38576e30>

Trace; c014cd5f <alloc_inode+11f/150>
Trace; c014d8d7 <new_inode+17/60>
Trace; c0142567 <get_pipe_inode+17/a0>
Trace; c0142621 <do_pipe+31/240>
Trace; c0123086 <do_sigaction+e6/120>
Trace; c0123408 <sys_rt_sigaction+a8/c0>
Trace; c010cd57 <sys_pipe+17/50>
Trace; c0115280 <do_page_fault+0/4df>
Trace; c010737f <system_call+33/38>

Code;  c013062a <__kmem_cache_alloc+4a/f0>
00000000 <_EIP>:
Code;  c013062a <__kmem_cache_alloc+4a/f0>   <=====
   0:   8b 44 81 18               mov    0x18(%ecx,%eax,4),%eax   <=====
Code;  c013062e <__kmem_cache_alloc+4e/f0>
   4:   0f af 5e 18               imul   0x18(%esi),%ebx
Code;  c0130632 <__kmem_cache_alloc+52/f0>
   8:   89 41 14                  mov    %eax,0x14(%ecx)
Code;  c0130635 <__kmem_cache_alloc+55/f0>
   b:   03 59 0c                  add    0xc(%ecx),%ebx
Code;  c0130638 <__kmem_cache_alloc+58/f0>
   e:   40                        inc    %eax
Code;  c0130639 <__kmem_cache_alloc+59/f0>
   f:   74 18                     je     29 <_EIP+0x29>
Code;  c013063b <__kmem_cache_alloc+5b/f0>
  11:   57                        push   %edi
Code;  c013063c <__kmem_cache_alloc+5c/f0>
  12:   9d                        popf   
Code;  c013063d <__kmem_cache_alloc+5d/f0>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.

--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Description: .config-2.4.21-pre7
Content-Disposition: attachment; filename="config-2.4.21-pre7"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
CONFIG_MK7=y
# CONFIG_MK8 is not set
# CONFIG_MELAN is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
# CONFIG_HIGHIO is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_SMP is not set
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
# CONFIG_ISA is not set
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
# CONFIG_HOTPLUG_PCI_ACPI is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
# CONFIG_PNP is not set
# CONFIG_ISAPNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_CISS_SCSI_TAPE is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_BLK_STATS=y

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_LVM is not set

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
# CONFIG_NETLINK_DEV is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set

#
#  
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set

#
# Appletalk devices
#
# CONFIG_DEV_APPLETALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI support
#
CONFIG_SCSI=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_SD_EXTRA_DEVS=40
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_DEBUG_QUEUES is not set
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=128
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_PROBE_EISA_VL is not set
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_ELMC is not set
# CONFIG_ELMC_II is not set
CONFIG_VORTEX=m
# CONFIG_TYPHOON is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
# CONFIG_PPPOE is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Input core support
#
CONFIG_INPUT=y
# CONFIG_INPUT_KEYBDEV is not set
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set
# CONFIG_MK712_MOUSE is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
# CONFIG_INPUT_NS558 is not set
# CONFIG_INPUT_LIGHTNING is not set
# CONFIG_INPUT_PCIGAME is not set
# CONFIG_INPUT_CS461X is not set
CONFIG_INPUT_EMU10K1=m
# CONFIG_INPUT_SERIO is not set
# CONFIG_INPUT_SERPORT is not set

#
# Joysticks
#
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
CONFIG_INPUT_SIDEWINDER=m
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_IPMI_PANIC_EVENT is not set
# CONFIG_IPMI_DEVICE_INTERFACE is not set
# CONFIG_IPMI_KCS is not set
# CONFIG_IPMI_WATCHDOG is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_SCx200_GPIO is not set
# CONFIG_AMD_RNG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AMD_PM768 is not set
CONFIG_NVRAM=m
CONFIG_RTC=m
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=m
# CONFIG_AGP_INTEL is not set
# CONFIG_AGP_I810 is not set
# CONFIG_AGP_VIA is not set
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD_8151 is not set
# CONFIG_AGP_SIS is not set
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
# CONFIG_DRM_OLD is not set

#
# DRM 4.1 drivers
#
CONFIG_DRM_NEW=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I810_XFREE_41 is not set
# CONFIG_DRM_I830 is not set
CONFIG_DRM_MGA=m
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_REISERFS_FS is not set
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
CONFIG_EXT3_FS=y
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
# CONFIG_EFS_FS is not set
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_JFS_FS is not set
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set
# CONFIG_DEVPTS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_NFS_FS is not set
# CONFIG_NFS_V3 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFSD is not set
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
# CONFIG_SUNRPC is not set
# CONFIG_LOCKD is not set
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=m
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
# CONFIG_USB_OHCI is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_BLUETOOTH is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_STORAGE is not set
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set
# CONFIG_USB_HIDINPUT is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set

#
# USB Imaging devices
#
CONFIG_USB_DC2XX=m
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#

#
#   Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
# CONFIG_USB_SERIAL_DEBUG is not set
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
CONFIG_USB_SERIAL_VISOR=m
# CONFIG_USB_SERIAL_IPAQ is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_KLSI is not set
# CONFIG_USB_SERIAL_KOBIL_SCT is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_RIO500=m
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_IOVIRT is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_FRAME_POINTER is not set

#
# Library routines
#
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--p4qYPpj5QlsIQJ0K--
