Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbVHGQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbVHGQsK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbVHGQsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:48:09 -0400
Received: from smtp1.libero.it ([193.70.192.51]:35564 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S1752321AbVHGQsJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:48:09 -0400
Date: Sun, 7 Aug 2005 18:48:24 +0200
From: andrea gelmini <andrea.gelmini@linux.it>
To: linux-kernel@vger.kernel.org
Subject: DMA problem with kernel >2.6.10
Message-ID: <20050807164824.GA3312@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.10
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	I'm trying to figure out the reason of my laptop problem.
	I beg your help to find the right way to debug it (I mean,
	I don't want to flood the mailing list with useless details,
	and so on).
	Well, let's try...
	
	Hardware: Toshiba Satellite P20 (P4-3200 MHz, 512MB RAM) [1]
	Software: Debian Unstable
	GCC: 3.4.5 [2]
	Memtest86+: v.1.60 (stress tools, CPU/RAM and so on, are all happy)
	Problem: with kernel <=2.6.10 everything is all right...
	but with any kernel released after 2.6.10 (pre, rc, stable, mm, and
	so on), I've got this:

hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
Losing too many ticks!
TSC cannot be used as a timesource.
Possible reasons for this are:
  You're running with Speedstep,
  You don't have DMA enabled for your hard disk (see hdparm),
  Incorrect TSC synchronization on an SMP system (see dmesg).
Falling back to a sane timesource now.
hda: dma_timer_expiry: dma status == 0x21
hda: DMA timeout error
hda: dma timeout error: status=0xd0 { Busy }

ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success
	
	after a stress activity of the hd (I can achieve this by unrar big
	files, or using 'iozone -A').
	I wanna make it clear: with 2.6.10, HD can work for days without
	rest/poweroff/reboot.
	It's enough to switch to another kernel >2.6.10 to have the
	problem.
	With some kernel, system simply freeze, with other it survive and
	gives the DMA notice. Anyway, when it happens, I've got a big filesystem
	corruption (I tried both ext2 and ext3).
	It happen quickly if I do also something like this:
	
	cd /proc/sys/vm
	echo 100 > dirty_background_ratio
	echo 1000000 > dirty_expire_centisecs
	echo 100 > dirty_ratio
	echo 1000000 > dirty_writeback_centisecs
	
	It could be useful to apply all 2.6.11 patch to 2.6.10 *but* the
	IDE layer?
	
	Or, which are really useful information about it?

Thanks a lot for your time and work,
Andrea

---

[1] Sorry, I didn't find an official homepage. anyway:
(lspci)
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:00:1f.6 Modem: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Modem Controller (rev 02)
0000:01:00.0 VGA compatible controller: nVidia Corporation NV34M [GeForce FX Go 5200] (rev a1)
0000:02:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
0000:02:01.0 Ethernet controller: Realtek Semiconductor Co., Ltd.  RTL-8139/8139C/8139C+ (rev 10)
0000:02:04.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
0000:02:04.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
0000:02:06.0 System peripheral: Toshiba America Info Systems SD TypA Controller (rev 03)

(dmidecode)
                Vendor: TOSHIBA
                Version: V1.20
                Release Date: 06/24/2003
                Address: 0xE4DF0
                Runtime Size: 111120 bytes
                ROM Size: 512 kB
		Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: TOSHIBA
                Product Name: Satellite P20
        Processor Information
                Socket Designation: NWD
                Type: Central Processor
                Family: Pentium 4
                Manufacturer: Intel
                ID: 29 0F 00 00 FF FB EB BF
                Signature: Type 0, Family 15, Model 2, Stepping 9
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: M1
                Bank Connections: 0 1
                Current Speed: Unknown
                Type: DIMM SDRAM
                Installed Size: 256 MB (Double-bank Connection)
                Enabled Size: 256 MB (Double-bank Connection)
                Error Status: OK
        DMI type 6, 12 bytes.
        Memory Module Information
                Socket Designation: M2
                Bank Connections: 4 5
                Current Speed: Unknown
                Type: DIMM SDRAM
                Installed Size: 256 MB (Double-bank Connection)
                Enabled Size: 256 MB (Double-bank Connection)
                Error Status: OK

[2]
Reading specs from /usr/lib/gcc/i486-linux-gnu/3.4.5/specs
Configured with: ../src/configure -v --enable-languages=c,c++,java,f77,pascal,objc,ada,treelang --prefix=/usr --libexecdir=/usr/lib --with-gxx-include-dir=/usr/include/c++/3.4 --enable-shared --with-system-zlib --enable-nls --without-included-gettext --program-suffix=-3.4 --enable-__cxa_atexit --enable-libstdcxx-allocator=mt --enable-clocale=gnu --enable-libstdcxx-debug --enable-java-gc=boehm --enable-java-awt=gtk --disable-werror i486-linux-gnu
Thread model: posix
gcc version 3.4.5 20050706 (prerelease) (Debian 3.4.4-5)

