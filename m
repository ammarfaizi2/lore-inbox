Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271756AbRH0P2t>; Mon, 27 Aug 2001 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271758AbRH0P2k>; Mon, 27 Aug 2001 11:28:40 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:61457 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S271756AbRH0P2Y>;
	Mon, 27 Aug 2001 11:28:24 -0400
Date: Mon, 27 Aug 2001 17:28:36 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: pcmcia ide (CF adapter) and exit resource munging 
Message-ID: <20010827172836.A7779@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
with 2.4.8 + pcmcia-cs modules 3.1.27 i see the problem that i put a
CF Card with the pcmcia adapter into the pcmcia slot - It gets detected
corrent and i mount the drive/vfat partition. Then i eject the card
(without unmounting) and the "virtual ide controller" does not get freed.
All processes still accessing the drive get killed which is completely ok

Means - the next time i insert a CF Card/Microdrive with the adapter
it does not get hde it gets hdg and so forth. It seems the driver
never realizes the controller has been gone.

[ ... dmesg output ... ]

hde: CFA, ATA DISK drive
ide2 at 0x100-0x107,0x10e on irq 5
hde: 128128 sectors (66 MB) w/4KiB Cache, CHS=1001/4/32
 hde: hde1
ide_cs: hde: Vcc = 3.3, Vpp = 0.0
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
VFS: Disk change detected on device ide2(33,1)
 hde: hde1
ide2: unexpected interrupt, status=0xff, count=2
Trying to free nonexistent resource <00000100-0000010f>
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,1)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
hdg: IBM-DSCM-11000, ATA DISK drive
ide3 at 0x110-0x117,0x11e on irq 10
hdg: 2104704 sectors (1078 MB) w/60KiB Cache, CHS=2088/16/63
 hdg: [PTBL] [522/64/63] hdg1
ide_cs: hdg: Vcc = 3.3, Vpp = 0.0
VFS: Disk change detected on device ide3(34,1)
 hdg: hdg1
VFS: Disk change detected on device ide3(34,1)
 hdg: hdg1
VFS: Disk change detected on device ide3(34,1)
 hdg: hdg1
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table
VFS: Disk change detected on device ide2(33,0)
 hde:hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
hde: drive not ready for command
ide2: reset timed-out, status=0xff
hde: status timeout: status=0xff { Busy }
end_request: I/O error, dev 21:00 (hde), sector 0
hde: drive not ready for command
 unable to read partition table

Flo
-- 
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
     Why is it called "common sense" when nobody seems to have any?
