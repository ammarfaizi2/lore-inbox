Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWH3Tk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWH3Tk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWH3TkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:40:25 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:57940 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1751392AbWH3TkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:40:22 -0400
Message-ID: <44F5E99D.2050902@tls.msk.ru>
Date: Wed, 30 Aug 2006 23:40:13 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Random scsi disk disappearing
References: <44E44B3E.10708@tls.msk.ru> <20060817113537.GK4340@parisc-linux.org> <44E4567B.4080104@tls.msk.ru>
In-Reply-To: <44E4567B.4080104@tls.msk.ru>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Matthew Wilcox wrote:
>> On Thu, Aug 17, 2006 at 02:55:58PM +0400, Michael Tokarev wrote:
> [sporadic disk disappearing, no logging]
>> I'd recommend turning on scsi logging; it might give you a clue about
>> which bit of scanning is failing to work properly.
>>
>> Try booting with scsi_mod.scsi_logging_level = 448 (I think I have that
>> number right; 7 shifted left by 6) and then you can compare failing and
>> non-failing runs and see if there's any difference.

Ok, yesterday it happened again.  This machine is running 2.6.11 still
(leftover - I'm updating it to current 2.6.17 now).

The controller is, according to lspci:

0000:04:04.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)

Here's the logging.  Too bad I don't understand most of this stuff ;)

Is it possible to say something from this or should I try different
log level or kernel version?

Thanks.

/mjt

16:25:35 SCSI error : <0 0 0 0> return code = 0x10000
16:25:36 end_request: I/O error, dev sda, sector 3003999
16:25:36 md: write_disk_sb failed for device sda2
16:25:36 SCSI error : <0 0 0 0> return code = 0x10000
16:25:36 end_request: I/O error, dev sda, sector 6263238
16:25:36 raid5: Disk failure on sda5, disabling device. Operation continuing on 3 devices
16:25:36 md: errors occurred during superblock update, repeating
16:25:36 SCSI error : <0 0 0 0> return code = 0x10000
16:25:36 end_request: I/O error, dev sda, sector 3003999
16:25:36 md: write_disk_sb failed for device sda2

.....repeated sequence of the above lines, with different sectors...

16:26:04 end_request: I/O error, dev sda, sector 3003999
16:26:04 scsi0:0:0:0: Attempting to abort cmd dbc10680: 0x2a 0x0 0x4 0x0 0x29 0x49md: write_disk_sb failed for device sda2
16:26:04  0x0 0x0 0x8 0x0

BTW, this should go in one line.  The machine is SMP... ;)

16:26:04 scsi0: At time of recovery, card was not paused
16:26:04 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
16:26:04 scsi0: Dumping Card State at program address 0x0 Mode 0x22
16:26:04 Card was paused
16:26:04 HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
16:26:04 SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11] DFFSTAT[0x31]:(CURRFIFO_1|FIFO0FREE|FIFO1FREE)
16:26:04 SCSISIGI[0x0]:(P_DATAOUT) SCSIPHASE[0x0] SCSIBUS[0x0]
16:26:04 LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) SCSISEQ0[0x0]
16:26:04 SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x10]:(FASTMODE)
16:26:04 SEQINTCTL[0x0] SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED)
16:26:04 SEQ_FLAGS2[0x0] SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE)
16:26:04 SSTAT2[0x0] SSTAT3[0x0] PERRDIAG[0x8]:(AIPERR) SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
16:26:04 LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x0] LQOSTAT0[0x0]
16:26:04 LQOSTAT1[0x0] LQOSTAT2[0x1]:(LQOSTOP0)
16:26:04
16:26:04 SCB Count = 128 CMDS_PENDING = 1 LASTSCB 0x4f CURRSCB 0x4f NEXTSCB 0xff40
16:26:04 qinstart = 34129 qinfifonext = 34129
16:26:04 QINFIFO:
16:26:04 WAITING_TID_QUEUES:
16:26:04 Pending list:
16:26:04  41 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7]
16:26:04 Total 1
16:26:04 Kernel Free SCB list: 126 78 79 12 127 10 93 113 30 96 49 37 73 33 52 95 103 27 72 106 71 18 61 85 83 110 20 87 94 75 115 8 51 99 45 22 3 92 50 86 125 28 48 15 122 63 107 80 114 70 36 23 104 26 2 16 68 42 21 64 118 7 81 67 59 88 117 34 24 82 105 25 31 84 4 76 58 91 66 11 121 102 14 1 97 57 44 120 29 65 39 100 89 74 6 124 32 35 54 17 69 19 111 55 47 46 5 53 77 0 112 109 9 119 60 101 108 13 38 40 98 62 56 116 43 123 90
16:26:04 Sequencer Complete DMA-inprog list:
16:26:04 Sequencer Complete list:
16:26:04 Sequencer DMA-Up and Complete list:
16:26:04
16:26:04 scsi0: FIFO0 Free, LONGJMP == 0x80ff, SCB 0x49
16:26:04 SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
16:26:04 SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
16:26:04 SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
16:26:04 SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
16:26:04 HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
16:26:04 scsi0: FIFO1 Free, LONGJMP == 0x8277, SCB 0x7e
16:26:04 SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
16:26:04 SEQINTSRC[0x0] DFCNTRL[0x4]:(DIRECTION) DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
16:26:04 SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
16:26:04 SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
16:26:04 HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x10]:(SG_CACHE_AVAIL)
16:26:04 LQIN: 0x55 0x0 0x0 0x7e 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
16:26:04 scsi0: LQISTATE = 0x0, LQOSTATE = 0x0, OPTIONMODE = 0x42
16:26:04 scsi0: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
16:26:04
16:26:04 SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
16:26:04 CCSCBCTL[0x0]
16:26:04 scsi0: REG0 == 0x4f, SINDEX = 0x122, DINDEX = 0xe1
16:26:04 scsi0: SCBPTR == 0x7e, SCB_NEXT == 0xff80, SCB_NEXT2 == 0xff62
16:26:04 CDB 2a 0 0 80 8 c8
16:26:04 STACK: 0x125 0x125 0x125 0x25e 0x240 0x25e 0x29 0x15
16:26:04 <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
16:26:04 DevQ(0:0:0): 0 waiting
16:26:04 DevQ(0:1:0): 0 waiting
16:26:04 DevQ(0:2:0): 0 waiting
16:26:04 DevQ(0:4:0): 0 waiting
16:26:04 (scsi0:A:0:0): Device is disconnected, re-queuing SCB
16:26:04 Recovery code sleeping
16:26:04 md: errors occurred during superblock update, repeating
16:26:04 Recovery SCB completes
16:26:04 Recovery code awake
16:26:14 scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 0 lun 0
16:26:14 SCSI error : <0 0 0 0> return code = 0x8000002
16:26:14 sda: Current: sense key: Aborted Command
16:26:14     Additional sense: No additional sense information
16:26:14 Info fld=0x0
16:26:14 end_request: I/O error, dev sda, sector 67119433
16:26:14 scsi0 (0:0): rejecting I/O to offline device
16:26:14 md: write_disk_sb failed for device sda6
16:26:14 md: write_disk_sb failed for device sda1
16:26:14 (scsi0:A:0): 320.000MB/s transfers (160.000MHz DT|IU|QAS, 16bit)
16:26:14 md: errors occurred during superblock update, repeating
16:26:14 scsi0 (0:0): rejecting I/O to offline device
16:26:14 md: write_disk_sb failed for device sda6
.....

