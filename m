Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbRGIDUU>; Sun, 8 Jul 2001 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbRGIDUK>; Sun, 8 Jul 2001 23:20:10 -0400
Received: from zeus.kernel.org ([209.10.41.242]:18661 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266989AbRGIDUD>;
	Sun, 8 Jul 2001 23:20:03 -0400
Date: Sat, 7 Jul 2001 23:26:44 -0600
From: Lawrence Gold <gold@shell.aros.net>
To: linux-kernel@vger.kernel.org
Subject: Oopses under 2.4.5/2.4.6 w/ Athlon Thunderbird
Message-ID: <20010707232644.A30026@shell.aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running 2.4.6 with the latest ext3 patch on an Expo 8kta3 motherboard
with an Athlon Thunderbird 1200MHz CPU.  My kernel is compiled with the
CPU type set to "Athlon" but the 3DNOW line in arch/i386/config.in is
commented out.  The compiler used was egcs-1.1.2.

For the past several weeks, I have been experiencing occasional oopses,
but only when running mplayer (http://192.190.173.45/homepage/news.html),
and even with vanilla 2.4.5 and 2.4.6 kernels.  I've run the player with
3dnow code disabled, but I still got oopses.

Below is the latest oops run through ksymoops.  I've tried several things
to try to alleviate the problem to no avail:

- Increased the core voltage of the CPU.
- Loaded the fail-safe defaults in the BIOS.
- Ran memtest86 with no problems found.
- Checked the CPU and case temperature from the BIOS and they were well
  within limits.  (But I understand that this is an inaccurate way to
  gauge the temperature.)

Thanks for any advice you can offer.

P.S. This is the first time I remember seeing the oops occur in process
sh; usually it showed the errant process as gnome-terminal.

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map (specified)

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Unable to handle kernel paging request at virtual address 38343031
c0143490
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[sys_getcwd+32/416]
EFLAGS: 00010203
eax: cff9ba30   ebx: 38343021   ecx: 0000000f   edx: cff80000
esi: 0028c69d   edi: c2d85f68   ebp: 38343031   esp: c2d85f08
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 14775, stackpage=c2d85000)
Stack: 0028c69d 00000000 c2d85f68 c2d85fa4 cff9ba30 caebf009 0028c69d 
00000003 
c013b230 cf5abb40 c2d85f68 0028c69d c013b962 cf5abb40 c2d85f68 00000000 
caebf000 00000000 c2d85fa4 bfffdca0 c2d84000 c2d84000 00000009 00000000 
Call Trace: [path_walk+400/1840] [path_init+50/304] [open_namei+732/1296]
[copy_strings+214/464] [sys_lseek+83/160] [system_call+51/56] 
Code: 8b 6d 00 8b 74 24 18 39 73 44 75 7c 8b 74 24 24 39 73 0c 75 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000003 Before first symbol
   3:   8b 74 24 18               mov    0x18(%esp,1),%esi
Code;  00000007 Before first symbol
   7:   39 73 44                  cmp    %esi,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 7c                     jne    88 <_EIP+0x88> 00000088 Before
first symbol
Code;  0000000c Before first symbol
   c:   8b 74 24 24               mov    0x24(%esp,1),%esi
Code;  00000010 Before first symbol
  10:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  00000013 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000015 Before
first symbol


1 warning issued.  Results may not be reliable.
