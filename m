Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269858AbUJGWXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269858AbUJGWXH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 18:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJGWWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 18:22:18 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:59817
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S269862AbUJGWTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:19:35 -0400
Date: Thu, 7 Oct 2004 18:27:09 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Adaptec drivers and 2.6.x kernels
Message-ID: <20041007222709.GA24314@animx.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been irritated with this for some time now.  I've seen this with 2.6.7
and 2.6.8.1 with both aic7xxx and aic79xx drivers.

I have a bad CD (I burned it as fast as my burner could force.  I expected
errors).  The scsi drivers do not handle errors very well.  I tried to read
this bad cd on an ide cdrom (I have 2 one on hda and one on hdd), it just
gives up with a read error.  If I do this on scd0 or scd1 (scd0 is an LG DVD
multi burner using an acard u2w scsi to udma66 converter, scd1 is a plextor
cdrw 40/12/40 narrow scsi), then the driver offlines the drive and I can't
use it anymore.

With this problem, the device recovered with scd1.  It was a simple:
cd /proc/scsi
echo "scsi remove-single-device 2 0 1 0" > scsi
echo "scsi add-single-device 2 0 1 0" > scsi
And it now works again.  Sometimes it doesn't.  scsi bus 0 and 1 are on the
aic79xx (builtin and rootfs is on that controller) so I can't remove the
driver.  scsi bus 2 is on the aic7xxx which I can remove that one.  I have
noticed that in the past that linux is not very graceful at handling errors. 
I have seen in the past bad sectors on an ide disk to continually complain
about errors and won't recover.  I should not have to issue the above
commands to recover from this (in some cases, I just have to reboot)

I tried it on scd0, this time it seems to handle it ok.  So I'm wondering if
the hardware (the plextor drive) barfed and didn't respond or it was the
driver.

Here's what's in the logs for scd1:
scsi2:0:1:0: Attempting to queue an ABORT message
CDB: 0x28 0x0 0x0 0x3 0x67 0xb4 0x0 0x0 0x40 0x0
scsi2: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi2: Dumping Card State in Data-in phase, at SEQADDR 0x6c
Card was paused
ACCUM = 0x0, SINDEX = 0x8, DINDEX = 0x8f, ARG_2 = 0x4
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x44]:(BSYI|IOI) ERROR[0x0] SCSIBUSL[0x1c] 
LASTPHASE[0x40]:(IOI) SCSISEQ[0x12]:(ENAUTOATNP|ENRSELI) 
SBLKCTL[0x0] SCSIRATE[0xf]:(SXFR_ULTRA2) SEQCTL[0x10]:(FASTMODE) 
SEQ_FLAGS[0x20]:(DPHASE) SSTAT0[0x0] SSTAT1[0x2]:(PHASECHG) 
SSTAT2[0x0] SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO) 
SXFRCTL0[0xa0]:(FAST20|DFON) DFCNTRL[0x78]:(HDMAEN|SDMAEN|SCSIEN|WIDEODD) 
DFSTATUS[0x21]:(FIFOEMP|FIFOQWDEMP) 
STACK: 0x0 0x149 0x18a 0x82
SCB count = 36
Kernel NEXTQSCB = 4
Card NEXTQSCB = 4
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 2 15 10 13 11 5 1 7 3 9 6 12 4 8 14 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) SCB_SCSIID[0x17] SCB_LUN[0x0] 
SCB_TAG[0x13] 
  1 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  2 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  3 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  4 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  5 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  6 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  7 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  8 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
  9 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 10 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 11 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 12 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 13 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 14 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
 15 SCB_CONTROL[0xe8]:(ULTRAENB|TAG_ENB|DISCENB|TARGET_SCB) 
SCB_SCSIID[0x7] SCB_LUN[0x0] SCB_TAG[0xff] 
Pending list: 
 19 SCB_CONTROL[0x48]:(ULTRAENB|DISCENB) SCB_SCSIID[0x17] SCB_LUN[0x0] 
