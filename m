Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSDNBn7>; Sat, 13 Apr 2002 21:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311564AbSDNBn6>; Sat, 13 Apr 2002 21:43:58 -0400
Received: from www.hr.vc-graz.ac.at ([193.171.240.3]:56071 "EHLO
	www.hr.vc-graz.ac.at") by vger.kernel.org with ESMTP
	id <S311536AbSDNBn5>; Sat, 13 Apr 2002 21:43:57 -0400
Message-ID: <3CB8DECF.CD89E999@fl.priv.at>
Date: Sun, 14 Apr 2002 03:43:43 +0200
From: Friedrich Lobenstock <fl@fl.priv.at>
Reply-To: linux-kernel@vger.kernel.org, Friedrich Lobenstock <fl@fl.priv.at>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Is this a SCSI termination problem, or what else?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm having trouble with a remote server. Can someone tell if the
message below comes from a scsi termination problem, or what else
could that possibly be?

Apr 12 02:48:27 backup kernel: (scsi1:0:3:-1) Unexpected busfree, LASTPHASE = 0xa0, SEQADDR = 0x162
Apr 12 02:48:28 backup kernel: st0: Error with sense data: Current st09:00: sns = 70  5
Apr 12 02:48:28 backup kernel: ASC=20 ASCQ= 0
Apr 12 02:48:28 backup kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0e 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 0x2c 0x01 0x00 0x00 0x00 0x00

This is with the old aic7xxx driver, but with the newer (Adaptec) aic7xxx
driver I get similar messages:

Apr 11 08:59:40 backup kernel: (scsi1:A:3:0): Unexpected busfree in Message-out phase
Apr 11 08:59:40 backup kernel: SEQADDR == 0x168
Apr 11 08:59:40 backup kernel: st0: Error 70000 (sugg. bt 0x0, driver bt 0x0, host bt 0x7).
Apr 11 08:59:40 backup kernel: st0: Error with sense data: Current st09:00: sns = 70  5
Apr 11 08:59:40 backup kernel: ASC=20 ASCQ= 0
Apr 11 08:59:40 backup kernel: Raw sense data:0x70 0x00 0x05 0x00 0x00 0x00 0x00 0x0e 0x00 0x00 0x00 0x00 0x20 0x00 0x00 0x00 0x2c 0x01 0x00 0x00 0x00 0x00


The setup:
backup:~ # uname -a
Linux backup 2.4.16-4GB #1 Fri Mar 22 15:38:04 GMT 2002 i686 unknown

backup:~ # cat /etc/SuSE-release
SuSE Linux 7.3 (i386)
VERSION = 7.3

backup:~ # cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: HP       Model: Ultrium 1-SCSI   Rev: E15D
  Type:   Sequential-Access                ANSI SCSI revision: 03

backup:~ # cat /proc/scsi/aic7xxx/1
Adaptec AIC7xxx driver version: 5.2.4/5.2.0
Compile Options:
  TCQ Enabled By Default : Enabled
  AIC7XXX_PROC_STATS     : Enabled

Adapter Configuration:
           SCSI Adapter: Adaptec AIC-7892 Ultra 160/m SCSI host adapter
                           Ultra-160/m LVD/SE Wide Controller at PCI 0/9/0
    PCI MMAPed I/O Base: 0xdffee000
 Adapter SEEPROM Config: SEEPROM found and used.
      Adaptec SCSI BIOS: Enabled
                    IRQ: 11
                   SCBs: Active 0, Max Active 1,
                         Allocated 31, HW 32, Page 255
             Interrupts: 159823
      BIOS Control Word: 0x08f4
   Adapter Control Word: 0x7c5d
   Extended Translation: Enabled
Disconnect Enable Flags: 0xffff
     Ultra Enable Flags: 0x0000
 Tag Queue Enable Flags: 0x0000
Ordered Queue Tag Flags: 0x0000
Default Tag Queue Depth: 24
    Tagged Queue By Device array for aic7xxx host instance 0:
      {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
    Actual queue depth per device for aic7xxx host instance 0:
      {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}

Statistics:

(scsi1:0:3:0)
  Device using Wide/Sync transfers at 80.0 MByte/sec, offset 15
  Transinfo settings: current(10/15/1/0), goal(9/127/1/0), user(9/127/1/2)
  Total transfers 159701 (2 reads and 159699 writes)
             < 2K      2K+     4K+     8K+    16K+    32K+    64K+   128K+
   Reads:       0       0       0       1       0       1       0       0
  Writes:       0       0       0   79866      11   79822       0       0

With the new driver loaded:
backup:~ # cat /proc/scsi/aic7xxx/1
Adaptec AIC7xxx driver version: 6.2.4
aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Channel A Target 0 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 1 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 2 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 3 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
        Goal: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
        Curr: 80.000MB/s transfers (40.000MHz, offset 15, 16bit)
        Channel A Target 3 Lun 0 Settings
                Commands Queued 3
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
Channel A Target 4 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 5 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 6 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 7 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 8 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 9 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 10 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 11 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 12 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 13 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 14 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)
Channel A Target 15 Negotiation Settings
        User: 160.000MB/s transfers (80.000MHz DT, offset 255, 16bit)

PS: As I'm not on this list please CC me on any replies. THX.

-- 
MfG / Regards
Friedrich Lobenstockk
