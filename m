Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKIIgX>; Thu, 9 Nov 2000 03:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129678AbQKIIgN>; Thu, 9 Nov 2000 03:36:13 -0500
Received: from pivsbh1.ms.com ([199.89.64.103]:19615 "EHLO pivsbh1.ms.com")
	by vger.kernel.org with ESMTP id <S129231AbQKIIgC>;
	Thu, 9 Nov 2000 03:36:02 -0500
Message-ID: <3A0A61DC.BA5BAAC@msdw.com>
Date: Thu, 09 Nov 2000 08:35:40 +0000
From: Richard Polton <Richard.Polton@msdw.com>
Reply-To: Richard.Polton@msdw.com
Organization: Morgan Stanley Dean Witter & Co.
X-Mailer: Mozilla 4.7 [en]C-CCK-MCD   (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Subject: 2.4.0-test10 problems
Content-Type: multipart/mixed;
 boundary="------------5B3981525AB29F33D6284A57"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5B3981525AB29F33D6284A57
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

More testing and more problems 8-(  Mind you, that is not to say that
many
things do not work wonderfully, because they do ;-)

With regard to point one yesterday about the warm reboot problem, it was

suggested that I toggle the PnP BIOS option and retry. Well, I did that
and indeed
there was a difference. Now the machine never (in my limited testing
anyway ;-)
hangs after printing 'Restarting system'. Now, instead, it always (same
caveat)
hangs when trying to initialise the UHCI controller 8-(

(usb people can ignore the rest of this message)


Moving on (I have reported points four and six against previous 2.4.0
test versions
but had no response),

4. I rebuilt the kernel without IDE ATAPI CDROM but with IDE SCSI
emulation.
    echo scsi dump 0 > /proc/scsi/scsi causes an oops. I have not,
unfortunately,
    been successful in my attempts to feed the oops report into ksymoops
but I can
    tell you that it is dereferencing a null pointer and killing the
shell.

5. Still with IDE SCSI emulation, I inserted a DVD into my (correctly
detected ATAPI DVD-ROM
    drive) and tried to mount it as UDF. I saw loads of 'attempt to read
beyond end of device' messages.
    Note, however, that I am not entirely convinced that this is a real
UDF disk, but how
    can I tell? I can mount it as iso9660 with no problem.

6. Continuing with IDE SCSI emulation we move onto the parallel port
CDROM. With the
    same commands as yesterday (modprobe friq ; modprobe pcd ; mount
/dev/pcd0 /mnt/cdrom )
    I see a new message - Stuck DRQ and the disk is not mounted.
Additionally, this affects
    the 'intelligent' eject button in the unit meaning that the only way
to extract the disk is
    to switch off at the wall, then switch back on again and press
eject.

Attached are snippets from the syslog for items five and six.

Thanks,

Richard

--------------5B3981525AB29F33D6284A57
Content-Type: text/plain; charset=us-ascii;
 name="kernlog_scsi_udf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kernlog_scsi_udf"

Nov  8 22:52:38 turbocharged kernel: Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0 
Nov  8 22:52:38 turbocharged kernel: sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray 
Nov  8 22:52:38 turbocharged kernel: Uniform CD-ROM driver Revision: 3.11 
Nov  8 22:52:38 turbocharged kernel: VFS: Disk change detected on device sr(11,0) 
Nov  8 22:53:01 turbocharged kernel: udf: registering filesystem 
Nov  8 22:53:01 turbocharged kernel: UDF-fs DEBUG (lowlevel.c, 57): udf_get_last_session: XA disk: no, vol_desc_start=0 
Nov  8 22:53:01 turbocharged kernel: UDF-fs DEBUG (super.c, 1316): udf_read_super: Multi-session=0 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899698, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899186, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899074, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899694, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899182, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899070, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899398, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=898886, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=898774, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=899394, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=898882, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=898770, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=738222, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737710, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737598, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=738218, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737706, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737594, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737922, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737410, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737298, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737918, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737406, limit=352704 
Nov  8 22:53:01 turbocharged kernel: attempt to access beyond end of device 
Nov  8 22:53:01 turbocharged kernel: 0b:00: rw=0, want=737294, limit=352704 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 1325): udf_read_super: Lastblock=0 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 389): udf_vrs: Starting at sector 16 (2048 byte sectors) 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 416): udf_vrs: ISO9660 Primary Volume Descriptor found 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 425): udf_vrs: ISO9660 Volume Descriptor Set Terminator found 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 739): udf_load_pvoldesc: recording time 894978747/0, 1998/05/12 14:12 (103c) 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 749): udf_load_pvoldesc: volIdent[] = 'ALL_IS_FULL_OF_LOVE130599' 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 756): udf_load_pvoldesc: volSetIdent[] = '35584ABB' 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 856): udf_load_logicalvol: Partition (0) type 1 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 912): udf_load_logicalvol: FileSet found in LogicalVolDesc at block=0, partition=0 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 786): udf_load_partdesc: Searching map: (0 == 0) 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 835): udf_load_partdesc: Partition (0:0 type 1511) starts at physical 262, block length 176089 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 1136): udf_load_partition: Using anchor in block 256 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 711): udf_find_fileset: Fileset at block=0, partition=0 
Nov  8 22:53:02 turbocharged kernel: UDF-fs DEBUG (super.c, 772): udf_load_fileset: Rootdir at block=2, partition=0 
Nov  8 22:53:02 turbocharged kernel: UDF-fs INFO UDF 0.9.1 (2000/02/29) Mounting volume 'ALL_IS_FULL_OF_LOVE130599', timestamp 1998/05/12 13:12 (1000) 