Kernel Free SCB list: 10 1 25 11 27 2 13 20 8 35 29 12 18 9 14 0 15 7 28 5 23 22 6 24 26 17 31 3 30 16 21 34 33 32 
Untagged Q(1): 19 
DevQ(0:0:0): 0 waiting
DevQ(0:1:0): 0 waiting
DevQ(0:6:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi2:0:1:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi2:0:1:0: Attempting to queue a TARGET RESET message
CDB: 0x28 0x0 0x0 0x3 0x67 0xb4 0x0 0x0 0x40 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi: Device offlined - not ready after error recovery: host 2 channel 0 id 1 lun 0
scsi2 (1:0): rejecting I/O to offline device
Buffer I/O error on device sr1, logical block 111578
Buffer I/O error on device sr1, logical block 111579
Buffer I/O error on device sr1, logical block 111580
Buffer I/O error on device sr1, logical block 111581
Buffer I/O error on device sr1, logical block 111582
Buffer I/O error on device sr1, logical block 111583
Buffer I/O error on device sr1, logical block 111584
Buffer I/O error on device sr1, logical block 111585
Buffer I/O error on device sr1, logical block 111586
Buffer I/O error on device sr1, logical block 111587
Buffer I/O error on device sr1, logical block 111588
Buffer I/O error on device sr1, logical block 111589
Buffer I/O error on device sr1, logical block 111590
Buffer I/O error on device sr1, logical block 111591
Buffer I/O error on device sr1, logical block 111592
Buffer I/O error on device sr1, logical block 111593
Buffer I/O error on device sr1, logical block 111594
Buffer I/O error on device sr1, logical block 111595
Buffer I/O error on device sr1, logical block 111596
Buffer I/O error on device sr1, logical block 111597
Buffer I/O error on device sr1, logical block 111598
Buffer I/O error on device sr1, logical block 111599
Buffer I/O error on device sr1, logical block 111600
Buffer I/O error on device sr1, logical block 111601
Buffer I/O error on device sr1, logical block 111602
Buffer I/O error on device sr1, logical block 111603
Buffer I/O error on device sr1, logical block 111604
Buffer I/O error on device sr1, logical block 111605
Buffer I/O error on device sr1, logical block 111606
Buffer I/O error on device sr1, logical block 111607
Buffer I/O error on device sr1, logical block 111608
Buffer I/O error on device sr1, logical block 111609
scsi2 (1:0): rejecting I/O to offline device
Buffer I/O error on device sr1, logical block 111578
scsi2 (1:0): rejecting I/O to offline device
SCSI error: host 2 id 1 lun 0 return code = 4000000
        Sense class 0, sense error 0, extended sense 0

On scd0 (just for completeness.  The following is acceptable):
scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 03 ca 34 00 00 40 00 
Info fld=0x3ca6d, Current sr0: sense = f0  3
ASC=11 ASCQ= 0
Raw sense data:0xf0 0x00 0x03 0x00 0x03 0xca 0x6d 0x10 0x00 0x00 0xff 0x80 0x11 0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0x00 0x00 0x00 
end_request: I/O error, dev sr0, sector 993712
Buffer I/O error on device sr0, logical block 124214
scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 03 ca 6e 00 00 06 00 
Info fld=0x3ca6e, Current sr0: sense = f0  3
ASC=10 ASCQ= 0
Raw sense data:0xf0 0x00 0x03 0x00 0x03 0xca 0x6e 0x10 0x00 0x00 0x00 0x80 0x10 0x00 0x00 0x00 0x00 0x00 0x03 0xcb 0x06 0x00 0x00 0x00 
end_request: I/O error, dev sr0, sector 993720
Buffer I/O error on device sr0, logical block 124215
SCSI error : <1 0 0 0> return code = 0x8000002
Info fld=0x0, Current sr0: sense = f0  b
Raw sense data:0xf0 0x00 0x0b 0x00 0x00 0x00 0x00 0x00 
end_request: I/O error, dev sr0, sector 993728
Buffer I/O error on device sr0, logical block 124216
scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 03 ca 6c 00 00 02 00 
Info fld=0x3ca6d, Current sr0: sense = f0  3
ASC=11 ASCQ= 0
Raw sense data:0xf0 0x00 0x03 0x00 0x03 0xca 0x6d 0x10 0x00 0x00 0xff 0x80 0x11 0x00 0x00 0x00 0x00 0x00 0xff 0xff 0xff 0x00 0x00 0x00 
end_request: I/O error, dev sr0, sector 993712
Buffer I/O error on device sr0, logical block 124214


-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
