Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317828AbSFSJZZ>; Wed, 19 Jun 2002 05:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317829AbSFSJZY>; Wed, 19 Jun 2002 05:25:24 -0400
Received: from pop.gmx.net ([213.165.64.20]:64357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317828AbSFSJZX>;
	Wed, 19 Jun 2002 05:25:23 -0400
Message-ID: <3D104DF4.A8053F67@gmx.net>
Date: Wed, 19 Jun 2002 11:25:08 +0200
From: Richard Ems <r.ems.home@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en,de,es
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Hubert Mantel <mantel@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: kernel OOPS: 2.4.18, nscd, nfsd
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

Two kernel Oopses in short time (22:35:59 and 22:50:00). But the computer was still alive until 00:00:00, where the daily cron jobs are started and then ... kernel panic, LED's where blinking   :(

kernel is 2.4.18, from SuSE's k_deflt-2.4.18-174 package (2.4.19-pre10aa2)

Please CC to r.ems@gmx.net, I'm not on the linux-kernel mailing list.

Thanks, Richard Ems


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
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3080.19



# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP]
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)



# scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bingo 2.4.18-4GB #1 Fri Jun 14 17:46:33 UTC 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.26
PPP                    2.4.1
Linux C Library        x    1 root     root      1394238 Mar 23 19:34 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         nfsd autofs4 matroxfb_base matroxfb_Ti3026 matroxfb_DAC1064 matroxfb_accel fbcon-cfb4 g450_pll matroxfb_misc 3c59x ext3 jbd lvm-mod


Extract from /var/log/messages:

...
Jun 18 22:21:36 bingo automount[23936]: expired /net/jupiter
Jun 18 22:22:52 bingo automount[23942]: expired /net/diablo
Jun 18 22:30:00 bingo /USR/SBIN/CRON[23961]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 22:35:59 bingo kernel: Unable to handle kernel paging request at virtual address 92766008
Jun 18 22:35:59 bingo kernel:  printing eip:
Jun 18 22:35:59 bingo kernel: c0217944
Jun 18 22:35:59 bingo kernel: *pde = 00000000
Jun 18 22:35:59 bingo kernel: Oops: 0000
Jun 18 22:35:59 bingo kernel: CPU:    0
Jun 18 22:35:59 bingo kernel: EIP:    0010:[sock_poll+4/32]    Not tainted
Jun 18 22:35:59 bingo kernel: EFLAGS: 00210282
Jun 18 22:35:59 bingo kernel: eax: c0217940   ebx: 00000145   ecx: 00000000   edx: 92766000
Jun 18 22:35:59 bingo kernel: esi: dcd88000   edi: c2bf76e0   ebp: 00000000   esp: c3419f28
Jun 18 22:35:59 bingo kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 22:35:59 bingo kernel: Process nscd (pid: 863, stackpage=c3419000)
Jun 18 22:35:59 bingo kernel: Stack: c0149610 92766000 00000000 00000000 000005dd 00000000 00000000 c01496fc
Jun 18 22:35:59 bingo kernel:        00000001 dcd88000 c3419f60 c3419f64 c3418000 c3418000 00000000 00000000
Jun 18 22:35:59 bingo kernel:        00000001 bf7ffa04 00000000 00000001 c0149860 00000001 00000000 00000001
Jun 18 22:35:59 bingo kernel: Call Trace: [do_pollfd+128/144] [do_poll+220/240] [sys_poll+336/704] [sys_time+17/80] [system_call+51/64]
Jun 18 22:35:59 bingo kernel:
Jun 18 22:35:59 bingo kernel: Code: 8b 42 08 8b 40 08 05 14 01 00 00 8b 48 08 ff 74 24 08 50 52
Jun 18 22:35:59 bingo kernel: klogd 1.4.1, ---------- state change ----------
Jun 18 22:35:59 bingo kernel: Inspecting /boot/System.map-2.4.18-4GB
Jun 18 22:35:59 bingo kernel: Loaded 13574 symbols from /boot/System.map-2.4.18-4GB.
Jun 18 22:35:59 bingo kernel: Symbols match kernel version 2.4.18.
Jun 18 22:35:59 bingo kernel: Loaded 168 symbols from 13 modules.
Jun 18 22:40:00 bingo /USR/SBIN/CRON[24006]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 22:50:00 bingo /USR/SBIN/CRON[24053]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 22:50:00 bingo kernel:  <1>Unable to handle kernel paging request at virtual address 42627044
Jun 18 22:50:00 bingo kernel:  printing eip:
Jun 18 22:50:00 bingo kernel: 42627044
Jun 18 22:50:00 bingo kernel: *pde = 00000000
Jun 18 22:50:00 bingo kernel: Oops: 0000
Jun 18 22:50:00 bingo kernel: CPU:    0
Jun 18 22:50:00 bingo kernel: EIP:    0010:[zisofs_cleanup+1113747380/-1072693392]    Not tainted
Jun 18 22:50:00 bingo kernel: EFLAGS: 00210282
Jun 18 22:50:00 bingo kernel: eax: c1607270   ebx: c39d5c9c   ecx: cdb20020   edx: cdb20d40
Jun 18 22:50:00 bingo kernel: esi: 00000011   edi: 00000003   ebp: 00000007   esp: c370bf30
Jun 18 22:50:00 bingo kernel: ds: 0018   es: 0018   ss: 0018
Jun 18 22:50:00 bingo kernel: Process nfsd (pid: 839, stackpage=c370b000)
Jun 18 22:50:00 bingo kernel: Stack: cdb20d40 d7f64160 c2668fb8 00000001 00000003 00000011 c364d800 c362f580
Jun 18 22:50:00 bingo kernel:        c6934014 c362f580 c3620505 c364d800 00000002 cf131240 c6934014 c364dc9c
Jun 18 22:50:00 bingo kernel:        c02687ec c364d800 c6934014 00000000 00000027 00000007 c6934014 00000000
Jun 18 22:50:00 bingo kernel: Call Trace: [nfsd:__insmod_nfsd_S.data_L2432+1888/2432] [nfsd:__insmod_nfsd_S.data_L2432+1888/2432] [nfsd:__insmod_nfsd_S.text_L52871+1189/52872] [svc_process+1100/1344] [nfsd:__insmod_nfsd_S.text_L52871+806/52872]
Jun 18 22:50:00 bingo kernel:    [nfsd:__insmod_nfsd_S.data_L2432+0/2432] [kernel_thread+38/48] [nfsd:__insmod_nfsd_S.text_L52871+352/52872]
Jun 18 22:50:00 bingo kernel:
Jun 18 22:50:00 bingo kernel: Code:  Bad EIP value.
Jun 18 22:59:00 bingo /USR/SBIN/CRON[24075]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hourly)
Jun 18 23:00:00 bingo /USR/SBIN/CRON[24080]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:10:00 bingo /USR/SBIN/CRON[24137]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:20:00 bingo /USR/SBIN/CRON[24184]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:30:00 bingo /USR/SBIN/CRON[24209]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:40:00 bingo /USR/SBIN/CRON[24254]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:50:00 bingo /USR/SBIN/CRON[24301]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 18 23:59:00 bingo /USR/SBIN/CRON[24323]: (root) CMD ( rm -f /var/spool/cron/lastrun/cron.hourly)
Jun 19 00:00:00 bingo /USR/SBIN/CRON[24329]: (root) CMD ( /usr/lib/sa/sa2 -A   #update reports every 6 hour)
Jun 19 00:00:00 bingo /USR/SBIN/CRON[24330]: (root) CMD ( /usr/lib/sa/sa1      )
Jun 19 10:25:25 bingo syslogd 1.4.1: restart.
...


Thanks again, Richard

--
Richard Ems
... e-mail: r.ems@gmx.net
... Computer Science, University of Hamburg

Unix IS user friendly. It's just selective about who its friends are.


