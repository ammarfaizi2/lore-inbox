Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVANOMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVANOMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVANOMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:12:40 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:5068 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S261994AbVANOMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:12:01 -0500
Date: Fri, 14 Jan 2005 15:12:22 +0100
From: Sander <sander@humilis.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-mm2] scsi0: Transmission error detected, and then hangs
Message-ID: <20050114141222.GA13783@favonius>
Reply-To: sander@humilis.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Uptime: 13:43:45 up 4 days, 15:26, 25 users,  load average: 1.00, 1.02, 1.07
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a server which hangs due to disk activity. The output of the scsi
driver (captured over serial) is below the dmesg part of the scsi
detection and initialisation.

The kernel used is 2.6.10-mm2, but I also see it with 2.6.10-rc3-mm1
The system is a dual Opteron 250 with 8GB ram and 4x 15k rpm scsi disks.

The four disks are divided in two partitions, with raid1 ext2 for /boot
(read only), and raid10 reiser3 for /
(rw,sync,data=journal,barrier=flush).

The / is mounted 'sync' to be more sure the data hit the platters before
the systems crashed (due to tests etc). (btw, should I mount it 'sync',
or is 'barrier=flush' (almost) as save?).

The distribution is up to date Debian gcc3.4 (64bit only), and that is
also the OS used to compile kernels:

gcc (GCC) 3.4.4 20041218 (prerelease) (Debian 3.4.3-7.0.0.1.gcc4)


After the systems spits out the "Dump Card State Begins" messages, I
have to reboot to get it back.

Can this be hardware? If not, can I provide more info on this?

Thanks in advance.

        Kind regards, Sander


# zcat /proc/config.gz |grep SCSI | grep y$
CONFIG_SCSI=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_AIC79XX=y
CONFIG_SCSI_QLA2XXX=y

===

(scsi0:A:0): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|RTI|QAS, 16bit)
(scsi0:A:1): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|RTI|QAS, 16bit)
(scsi0:A:2): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|RTI|QAS, 16bit)
(scsi0:A:3): 320.000MB/s transfers (160.000MHz RDSTRM|DT|IU|RTI|QAS, 16bit)
  Vendor: SEAGATE   Model: ST336753LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 128
  Vendor: SEAGATE   Model: ST336753LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 128
  Vendor: SEAGATE   Model: ST336753LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:2:0: Tagged Queuing enabled.  Depth 128
  Vendor: SEAGATE   Model: ST336753LC        Rev: 0006
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:3:0: Tagged Queuing enabled.  Depth 128
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
        <Adaptec AIC7902 Ultra320 SCSI adapter>
        aic7902: Ultra320 Wide Channel B, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
SCSI device sdd: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 71687372 512-byte hdwr sectors (36704 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2
Attached scsi disk sdd at scsi0, channel 0, id 3, lun 0


===


scsi0: Transmission error detected
LQISTAT1[0x8] LASTPHASE[0x1] SCSISIGI[0x60] PERRDIAG[0x4] 
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x28 Mode 0x22
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x24] SCSISIGI[0xb6] SCSIPHASE[0x4] SCSIBUS[0xff] 
LASTPHASE[0x1] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] 
SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] SSTAT0[0x2] 
SSTAT1[0x19] SSTAT2[0x20] SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0xc0] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1] 

SCB Count = 192 CMDS_PENDING = 1 LASTSCB 0xb CURRSCB 0x34 NEXTSCB 0xffc0
qinstart = 10464 qinfifonext = 10464
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
 52 FIFO_USE[0x1] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Total 1
