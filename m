Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbRBHL4c>; Thu, 8 Feb 2001 06:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131074AbRBHL4W>; Thu, 8 Feb 2001 06:56:22 -0500
Received: from linux2.viasys.com ([194.100.28.129]:1541 "HELO mail.viasys.com")
	by vger.kernel.org with SMTP id <S131156AbRBHL4L>;
	Thu, 8 Feb 2001 06:56:11 -0500
Date: Thu, 8 Feb 2001 13:56:06 +0200
From: Ville Herva <vherva@viasys.com>
To: dledford@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Aic7xxx troubles with 2.4.1ac6
Message-ID: <20010208135606.F2223@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like ac6 (which I believe includes the patch you posted) is
still a no-go with 7892. The boot halts and it just prints this once a
second:

(SCSI0:0:3:1) Synchronous at 160 Mbyte/sec offset 31
(SCSI0:0:3:1) CRC error during data in phase
(SCSI0:0:3:1)   CRC error in intermediate CRC packet

This happens also with ac5+the small patch you posted earlier. ac2 works
fine (although something did corrupt my MBR while using it. It is still
a complete mystery to me what could have done it. Now I'm unable to
boot NT; linux of course works with the boot floppy.)


ac2 dmesg's:

SCSI subsystem driver Revision: 1.00
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
3/9/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
(scsi0:0:3:0) Synchronous at 80.0 Mbyte/sec, offset 31.
  Vendor: QUANTUM   Model: ATLAS 10K 18WLS   Rev: UCHK
  Type:   Direct-Access                      ANSI SCSI revision: 03
Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
SCSI device sda: 35566480 512-byte hdwr sectors (18210 MB)
Partition check:
 /dev/scsi/host0/bus0/target3/lun0: p1 p2 p3


cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 5.2.1/5.2.0
Compile Options:
  TCQ Enabled By Default : Enabled
  AIC7XXX_PROC_STATS     : Enabled

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7892 Ultra 160/m SCSI host adapter
                           Ultra-160/m LVD/SE Wide Controller at PCI 3/9/0
    PCI MMAPed I/O Base: 0xfc8ff000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 10
                   SCBs: Active 0, Max Active 8,
                         Allocated 31, HW 32, Page 255
             Interrupts: 42493
      BIOS Control Word: 0x58a4
   Adapter Control Word: 0x1c5e
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0008
Ordered Queue Tag Flags: 0x0008
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:3:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 31
  Transinfo settings: current(10/31/1/0), goal(10/127/1/0),
user(9/127/1/2)
  Total transfers 42420 (34614 reads and 7806 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+   128K+
   Reads:      39       0   25175    3674    4257     946     433      90
  Writes:       0       0    3558    1864     502     480     455     947

cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 18WLS  Rev: UCHK
  Type:   Direct-Access                    ANSI SCSI revision: 03


-- 
Ville Herva            vherva@viasys.com             +358-50-5164500
Viasys Oy              Hannuntie 6  FIN-02360 Espoo  +358-9-2313-2160
PGP key available: http://www.iki.fi/v/pgp.html  fax +358-9-2313-2250
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
