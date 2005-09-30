Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVI3Ldu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVI3Ldu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 07:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVI3Ldu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 07:33:50 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:42628 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1751287AbVI3Ldt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 07:33:49 -0400
From: dth@cistron.nl (Danny ter Haar)
Subject: Re: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18
 hours
Date: Fri, 30 Sep 2005 11:33:47 +0000 (UTC)
Organization: Cistron
Message-ID: <dhj7qr$id0$1@news.cistron.nl>
References: <dhinf5$skf$1@news.cistron.nl> <20050930001301.08eeab9d.akpm@osdl.org>
X-Trace: ncc1701.cistron.net 1128080027 18848 62.216.30.70 (30 Sep 2005 11:33:47 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@cistron.nl (Danny ter Haar)
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton  <akpm@osdl.org> wrote:
>The log buffer starts with
>scsi1 (4:0): rejecting I/O to offline device
>scsi1 (4:0): rejecting I/O to offline device
>scsi1 (4:0): rejecting I/O to offline device
>So we've probably lost the info which will tell us how the problems
>started.  A serial console would be nice.

My colleque found in kern.log the real first announcement:

Sep 30 00:17:17 newsgate kernel: hw tcp v4 csum failed
Sep 30 00:20:48 newsgate kernel: hw tcp v4 csum failed
Sep 30 00:26:54 newsgate kernel: scsi1: Transmission error detected
Sep 30 00:26:54 newsgate kernel: LQISTAT1[0x8]:(LQICRCI_NLQ) LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
Sep 30 00:26:54 newsgate kernel: SCSISIGI[0x60]:(P_DATAIN_DT) PERRDIAG[0x4]:(CRCERR)
Sep 30 00:26:54 newsgate kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 30 00:26:54 newsgate kernel: scsi1: Dumping Card State at program address 0xf Mode 0x33
Sep 30 00:26:54 newsgate kernel: Card was paused
Sep 30 00:26:54 newsgate kernel: HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
Sep 30 00:26:54 newsgate kernel: SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11]
Sep 30 00:26:54 newsgate kernel: DFFSTAT[0x24]:(CURRFIFO_0|FIFO1FREE) SCSISIGI[0xb6]:(P_MESGOUT|REQI|BSYI|ATNI)
Sep 30 00:26:54 newsgate kernel: SCSIPHASE[0x4]:(MSG_OUT_PHASE) SCSIBUS[0xf7] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
Sep 30 00:26:54 newsgate kernel: SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
Sep 30 00:26:54 newsgate kernel: SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]
Sep 30 00:26:54 newsgate kernel: SSTAT0[0x2]:(SPIORDY) SSTAT1[0x19]:(REQINIT|BUSFREE|PHASEMIS)
Sep 30 00:26:54 newsgate kernel: SSTAT2[0x20]:(NONPACKREQ) SSTAT3[0x0] PERRDIAG[0x0]
Sep 30 00:26:54 newsgate kernel: SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
Sep 30 00:26:54 newsgate kernel: LQISTAT0[0x0] LQISTAT1[0x8]:(LQICRCI_NLQ) LQISTAT2[0xc0]:(LQIPHASE_OUTPKT|PACKETIZED)
Sep 30 00:26:54 newsgate kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)
Sep 30 00:26:54 newsgate kernel:
Sep 30 00:26:54 newsgate kernel: SCB Count = 128 CMDS_PENDING = 6 LASTSCB 0x6b CURRSCB 0x14 NEXTSCB 0xff80
Sep 30 00:26:54 newsgate kernel: qinstart = 16079 qinfifonext = 16079
Sep 30 00:26:54 newsgate kernel: QINFIFO:
Sep 30 00:26:54 newsgate kernel: WAITING_TID_QUEUES:
Sep 30 00:26:54 newsgate kernel: Pending list:
Sep 30 00:26:54 newsgate kernel:  20 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel: 107 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:  74 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:   3 FIFO_USE[0x1] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0xf7]:(TID)
Sep 30 00:26:54 newsgate kernel:  62 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0xf7]:(TID)
Sep 30 00:26:54 newsgate kernel: Total 6
Sep 30 00:26:54 newsgate kernel: Kernel Free SCB list: 116 115 105 35 111 108 29 106 13 76 112 34 17 69 84 51 122 23 87 99 43 32 91 88 75 11 92
+40 46 30 5 102 52 70 16 41 15 97 36 0 119 19 100 126 22 54 65 39 93 55 117 50 61 121 2 25 26 60 27 45 8 123 53 57 125 78 47 66 49 4 103 101 77
+24 37 72 90 82 48 79 56 86 118 1 120 59 94 73 21 58 113 64 85 89 81 18 98 96 6 12 31 95 114 7 44 14 127 124 67 33 71 109 63 68 9 104 42 10 80 83+110 38
Sep 30 00:26:54 newsgate kernel: Sequencer Complete DMA-inprog list:
Sep 30 00:26:54 newsgate kernel: Sequencer Complete list:
Sep 30 00:26:54 newsgate kernel: Sequencer DMA-Up and Complete list:
Sep 30 00:26:54 newsgate kernel:
Sep 30 00:26:54 newsgate kernel: scsi1: FIFO0 Active, LONGJMP == 0x233, SCB 0x4a
Sep 30 00:26:54 newsgate kernel: SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
Sep 30 00:26:54 newsgate kernel: SEQINTSRC[0x0] DFCNTRL[0x8]:(HDMAEN) DFSTATUS[0xc8]:(HDONE|PKT_PRELOAD_AVAIL|PRELOAD_AVAIL)
Sep 30 00:26:54 newsgate kernel: SG_CACHE_SHADOW[0x50] SG_STATE[0x3]:(SEGS_AVAIL|LOADING_NEEDED)
Sep 30 00:26:54 newsgate kernel: DFFSXFRCTL[0x0] SOFFCNT[0x0] MDFFSTAT[0x46]:(DATAINFIFO|DLZERO|SHCNTNEGATIVE)
Sep 30 00:26:54 newsgate kernel: SHADDR = 0x0d65c9200, SHCNT = 0xfffe00 HADDR = 0x0d65c9000, HCNT = 0x0
Sep 30 00:26:54 newsgate kernel: CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Sep 30 00:26:54 newsgate kernel: scsi1: FIFO1 Free, LONGJMP == 0x823a, SCB 0x6a
Sep 30 00:26:54 newsgate kernel: SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
Sep 30 00:26:54 newsgate kernel: SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Sep 30 00:26:54 newsgate kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
Sep 30 00:26:54 newsgate kernel: SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
Sep 30 00:26:54 newsgate kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0]
Sep 30 00:26:54 newsgate kernel: LQIN: 0x4 0x0 0x0 0x4a 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x28 0x0 0x0 0x0 0x2 0x0
Sep 30 00:26:54 newsgate kernel: scsi1: LQISTATE = 0x2b, LQOSTATE = 0x0, OPTIONMODE = 0x52
Sep 30 00:26:54 newsgate kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x2
Sep 30 00:26:54 newsgate kernel: SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
Sep 30 00:26:54 newsgate kernel: CCSCBCTL[0x0]
Sep 30 00:26:54 newsgate kernel: scsi1: REG0 == 0x14, SINDEX = 0x150, DINDEX = 0x10a
Sep 30 00:26:54 newsgate kernel: scsi1: SCBPTR == 0x74, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xff74
Sep 30 00:26:54 newsgate kernel: CDB 28 0 7 80 8 a0
Sep 30 00:26:54 newsgate kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 30 00:26:54 newsgate kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 30 00:26:54 newsgate kernel: LQICRC_NLQ
Sep 30 00:26:54 newsgate kernel: scsi1: Unexpected PKT busfree condition
Sep 30 00:26:54 newsgate kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 30 00:26:54 newsgate kernel: scsi1: Dumping Card State at program address 0xf Mode 0x33
Sep 30 00:26:54 newsgate kernel: Card was paused
Sep 30 00:26:54 newsgate kernel: HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
Sep 30 00:26:54 newsgate kernel: SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x11]
Sep 30 00:26:54 newsgate kernel: DFFSTAT[0x24]:(CURRFIFO_0|FIFO1FREE) SCSISIGI[0xb6]:(P_MESGOUT|REQI|BSYI|ATNI)
Sep 30 00:26:54 newsgate kernel: SCSIPHASE[0x4]:(MSG_OUT_PHASE) SCSIBUS[0xf7] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
Sep 30 00:26:54 newsgate kernel: SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
Sep 30 00:26:54 newsgate kernel: SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]
Sep 30 00:26:54 newsgate kernel: SSTAT0[0x2]:(SPIORDY) SSTAT1[0x19]:(REQINIT|BUSFREE|PHASEMIS)
Sep 30 00:26:54 newsgate kernel: SSTAT2[0x20]:(NONPACKREQ) SSTAT3[0x0] PERRDIAG[0x0]
Sep 30 00:26:54 newsgate kernel: SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
Sep 30 00:26:54 newsgate kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0xc0]:(LQIPHASE_OUTPKT|PACKETIZED)
Sep 30 00:26:54 newsgate kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)
Sep 30 00:26:54 newsgate kernel:
Sep 30 00:26:54 newsgate kernel: SCB Count = 128 CMDS_PENDING = 6 LASTSCB 0x6b CURRSCB 0x14 NEXTSCB 0xff80
Sep 30 00:26:54 newsgate kernel: qinstart = 16079 qinfifonext = 16079
Sep 30 00:26:54 newsgate kernel: QINFIFO:
Sep 30 00:26:54 newsgate kernel: WAITING_TID_QUEUES:
Sep 30 00:26:54 newsgate kernel: Pending list:
Sep 30 00:26:54 newsgate kernel:  20 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel: 107 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:  74 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:   3 FIFO_USE[0x1] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x47]
Sep 30 00:26:54 newsgate kernel:  28 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0xf7]:(TID)
Sep 30 00:26:54 newsgate kernel:  62 FIFO_USE[0x0] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0xf7]:(TID)
Sep 30 00:26:54 newsgate kernel: Total 6
Sep 30 00:26:54 newsgate kernel: Kernel Free SCB list: 116 115 105 35 111 108 29 106 13 76 112 34 17 69 84 51 122 23 87 99 43 32 91 88
+75 11 92 40 46 30 5 102 52 70 16 41 15 97 36 0 119 19 100 126 22 54 65 39 93 55 117 50 61 121 2 25 26 60 27 45 8 123 53 57 125 78 47
+66 49 4 103 101 77 24 37 72 90 82 48 79 56 86 118 1 120 59 94 73 21 58 113 64 85 89 81 18 98 96 6 12 31 95 114 7 44 14 127 124 67 33
+71 109 63 68 9 104 42 10 80 83 110 38
Sep 30 00:26:54 newsgate kernel: Sequencer Complete DMA-inprog list:
Sep 30 00:26:54 newsgate kernel: Sequencer Complete list:
Sep 30 00:26:54 newsgate kernel: Sequencer DMA-Up and Complete list:
Sep 30 00:26:54 newsgate kernel:
Sep 30 00:26:54 newsgate kernel: scsi1: FIFO0 Active, LONGJMP == 0x233, SCB 0x4a
Sep 30 00:26:54 newsgate kernel: SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
Sep 30 00:26:54 newsgate kernel: SEQINTSRC[0x0] DFCNTRL[0x8]:(HDMAEN) DFSTATUS[0xc8]:(HDONE|PKT_PRELOAD_AVAIL|PRELOAD_AVAIL)
Sep 30 00:26:54 newsgate kernel: SG_CACHE_SHADOW[0x50] SG_STATE[0x3]:(SEGS_AVAIL|LOADING_NEEDED)
Sep 30 00:26:54 newsgate kernel: DFFSXFRCTL[0x0] SOFFCNT[0x0] MDFFSTAT[0x46]:(DATAINFIFO|DLZERO|SHCNTNEGATIVE)
Sep 30 00:26:54 newsgate kernel: SHADDR = 0x0d65c9200, SHCNT = 0xfffe00 HADDR = 0x0d65c9000, HCNT = 0x0
Sep 30 00:26:54 newsgate kernel: CCSGCTL[0x10]:(SG_CACHE_AVAIL)
Sep 30 00:26:54 newsgate kernel: scsi1: FIFO1 Free, LONGJMP == 0x823a, SCB 0x6a
Sep 30 00:26:54 newsgate kernel: SEQIMODE[0x3f]:(ENCFG4TCMD|ENCFG4ICMD|ENCFG4TSTAT|ENCFG4ISTAT|ENCFG4DATA|ENSAVEPTRS)
Sep 30 00:26:54 newsgate kernel: SEQINTSRC[0x0] DFCNTRL[0x0] DFSTATUS[0x89]:(FIFOEMP|HDONE|PRELOAD_AVAIL)
Sep 30 00:26:54 newsgate kernel: SG_CACHE_SHADOW[0x2]:(LAST_SEG) SG_STATE[0x0] DFFSXFRCTL[0x0]
Sep 30 00:26:54 newsgate kernel: SOFFCNT[0x0] MDFFSTAT[0x5]:(FIFOFREE|DLZERO) SHADDR = 0x00, SHCNT = 0x0
Sep 30 00:26:54 newsgate kernel: HADDR = 0x00, HCNT = 0x0 CCSGCTL[0x0]
Sep 30 00:26:54 newsgate kernel: LQIN: 0x4 0x0 0x0 0x4a 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x28 0x0 0x0 0x0 0x2 0x0
Sep 30 00:26:54 newsgate kernel: scsi1: LQISTATE = 0x2b, LQOSTATE = 0x0, OPTIONMODE = 0x52
Sep 30 00:26:54 newsgate kernel: scsi1: OS_SPACE_CNT = 0x20 MAXCMDCNT = 0x2
Sep 30 00:26:54 newsgate kernel: SIMODE0[0xc]:(ENOVERRUN|ENIOERR)
Sep 30 00:26:54 newsgate kernel: CCSCBCTL[0x0]
Sep 30 00:26:54 newsgate kernel: scsi1: REG0 == 0x14, SINDEX = 0x150, DINDEX = 0x10a
Sep 30 00:26:54 newsgate kernel: scsi1: SCBPTR == 0x74, SCB_NEXT == 0xff40, SCB_NEXT2 == 0xff74
Sep 30 00:26:54 newsgate kernel: CDB 28 0 7 80 8 a0
Sep 30 00:26:54 newsgate kernel: STACK: 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
Sep 30 00:26:54 newsgate kernel: <<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
Sep 30 00:27:28 newsgate kernel: scsi1:0:15:0: Attempting to queue an ABORT message:CDB: 0x28 0x0 0x9 0xd4 0xb 0xd7 0x0 0x0 0x80 0x0
Sep 30 00:27:28 newsgate kernel: scsi1: At time of recovery, card was not paused
Sep 30 00:27:28 newsgate kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Sep 30 00:27:28 newsgate kernel: scsi1: Dumping Card State at program address 0x25 Mode 0x11
Sep 30 00:27:28 newsgate kernel: Card was paused
Sep 30 00:27:28 newsgate kernel: HS_MAILBOX[0x0] INTCTL[0xc0]:(SWTMINTEN|SWTMINTMASK)
Sep 30 00:27:28 newsgate kernel: SEQINTSTAT[0x10]:(SEQ_SWTMRTO) SAVED_MODE[0x33]
Sep 30 00:27:28 newsgate kernel: DFFSTAT[0x34]:(CURRFIFO_0|FIFO0FREE|FIFO1FREE)
Sep 30 00:27:28 newsgate kernel: SCSISIGI[0x66]:(P_DATAIN_DT|REQI|BSYI) SCSIPHASE[0x0]
Sep 30 00:27:28 newsgate kernel: SCSIBUS[0x9b] LASTPHASE[0x60]:(P_DATAIN_DT) SCSISEQ0[0x0]
Sep 30 00:27:28 newsgate kernel: SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI) SEQCTL0[0x0]
Sep 30 00:27:28 newsgate kernel: SEQINTCTL[0x0] SEQ_FLAGS[0x20]:(DPHASE) SEQ_FLAGS2[0x0]
Sep 30 00:27:28 newsgate kernel: SSTAT0[0x0] SSTAT1[0x0] SSTAT2[0x0] SSTAT3[0x0]
Sep 30 00:27:28 newsgate kernel: PERRDIAG[0x0] SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
Sep 30 00:27:28 newsgate kernel: LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0xc0]:(LQIPHASE_OUTPKT|PACKETIZED)
Sep 30 00:27:28 newsgate kernel: LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

etc...

Hope this gives more info on the crash..

Danny

