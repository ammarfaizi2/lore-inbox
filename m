Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbQKKQ1H>; Sat, 11 Nov 2000 11:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbQKKQ06>; Sat, 11 Nov 2000 11:26:58 -0500
Received: from nat-ip.networkers.dk ([194.239.251.254]:4314 "EHLO
	marvin.framfab.dk") by vger.kernel.org with ESMTP
	id <S131219AbQKKQ0m> convert rfc822-to-8bit; Sat, 11 Nov 2000 11:26:42 -0500
Message-ID: <3A0D7346.1C646F5@framfab.dk>
Date: Sat, 11 Nov 2000 17:26:46 +0100
From: Anders Peter Fugmann <anders.fugmann@framfab.dk>
Organization: Framfab
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem detecting QUANTUM scsi disks in Wide mode.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm having problems with an Adaptec AIC-7890/1 Ultra2 SCSI adapter.
under kernel 2.4.0-test10.

Under boot, the the two Quantum scsi disks are not detected correctly,
and the root partition could not be mounted (because it could not find
the disks). 

Written of the screen:
	Host:   scsi0 channel:  00 Id: 01  Lun:00
	Vendor: ÉP      Model: @L       rev: P
	Type:   Unknown                 ANSI SCSI revision: 00
	Host:   scsi0 channel:  00 Id: 02  Lun:00
	Vendor: ÉP      Model: @L       rev: P
	Type:   Unknown                 ANSI SCSI revision: 00

Going into the scsi bios, and setting the scsi transfer to narrow (40Mb
instead of 80Mb)
corrects the problem. Is there any solution to this problem, or won't I
ever get my discs up and running 80Mb/sec?

Btw. They both gets detected correctly in 2.2.16 in wide mode.
The mobo is a P2B-DS, with two PIII-550 Mhz CPU's

> cat \proc\scsi\scsi
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9WLS   Rev: UCP0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9WLS   Rev: UCP0
  Type:   Direct-Access                    ANSI SCSI revision: 03

>cat /proc/scsi/aic7xxx/0
Adaptec AIC7xxx driver version: 5.2.1/5.2.0
Compile Options:
  TCQ Enabled By Default : Enabled
  AIC7XXX_PROC_STATS     : Enabled

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7890/1 Ultra2 SCSI host adapter
                           Ultra-2 LVD/SE Wide Controller at PCI 0/6/0
    PCI MMAPed I/O Base: 0xcc000000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 19
                   SCBs: Active 0, Max Active 16,
                         Allocated 31, HW 32, Page 255
             Interrupts: 53607
      BIOS Control Word: 0x1886
   Adapter Control Word: 0x1c1e
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0003
Ordered Queue Tag Flags: 0x0003
Default Tag Queue Depth: 8
    Tagged Queue By Device array for aic7xxx host instance 0:
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    Actual queue depth per device for aic7xxx host instance 0:
      {8,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi0:0:0:0)
  Device using Narrow/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(10/31/0/0), goal(10/127/0/0),
user(10/127/0/0)
  Total transfers 32157 (9525 reads and 22632 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+  
128K+
   Reads:      18       0    6983     807     354     413     950      
0
  Writes:       0       0   18640    3822     121      22      27      
0


(scsi0:0:1:0)
  Device using Narrow/Sync transfers at 40.0 MByte/sec, offset 31
  Transinfo settings: current(10/31/0/0), goal(10/127/0/0),
user(10/127/0/0)
  Total transfers 21348 (9521 reads and 11827 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+  
128K+
   Reads:       7       0    7003     809     352     398     952      
0
  Writes:       0       0   10492    1184      55      68      28      
0



Regards 
Anders Fugmann
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