--------------5B3981525AB29F33D6284A57
Content-Type: text/plain; charset=us-ascii;
 name="kernlog_pcd_scsi"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kernlog_pcd_scsi"

modprobe friq
modprobe pcd
mount /dev/pcd0 /mnt/cdrom1

Nov  8 22:56:19 turbocharged kernel: paride: version 1.05 installed 
Nov  8 22:56:19 turbocharged kernel: paride: friq registered as protocol 0 
Nov  8 22:56:38 turbocharged kernel: pcd: pcd version 1.07, major 46, nice 0 
Nov  8 22:56:38 turbocharged kernel: pcd0: friq 1.01, Freecom IQ ASIC-2 adapter at 0x378, mode 0 (4-bit), delay 1 
Nov  8 22:56:41 turbocharged kernel: pcd0: Master: R/RW 2x2x24 
Nov  8 22:56:41 turbocharged kernel: pcd0: mode sense capabilities completion: alt=0x53 stat=0x51 err=0x60 loop=42 phase=3 
Nov  8 22:56:41 turbocharged kernel: pcd0: mode sense capabilities: Sense key: 6, ASC: 29, ASQ: 0 
Nov  8 22:57:26 turbocharged kernel: pcd0: WARNING: ATAPI phase errors 
Nov  8 22:57:26 turbocharged kernel: pcd0: Stuck DRQ 
Nov  8 22:57:26 turbocharged kernel: pcd0: lock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:57:26 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:57:26 turbocharged kernel: VFS: Disk change detected on device pcd(46,0) 
Nov  8 22:57:40 turbocharged kernel: pcd0: read block before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:57:40 turbocharged kernel: end_request: I/O error, dev 2e:00 (PCD), sector 2 
Nov  8 22:58:08 turbocharged kernel: pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:58:08 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 

issue a second mount /dev/pcd0 /mnt/cdrom1

Nov  8 22:59:21 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:59:21 turbocharged kernel: cdrom: open failed. 
Nov  8 22:59:21 turbocharged kernel: pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:59:21 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 22:59:21 turbocharged kernel: VFS: Disk change detected on device pcd(46,0) 
Nov  8 23:00:16 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:00:16 turbocharged kernel: cdrom: open failed. 
Nov  8 23:00:16 turbocharged kernel: pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:00:16 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:00:16 turbocharged kernel: VFS: Disk change detected on device pcd(46,0) 
Nov  8 23:01:11 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:01:11 turbocharged kernel: cdrom: open failed. 
Nov  8 23:01:11 turbocharged kernel: pcd0: unlock door before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:01:11 turbocharged kernel: pcd0: Request sense before command: alt=0x58 stat=0x58 err=0x100 loop=160001 phase=2 
Nov  8 23:01:11 turbocharged kernel: VFS: Disk change detected on device pcd(46,0) 

--------------5B3981525AB29F33D6284A57--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
