Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317772AbSFMP6f>; Thu, 13 Jun 2002 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317774AbSFMP6e>; Thu, 13 Jun 2002 11:58:34 -0400
Received: from gardeny.udl.es ([193.144.12.130]:56080 "EHLO marraco.udl.es")
	by vger.kernel.org with ESMTP id <S317772AbSFMP6c>;
	Thu, 13 Jun 2002 11:58:32 -0400
Date: Thu, 13 Jun 2002 16:02:17 +0200
From: Juan Manuel Gimeno Illa <jmgimeno@eup.udl.es>
To: linux-kernel@vger.kernel.org
Subject: [eepro100] System freezes while transferring large files
Message-ID: <20020613160217.A1150@kiai.udl.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I installed RedHat Linux 7.3 in a Toshiba Laptop (Satellite
1900-102) and I've been experiencing some system lock-ups while
fetching files from the net. 
I discarded problems with both RedCarpet and up2date because it happened
also while transferring large data with ftp, so I think it is the 
network
driver of the kernel. The problem occurs with both kernel-2.4.18-3 and
kernel-2.4.18-4

I have made some research and at the In the documentation from intel:

	Intel 82801BA I/O Controller Hub 2 and Intel 82801BAM

I have found the following paragraph:

    LAN Microcontroler PCI Protocol Violation
       Problem:
       When the ICH2/ICH2-M is receiving large files from a peer LAN 
device
    using the 10Mbps data rate, the ICH2/ICH2-M can cause a system 
lock-up.    Specifically if the LAN Controller has Standby Enable set 
(EEPROM Word 0Ah    bit-1 =1), while receiving large files usinf the 
10Mbps data rate and    receives a CU_RESUME command when it is just 
entering IDLE state, the
    ICH2/ICH2-M will cause a PCI proptocol violation (typically bu 
asserting
    FRAME# and IRDY# together) within the next few PCI cycles. This 
will cause
    the PCI bus to lock-up, further resulting in system lock-up.
       Implication:
       Large file transfers to the ICH2/ICH2-M using 10Mbps can cause 
the receiving
    system to lock-up.
       Workaround:
       Clear EEPROM Word 0Ah bit-1 to 0. This will result in an 
increase power
    consumption of the ICH2/ICH2-M of ~40mW
       Status:
       There are no plans to fix this erratum.

I have changed my ethernet connection to one of 100Mbps and, since the 
change, I
have not found any problem.

- Is there any configuration option to overcome the problem using 
10Mbps or any patch
I can apply to the eepro100 driver?

	Plase CC to my address the answer.

	Juan Manuel Gimeno

My /proc/modules is:

sr_mod                 16920   0 (autoclean)
i810_audio             23008   0 (autoclean)
ac97_codec             11904   0 (autoclean) [i810_audio]
soundcore               6692   2 (autoclean) [i810_audio]
radeon                 97400   1
agpgart                39488   3
eepro100               20336   1
parport_pc             18724   1 (autoclean)
lp                      8864   0 (autoclean)
parport                34208   1 (autoclean) [parport_pc lp]
binfmt_misc             7556   1
autofs                 12164   0 (autoclean) (unused)
ds                      8608   2
yenta_socket           12384   2
pcmcia_core            50752   0 [ds yenta_socket]
ipchains               43560   9
ide-scsi                9664   0
scsi_mod              108608   2 [sr_mod ide-scsi]
ide-cd                 30272   0
cdrom                  32192   0 [sr_mod ide-cd]
usb-uhci               24484   0 (unused)
usbcore                73152   1 [usb-uhci]
ext3                   67136   2
jbd                    49464   2 [ext3]

and my /proc/pci

PCI devices found:
   Bus  0, device   0, function  0:
     Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 4).
       Prefetchable 32 bit memory at 0xec000000 [0xefffffff].
   Bus  0, device   1, function  0:
     PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 4).
       Master Capable.  No bursts.  Min Gnt=12.
   Bus  0, device  30, function  0:
     PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 5).
       Master Capable.  No bursts.  Min Gnt=4.
   Bus  0, device  31, function  0:
     ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge 
(ICH2) (rev 5).
   Bus  0, device  31, function  1:
     IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 
(rev 5).
       I/O at 0x1800 [0x180f].
   Bus  0, device  31, function  2:
     USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub 
A) (rev 5).
       IRQ 5.
       I/O at 0x1820 [0x183f].
   Bus  0, device  31, function  3:
     SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 5).
       IRQ 11.
       I/O at 0x1810 [0x181f].
   Bus  0, device  31, function  4:
     USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub 
B) (rev 5).
       IRQ 11.
       I/O at 0x1840 [0x185f].
   Bus  0, device  31, function  5:
     Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) 
Chipset AC'97 Audio Controller (rev 5).
       IRQ 11.
       I/O at 0x1c00 [0x1cff].
       I/O at 0x1880 [0x18bf].
   Bus  0, device  31, function  6:
     Modem: Intel Corp. 82820 820 (Camino 2) Chipset AC'97 Modem 
Controller (rev 5).
       IRQ 11.
       I/O at 0x2400 [0x24ff].
       I/O at 0x2000 [0x207f].
   Bus  1, device   0, function  0:
     VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 
LY (rev 0).
       IRQ 5.
       Master Capable.  No bursts.  Min Gnt=8.
       Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
       I/O at 0x3000 [0x30ff].
       Non-prefetchable 32 bit memory at 0xe8000000 [0xe800ffff].
   Bus  2, device   0, function  0:
     CardBus bridge: Texas Instruments PCI1420 (rev 0).
       IRQ 5.
       Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
       Non-prefetchable 32 bit memory at 0xe8101000 [0xe8101fff].
   Bus  2, device   0, function  1:
     CardBus bridge: Texas Instruments PCI1420 (#2) (rev 0).
       IRQ 11.
       Master Capable.  Latency=168.  Min Gnt=192.Max Lat=5.
       Non-prefetchable 32 bit memory at 0xe8102000 [0xe8102fff].
   Bus  2, device   8, function  0:
     Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet 
Controller (rev 3).
       IRQ 11.
       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=56.
       Non-prefetchable 32 bit memory at 0xe8100000 [0xe8100fff].
       I/O at 0x4000 [0x403f].


-- 
Those who would give up essential Liberty, to purchase a little 
temporary Safety, deserve neither Liberty nor Safety.

Juan Manuel Gimeno Illa <jmgimeno@eup.udl.es>
+-> Dept. d'Informàtica i Enginyeria Industrial (DIEI)
     +-> Escola Universitària Politècnica (EUP)
         +-> Universitat de Lleida (UdL)
