Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317398AbSGRIjP>; Thu, 18 Jul 2002 04:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSGRIjP>; Thu, 18 Jul 2002 04:39:15 -0400
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:44284 "EHLO
	anaconda.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id <S317398AbSGRIjI>; Thu, 18 Jul 2002 04:39:08 -0400
Message-ID: <3D367F57.EF75DCED@gmx.net>
Date: Thu, 18 Jul 2002 10:41:59 +0200
From: Richard Ems <r.ems.mtg@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: kernel OOPS: 2.4.18, nscd
References: <3D104DF4.A8053F67@gmx.net> <15634.50708.164289.246414@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Wednesday June 19, r.ems.home@gmx.net wrote:
> > Hi all!
> >
> > Two kernel Oopses in short time (22:35:59 and 22:50:00). But the computer was still alive until 00:00:00, where the daily cron jobs are started and then ... kernel panic, LED's where blinking   :(
> >
> > kernel is 2.4.18, from SuSE's k_deflt-2.4.18-174 package (2.4.19-pre10aa2)
> >
> > Please CC to r.ems@gmx.net, I'm not on the linux-kernel mailing
> > list.
> 
> Would I be right is surmising that you are exporting an ISO filesystem
> over NFS??  That would be the second Oops in as many days with that
> scenario.
> 
> If that is the case, then I'm afraid that I cannot point you to any
> fix, though exporting with "no_subtree_check" may reduce the incidence.
> 
> NeilBrown

Hi all!

No, I'm not exporting any ISO fs over NFS anymore, sometimes I do, but
then only for a couple of minutes and then I exportfs -u the exported
mount point.

I thought it was a heat problem, since I was running dnetc on an AMD
which gets very hot, but I had the same OOPS yesterday, this time only
on nscd (dnetc was also running, so load was at 1).

Everything seems to continue running after nscd oopses, but logins are
impossible, so the machine needs to be rebooted.

Here the last nscd oops:

Jul 17 15:15:25 bingo kernel: Unable to handle kernel paging request at
virtual address 00282008
Jul 17 15:15:25 bingo kernel: c020d014
Jul 17 15:15:25 bingo kernel: *pde = 00000000
Jul 17 15:15:25 bingo kernel: Oops: 0000
Jul 17 15:15:25 bingo kernel: CPU:    0
Jul 17 15:15:25 bingo kernel: EIP:    0010:[sock_poll+4/32]    Not
tainted
Jul 17 15:15:25 bingo kernel: EFLAGS: 00210282
Jul 17 15:15:25 bingo kernel: eax: c020d010   ebx: 00000145   ecx:
00000000   edx: 00282000
Jul 17 15:15:25 bingo kernel: esi: ca83f000   edi: c3282a20   ebp:
00000000   esp: c3685f28
Jul 17 15:15:25 bingo kernel: ds: 0018   es: 0018   ss: 0018
Jul 17 15:15:25 bingo kernel: Process nscd (pid: 870,
stackpage=c3685000)
Jul 17 15:15:25 bingo kernel: Stack: c0149650 00282000 00000000 00000000
000005dd 00000000 00000000 c014973c
Jul 17 15:15:25 bingo kernel:        00000001 ca83f000 c3685f60 c3685f64
c3684000 c3684000 00000000 00000000
Jul 17 15:15:25 bingo kernel:        00000001 bf7ffa04 00000000 00000001
c01498a0 00000001 00000000 00000001
Jul 17 15:15:25 bingo kernel: Call Trace: [do_pollfd+128/144]
[do_poll+220/240] [sys_poll+336/704] [sys_time+17/80]
[system_call+51/64]
Jul 17 15:15:25 bingo kernel: Code: 8b 42 08 8b 40 08 05 14 01 00 00 8b
48 08 ff 74 24 08 50 52

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 42 08                  mov    0x8(%edx),%eax
Code;  00000002 Before first symbol
   3:   8b 40 08                  mov    0x8(%eax),%eax
Code;  00000006 Before first symbol
   6:   05 14 01 00 00            add    $0x114,%eax
Code;  0000000a Before first symbol
   b:   8b 48 08                  mov    0x8(%eax),%ecx
Code;  0000000e Before first symbol
   e:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  00000012 Before first symbol
  12:   50                        push   %eax
Code;  00000012 Before first symbol
  13:   52                        push   %edx



Here the first nscd oops:

Jun 18 22:35:59 bingo kernel: Unable to handle kernel paging request at
virtual address 92766008
Jun 18 22:35:59 bingo kernel: c0217944
Jun 18 22:35:59 bingo kernel: *pde = 00000000
Jun 18 22:35:59 bingo kernel: Oops: 0000
Jun 18 22:35:59 bingo kernel: CPU:    0
Jun 18 22:35:59 bingo kernel: EIP:    0010:[sock_poll+4/32]    Not
tainted
Jun 18 22:35:59 bingo kernel: EFLAGS: 00210282
Jun 18 22:35:59 bingo kernel: eax: c0217940   ebx: 00000145   ecx:
00000000   edx: 92766000
Jun 18 22:35:59 bingo kernel: esi: dcd88000   edi: c2bf76e0   ebp:
00000000   esp: c3419f28
Jun 18 22:35:59 bingo kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 22:35:59 bingo kernel: Process nscd (pid: 863,
stackpage=c3419000)
Jun 18 22:35:59 bingo kernel: Stack: c0149610 92766000 00000000 00000000
000005dd 00000000 00000000 c01496fc
Jun 18 22:35:59 bingo kernel:        00000001 dcd88000 c3419f60 c3419f64
c3418000 c3418000 00000000 00000000
Jun 18 22:35:59 bingo kernel:        00000001 bf7ffa04 00000000 00000001
c0149860 00000001 00000000 00000001
Jun 18 22:35:59 bingo kernel: Call Trace: [do_pollfd+128/144]
[do_poll+220/240] [sys_poll+336/704] [sys_time+17/80]
[system_call+51/64]
Jun 18 22:35:59 bingo kernel: Code: 8b 42 08 8b 40 08 05 14 01 00 00 8b
48 08 ff 74 24 08 50 52
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 42 08                  mov    0x8(%edx),%eax
Code;  00000002 Before first symbol
   3:   8b 40 08                  mov    0x8(%eax),%eax
Code;  00000006 Before first symbol
   6:   05 14 01 00 00            add    $0x114,%eax
Code;  0000000a Before first symbol
   b:   8b 48 08                  mov    0x8(%eax),%ecx
Code;  0000000e Before first symbol
   e:   ff 74 24 08               pushl  0x8(%esp,1)
Code;  00000012 Before first symbol
  12:   50                        push   %eax
Code;  00000012 Before first symbol
  13:   52                        push   %edx


System is SuSE 8.0, all updates aplied.
Kernel is SuSE's k_deflt-2.4.18-186
Only IDE, no SCSI.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) XP1800+
stepping        : 2
cpu MHz         : 1544.555
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3080.19


# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04)



Any more information needed?

Thanks, Richard
 

P.S.: Please reply also to r.ems@gmx.net, I'm not on lkml.

-- 
   Richard Ems
   ... e-mail: r.ems@gmx.net
   ... Computer Science, University of Hamburg

   Unix IS user friendly. It's just selective about who its friends are.
