Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTBQOOM>; Mon, 17 Feb 2003 09:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267261AbTBQONV>; Mon, 17 Feb 2003 09:13:21 -0500
Received: from [207.61.129.108] ([207.61.129.108]:30179 "EHLO
	mail.datawire.net") by vger.kernel.org with ESMTP
	id <S267245AbTBQOMh>; Mon, 17 Feb 2003 09:12:37 -0500
From: Shawn Starr <shawn.starr@datawire.net>
Organization: Datawire Communication Networks Inc.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.61][SCSI][AIC7xxx] Problems with Tape driver
Date: Mon, 17 Feb 2003 09:23:50 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302170923.50463.shawn.starr@datawire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While attempting to cpio extract data from the tape I got this in the logs. Is 
this due to corrupt data on tape or the tape driver having a fit? ;-)

We are the following SCSI card and tape drive:

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>
        aic7850: Single Channel A, SCSI Id=7, 3/253 SCBs

  Vendor: HP        Model: T4000s            Rev: 1.10
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20021214, fixed bufsize 32768, wrt 30720, s/g segs 256
Attached scsi tape st0 at scsi0, channel 0, id 4, lun 0
st0: try direct i/o: yes, max page reachable by HBA 1048575


Problems below:
==========
st0: Error with sense data: Info fld=0x4, Current stst0: sense = f0  4
ASC=40 ASCQ=81
Raw sense data:0xf0 0x00 0x04 0x00 0x00 0x00 0x04 0x10 0x00 0x00 0x00 0x00 
0x40 0x81 0x00 0x00 0x00 0x00 0x13 0x01 0x00 0x00 0x00 0x00
scsi0:0:4:0: Attempting to queue an ABORT message
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State while idle, at SEQADDR 0x7
Card was paused
ACCUM = 0xb7, SINDEX = 0x47, DINDEX = 0x25, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0x1]:(P_BUSFREE)
SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) SBLKCTL[0x0] SCSIRATE[0x0]
SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0xc0]:(NO_CDB_SENT|NOT_IDENTIFIED)
SSTAT0[0x5]:(DMADONE|SDONE) SSTAT1[0xa]:(PHASECHG|BUSFREE)
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] 
SIMODE1[0xa4]:(ENSCSIPERR|ENSCSIRST|ENSELTIMO)
SXFRCTL0[0x80]:(DFON) DFCNTRL[0x0] 
DFSTATUS[0x2d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP)
STACK: 0x0 0x163 0x1a4 0x3
SCB count = 4
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries:
Waiting Queue entries:
Disconnected Queue entries: 0:3
QOUTFIFO entries:
Sequencer Free SCB List: 1 2
Sequencer SCB Info:
  0 SCB_CONTROL[0x44]:(DISCONNECTED|DISCENB) SCB_SCSIID[0x47]
SCB_LUN[0x0] SCB_TAG[0x3]
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID)
SCB_LUN[0xff]:(LID) SCB_TAG[0xff]
Pending list:
  3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x47] SCB_LUN[0x0]
Kernel Free SCB list: 1 0
Untagged Q(4): 3
DevQ(0:4:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
(scsi0:A:4:0): Device is disconnected, re-queuing SCB
Recovery code sleeping
(scsi0:A:4:0): Abort Message Sent
(scsi0:A:4:0): SCB 3 - Abort Completed.
Recovery SCB completes
Recovery code awake
aic7xxx_abort returns 0x2002
st0: Error with sense data: Current stst0: sense = 70  6
ASC=28 ASCQ= 0
Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 0x10 0x00 0x00 0x00 0x00 
0x28 0x00 0x00 0x00 0x00 0x00 0x01 0x12 0x00 0x00 0x00 0x00
st0: Error with sense data: Current stst0: sense = 70  4
ASC=40 ASCQ=b6
Raw sense data:0x70 0x00 0x04 0x00 0x00 0x00 0x00 0x10 0x00 0x00 0x00 0x00 
0x40 0xb6 0x00 0x00 0x00 0x00 0x00 0x05 0x00 0x00 0x00 0x00

-- 
Shawn Starr
UNIX Systems Administrator, Operations
Datawire Communication Networks Inc.
10 Carlson Court, Suite 300
Toronto, ON, M9W 6L2
T: 416-213-2001 ext 179  F: 416-213-2008
shawn.starr@datawire.net
"The power to Transact" - http://www.datawire.net

