Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129891AbQK1QyK>; Tue, 28 Nov 2000 11:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129990AbQK1Qxx>; Tue, 28 Nov 2000 11:53:53 -0500
Received: from portraits.wsisiz.edu.pl ([195.205.208.34]:23843 "EHLO
        portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
        id <S129891AbQK1Qxs>; Tue, 28 Nov 2000 11:53:48 -0500
Date: Tue, 28 Nov 2000 17:22:58 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: Francois romieu <romieu@ensta.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
In-Reply-To: <20001128163305.A785@nic.fr>
Message-ID: <Pine.LNX.4.30.0011281713200.3863-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2000, Francois romieu wrote:

> > NETDEV WATCHDOG: eth0: transmit timed out
> > eth0: Transmit timeout using MII device, Tx status 0003.
> > eth0: Restarting the EPIC chip, Rx 4568454/4568454 Tx 6262613/6262623.
> > eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.
>
> Could you describe a way to reproduce it or be more specific regarding
> the hardware/load/whatever ?

Well, during the heavy load tranfser for example big files (iso images)
over FTP or sending backup files by Amanda to other the machine in the
same network.

Linux RedHat 7.0+upgrades (glibc 2.2)

[root@mask /root]# procinfo
Linux 2.4.0-test11 (root@mask.wsisiz.edu.pl) (gcc 2.96 20000731 ) #1 1CPU
[mask]
Memory:      Total        Used        Free      Shared     Buffers
Cached
Mem:        255804      230416       25388           0        2180
96472
Swap:       311300           4      311296

Bootup: Sat Nov 25 23:20:16 2000    Load average: 0.15 0.32 0.34 1/112
17056

user  :       5:13:02.51   7.9%  page in : 12874041
nice  :       0:02:59.64   0.1%  page out:  2702219
system:       2:42:42.61   4.1%  swap in :        2
idle  :   2d  9:57:42.91  87.9%  swap out:        1
uptime:   2d 17:56:27.67         context : 36996214

irq  0:  23738767 timer                 irq  7:     13183
irq  1:         2 keyboard              irq 10:  11915007 eth0
irq  2:         0 cascade [4]           irq 14:   1344730 ide0
irq  4:       106 serial                irq 15:    406003 ide1
irq  6:         3


[root@mask /root]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev  3).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe0000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev  3).
      Master Capable.  Latency=64.  Min Gnt=137.
  Bus  0, device   7, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.
      I/O at 0xf000 [0xf00f].
USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.
      I/O at 0x6400 [0x641f].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device  12, function  0:
  Ethernet controller: Standard Microsystems Corp [SMC] 83C170QF (rev 6).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=28.
      I/O at 0x6800 [0x68ff].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe8000fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: S3 Inc. ViRGE/GX2 (rev 6).
      IRQ 9.
      Master Capable.  Latency=64.  Min Gnt=4.Max Lat=255.
      Non-prefetchable 32 bit memory at 0xd8000000 [0xdbffffff].

[root@mask /root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 350.000800
cache size      : 512 KB


I have just found another strange message on this machine:

Attempt to read inode for relocated directory

What it means?

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
