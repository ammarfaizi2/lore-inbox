Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVHACfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVHACfe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 22:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVHACfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 22:35:34 -0400
Received: from mxsf17.cluster1.charter.net ([209.225.28.217]:41168 "EHLO
	mxsf17.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S262021AbVHACfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 22:35:32 -0400
X-IronPort-AV: i="3.95,156,1120449600"; 
   d="scan'208"; a="1191901152:sNHT31722768874"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17133.35430.609291.83377@smtp.charter.net>
Date: Sun, 31 Jul 2005 22:35:18 -0400
From: "John Stoffel" <john@stoffel.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: SCSI tape problems: 2.6.12, DLT 7000, Adaptec AIC7xxx controller
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

I've just a Dell Precision 610 dual CPU Xeon workstation, with 550mhz
CPUs and 768mb of RAM.  I'm running 2.6.12 right now, and using two
different SCSI busses on the system to run some disks and a DLT 7000
tape drive on it's own bus.  I'm using Bacula (www.bacula.org) as my
backup software.

The aic7xxx and st, sd drivers are all compiled into the kernel.  I'll
be trying 2.6.13-rc4 as well, but I don't know what will happen here.

I don't know if this is a problem with the AIC7xxx driver, the tape in
the drive, or the DLT7000 drive itself.  I've gotten the following
oops/crash, which kills the tape drive completely.  I can't get it
back without a power cycle of the tape drive.  Doing 'scsiadd' or
'sg_scan' sometimes works, but not often.  I've had some sucess with
doing a 'scsiadd -r' first to remove the DLT entry, then doing a
'scsiadd -a' to bring it back online, but only if I power cycle the
tape drive.  

Here's the oops/crash info:

scsi1:0:6:0: Attempting to queue an ABORT message
CDB: 0xa 0x0 0x0 0xfc 0x0 0x0
scsi1: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi1: Dumping Card State in Command phase, at SEQADDR 0x156
Card was paused
ACCUM = 0x80, SINDEX = 0xac, DINDEX = 0xc0, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x84]:(BSYI|CDI) ERROR[0x0] SCSIBUSL[0xc0] 
LASTPHASE[0x80]:(CDI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x2]:(SELWIDE) SCSIRATE[0x88]:(WIDEXFER) 
SEQCTL[0x10]:(FASTMODE) SEQ_FLAGS[0x0] SSTAT0[0x7]:(DMADONE|SPIORDY|SDONE) 
SSTAT1[0x2]:(PHASECHG) SSTAT2[0x0] SSTAT3[0x0] 
SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0x88]:(SPIOEN|DFON) DFCNTRL[0x4]:(DIRECTION) 
DFSTATUS[0x6d]:(FIFOEMP|DFTHRESH|HDONE|FIFOQWDEMP|DFCACHETH) 
STACK: 0x37 0x0 0x150 0x191
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 3
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
SCB_TAG[0x2] 
  1 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff]:(TWIN_CHNLB|OID|TWIN_TID) 
SCB_LUN[0xff]:(SCB_XFERLEN_ODD|LID) SCB_TAG[0xff] 
Pending list: 
  2 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(6): 2 

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:6:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi1:0:6:0: Attempting to queue a TARGET RESET message
CDB: 0xa 0x0 0x0 0xfc 0x0 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 6 lun 0
st0: Error 10000 (sugg. bt 0x0, driver bt 0x0, host bt 0x1).

----------------------------------------------------------------------
Here's the cat /proc/scsi/aic7xxx/1 info:

jfsnew:~> cat /proc/scsi/aic7xxx/1 
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7880 Ultra SCSI adapter
aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Allocated SCBs: 4, SG List Length: 128

Serial EEPROM:
0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 
0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 
0x10a4 0x1c1e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x8c4e 

Target 0 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 1 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 2 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 3 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 4 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 5 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 6 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 7 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 8 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 9 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 10 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 11 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 12 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 13 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 14 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)
Target 15 Negotiation Settings
        User: 40.000MB/s transfers (20.000MHz, offset 127, 16bit)

----------------------------------------------------------------------

Let me know if there is any more info/tests I can run here.  I'll be
putting 2.6.13-rc4 into place and seeing how that works as well
tonight.

Thanks,
John
