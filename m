Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269000AbRHGQUb>; Tue, 7 Aug 2001 12:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268996AbRHGQUV>; Tue, 7 Aug 2001 12:20:21 -0400
Received: from cx838204-a.alsv1.occa.home.com ([24.16.83.66]:8065 "HELO
	shakti.rupa.com") by vger.kernel.org with SMTP id <S269000AbRHGQUD>;
	Tue, 7 Aug 2001 12:20:03 -0400
To: linux-kernel@vger.kernel.org
Subject: Ooops in try_to_swap_out (v2.4.5 + xfs)
From: Rupa Schomaker <rupa-list+linux-kernel@rupa.com>
Mail-Copies-To: never
Date: Tue, 07 Aug 2001 09:20:12 -0700
Message-ID: <m3lmkvetab.fsf@shakti.rupa.com>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Copyleft)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

I received the following oops (below).  I'm running swap on a RAID 1
MD (/dev/md2).  If you need any other info, please let me know.

Aug  7 00:46:28 shakti kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Aug  7 00:46:28 shakti kernel:  printing eip:
Aug  7 00:46:28 shakti kernel: c0112d63
Aug  7 00:46:28 shakti kernel: *pde = 00000000
Aug  7 00:46:28 shakti kernel: Oops: 0000
Aug  7 00:46:28 shakti kernel: CPU:    0
Aug  7 00:46:28 shakti kernel: EIP:    0010:[__wake_up+67/208]
Aug  7 00:46:28 shakti kernel: EFLAGS: 00010006
Aug  7 00:46:28 shakti kernel: eax: c984d078   ebx: c98470c0   ecx: 00000000   edx: 00000003
Aug  7 00:46:28 shakti kernel: esi: c184d07c   edi: c184d07c   ebp: c1891eec   esp: c1891ecc
Aug  7 00:46:28 shakti kernel: ds: 0018   es: 0018   ss: 0018
Aug  7 00:46:28 shakti kernel: Process kswapd (pid: 3, stackpage=c1891000)
Aug  7 00:46:28 shakti kernel: Stack: c184d054 c184d07c 1f401005 c984d078 c184d080 00000001 00000282 000000
03
Aug  7 00:46:28 shakti kernel:        dddec1c4 c012b56c dddec1c4 08071000 00000003 080aa000 00f71900 c012b7
09
Aug  7 00:46:28 shakti kernel:        c8319740 ded31440 08071000 dddec1c4 c184d054 080aa000 08069000 ddc540
80
Aug  7 00:46:28 shakti kernel: Call Trace: [try_to_swap_out+252/448] [swap_out_pmd+217/256] [swap_out_vma+1
52/224] [swap_out_mm+76/128] [swap_out+179/224] [refill_inactive+125/160] [do_try_to_free_pages+66/96]
Aug  7 00:46:28 shakti kernel:        [kswapd+83/224] [kernel_thread+40/64]
Aug  7 00:46:28 shakti kernel:
Aug  7 00:46:28 shakti kernel: Code: 8b 01 85 45 fc 74 66 31 c0 9c 5e fa f0 fe 0d 00 f0 3e c0 0f

Running it through ksymoops:

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c029ccf0, System.map says c0155670.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000000
c0112d63
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0112d63>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010006
eax: c184d054   ebx: c98470c0     ecx: 00000000       edx: 00000000
esi: c184d07c   edi: c184d07c     ebp: c1781eec       esp: c1781ecc
ds: 0018    es: 0018    ss: 0018
Stack: c184d054 c184d07c 1f401005 c984d078 c184d080 00000001 00000282 00000003
       dddec1c4 c012d56c dddec1c4 08071000 00000003 080aa000 00f71900 c012b709
       c8319740 ded31440 08071000 dddec1c4 c184d054 080aa000 08069000 ddc54080
Call Trace: [<c012b56c>] [<c012b709>] [<c012b7c8>] [<c012b85c>] [<c012b943>] [<c012c91d>] [<c012c982>]
            [<c012c9f3>] [<c0105768>]
Code: 8b 01 85 45 fc 74 66 31 c0 9c 5e fa f0 fe 0d 00 f0 3e c0 0f

>>EIP; c0112d63 <__wake_up+43/d0>   <=====
Trace; c012b56c <try_to_swap_out+fc/1c0>
Trace; c012b709 <swap_out_pmd+d9/100>
Trace; c012b7c8 <swap_out_vma+98/e0>
Trace; c012b85c <swap_out_mm+4c/80>
Trace; c012b943 <swap_out+b3/e0>
Trace; c012c91d <refill_inactive+7d/a0>
Trace; c012c982 <do_try_to_free_pages+42/60>
Trace; c012c9f3 <kswapd+53/e0>
Trace; c0105768 <kernel_thread+28/40>
Code;  c0112d63 <__wake_up+43/d0>
00000000 <_EIP>:
Code;  c0112d63 <__wake_up+43/d0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0112d65 <__wake_up+45/d0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0112d68 <__wake_up+48/d0>
   5:   74 66                     je     6d <_EIP+0x6d> c0112dd0 <__wake_up+b0/d0>
Code;  c0112d6a <__wake_up+4a/d0>
   7:   31 c0                     xor    %eax,%eax
Code;  c0112d6c <__wake_up+4c/d0>
   9:   9c                        pushf
Code;  c0112d6d <__wake_up+4d/d0>
   a:   5e                        pop    %esi
Code;  c0112d6e <__wake_up+4e/d0>
   b:   fa                        cli
Code;  c0112d6f <__wake_up+4f/d0>
   c:   f0 fe 0d 00 f0 3e c0      lock decb 0xc03ef000
Code;  c0112d76 <__wake_up+56/d0>
  13:   0f 00 00                  sldt   (%eax)

- -- 
- -rupa

-----BEGIN PGP SIGNATURE-----
Version: 2.6.3ia
Charset: noconv
Comment: Processed by Mailcrypt 3.5.5, an Emacs/PGP interface

iQEVAwUBO3AVGXHDM4ucEopdAQGrGwgAuOuVsJibISUhIRvpHJQzvSNDG6QKd6gc
bqD/I10ig2Rz6Vdvj90UQdRCsrvQKiX+95zuV+35QvaqaAUNXVWqioU0OjcUCPsc
7uWZqSeD2tMdj49eWZrvawDED5YYZC6XdxQKjG77OwYsjdYC4GyV1WXbEhr5h5aD
KQRRwfBWyUWDejTZjvHcJEkrHjkBFA8awpcEi0zroeBvxIHMFP9wsijcj3yddXf7
uPhQhvSkrzyobV/IcLz38pKvOSPY/8xIK9HAcQpAvy90czTZhjScSgWGBW47vt8K
D6VBgy5UHUYMpFGF7mvdG1NNAF97vYMA67xtfAcLMyHuFL9dhz3PdA==
=1OBi
-----END PGP SIGNATURE-----
