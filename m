Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRIRNnb>; Tue, 18 Sep 2001 09:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIRNnU>; Tue, 18 Sep 2001 09:43:20 -0400
Received: from juicer46.bigpond.com ([144.135.25.133]:26064 "EHLO
	mta01ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S271329AbRIRNnD>; Tue, 18 Sep 2001 09:43:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: harisri <harisri@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: IDE related messages from linux-2.4.9-ac10
Date: Tue, 18 Sep 2001 23:42:23 +0000
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010918134314Z271329-760+13845@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My IDE configuration is as follows as provided by 'dmesg':
--------------------------------------------------------------------
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL CX10.2A, ATA DISK drive
hdb: RICOH CD-R/RW MP7083A, ATAPI CD/DVD-ROM drive
hdc: SAMSUNG SV1022D, ATA DISK drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-113 0113, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 20044080 sectors (10263 MB) w/418KiB Cache, CHS=1247/255/63
hdc: 19931184 sectors (10205 MB) w/472KiB Cache, CHS=19773/16/63

I got the following error messages when I tried to unmount '/dev/hdd':
-----------------------------------------------------------------------------------
hdd: irq timeout: status=0xd0 { Busy }
hdd: ATAPI reset complete
hdd: irq timeout: status=0xc0 { Busy }
hdd: ATAPI reset timed-out, status=0x80
hdc: DMA disabled
ide1: reset timed-out, status=0x80
hdd: status timeout: status=0x80 { Busy }
end_request: I/O error, dev 16:40 (hdd), sector 3040
hdd: drive not ready for command
hdd: status timeout: status=0x80 { Busy }
hdd: drive not ready for command
hdd: ATAPI reset timed-out, status=0x80
ide1: reset timed-out, status=0x80
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
end_request: I/O error, dev 16:40 (hdd), sector 0
Uniform CD-ROM driver unloaded

While I could successfully unmount the file system, the DVD drive's tray 
would not eject. I had to reboot the computer to eject the DVD :-(
The 'eject' command returned the following error message:
eject: unable to eject, last error: Invalid argument

I was worried after seeing these error messages, but I guess my data may not 
be at risk after reading similar posts. (Thanks to google) 

While it claimed that it disabled the DMA on /dev/hdc (the hard drive), I was 
able to set the DMA again successfully. (It was strange that the hard drive 
LED continued to glow even though there was no disk related activities)

The following error message appeared after the reboot:
-----------------------------------------------------------------
hda: set_drive_speed_status: status=0x58hda: dma_intr: status=0x58 { 
DriveReady SeekComplete DataRequest }
 { DriveReady SeekComplete DataRequest }
ide0: Drive 0 didn't accept speed setting. Oh, well.
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }

Of course I have enabled DMA for both /dev/hda and /dev/hdc (hard drives), 
and also 'VIA82CXXX chipset support' on linux kernel. (I only get 3 MB/sec 
without DMA, ~20 MB/sec otherwise)

The software configuration as provided by 'ver_linux':
---------------------------------------------------------------
Linux pengu 2.4.9-ac10 #1 Sat Sep 8 23:59:31 GMT 2001 i686 unknown
 
Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.11b
mount                  2.11b
modutils               2.4.1
e2fsprogs              1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1a
Linux C Library        x    1 root     root      1382179 Jan 19  2001 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         soundcore ppp_async ppp_generic slhc serial ext3 jbd

The hardware configuration as provided by 'lspci':
----------------------------------------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700e (rev 
12)
00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700f
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 06)
00:0c.1 Input device controller: Creative Labs SB Live! (rev 06)
01:05.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15)

Could this be a problem with the way I configured the kernel, or hardware, or 
linux kernel? I am not subscribed to this list, so please cc me if you can, 
else I can refer the kernel archives to find any responses.

Thanks in advance for your time, and keep up your good work at Linux kernel.
-- 
Hari.
harisri@bigpond.com

