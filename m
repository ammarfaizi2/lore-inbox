Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSHUPOS>; Wed, 21 Aug 2002 11:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHUPOS>; Wed, 21 Aug 2002 11:14:18 -0400
Received: from moutng.kundenserver.de ([212.227.126.176]:3038 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S318365AbSHUPOP>; Wed, 21 Aug 2002 11:14:15 -0400
Date: Wed, 21 Aug 2002 19:16:40 +0200
To: linux-kernel@vger.kernel.org
Subject: oops while fixating cd-r: 2.4.18,aha152x,phillips cdd2600
Message-ID: <20020821171640.GE709@hexenkessel.bc>
Reply-To: bd@bc-bd.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: bd@bc-bd.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

i can reproduce an oops on 2.4.18 when trying to fixate a CD-R. i use
the Phillips CD2600 CD-Writer attached to an old ISA aha1510 SCSI card.
cdrecord was used (1.10) to create the cd.

i changed all cables to assure that they are ok and my MO (FUJUTSU)
works fine with the controler. the writer works fine with windows so i
dont think that either the controler nor the writer is broken.

the oops's are from my i586 machine, running debian/testing. i can not
test this issue wihh the 2.4.19 kernel, since it hangs on boottime
during partitionchecking, even with -ac4.

i tested the writer on my p3 with an adaptec controler useing the
NCR53C8XX module with kernel 2.4.18. there i can _not_ produce an oops,
but i can only fixate a cd-r one time per module load. i even tried the
open tray, close tray trick descriped on the cdrecord page. after
un- and reloading the module i can fixate a cd again. the problem
persists with 2.4.19 (this ones debian/testing too).

by
	bd
-- 
PGP/GPG Key at http://bc-bd.org/pgp/bd@bc-bd.org.asc
----------------------------------------------------
If you've done six impossible things before breakfast, why not round it
off with dinner at Milliway's, the restaurant at the end of the universe?
		-- Douglas Adams, "The Restaurant at the End of the Universe"

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.decoded"

ksymoops 2.4.6 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 20 18:31:09 hexenkessel kernel: c6a3b67c
Aug 20 18:31:09 hexenkessel kernel: Oops: 0000
Aug 20 18:31:09 hexenkessel kernel: CPU:    0
Aug 20 18:31:09 hexenkessel kernel: EIP:    0010:[<c6a3b67c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 20 18:31:09 hexenkessel kernel: EFLAGS: 00010086
Aug 20 18:31:09 hexenkessel kernel: eax: 00000000   ebx: c3871c00   ecx: c5817480   edx: c56fd800
Aug 20 18:31:09 hexenkessel kernel: esi: c56fd800   edi: 00000086   ebp: c56fd884   esp: c32d7f4c
Aug 20 18:31:09 hexenkessel kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 18:31:09 hexenkessel kernel: Process scsi_eh_0 (pid: 1538, stackpage=c32d7000)
Aug 20 18:31:09 hexenkessel kernel: Stack: 00000286 c56fd800 00000000 c3871c00 c6a3b72c c56fd800 c56fd884 c56fd800 
Aug 20 18:31:09 hexenkessel kernel:        c56fd87c 00000286 c3871c00 c6a213af c3871c00 00002003 00000000 c6a219f7 
Aug 20 18:31:09 hexenkessel kernel:        c3871c00 c32d6000 c32d7fdc c32d7fdc c56fd800 c32d7fe8 c32d7fe8 c5817e80 
Aug 20 18:31:09 hexenkessel kernel: Call Trace: [<c6a3b72c>] [<c6a213af>] [<c6a219f7>] [<c6a21ecb>] [kernel_thread+40/56] 
Aug 20 18:31:09 hexenkessel kernel: Code: 8b 30 8b 43 0c f6 80 ef 00 00 00 10 75 70 8b 4d 00 31 d2 eb 


>>EIP; c6a3b67c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====

>>ebx; c3871c00 <_end+36330b4/65c34b4>
>>ecx; c5817480 <_end+55d8934/65c34b4>
>>edx; c56fd800 <_end+54becb4/65c34b4>
>>esi; c56fd800 <_end+54becb4/65c34b4>
>>ebp; c56fd884 <_end+54bed38/65c34b4>
>>esp; c32d7f4c <_end+3099400/65c34b4>

Trace; c6a3b72c <[aha152x]aha152x_bus_reset+20/a0>
Trace; c6a213af <[scsi_mod]scsi_try_bus_reset+3f/90>
Trace; c6a219f7 <[scsi_mod]scsi_unjam_host+357/758>
Trace; c6a21ecb <[scsi_mod]scsi_error_handler+d3/12b>

Code;  c6a3b67c <[aha152x]free_hard_reset_SCs+1c/ac>
00000000 <_EIP>:
Code;  c6a3b67c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====
   0:   8b 30                     mov    (%eax),%esi   <=====
Code;  c6a3b67e <[aha152x]free_hard_reset_SCs+1e/ac>
   2:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c6a3b681 <[aha152x]free_hard_reset_SCs+21/ac>
   5:   f6 80 ef 00 00 00 10      testb  $0x10,0xef(%eax)
Code;  c6a3b688 <[aha152x]free_hard_reset_SCs+28/ac>
   c:   75 70                     jne    7e <_EIP+0x7e> c6a3b6fa <[aha152x]free_hard_reset_SCs+9a/ac>
Code;  c6a3b68a <[aha152x]free_hard_reset_SCs+2a/ac>
   e:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c6a3b68d <[aha152x]free_hard_reset_SCs+2d/ac>
  11:   31 d2                     xor    %edx,%edx
Code;  c6a3b68f <[aha152x]free_hard_reset_SCs+2f/ac>
  13:   eb 00                     jmp    15 <_EIP+0x15> c6a3b691 <[aha152x]free_hard_reset_SCs+31/ac>


1 warning issued.  Results may not be reliable.

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.decoded"

ksymoops 2.4.6 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 20 19:35:19 hexenkessel kernel: c6a4267c
Aug 20 19:35:19 hexenkessel kernel: Oops: 0000
Aug 20 19:35:19 hexenkessel kernel: CPU:    0
Aug 20 19:35:19 hexenkessel kernel: EIP:    0010:[<c6a4267c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 20 19:35:19 hexenkessel kernel: EFLAGS: 00010086
Aug 20 19:35:19 hexenkessel kernel: eax: 00000000   ebx: c3b12000   ecx: c32edb80   edx: c3aa8400
Aug 20 19:35:19 hexenkessel kernel: esi: c3aa8400   edi: 00000086   ebp: c3aa8484   esp: c3a43f4c
Aug 20 19:35:19 hexenkessel kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 19:35:19 hexenkessel kernel: Process scsi_eh_0 (pid: 565, stackpage=c3a43000)
Aug 20 19:35:19 hexenkessel kernel: Stack: 00000286 c3aa8400 00000000 c3b12000 c6a4272c c3aa8400 c3aa8484 c3aa8400 
Aug 20 19:35:19 hexenkessel kernel:        c3aa847c 00000286 c3b12000 c6a2168f c3b12000 00002003 00000000 c6a21cd7 
Aug 20 19:35:19 hexenkessel kernel:        c3b12000 c3a42000 c3a43fdc c3a43fdc c3aa8400 c3a43fe8 c3a43fe8 c32ed680 
Aug 20 19:35:19 hexenkessel kernel: Call Trace: [<c6a4272c>] [<c6a2168f>] [<c6a21cd7>] [<c6a221ab>] [kernel_thread+40/56] 
Aug 20 19:35:19 hexenkessel kernel: Code: 8b 30 8b 43 0c f6 80 ef 00 00 00 10 75 70 8b 4d 00 31 d2 eb 


>>EIP; c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====

>>ebx; c3b12000 <_end+38d34b4/65c34b4>
>>ecx; c32edb80 <_end+30af034/65c34b4>
>>edx; c3aa8400 <_end+38698b4/65c34b4>
>>esi; c3aa8400 <_end+38698b4/65c34b4>
>>ebp; c3aa8484 <_end+3869938/65c34b4>
>>esp; c3a43f4c <_end+3805400/65c34b4>

Trace; c6a4272c <[aha152x]aha152x_bus_reset+20/a0>
Trace; c6a2168f <[scsi_mod]scsi_try_bus_reset+3f/90>
Trace; c6a21cd7 <[scsi_mod]scsi_unjam_host+357/758>
Trace; c6a221ab <[scsi_mod]scsi_error_handler+d3/12b>

Code;  c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>
00000000 <_EIP>:
Code;  c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====
   0:   8b 30                     mov    (%eax),%esi   <=====
Code;  c6a4267e <[aha152x]free_hard_reset_SCs+1e/ac>
   2:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c6a42681 <[aha152x]free_hard_reset_SCs+21/ac>
   5:   f6 80 ef 00 00 00 10      testb  $0x10,0xef(%eax)
Code;  c6a42688 <[aha152x]free_hard_reset_SCs+28/ac>
   c:   75 70                     jne    7e <_EIP+0x7e> c6a426fa <[aha152x]free_hard_reset_SCs+9a/ac>
Code;  c6a4268a <[aha152x]free_hard_reset_SCs+2a/ac>
   e:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c6a4268d <[aha152x]free_hard_reset_SCs+2d/ac>
  11:   31 d2                     xor    %edx,%edx
Code;  c6a4268f <[aha152x]free_hard_reset_SCs+2f/ac>
  13:   eb 00                     jmp    15 <_EIP+0x15> c6a42691 <[aha152x]free_hard_reset_SCs+31/ac>


1 warning issued.  Results may not be reliable.

--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops4.decoded"

ksymoops 2.4.6 on i586 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Aug 20 23:18:53 hexenkessel kernel: c6a4267c
Aug 20 23:18:53 hexenkessel kernel: Oops: 0000
Aug 20 23:18:53 hexenkessel kernel: CPU:    0
Aug 20 23:18:53 hexenkessel kernel: EIP:    0010:[<c6a4267c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug 20 23:18:53 hexenkessel kernel: EFLAGS: 00010086
Aug 20 23:18:53 hexenkessel kernel: eax: 00000000   ebx: c235c800   ecx: c1f92880   edx: c2eea400
Aug 20 23:18:53 hexenkessel kernel: esi: c2eea400   edi: 00000086   ebp: c2eea484   esp: c4359f4c
Aug 20 23:18:53 hexenkessel kernel: ds: 0018   es: 0018   ss: 0018
Aug 20 23:18:53 hexenkessel kernel: Process scsi_eh_0 (pid: 941, stackpage=c4359000)
Aug 20 23:18:53 hexenkessel kernel: Stack: 00000286 c2eea400 00000000 c235c800 c6a4272c c2eea400 c2eea484 c2eea400 
Aug 20 23:18:53 hexenkessel kernel:        c2eea47c 00000286 c235c800 c6a2168f c235c800 00002003 00000000 c6a21cd7 
Aug 20 23:18:53 hexenkessel kernel:        c235c800 c4358000 c4359fdc c4359fdc c2eea400 c4359fe8 c4359fe8 c1f92880 
Aug 20 23:18:53 hexenkessel kernel: Call Trace: [<c6a4272c>] [<c6a2168f>] [<c6a21cd7>] [<c6a221ab>] [kernel_thread+40/56] 
Aug 20 23:18:53 hexenkessel kernel: Code: 8b 30 8b 43 0c f6 80 ef 00 00 00 10 75 70 8b 4d 00 31 d2 eb 


>>EIP; c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====

>>ebx; c235c800 <_end+211dcb4/65c34b4>
>>ecx; c1f92880 <_end+1d53d34/65c34b4>
>>edx; c2eea400 <_end+2cab8b4/65c34b4>
>>esi; c2eea400 <_end+2cab8b4/65c34b4>
>>ebp; c2eea484 <_end+2cab938/65c34b4>
>>esp; c4359f4c <_end+411b400/65c34b4>

Trace; c6a4272c <[aha152x]aha152x_bus_reset+20/a0>
Trace; c6a2168f <[scsi_mod]scsi_try_bus_reset+3f/90>
Trace; c6a21cd7 <[scsi_mod]scsi_unjam_host+357/758>
Trace; c6a221ab <[scsi_mod]scsi_error_handler+d3/12b>

Code;  c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>
00000000 <_EIP>:
Code;  c6a4267c <[aha152x]free_hard_reset_SCs+1c/ac>   <=====
   0:   8b 30                     mov    (%eax),%esi   <=====
Code;  c6a4267e <[aha152x]free_hard_reset_SCs+1e/ac>
   2:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c6a42681 <[aha152x]free_hard_reset_SCs+21/ac>
   5:   f6 80 ef 00 00 00 10      testb  $0x10,0xef(%eax)
Code;  c6a42688 <[aha152x]free_hard_reset_SCs+28/ac>
   c:   75 70                     jne    7e <_EIP+0x7e> c6a426fa <[aha152x]free_hard_reset_SCs+9a/ac>
Code;  c6a4268a <[aha152x]free_hard_reset_SCs+2a/ac>
   e:   8b 4d 00                  mov    0x0(%ebp),%ecx
Code;  c6a4268d <[aha152x]free_hard_reset_SCs+2d/ac>
  11:   31 d2                     xor    %edx,%edx
Code;  c6a4268f <[aha152x]free_hard_reset_SCs+2f/ac>
  13:   eb 00                     jmp    15 <_EIP+0x15> c6a42691 <[aha152x]free_hard_reset_SCs+31/ac>


1 warning issued.  Results may not be reliable.

--GRPZ8SYKNexpdSJ7--