Kernel Free SCB list: 11 2 62 90 14 15 108 36 92 107 111 23 35 10 6 46 0 61 18 68 12 42 60 122 75 72 5 95 1 110 112 119 53 50 34 19 43 25 30 4 28 85 93 125 102 105 113 70 80 87 71 91 82 86 100 116 22 118 97 84 7 120 69 126 9 98 96 73 76 67 117 115 64 114 54 78 88 89 94 109 81 79 77 106 101 99 83 127 65 121 124 74 104 123 103 37 41 45 29 33 17 27 31 51 21 13 24 16 38 48 58 44 57 40 32 47 49 39 59 56 55 63 8 26 20 3 66 189 190 191 184 185 186 187 180 181 182 183 176 177 178 179 172 173 174 175 168 169 170 171 164 165 166 167 160 161 162 163 156 157 158 159 152 153 154 155 148 149 150 151 144 145 146 147 140 141 142 143 136 137 138 139 132 133 134 135 128 129 130 131 188 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi0: FIFO0 Active, LONGJMP == 0x23a, SCB 0x34
SEQIMODE[0x3f] SEQINTSRC[0x40] DFCNTRL[0x8] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x13] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x16] SHADDR = 0x1f2b51800, SHCNT = 0x0 
HADDR = 0x1f2b51800, HCNT = 0x0 CCSGCTL[0x10] 
scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x5 0x0 0x0 0x34 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x34 0x0 0x0 0x0 0x2 0x0 
scsi0: LQISTATE = 0x2b, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
SIMODE0[0xc] 
CCSCBCTL[0x4] 
scsi0: REG0 == 0x34, SINDEX = 0x112, DINDEX = 0x102
scsi0: SCBPTR == 0xff34, SCB_NEXT == 0xff00, SCB_NEXT2 == 0x0
CDB 34 1 0 0 0 0
STACK: 0x14 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
LQICRC_NLQ
LQIRETRY for LQIPHASE_OUTPKT
scsi0:0:0:0: Attempting to abort cmd ffff8101fc755040: 0x28 0x0 0x0 0x5 0x78 0x1a 0x0 0x0 0x5a 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State at program address 0x197 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80] SEQINTSTAT[0x0] SAVED_MODE[0x11] 
DFFSTAT[0x23] SCSISIGI[0x0] SCSIPHASE[0x0] SCSIBUS[0x0] 
LASTPHASE[0xa0] SCSISEQ0[0x0] SCSISEQ1[0x12] SEQCTL0[0x0] 
SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x4] SSTAT0[0x0] 
SSTAT1[0x8] SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4] LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1] 

SCB Count = 192 CMDS_PENDING = 1 LASTSCB 0xb CURRSCB 0x34 NEXTSCB 0xff02
qinstart = 10464 qinfifonext = 10464
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
 52 FIFO_USE[0x0] SCB_CONTROL[0x60] SCB_SCSIID[0x7] 
Total 1
Kernel Free SCB list: 11 2 62 90 14 15 108 36 92 107 111 23 35 10 6 46 0 61 18 68 12 42 60 122 75 72 5 95 1 110 112 119 53 50 34 19 43 25 30 4 28 85 93 125 102 105 113 70 80 87 71 91 82 86 100 116 22 118 97 84 7 120 69 126 9 98 96 73 76 67 117 115 64 114 54 78 88 89 94 109 81 79 77 106 101 99 83 127 65 121 124 74 104 123 103 37 41 45 29 33 17 27 31 51 21 13 24 16 38 48 58 44 57 40 32 47 49 39 59 56 55 63 8 26 20 3 66 189 190 191 184 185 186 187 180 181 182 183 176 177 178 179 172 173 174 175 168 169 170 171 164 165 166 167 160 161 162 163 156 157 158 159 152 153 154 155 148 149 150 151 144 145 146 147 140 141 142 143 136 137 138 139 132 133 134 135 128 129 130 131 188 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi0: FIFO0 Active, LONGJMP == 0x262, SCB 0x34
SEQIMODE[0x3f] SEQINTSRC[0x40] DFCNTRL[0x8] DFSTATUS[0x81] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0xc] SHADDR = 0x011a9f41e, SHCNT = 0xe2 
HADDR = 0x011a9f41e, HCNT = 0xe2 CCSGCTL[0x10] 
scsi0: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f] SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89] 
SG_CACHE_SHADOW[0x2] SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5] SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10] 
LQIN: 0x8 0x0 0x0 0x34 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x1e 0x0 0x0 0x0 0x0 
scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
SIMODE0[0xc] 
CCSCBCTL[0x4] 
scsi0: REG0 == 0x6b, SINDEX = 0x107, DINDEX = 0x102
scsi0: SCBPTR == 0xff34, SCB_NEXT == 0xff00, SCB_NEXT2 == 0x0
CDB 34 1 0 0 0 0
STACK: 0x10c 0xf 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:2:0): 0 waiting
DevQ(0:3:0): 0 waiting
(scsi0:A:0:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
Recovery code awake
Timer Expired
Recovery code sleeping
Recovery code awake
Timer Expired
scsi0: Device reset returning 0x2003
Recovery SCB completes
Recovery SCB completes

-- 
Humilis IT Services and Solutions
http://www.humilis.net
