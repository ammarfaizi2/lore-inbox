Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279768AbRLWPqn>; Sun, 23 Dec 2001 10:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRLWPqd>; Sun, 23 Dec 2001 10:46:33 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:21195 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S279768AbRLWPqZ>; Sun, 23 Dec 2001 10:46:25 -0500
Message-ID: <3C25FC02.5000302@korseby.net>
Date: Sun, 23 Dec 2001 16:45:06 +0100
From: Kristian Peters <kristian.peters@korseby.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: strange cpu load since 2.4.17
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Since upgrading (from 2.4.16) to 2.4.17 I'm getting strange high cpu loads. 
Always 50% of cpu are used by the system.
I made a "make oldconfig" to be sure that I'm using the same config as with 
2.4.16. (Also I have disabled "Make CPU Idle calls when idle".)

Any ideas what could cause that high CPU ratio ?

$ cat /proc/interrupts
            CPU0
   0:     113000          XT-PIC  timer
   1:       5744          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   8:          1          XT-PIC  rtc
  11:       6786          XT-PIC  usb-uhci, eth0, bttv, es1371
  12:      46567          XT-PIC  PS/2 Mouse
             ^^^^ that was lower with 2.4.16
  14:      10647          XT-PIC  ide0
  15:         14          XT-PIC  ide1
NMI:          0
LOC:     112960
             ^^^^ what's this ?
ERR:          0
MIS:          0


top sais:

   4:33pm  up 17 min,  3 users,  load average: 0,53, 0,64, 0,63
72 processes: 69 sleeping, 3 running, 0 zombie, 0 stopped
CPU states:  5,7% user, 53,1% system,  0,0% nice, 41,0% idle
Mem:   255484K av,  187268K used,   68216K free,       0K shrd,   15948K buff
Swap:  529192K av,       0K used,  529192K free                   66600K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  2041 tisi      15   0   952  952   768 R    40,2  0,3   3:26 wmtcp
  1474 root      11   0     0    0     0 SW    8,3  0,0   0:17 lirc_dev
  1612 root       9   0 96800  46M  2116 S     3,9 18,5   1:44 X
  2053 tisi       9   0 33988  33M 13232 S     1,7 13,3   1:03 mozilla-bin
  2039 tisi       9   0  6784 6784  6212 S     1,5  2,6   0:03 kdeinit
  2003 tisi       9   0  2216 2216  1840 S     0,9  0,8   0:02 gproc
  2014 tisi       9   0  1292 1292  1080 S     0,5  0,5   0:02 xosview
  2044 tisi      10   0   400  400   344 S     0,5  0,1   0:03 fireload_cpu
  2186 tisi      11   0  1056 1056   832 R     0,3  0,4   0:04 top
   159 root       9   0     0    0     0 SW    0,1  0,0   0:00 kjournald
  2017 tisi       9   0  1308 1308  1096 S     0,1  0,5   0:00 xosview
     1 root       9   0   516  516   448 S     0,0  0,2   0:04 init
     2 root       9   0     0    0     0 SW    0,0  0,0   0:00 keventd
     3 root       9   0     0    0     0 SW    0,0  0,0   0:21 kapm-idled
     4 root      19  19     0    0     0 SWN   0,0  0,0   0:00 ksoftirqd_CPU0
     5 root       9   0     0    0     0 SW    0,0  0,0   0:00 kswapd
     6 root       9   0     0    0     0 SW    0,0  0,0   0:00 bdflush

->wmtcp is a window-maker applet. When I kill it, X takes that amount of CPU.
->lirc_dev is a driver, that taint the kernel, but not made any problems before. 
CPU is even the same without it loaded.

$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
00:0f.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
00:10.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
00:10.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
00:14.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:14.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:14.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:14.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

I'm using gcc-2.96-98 from Redhat 7.2.

*Kristian

-- 
·· · · reach me :: · ·· ·· ·  · ·· · ··  · ··· · ·
                          :: http://www.korseby.net
                          :: http://www.tomlab.de
kristian@korseby.net ....::

