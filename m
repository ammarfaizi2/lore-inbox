Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278346AbRJ1NSc>; Sun, 28 Oct 2001 08:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278320AbRJ1NSW>; Sun, 28 Oct 2001 08:18:22 -0500
Received: from chello212017085031.13.vie.surfer.at ([212.17.85.31]:54409 "EHLO
	www.tud.at") by vger.kernel.org with ESMTP id <S278346AbRJ1NSE>;
	Sun, 28 Oct 2001 08:18:04 -0500
Message-ID: <3BDC05AD.432CCA22@tud.at>
Date: Sun, 28 Oct 2001 14:18:37 +0100
From: =?iso-8859-2?Q?S=E1ndor=20B=E1r=E1ny?= <bs@tud.at>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i586)
X-Accept-Language: en, de-DE, de-AT, hu
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: 2.4.13 issue: /dev/null flags reset to 600
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading to 2.4.13 I recognised some programs are complaining
about /dev/null. 
And yes, /dev/null flags were changed to crw------- , again and again.

It turned out that happens every morning when my cron.daily scripts run.
And more specifically it happens every time when:
1. sensord (version 0.5.0) is restarted (in about one-two seconds after
sensord starts again)
2. syslog-ng (1.5.9) initalizes after boot, is restarted, or get a kill
-1 (the flags change at the next minute when syslog-ng awakes).

I went back to 2.4.9 and was not able to reproduce the same there. Tried
out in 2.4.13 also with and without devfs, it does not matter; however
in the boot sequence with devfs there is (a perhaps unrelated) error in
reparent_to_init

sr1: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda tray
Adding Swap: 40952k swap-space (priority -2)
Adding Swap: 136512k swap-space (priority -3)
eth0: Setting half-duplex based on auto-negotiated partner ability 0000.
******
task `ifconfig' exit_signal 17 in reparent_to_init
******
Real Time Clock Driver v1.10e
parport0: PC-style at 0x378 [PCSPP(,...)]

I would be glad to supply more debug info - please ask for them
specifically.

Some general system info:

Debian, testing;
Linux version 2.4.13 (root@zsuzsi) (gcc version 2.95.4 20011006 (Debian
prerelease)) #4 Sat Oct 27 17:24:05 CEST 2001
Kernel command line: BOOT_IMAGE=current ro root=307 pci=biosirq
devfs=nomount
Memory: 127124k/131056k available (832k kernel code, 3544k reserved,
212k data, 212k init, 0k highmem)
CPU: AMD-K6(tm) 3D processor stepping 0c
PCI: PCI BIOS revision 2.10 entry at 0xf0560, last bus=1
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
i2c-proc.o version 2.6.1 (20010825)
w83781d.o version 2.6.1 (20010830)

Sándor /* not kernel hacker */
