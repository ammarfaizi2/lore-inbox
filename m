Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVKVRAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVKVRAp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbVKVRAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:00:45 -0500
Received: from 82-68-174-133.dsl.in-addr.zen.co.uk ([82.68.174.133]:28559 "EHLO
	winnipeg.principle.co.uk") by vger.kernel.org with ESMTP
	id S965008AbVKVRAo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:00:44 -0500
Date: Tue, 22 Nov 2005 16:59:13 +0000
From: Robie Basak <robie@8networks.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Panic with aic7xxx
Message-ID: <20051122165913.GA25825@alpha.winnipeg.8networks.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've had a SCSI-related panic on 2.4.31. This seems related to:
    http://www.ussg.iu.edu/hypermail/linux/kernel/0202.3/0038.html

I have aic7xxx compiled in, not as a module. /proc/scsi/aic7xxx/0 says
that I'm using driver version 6.2.36, higher than in the patch mentioned
there.

The eventual panic message is "Kernel panic: Loop 1", which seems
related to the above. I can't make sense of the rest.

We use a lot of these cards (Adaptec 2904), and this is the first time
this has happened - I doubt I can reproduce.

We believe it happened while trying to kill an afio process that was
hung trying to read from a tape. The drive is a DDS4, identifying as
"ARCHIVE  Model: Python 06408-XXX Rev: 9100"
(Seagate/Certance/Quantum/whoever it is this week).

Full text out of syslog, lspci, /proc/scsi/scsi and /proc/scsi/aic7xxx/0
below (all taken after a subsequent reboot).


syslog:

Nov 21 14:53:19 eccles kernel: scsi0:0:5:0: Attempting to queue an ABORT message
Nov 21 14:53:19 eccles kernel: CDB: 0x0 0x0 0x0 0x0 0x0 0x0
Nov 21 14:53:19 eccles kernel: scsi0: At time of recovery, card was paused
Nov 21 14:53:19 eccles kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Nov 21 14:53:19 eccles kernel: scsi0: Dumping Card State in Data-out phase, at SEQADDR 0x0
Nov 21 14:53:19 eccles kernel: Card was paused
Nov 21 14:53:19 eccles kernel: ACCUM = 0x0, SINDEX = 0x0, DINDEX = 0x0, ARG_2 = 0x0
Nov 21 14:53:19 eccles kernel: HCNT = 0x0 SCBPTR = 0x0
Nov 21 14:53:19 eccles kernel: SCSISIGI[0x0] ERROR[0x40] SCSIBUSL[0x0] LASTPHASE[0x0] 
Nov 21 14:53:19 eccles kernel: SCSISEQ[0x0] SBLKCTL[0xca] SCSIRATE[0x0] SEQCTL[0xa0] 
Nov 21 14:53:19 eccles kernel: SEQ_FLAGS[0x0] SSTAT0[0x0] SSTAT1[0x8] SSTAT2[0x0] 
Nov 21 14:53:19 eccles kernel: SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0x0] SXFRCTL0[0x0] 
Nov 21 14:53:19 eccles kernel: DFCNTRL[0x0] DFSTATUS[0x89] 
Nov 21 14:53:20 eccles kernel: STACK: 0x0 0x0 0x0 0x0
Nov 21 14:53:20 eccles kernel: SCB count = 5
Nov 21 14:53:20 eccles kernel: Kernel NEXTQSCB = 4
Nov 21 14:53:20 eccles kernel: Card NEXTQSCB = 0
Nov 21 14:53:20 eccles kernel: QINFIFO entries: 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 4 3 3 4 3 4 3 4 3 
Nov 21 14:53:20 eccles kernel: Waiting Queue entries: 0:255 1:255 3:255 7:255 15:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:
Nov 21 14:53:20 eccles kernel: 55 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 
Nov 21 14:53:20 eccles kernel: Disconnected Queue entries: 0:255 1:255 3:255 7:255 15:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:25
Nov 21 14:53:20 eccles kernel:  31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 31:255 
Nov 21 14:53:20 eccles kernel: QOUTFIFO entries: 
Nov 21 14:53:20 eccles kernel: Sequencer Free SCB List: 0 1 3 7 15 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 31 
Nov 21 14:53:20 eccles kernel: Sequencer SCB Info: 
Nov 21 14:53:20 eccles kernel:   0 SCB_CONTROL[0xc0] SCB_SCSIID[0x57] SCB_LUN[0x0] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   1 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:   9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  16 SCB_CONTROL[0xc0] SCB_SCSIID[0x57] SCB_LUN[0x0] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  17 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  18 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  19 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  20 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  21 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  22 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  23 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  24 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  25 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  26 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  27 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  28 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  29 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  30 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel:  31 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff] 
Nov 21 14:53:20 eccles kernel: Pending list: 
Nov 21 14:53:20 eccles kernel:   3 SCB_CONTROL[0x40] SCB_SCSIID[0x57] SCB_LUN[0x0] 
Nov 21 14:53:20 eccles kernel: Kernel Free SCB list: 2 1 0 
Nov 21 14:53:20 eccles kernel: Untagged Q(5): 3 
Nov 21 14:53:20 eccles kernel: DevQ(0:5:0): 0 waiting
Nov 21 14:53:20 eccles kernel: 
Nov 21 14:53:20 eccles kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Nov 21 14:53:20 eccles kernel: qinpos = 0, SCB index = 4
Nov 21 14:53:20 eccles kernel: Kernel panic: Loop 1
Nov 21 14:53:20 eccles kernel: 


lspci -vvv:

00:03.0 SCSI storage controller: Adaptec AHA-2940U2/W
        Subsystem: Adaptec: Unknown device a180
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (9750ns min, 6250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        BIST result: 00
        Region 0: I/O ports at ec00 [disabled] [size=256]
        Region 1: Memory at fe104000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


/proc/scsi/scsi:

Attached devices: 
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: ARCHIVE  Model: Python 06408-XXX Rev: 9100
  Type:   Sequential-Access                ANSI SCSI revision: 03


/proc/scsi/aic7xxx/0:

Adaptec AIC7xxx driver version: 6.2.36
Adaptec 2940 Ultra2 SCSI adapter
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Allocated SCBs: 5, SG List Length: 102

Serial EEPROM:
0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 
0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 
0x18a6 0x1c5d 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x98bf 

Target 0 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 1 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 2 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 3 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 4 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 5 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
	Goal: 40.000MB/s transfers (20.000MHz, offset 32, 16bit)
	Curr: 40.000MB/s transfers (20.000MHz, offset 32, 16bit)
	Channel A Target 5 Lun 0 Settings
		Commands Queued 1201708
		Commands Active 0
		Command Openings 1
		Max Tagged Openings 0
		Device Queue Frozen Count 0
Target 6 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 7 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 8 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 9 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 10 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 11 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 12 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 13 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 14 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 15 Negotiation Settings
	User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
