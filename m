Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHaBl6>; Fri, 30 Aug 2002 21:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSHaBl5>; Fri, 30 Aug 2002 21:41:57 -0400
Received: from ns1.baby-dragons.com ([199.33.245.254]:52355 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S315717AbSHaBl4>; Fri, 30 Aug 2002 21:41:56 -0400
Date: Fri, 30 Aug 2002 21:46:21 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Run Away scsi_eh_1 ,  Load was still climbing .
Message-ID: <Pine.LNX.4.44.0208302118460.6840-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  Loaded a cdrom into a HP-2100 cd-rw for reading
	or I had hoped to .  did a mount .  & the little critter did the
	obvious thing & just kept on flashing its light at me .  So I hit
	the unload button which it did for about 500ms and reinserted
	itself .  Then the flashing light quit after about two iterations
	of flashing & stop & restart flashing .  Then the load began to
	climb ~ .15 Load avr. every 5 sec. ,  at about 2.0 I punched &
	help down the unload button & removed the cdrom .  At that time
	the load began to drop & scsi_erh_1 went back to sleep .
	Some specifics below .  Hth ,  JimL


  9:18pm  up 1 day, 23:41,  5 users,  load average: 1.85, 0.99, 0.48
55 processes: 54 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
CPU1 states:  0.0% user,  0.1% system,  0.0% nice, 99.4% idle
Mem:  2068200K av,  144980K used, 1923220K free,       0K shrd,    5048K buff
Swap:  656532K av,       0K used,  656532K free                   94576K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
    9 root      11   0     0    0     0 DW    0.1  0.0   0:00 scsi_eh_1
 7199 root      15   0   968  968   772 R     0.1  0.0   0:00 top
 ...


# tail -17 /var/log/syslog

kernel: sr0: CDROM not ready yet.
last message repeated 5 times
kernel: sym1:6:0: ABORT operation started.
kernel: sym1:6:control msgout: 80 6.
kernel: sym1:6:0: ABORT operation complete.
kernel: sr0: CDROM not ready.  Make sure there is a disc in the drive.
kernel: cdrom: open failed.
kernel: sym1:6:0: ABORT operation started.
kernel: sym1:6:0: ABORT operation timed-out.
kernel: sym1:6:0: DEVICE RESET operation started.
kernel: sym1:6:0: DEVICE RESET operation timed-out.
kernel: sym1:6:0: BUS RESET operation started.
kernel: sym1: SCSI BUS reset detected.
kernel: sym1: SCSI BUS has been reset.
kernel: sym1:6:0: BUS RESET operation complete.
kernel: sym1:4: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 15)


# sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux filesrv1 2.4.19 #1 SMP Sat Aug 3 16:01:37 EDT 2002 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0


# lspci -v | grep -A2 -e'^[[:alnum:]]' | grep -ve'^--'

00:00.0 Host bridge: Relience Computer CNB20HE (rev 23)
     Flags: fast devsel
     Memory at f4000000 (32-bit, prefetchable) [disabled] [size=32M]
00:00.1 PCI bridge: Relience Computer CNB20HE (rev 01) (prog-if 00 [Normal decode])
     Flags: bus master, 66Mhz, medium devsel, latency 64
     Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
00:00.2 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
     Flags: medium devsel
00:00.3 Host bridge: Relience Computer: Unknown device 0006 (rev 01)
     Flags: medium devsel
00:01.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0021 (rev 01)
     Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
     Flags: bus master, medium devsel, latency 72, IRQ 29
00:01.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0021 (rev 01)
     Subsystem: Symbios Logic Inc. (formerly NCR): Unknown device 1000
     Flags: bus master, medium devsel, latency 72, IRQ 28
00:02.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 09)
     Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
     Flags: bus master, slow devsel, latency 64, IRQ 30
00:04.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 05) (prog-if 00 [Normal decode])
     Flags: bus master, medium devsel, latency 64
     Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
00:04.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
     Subsystem: Mylex Corporation DAC960PX
     Flags: bus master, medium devsel, latency 64, IRQ 18
00:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
     Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter (PILA8470B)
     Flags: bus master, medium devsel, latency 64, IRQ 23
00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 51)
     Subsystem: Relience Computer: Unknown device 0200
     Flags: bus master, medium devsel, latency 0
00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
     Flags: bus master, medium devsel, latency 64
     I/O ports at ffa0 [size=16]
00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
     Subsystem: Relience Computer: Unknown device 0220
     Flags: medium devsel
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
     Subsystem: ATI Technologies Inc: Unknown device 0008
     Flags: bus master, stepping, 66Mhz, medium devsel, latency 64, IRQ 17

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

