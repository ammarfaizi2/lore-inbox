Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbRBGP1x>; Wed, 7 Feb 2001 10:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBGP1o>; Wed, 7 Feb 2001 10:27:44 -0500
Received: from cr636385-a.nmkt1.on.wave.home.com ([24.112.44.117]:2034 "helo
	cr636385-a.nmkt1.on.wave.home.com") by vger.kernel.org with SMTP
	id <S129027AbRBGP1c>; Wed, 7 Feb 2001 10:27:32 -0500
From: <glouis@dynamicro.on.ca>
Subject: 2.4.1-ac4 aic7xxx driver, heads-up re possible problem
Message-Id: <20010207152737Z129027-513+3874@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Date: Wed, 7 Feb 2001 10:27:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night I installed 2.4.1-ac4 remotely on two machines that had been
running -ac3.  Neither was essential to production so I rebooted
remotely to try it.  One of them works fine.  The other hangs at boot
with an interrupt synch problem (sorry, but I'm away from the office and
have only sketchy secondhand info; will reproduce Friday and supply
details if needed).  The contents of /proc/scsi/aic7xxx/0 follow for
each (the machine that failed has been rebooted with -ac3).

No failure, 2.4.1-ac4 running:

Adaptec AIC7xxx driver version: 5.2.2/5.2.0
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Enabled

Adapter Configuration:
           SCSI Adapter: Adaptec AHA-294X Ultra2 SCSI host adapter
                           Ultra-2 LVD/SE Wide Controller at PCI 0/11/0
    PCI MMAPed I/O Base: 0xe9000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 11
                   SCBs: Active 0, Max Active 1,
                         Allocated 31, HW 32, Page 255
             Interrupts: 67123
      BIOS Control Word: 0x18a6
   Adapter Control Word: 0x1c5d
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 15
  Transinfo settings: current(10/15/1/0), goal(10/15/1/0),
user(10/127/1/0)
  Total transfers 67029 (23273 reads and 43756 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+   64K+ 128K+
   Reads:    8996     455    8712    1511    1063    1328    900    308
  Writes:   10272    4717   10359    7676    3064    2896    2715  2057

(scsi0:0:4:0)
  Device using Narrow/Async transfers.
  Transinfo settings: current(0/0/0/0), goal(0/0/0/0), user(10/127/1/0)
  Total transfers 0 (0 reads and 0 writes)

===========================
2.4.1-ac4 fails to access disk, said to be an "interrupt synch
problem," 2.4.1-ac3 running:

Adaptec AIC7xxx driver version: 5.2.1/5.2.0
Compile Options:
  TCQ Enabled By Default : Disabled
  AIC7XXX_PROC_STATS     : Enabled

Adapter Configuration:
           SCSI Adapter: Adaptec AHA-294X Ultra SCSI host adapter
                           Ultra Wide Controller at PCI 0/11/0
    PCI MMAPed I/O Base: 0xe1800000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 10
                   SCBs: Active 0, Max Active 1,
                         Allocated 31, HW 16, Page 255
             Interrupts: 8065
      BIOS Control Word: 0x18b6
   Adapter Control Word: 0x005b
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0001
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Narrow/Sync transfers at 20.0 MByte/sec, offset 15
  Transinfo settings: current(12/15/0/0), goal(12/15/0/0),
user(12/15/1/0)
  Total transfers 7976 (4527 reads and 3449 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+   64K+  128K+
   Reads:      84       0    3281     166     493     233     264      6
  Writes:       0       0    2449     810     145      28       7     10


(scsi0:0:4:0)
  Device using Narrow/Sync transfers at 10.0 MByte/sec, offset 15
  Transinfo settings: current(25/15/0/0), goal(12/15/0/0),
user(12/15/1/0)
  Total transfers 0 (0 reads and 0 writes)

(scsi0:0:6:0)
  Device using Narrow/Sync transfers at 4.0 MByte/sec, offset 15
  Transinfo settings: current(59/15/0/0), goal(12/15/0/0),
user(12/15/1/0)
  Total transfers 0 (0 reads and 0 writes)

=================
More info Friday as mentioned; let me know if there's anything specific
i should try.

-- 
Greg Louis <glouis@dynamicro.on.ca>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
