Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752373AbVHGRGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbVHGRGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 13:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbVHGRGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 13:06:34 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:54225 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1752372AbVHGRGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 13:06:33 -0400
From: dth@picard.cistron.nl (Danny ter Haar)
Subject: Re: rc5 seemed to kill a disk that rc4-mm1 likes.  Also some X
 trouble.
Date: Sun, 7 Aug 2005 17:06:27 +0000 (UTC)
Organization: Cistron
Message-ID: <dd5f2j$fj7$1@news.cistron.nl>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <20050805150506.703e804f.akpm@osdl.org>
X-Trace: ncc1701.cistron.net 1123434387 15975 62.216.30.70 (7 Aug 2005 17:06:27 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@picard.cistron.nl (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@osdl.org> wrote:
>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>> 2.6.13-rc5 seemed to kill a scsi disk (sdb) for me, where 2.6.13-rc4-mm1
>> have no problems with the same disk.

Sort of same with me:
2.6.12-mm1 runs for _weeks_ where others keep crashing:

>The latest -git kernel (or 2.6.13-rc6 if it's there) with APCI enabled is
>the one to test, please.

no rc6 yet, i did however experience the following:

reboot   system boot  2.6.12-mm1       Sun Aug  7 18:20          (00:36)
dth      pts/1        zaphod.dth.net   Sun Aug  7 15:41 - crash  (02:38)
reboot   system boot  2.6.13-rc5-git5  Sun Aug  7 14:04          (04:52)
reboot   system boot  2.6.13-rc5-git4  Sun Aug  7 10:05          (03:43)
reboot   system boot  2.6.13-rc5-git3  Fri Aug  5 16:55         (1+17:07)

git3 lasted near 2 days
git4 ran for nearly 5 hours than i upgraded to
git5 didn't last longer than 2.5 hours

Fortunatly some info was found in the log files.
What i dont "get" is that ethernet also goes down when the scsi
controller goes bezerk.
I'm pretty sure it's not a hardware problem since 2.6.12-mm1 survives
and brings this usenet host in the worldwide top 1000.

>From the log files:

scsi1: Transmission error detected
LQISTAT1[0x8]:(LQICRCI_NLQ) LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) 
SCSISIGI[0x60]:(P_DATAIN_DT) PERRDIAG[0x4]:(CRCERR) 
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x11 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK) 
SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11] 
DFFSTAT[0x24]:(CURRFIFO_0|FIFO1FREE) SCSISIGI[0xb6]:(P_MESGOUT|REQI|BSYI|ATNI) 
SCSIPHASE[0x4]:(MSG_OUT_PHASE) SCSIBUS[0xff] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) 
SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) 
SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] 
SSTAT0[0x2]:(SPIORDY) SSTAT1[0x19]:(REQINIT|BUSFREE|PHASEMIS) 
SSTAT2[0x20]:(NONPACKREQ) SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
LQISTAT0[0x0] LQISTAT1[0x8]:(LQICRCI_NLQ) LQISTAT2[0xc0]:(LQIPHASE_OUTPKT|PACKETIZED) 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT) 

SCB Count = 128 CMDS_PENDING = 2 LASTSCB 0x34 CURRSCB 0x8 NEXTSCB 0xffc0
qinstart = 15426 qinfifonext = 15426
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  8 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47] 
 66 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47] 
