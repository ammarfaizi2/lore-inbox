Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132921AbRDEPKp>; Thu, 5 Apr 2001 11:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132920AbRDEPKf>; Thu, 5 Apr 2001 11:10:35 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:41482 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S132919AbRDEPKY>; Thu, 5 Apr 2001 11:10:24 -0400
Date: Thu, 5 Apr 2001 18:09:28 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.0.39 oopses in sys_new(l)stat
Message-ID: <20010405180927.A8000@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if there might still be a bug in 2.0.39 sys_new(l)stat. Today, one
of my trustworthy servers crashed (see details below), and it has actually
given me two slightly similar looking oopses before.

While this might be a hardware problem (I'll run memory test asap), it seems
that the oopses are quite similar and could perhaps be caused by a kernel
bug.

This is vanilla 2.0.39 (2.0.37 before), gcc-2.7.2.3, Ppro-200, Intel
motherboard etc. It has been very reliable in past. These oopses are the
_only_ problems. It runs qmail, samba, cvs, rsync, apache, pop, sshd and
oracle. All local fs's are plain ext2.

I hope somebody (with more kernel hacking experience than me) is still
interested in the 2.0.39. I'll be happy to provide any additional details or
try something. The oops will propably be hard to reproduce, however.


======================================================================
It began with this:

Apr  5 05:33:35 some kernel: general protection: 0000
Apr  5 05:33:36 some kernel: CPU:    0
Apr  5 05:33:36 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:36 some kernel: EFLAGS: 00010292
Apr  5 05:33:36 some kernel: eax: 00000341   ebx: 9a0004b6   ecx: 000203e5 edx: 001c7658
Apr  5 05:33:36 some kernel: esi: 001ba164   edi: 00000000   ebp: 001c7658 esp: 06436ef0
Apr  5 05:33:36 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:36 some kernel: Process rsync (pid: 15624, process nr: 76, stackpage=06436000)
Apr  5 05:33:36 some kernel: Stack: 05144d00 07ff1418 00000004 03070004 07ff1418 00154f27 001c7658 000203e5
Apr  5 05:33:36 some kernel:        00000001 05144d00 06436f74 06436f74 00000004 0897eaf8 000203e5 0012ce12
Apr  5 05:33:36 some kernel:        05144d00 03070004 00000004 06436f74 00000000 06436f74 06436fb4 bfffdb30
Apr  5 05:33:36 some kernel: Call Trace: [ext2_lookup+343/368]
                             [lookup+222/248] [_namei+90/228] [lnamei+48/72] [sys_newlstat+41/88]
                             [system_call+85/124]
Apr  5 05:33:36 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 05:33:36 some kernel: general protection: 0000
Apr  5 05:33:36 some kernel: CPU:    0
Apr  5 05:33:36 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:36 some kernel: EFLAGS: 00010292
Apr  5 05:33:36 some kernel: eax: 00000341   ebx: 9a0004b6   ecx: 000203e5 edx: 000203e5
Apr  5 05:33:36 some kernel: esi: 001ba164   edi: 00000000   ebp: 001c7658 esp: 01083ef0
Apr  5 05:33:36 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:36 some kernel: Process rsync (pid: 15278, process nr: 77, stackpage=01083000)
Apr  5 05:33:36 some kernel: Stack: 05144d00 01083f74 00000004 09036004 00154e51 00154e84 001c7658 000203e5
Apr  5 05:33:36 some kernel:        00000001 05144d00 01083f74 01083f74 00000004 05144d00 000203e5 0012ce12
Apr  5 05:33:36 some kernel:        05144d00 09036004 00000004 01083f74 00000000 01083f74 01083fb4 bffff1f8
Apr  5 05:33:36 some kernel: Call Trace: [ext2_lookup+129/368]
                             [ext2_lookup+180/368] [lookup+222/248] [_namei+90/228] [lnamei+48/72]
                             [sys_newlstat+41/88] [system_call+85/124]
Apr  5 05:33:36 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 05:33:37 some kernel: general protection: 0000
Apr  5 05:33:37 some kernel: CPU:    0
Apr  5 05:33:37 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:37 some kernel: EFLAGS: 00010212
Apr  5 05:33:37 some kernel: eax: 00000301   ebx: 6a000973   ecx: 01fbc598 edx: 001c6b4c
Apr  5 05:33:37 some kernel: esi: 001b9d34   edi: 00000000   ebp: 001c6b4c esp: 054b4ef0
Apr  5 05:33:37 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:37 some kernel: Process cvs (pid: 15623, process nr: 70, stackpage=054b4000)
Apr  5 05:33:37 some kernel: Stack: 0191c400 01fbc598 00000008 0320f000 01fbc598 00154f27 001c6b4c 000c2b1f
Apr  5 05:33:37 some kernel:        00000001 0191c400 054b4f74 054b4f74 00000008 075f4cc0 000c2b1f 0012ce12
Apr  5 05:33:37 some kernel:        0191c400 0320f000 00000008 054b4f74 00000000 054b4f74 054b4fb4 bffff670
Apr  5 05:33:37 some kernel: Call Trace: [ext2_lookup+343/368] [lookup+222/248] [_namei+90/228] [lnamei+48/72] [sys_newlstat+41/88] [system_call+85/124]
Apr  5 05:33:37 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 05:33:43 some kernel: general protection: 0000
Apr  5 05:33:43 some kernel: CPU:    0
Apr  5 05:33:43 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:43 some kernel: EFLAGS: 00010292
Apr  5 05:33:43 some kernel: eax: 00001605   ebx: 9a000945   ecx: 098eb398 edx: 001c7330
Apr  5 05:33:43 some kernel: esi: 001ba0ac   edi: 00000000   ebp: 001c7330 esp: 01ce5ec4
Apr  5 05:33:43 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:43 some kernel: Process smbd (pid: 23077, process nr: 72, stackpage=01ce5000)
Apr  5 05:33:43 some kernel: Stack: 09cff600 098eb398 00000007 047a6000 098eb398 00154f27 001c7330 00047e88
Apr  5 05:33:43 some kernel:        00000001 09cff600 047a6008 01ce5f4c 00000007 02cef608 00047e88 0012ce12
Apr  5 05:33:43 some kernel:        09cff600 047a6000 00000007 01ce5f4c 047a6000 047a6008 01ce5f88 01ce5f78
Apr  5 05:33:43 some kernel: Call Trace: [ext2_lookup+343/368] [lookup+222/248] [dir_namei+155/304] [_namei+46/228] [namei+48/72] [sys_newstat+41/88] [system_call+85/124]
Apr  5 05:33:43 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 05:33:59 some kernel: general protection: 0000
Apr  5 05:33:59 some kernel: CPU:    0
Apr  5 05:33:59 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 05:33:59 some kernel: EFLAGS: 00010292
Apr  5 05:33:59 some kernel: eax: 00001605   ebx: 9a000945   ecx: 098eb398 edx: 001c7330
Apr  5 05:33:59 some kernel: esi: 001ba0ac   edi: 00000000   ebp: 001c7330 esp: 01ce5ec4
Apr  5 05:33:59 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:33:59 some kernel: Process smbd (pid: 15762, process nr: 73, stackpage=01ce5000)
Apr  5 05:33:59 some kernel: Stack: 09cff600 098eb398 00000007 066e3000 098eb398 00154f27 001c7330 00047e88
Apr  5 05:33:59 some kernel:        00000001 09cff600 066e3008 01ce5f4c 00000007 02cef608 00047e88 0012ce12
Apr  5 05:33:59 some kernel:        09cff600 066e3000 00000007 01ce5f4c 066e3000 066e3008 01ce5f88 01ce5f78
Apr  5 05:33:59 some kernel: Call Trace: [ext2_lookup+343/368] [lookup+222/248] [dir_namei+155/304] [_namei+46/228] [namei+48/72] [sys_newstat+41/88] [system_call+85/124] 
Apr  5 05:33:59 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 05:34:01 some kernel: Unable to handle kernel paging request at virtual address de009a6c
Apr  5 05:34:01 some kernel: current->tss.cr3 = 056f9000, %%cr3 = 056f9000
Apr  5 05:34:01 some kernel: *pde = 00000000
Apr  5 05:34:01 some kernel: Oops: 0002
Apr  5 05:34:01 some kernel: CPU:    0
Apr  5 05:34:01 some kernel: EIP:    0010:[clear_inode+160/332]
Apr  5 05:34:01 some kernel: EFLAGS: 00010206
Apr  5 05:34:01 some kernel: eax: 09450e00   ebx: 02099900   ecx: 00000000 edx: 1e009a00
Apr  5 05:34:01 some kernel: esi: 00000002   edi: 00000000   ebp: 001c6b4c esp: 01ae9ed0
Apr  5 05:34:01 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 05:34:01 some kernel: Process find (pid: 15630, process nr: 70, stackpage=01ae9000)
Apr  5 05:34:01 some kernel: Stack: 02099900 00000000 0599b700 00125b93 02099900 00000000 001ba80c 00125d3d
Apr  5 05:34:01 some kernel:        08b41900 01ae9f74 0000000a 06d6c000 00154e51 00154e84 001c6b4c 00030878
Apr  5 05:34:01 some kernel:        00000001 08b41900 01ae9f74 01ae9f74 0000000a 08b41900 00030878 0012ce12
Apr  5 05:34:01 some kernel: Call Trace: [get_empty_inode+243/348] [__iget+97/544] [ext2_lookup+129/368] [ext2_lookup+180/368] [lookup+222/248] [_namei+90/228] [lnamei+48/72]
Apr  5 05:34:01 some kernel:        [sys_newlstat+41/88] [system_call+85/124]
Apr  5 05:34:01 some kernel: Code: 89 42 6c c7 43 6c 00 00 00 00 c7 43 70 00 00 00 00 39 1d 44


and continued spitting oopses for smbd every second until I booted the box.
The last one was this:

Apr  5 09:48:07 some kernel: general protection: 0000
Apr  5 09:48:07 some kernel: CPU:    0
Apr  5 09:48:07 some kernel: EIP:    0010:[__iget+60/544]
Apr  5 09:48:07 some kernel: EFLAGS: 00010292
Apr  5 09:48:07 some kernel: eax: 00001605   ebx: 9a000945   ecx: 06b17efc edx: 00047e88
Apr  5 09:48:07 some kernel: esi: 001ba0ac   edi: 00000000   ebp: 001c7330 esp: 06b17ec4
Apr  5 09:48:07 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Apr  5 09:48:07 some kernel: Process smbd (pid: 16603, process nr: 81, stackpage=06b17000)
Apr  5 09:48:07 some kernel: Stack: 09cff600 073b3008 00000007 073b3000 00154e51 00154e84 001c7330 00047e88
Apr  5 09:48:07 some kernel:        00000001 09cff600 073b3008 06b17f4c 00000007 09cff600 00047e88 0012ce12
Apr  5 09:48:07 some kernel:        09cff600 073b3000 00000007 06b17f4c 073b3000 073b3008 06b17f88 06b17f78
Apr  5 09:48:07 some kernel: Call Trace: [ext2_lookup+129/368] [ext2_lookup+180/368] [lookup+222/248] [dir_namei+155/304] [_namei+46/228] [namei+48/72] [sys_newstat+41/88]
Apr  5 09:48:07 some kernel:        [system_call+85/124]
Apr  5 09:48:07 some kernel: Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b
Apr  5 09:54:23 some PAM_pwdb[331]: (login) session opened for user root by (uid=0)
Apr  5 09:54:23 some login[331]: ROOT LOGIN ON tty2
Apr  5 09:54:23 some PAM_pwdb[331]: (login) session closed for user root

I also wrote the last one down by hand I fed it through ksymoops:

CPU:  0
EIP:  0010:[<00125d18>]
EFLAGS: 00010292
eax: 00001605  ebx: 9a000945 ecx: 06005efc  edx: 00047e88
esi: 001ba0ac  edi: 00000000 abp: 001c7330  esp: 06005ec4
ds: 0018  es: 0018  fs: 002b  gs: 002b  ss: 0018
Process smbd (pid 16595, process nr 81: stackpage=06b17000)
Stack: 09cff600 073b3000 00000007 073b3000 00154e51 00154e84 001c7330 00047e88
       00000001 09cff600 073b3008 06b17f4c 00000007 09cff600 00047e88 0012ce12
       09cff600 073b3000 00000007 06b17f4c 073b3000 073b3000 06b17f88 06b17f78
Call Trace: [<00154e51>] [00154e84>] [<0012ce12>] [<0012cf37>] [<0012cffa>]
            [<0012d128>] [0012b11d>] [<0010bb81>]
Code: 66 39 03 75 0d 8b 4c 24 1c 39 4b 04 0f 84 fa 00 00 00 8b 5b

Using /boot/System.map-2.0.39-linux2' to map addresses to symbols.

>>EIP: 125d18 <__iget+3c/220>
Trace: 154e51 <ext2_lookup+81/170>

Code: 125d18 <__iget+3c/220>
Code: 125d18 <__iget+3c/220>  66 39 03          cmpw   %ax,(%ebx)
Code: 125d1b <__iget+3f/220>  75 0d             jne    125d2a <__iget+4e/220>
Code: 125d1d <__iget+41/220>  8b 4c 24 1c       movl   0x1c(%esp,1),%ecx
Code: 125d21 <__iget+45/220>  39 4b 04          cmpl   %ecx,0x4(%ebx)
Code: 125d2a <__iget+4e/220>  0f 84 fa 00 00    je     125e24 <__iget+148/220>
Code: 125d2f <__iget+53/220>  00
Code: 125d30 <__iget+54/220>  8b 5b 00          movl   0x0(%ebx),%ebx
Code: 125d39 <__iget+5d/220>  90                nop
Code: 125d3a <__iget+5e/220>  90                nop
Code: 125d3b <__iget+5f/220>  90                nop

I put all the oopses from the syslog available at
http://v.iki.fi/~vherva/tmp/messages.bz2 just in case.
The .config is also at http://v.iki.fi/~vherva/tmp/config



I also had two oopses in past:

============================================================================
04.04.2000:

(kernel 2.0.37)
Just a single oops in dmesg's, I didn't do anything about it:

CPU:    0
EIP:    0010:[<0094b010>]
EFLAGS: 00257702
eax: 492f6561   ebx: 0094b000   ecx: 00000001   edx: 08b07201
esi: ffffffff   edi: 2f656d6e   ebp: 0012d03c   esp: 00d21f94
ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Process ipop3d (pid: 12111, process nr: 31, stackpage=00d21000)
Stack: bfffd5fc bfffd6c0 0094b000 0012b179 bfffd6c0 00d21fb4 0721ec0c bfffd668
       00000000 0010bbe9 bfffd6c0 bfffd5fc 400df6cc bfffd668 bfffd6c0 bfffd63c
       ffffffda 0010002b 0000002b 0000002b 0000002b 0000006a 400bb4a1 00000023
Call Trace: [<0012b179>] [<0010bbe9>]
Code: 00 78 74 00 69 6e 64 65 78 00 6e 20 42 2e 4f 2e 46 2e 48 20

ksymoops /boot/System.map-2.0.37
Using /boot/System.map-2.0.37' to map addresses to symbols.

CPU:    0
EIP:    0010:[<0094b010>]
EFLAGS: 00257702
eax: 492f6561   ebx: 0094b000   ecx: 00000001   edx: 08b07201
esi: ffffffff   edi: 2f656d6e   ebp: 0012d03c   esp: 00d21f94
ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Process ipop3d (pid: 12111, process nr: 31, stackpage=00d21000)
Stack: bfffd5fc bfffd6c0 0094b000 0012b179 bfffd6c0 00d21fb4 0721ec0c bfffd668
       00000000 0010bbe9 bfffd6c0 bfffd5fc 400df6cc bfffd668 bfffd6c0 bfffd63c
       ffffffda 0010002b 0000002b 0000002b 0000002b 0000006a 400bb4a1 00000023
Call Trace: [<0012b179>] [<0010bbe9>]
Code: 00 78 74 00 69 6e 64 65 78 00 6e 20 42 2e 4f 2e 46 2e 48 20
Trace: 12b179 <sys_newstat+29/58>
Trace: 10bbe9 <system_call+55/7c>

Code:
Code:  00 78 74         addb   %bh,0x74(%eax)
Code:  00 69 6e         addb   %ch,0x6e(%ecx)
Code:  64 65 78 00      js     a <_EIP+0xa>
Code:  6e               outsb  %ds:(%esi),(%dx)
Code:  20 42 2e         andb   %al,0x2e(%edx)
Code:  4f               decl   %edi
Code:  2e 46            incl   %esi
Code:  2e 48            decl   %eax
Code:  20 00            andb   %al,(%eax)
Code:  90               nop
Code:  90               nop
Code:  90               nop
=============================================================================
13.07.2000:

(kernel 2.0.37)
The machine died and the only thing I could save is this (sorry I can't feed
it thru ksymoops):

      Jul 13 09:28:54 some kernel: general protection: 0000
      Jul 13 09:28:54 some kernel: CPU:    0
      Jul 13 09:28:54 some kernel: EIP:    0010:[<075fb000>]
      Jul 13 09:28:54 some kernel: EFLAGS: 00257706
      Jul 13 09:28:54 some kernel: eax: 00000000   ebx: 04f21fb4   ecx: 00000000   edx: 00000000
      Jul 13 09:28:54 some kernel: esi: 00000005   edi: bfffe3c8   ebp: 00000203   esp: 04f21f78
      Jul 13 09:28:54 some kernel: ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
      Jul 13 09:28:54 some kernel: Process smbd (pid: 18364, process nr:44, stackpage=04f21000)
      Jul 13 09:28:54 some kernel: Stack: 00000000 0012d03c 075fb000 075fb000 02c6d400 00000001 04f21fb4 bfffe388
      Jul 13 09:28:54 some kernel:        080fee74 075fb000 0012b179 080fee74 04f21fb4 053ffc0c bffff09c 00000000
      Jul 13 09:28:54 some kernel:        0010bbe9 080fee74 bfffe388 400fb6cc bffff09c 00000005 bfffe3c8 ffffffda
      Jul 13 09:28:54 some kernel: Call Trace: [namei+60/72]
                                     [sys_newstat+41/88] [system_call+85/124]
      Jul 13 09:28:54 some kernel: Code: 6c 69 62 72 61 72 69 65 73 2f 4f
                                     62 6a 65 63 74 41 52 58 32

============================================================================



-- v --

v@iki.fi
