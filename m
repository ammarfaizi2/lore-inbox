Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSFUG52>; Fri, 21 Jun 2002 02:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316416AbSFUG51>; Fri, 21 Jun 2002 02:57:27 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:63498 "HELO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with SMTP
	id <S316342AbSFUG5Z> convert rfc822-to-8bit; Fri, 21 Jun 2002 02:57:25 -0400
Date: Fri, 21 Jun 2002 08:57:25 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Sander van Malssen <svm@kozmix.cistron.nl>
Subject: Procinfo behaving strange under 2.4.19-pre10
Message-ID: <Pine.LNX.4.44.0206210849450.678-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I upgraded a short time ago from kernel 2.4.18 to 2.4.19-pre10, but now
procinfo reports interrupts in a strange way.

2.4.19-pre10:

# procinfo
Linux 2.4.19-pre10 (root@grignard) (gcc 2.95.4 20011002 ) #2 1CPU [grignard]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        257480      225016       32464           0       20912      119516
Swap:       265064           0      265064

Bootup: Fri Jun 21 08:12:02 2002    Load average: 0.03 0.07 0.02 2/83 16013

user  :       0:01:06.58   3.2%  page in :   128235  disk 1:    10476r    6363w
nice  :       0:00:00.00   0.0%  page out:    90740
system:       0:00:30.95   1.5%  swap in :        1
idle  :       0:32:59.28  95.3%  swap out:        0
uptime:       0:34:36.80         context :   561976

irq  0:1000207681 timer                 irq  8:1000000003
irq  1:1000004868 keyboard              irq  9:1000000000 acpi
irq  2:1000000000 cascade [4]           irq 10:1000007854 eth0
irq  3:1000000000                       irq 11:1000114199 nvidia
irq  4:1000000000                       irq 12:1000026199 PS/2 Mouse
irq  5:1000003195 es1370                irq 13:1000000000
irq  6:1000000000                       irq 14:1000016806 ide0
irq  7:1000000000                       irq 15:1000000000

# cat/proc/interrupts
           CPU0
  0:     207681          XT-PIC  timer
  1:       4868          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:       3195          XT-PIC  es1370
  9:          0          XT-PIC  acpi
 10:       7857          XT-PIC  eth0
 11:     114199          XT-PIC  nvidia
 12:      26199          XT-PIC  PS/2 Mouse
 14:      16806          XT-PIC  ide0
NMI:          0
ERR:          0

After rebooting to 2.4.18:

# procinfo
Linux 2.4.18 (root@grignard) (gcc 2.95.4 20011002 ) #1 1CPU [grignard]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        256228       47544      208684           0        3720       26012
Swap:       265064           0      265064

Bootup: Fri Jun 21 08:48:25 2002    Load average: 0.24 0.06 0.02 1/47 664

user  :       0:00:01.73   4.2%  page in :    27919  disk 1:     2206r     571w
nice  :       0:00:00.00   0.0%  page out:     8616
system:       0:00:04.61  11.2%  swap in :        1
idle  :       0:00:34.87  84.6%  swap out:        0
uptime:       0:00:41.21         context :     8126

irq  0:      4121 timer                 irq  9:         0 acpi
irq  1:        72 keyboard              irq 10:       177 eth0
irq  2:         0 cascade [4]           irq 12:         8 PS/2 Mouse
irq  5:         0 es1370                irq 14:      2782 ide0
irq  8:         3 rtc

# procinfo
           CPU0
  0:       4122          XT-PIC  timer
  1:         72          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  es1370
  8:          3          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:        177          XT-PIC  eth0
 12:          8          XT-PIC  PS/2 Mouse
 14:       2782          XT-PIC  ide0
NMI:          0
ERR:          0

Both kernels were compiled and installed under the same environment:

Linux grignard 2.4.18 #1 tor maj 30 22:09:28 CEST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    [muligheder...]
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         parport_pc lp parport autofs4 es1370 soundcore ipt_REJECT ipt_unclean ipt_LOG ipt_limit ipt_state iptable_mangle iptable_nat iptable_filter ip_tables ip_conntrack_irc ip_conntrack_ftp ip_conntrack nls_iso8859-15 nls_cp865 vfat fat serial eepro100 af_packet rtc

Procinfo is procinfo-18; my system is Debian Woody.

Regards
/Rasmus

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
Because I don't want to force you to follow my philosophy, even though
it happens to be the only possible correct philosophy.
                                                          -- Ted Lemon
----------------------------------[ moffe at amagerkollegiet dot dk ] --