Total 2
Kernel Free SCB list: 53 94 52 127 115 73 21 114 63 37 22 117 93 92 64 1 41 88 43 121 68 50 91 46 122 56 80 30 104 116 34 48 7 105 3 39 58 81 112 119 28 27 62 4 17 120 24 103 0 49 101 106 32 47 75 69 11 95 42 65 96 14 67 72 89 108 13 36 125 44 51 71 20 54 38 90 82 85 31 59 76 60 6 97 33 5 124 16 25 111 18 15 19 87 107 23 123 99 110 10 84 29 100 74 55 118 40 9 126 113 12 61 77 98 79 109 2 78 102 57 70 35 83 45 86 26 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Active, LONGJMP == 0x232, SCB 0x42
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 
SEQINTSRC[0x0] DFCNTRL[0x8]:(HDMAEN) DFSTATUS[0xc9]:(FIFOEMP|HDONE|PKT_PRELOAD_AVAIL|PRELOAD_AVAIL) 
SG_CACHE_SHADOW[0x78] SG_STATE[0x3]:(SEGS_AVAIL|LOADING_NEEDED) 
DFFSXFRCTL[0x0] SOFFCNT[0x0] MDFFSTAT[0x6]:(DATAINFIFO|DLZERO) 
SHADDR = 0x048b4000, SHCNT = 0x0 HADDR = 0x048b4000, HCNT = 0x0 
CCSGCTL[0x10]:(SG_CACHE_AVAIL) 
scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0] 
LQIN: 0x4 0x0 0x0 0x42 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x28 0x0 0x0 0x0 0x2 0x0 
scsi1: LQISTATE = 0x2b, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
SIMODE0[0xc]:(ENOVERRUN|ENIOERR) 
CCSCBCTL[0x0] 
scsi1: REG0 == 0x42, SINDEX = 0x178, DINDEX = 0x10a
scsi1: SCBPTR == 0x35, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff39
CDB 28 0 c 80 70 a4
STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:14:0): 0 waiting
DevQ(0:15:0): 0 waiting
LQICRC_NLQ
eth0: Optical link DOWN
eth0: Optical link UP (Full Duplex, Flow Control: TX RX)
scsi1: Unexpected PKT busfree condition
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State at program address 0x11 Mode 0x33
Card was paused
HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK) 
SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11] 
DFFSTAT[0x24]:(CURRFIFO_0|FIFO1FREE) SCSISIGI[0xb6]:(P_MESGOUT|REQI|BSYI|ATNI) 
SCSIPHASE[0x4]:(MSG_OUT_PHASE) SCSIBUS[0xff] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE) 
SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) 
SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0] 
SSTAT0[0x2]:(SPIORDY) SSTAT1[0x19]:(REQINIT|BUSFREE|PHASEMIS) 
SSTAT2[0x20]:(NONPACKREQ) SSTAT3[0x0] PERRDIAG[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO) 
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0xc0]:(LQIPHASE_OUTPKT|PACKETIZED) 
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT) 

SCB Count = 128 CMDS_PENDING = 2 LASTSCB 0x34 CURRSCB 0x8 NEXTSCB 0xffc0
qinstart = 15426 qinfifonext = 15426
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
  8 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47] 
 66 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47] 
Total 2
Kernel Free SCB list: 53 94 52 127 115 73 21 114 63 37 22 117 93 92 64 1 41 88 43 121 68 50 91 46 122 56 80 30 104 116 34 48 7 105 3 39 58 81 112 119 28 27 62 4 17 120 24 103 0 49 101 106 32 47 75 69 11 95 42 65 96 14 67 72 89 108 13 36 125 44 51 71 20 54 38 90 82 85 31 59 76 60 6 97 33 5 124 16 25 111 18 15 19 87 107 23 123 99 110 10 84 29 100 74 55 118 40 9 126 113 12 61 77 98 79 109 2 78 102 57 70 35 83 45 86 26 
Sequencer Complete DMA-inprog list: 
Sequencer Complete list: 
Sequencer DMA-Up and Complete list: 

scsi1: FIFO0 Active, LONGJMP == 0x232, SCB 0x42
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 
SEQINTSRC[0x0] DFCNTRL[0x8]:(HDMAEN) DFSTATUS[0xc9]:(FIFOEMP|HDONE|PKT_PRELOAD_AVAIL|PRELOAD_AVAIL) 
SG_CACHE_SHADOW[0x78] SG_STATE[0x3]:(SEGS_AVAIL|LOADING_NEEDED) 
DFFSXFRCTL[0x0] SOFFCNT[0x0] MDFFSTAT[0x6]:(DATAINFIFO|DLZERO) 
SHADDR = 0x048b4000, SHCNT = 0x0 HADDR = 0x048b4000, HCNT = 0x0 
CCSGCTL[0x10]:(SG_CACHE_AVAIL) 
scsi1: FIFO1 Free, LONGJMP == 0x8063, SCB 0x3
SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS) 
SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL) 
SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0] 
SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0 
HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0] 
LQIN: 0x4 0x0 0x0 0x42 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x28 0x0 0x0 0x0 0x2 0x0 
scsi1: LQISTATE = 0x2b, LQOSTATE = 0x0, OPTIONMODE = 0x52
scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x1
SIMODE0[0xc]:(ENOVERRUN|ENIOERR) 
CCSCBCTL[0x0] 
scsi1: REG0 == 0x42, SINDEX = 0x178, DINDEX = 0x10a
scsi1: SCBPTR == 0x35, SCB_NEXT == 0xff00, SCB_NEXT2 == 0xff39
CDB 28 0 c 80 70 a4
STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
DevQ(0:4:0): 0 waiting
DevQ(0:5:0): 0 waiting
DevQ(0:14:0): 0 waiting
DevQ(0:15:0): 0 waiting

