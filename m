Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262253AbSJJVCC>; Thu, 10 Oct 2002 17:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSJJVCC>; Thu, 10 Oct 2002 17:02:02 -0400
Received: from va.cs.wm.edu ([128.239.2.31]:55311 "EHLO va.cs.wm.edu")
	by vger.kernel.org with ESMTP id <S262253AbSJJVCA>;
	Thu, 10 Oct 2002 17:02:00 -0400
Date: Thu, 10 Oct 2002 17:07:42 -0400
From: Bruce Lowekamp <lowekamp@CS.WM.EDU>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre10-ac1/2.5.41 hda: DMA disabled, but it's not
Message-ID: <11730000.1034284062@chorus.cs.wm.edu>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a report of a suspicious message that is not really a problem, as 
far as I can tell.

With both 2.4.20-pre10-ac1 and 2.5.41 on an A7V266-E MB, hard drives hooked 
up to the VIA vt8233 IDE controller, on bootup messages about hda: DMA 
disabled appear, but as far as I can tell, it's not disabled, at least not 
by the time I can log into the system, and copying /proc/ide/via to /tmp 
right after / is remounted rw shows that it is UDMA enabled at that point.

This is a rh7.3 system.  I've tried to rule out that hdparm or sysctl is 
being run somewhere.  Nothing appears in rc.local or one of the scripts in 
/etc/rc.d/init.d.  /etc/sysctl.conf doesn't seem to have anything that 
would enable DMA, and USE_DMA=1 is commented out in 
/etc/sysconfig/harddisks.

Once the system is up, DMA appears to be enabled on hda.  /proc/ide/via 
shows it enabled, and bonnie++ gets good throughput (higher than 2.4.19 on 
sequential reads, slightly slower on writes).

If what's happening is that DMA is being disabled, then enabled, maybe 
either the disabled message should be removed or a message that it's being 
enabled should be added, because right now it looks rather suspicious.

Thanks,
Bruce


The messages that appear on bootup look like:
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci00:11.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L060AVER07-0, ATA DISK drive
hda: DMA disabled
blk: queue c030afc0, I/O limit 4095Mb (mask 0xffffffff)
hdc: TOSHIBA DVD-ROM SD-M1612, ATAPI CD/DVD-ROM drive
hdc: DMA disabled
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=7476/255/63, 
UDMA(100)
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
..skipping a bit..
hdc: DMA disabled

But /proc/ide/via is:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt8233
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0x9400
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                  no
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          20ns     600ns     120ns     600ns
Transfer Rate:   99.9MB/s   3.3MB/s  16.6MB/s   3.3MB/s


