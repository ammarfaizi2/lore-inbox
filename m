Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSLABrl>; Sat, 30 Nov 2002 20:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSLABrl>; Sat, 30 Nov 2002 20:47:41 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:32661 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261356AbSLABrj>;
	Sat, 30 Nov 2002 20:47:39 -0500
Date: Sun, 1 Dec 2002 02:55:03 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.20-jam0
Message-ID: <20021201015503.GA1719@werewolf.able.es>
References: <20021129233807.GA1610@werewolf.able.es> <20021130175048.GF28164@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021130175048.GF28164@dualathlon.random>; from andrea@suse.de on Sat, Nov 30, 2002 at 18:50:48 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.11.30 Andrea Arcangeli wrote:
>On Sat, Nov 30, 2002 at 12:38:07AM +0100, J.A. Magallon wrote:
>> - reverted the fast-pte part of -aa. Still have to try again
>>   to see if it is more stable now.
>
>AFIK this was reproduced by Srihari on nohighmem so it must be that
>somebody is calling pgd_free_fast on a pgd that cannot be re-used.
>Can you try this patch on top of 2.4.20rc2aa1? (or jam0 after backing
>out the fast-pte removal that would otherwise forbid the debugging check
>to trigger)
>

I suppose this will be useless (tainted ;))
BTW, what does mean the symbol address mismatch ?

ksymoops 2.4.8 on i686 2.4.20-jam1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-jam1/ (default)
     -m /boot/System.map-2.4.20-jam1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol __nvsym03120  , nvdriver says 692dac20, /lib/modules/2.4.20-jam1/video/nvdriver.o says 692d3560.  Ignoring /lib/modules/2.4.20-jam1/video/nvdriver.o entry
Dec  1 02:35:57 werewolf kernel: Unable to handle kernel paging request at virtual address 47000be8
Dec  1 02:35:57 werewolf kernel: 4012060d
Dec  1 02:35:57 werewolf kernel: *pde = 070001e3
Dec  1 02:35:57 werewolf kernel: Oops: 0000 2.4.20-jam1 #4 SMP dom dic 1 00:44:09 CET 2002
Dec  1 02:35:57 werewolf kernel: CPU:    0
Dec  1 02:35:57 werewolf kernel: EIP:    0010:[dup_mmap+285/458]    Tainted: P 
Dec  1 02:35:57 werewolf kernel: EIP:    0010:[<4012060d>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
Dec  1 02:35:57 werewolf kernel: EFLAGS: 00010202
Dec  1 02:35:57 werewolf kernel: eax: 42527780   ebx: 4387b6e0   ecx: 00000000   edx: 47000be0
Dec  1 02:35:57 werewolf kernel: esi: 467a5544   edi: 4387b724   ebp: 467a5500   esp: 4504bf28
Dec  1 02:35:57 werewolf kernel: ds: 0018   es: 0018   ss: 0018
Dec  1 02:35:57 werewolf kernel: Process rc (pid: 3543, stackpage=4504b000)
Dec  1 02:35:57 werewolf kernel: Stack: 419afeac 000001f0 46c62a80 4504a000 46c62a8c 42527820 4252783c 4252780c 
Dec  1 02:35:57 werewolf kernel:        42527780 4011f65c 42527780 000001f0 fffffff4 5046e000 43273a64 42cd0aa4 
Dec  1 02:35:57 werewolf kernel:        00000011 4011fdfb 00000011 5046e000 4504bf98 4504bf98 4504bfa8 00000000 
Dec  1 02:35:57 werewolf kernel: Call Trace:    [copy_mm+252/352] [do_fork+843/2272] [sys_fork+39/48] [system_call+51/56]
Dec  1 02:35:57 werewolf kernel: Call Trace:    [<4011f65c>] [<4011fdfb>] [<40107d07>] [<40109777>]
Dec  1 02:35:57 werewolf kernel: Code: 8b 42 08 8b 48 08 f0 ff 42 14 f6 43 15 08 74 07 f0 ff 89 18 


>>EIP; 4012060d <dup_mmap+11d/1ca>   <=====

>>eax; 42527780 <[videodev].data.end+c8341/110c21>
>>ebx; 4387b6e0 <[8390].rodata.end+d00291/34bcc11>
>>edx; 47000be0 <[mii].text.end+c8e404/122d884>
>>esi; 467a5544 <[mii].text.end+432d68/122d884>
>>edi; 4387b724 <[8390].rodata.end+d002d5/34bcc11>
>>ebp; 467a5500 <[mii].text.end+432d24/122d884>
>>esp; 4504bf28 <[8390].rodata.end+24d0ad9/34bcc11>

Trace; 4011f65c <copy_mm+fc/160>
Trace; 4011fdfb <do_fork+34b/8e0>
Trace; 40107d07 <sys_fork+27/30>
Trace; 40109777 <system_call+33/38>

Code;  4012060d <dup_mmap+11d/1ca>
00000000 <_EIP>:
Code;  4012060d <dup_mmap+11d/1ca>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  40120610 <dup_mmap+120/1ca>
   3:   8b 48 08                  mov    0x8(%eax),%ecx
Code;  40120613 <dup_mmap+123/1ca>
   6:   f0 ff 42 14               lock incl 0x14(%edx)
Code;  40120617 <dup_mmap+127/1ca>
   a:   f6 43 15 08               testb  $0x8,0x15(%ebx)
Code;  4012061b <dup_mmap+12b/1ca>
   e:   74 07                     je     17 <_EIP+0x17> 40120624 <dup_mmap+134/1ca>
Code;  4012061d <dup_mmap+12d/1ca>
  10:   f0 ff 89 18 00 00 00      lock decl 0x18(%ecx)


2 warnings issued.  Results may not be reliable.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
