Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317365AbSHVVs5>; Thu, 22 Aug 2002 17:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317378AbSHVVs5>; Thu, 22 Aug 2002 17:48:57 -0400
Received: from www.telenet.net ([204.97.152.225]:20747 "EHLO telenet.net")
	by vger.kernel.org with ESMTP id <S317365AbSHVVsz>;
	Thu, 22 Aug 2002 17:48:55 -0400
Date: Thu, 22 Aug 2002 17:24:26 -0400
From: Rob Speer <rob@twcny.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac4 IDE is slow
Message-ID: <20020822212426.GA662@twcny.rr.com>
Reply-To: rob@twcny.rr.com
References: <20020822175945.GA743@twcny.rr.com> <1030045828.14545.26.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1030045828.14545.26.camel@flory.corp.rackablelabs.com>
User-Agent: Mutt/1.4i
X-Is-It-Not-Nifty: www.sluggy.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As many people have asked in private e-mail, I'm providing some actual
numbers to justify that the IDE is slower.

I was also told to set the hdparm options -a 1 -b 1 -c 1 -d 1 -u 1. -d 1
doesn't work, as DMA doesn't work (perhaps that would solve all of this
if it did).

The results from 'hdparm -t /dev/hda':

On 2.4.20-pre1:
  Without hdparm options: 2.5 MB/sec
  With hdparm options: 4.17 MB/sec

On 2.4.20-pre2-ac4 (with a1.patch so it doesn't kernel panic on startup):
  Without hdparm options: ???
  With hdparm options: 877.21 kB/sec

The ??? is there because it actually *lies* in this situation. It says
it took 10.52 seconds, giving 6.08 MB/sec, but it actually takes as long
as it does with the hdparm options, if not longer.

The thing is, on -ac4, the entire system becomes unresponsive while
hdparm is going on. The clock in the corner of my screen stops counting.
With hdparm on, the clock jumps forward the appropriate amount at the
end. Without hdparm, the clock only jumps forward... 10 seconds.

Could the hard disk be preventing even the system clock from working?

As I was saying, I suppose this would all be wonderfully fast if DMA
worked. It seems that DMA fails for a different reason on each kernel.
On pre1 the error message is
  PCI: Device 00:1f.1 not available because of resource collisions
while on pre2, it's
  PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1


The complete IDE boot messages:
On pre1:

ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Device 00:1f.1 not available because of resource collisions
ICH4: (ide_setup_pci_device:) Could not enable device.
hda: C/H/S=19161/16/255 from BIOS ignored
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: IC35L060AVVA07-0, ATA DISK drive
hdc: DVDROM 8X, ATAPI CD/DVD-ROM drive
hdd: Memorex CDRW-2216, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63
hdb: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63
hdc: ATAPI DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 16X CD-ROM CD-R/RW drive, 1024kB Cache
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdb: hdb1 hdb2 hdb3 hdb4 
  

On pre2-ac4:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PCI: Unable to reserve I/O region #1:8@0 for device 00:1f.1
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <00000000-00000007>
Trying to free nonexistent resource <00000000-00000003>
Trying to free nonexistent resource <0000f000-0000f00f>
Trying to free nonexistent resource <1f800000-1f8003ff>
hda: C/H/S=19161/16/255 from BIOS ignored
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: IC35L060AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DVDROM 8X, ATAPI CD/DVD-ROM drive
hdd: Memorex CDRW-2216, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 78177792 sectors (40027 MB) w/1819KiB Cache, CHS=77557/16/63
hdb: host protected area => 1
hdb: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=7476/255/63
hdc: ATAPI DVD-ROM drive, 512kB Cache
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 16X CD-ROM CD-R/RW drive, 1024kB Cache
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdb: hdb1 hdb2 hdb3 hdb4

Is there any other information I should provide?
-- 
Rob Speer

