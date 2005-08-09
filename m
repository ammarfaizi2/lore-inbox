Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVHITfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVHITfo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 15:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVHITfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 15:35:43 -0400
Received: from mxsf11.cluster1.charter.net ([209.225.28.211]:1712 "EHLO
	mxsf11.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932267AbVHITfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 15:35:42 -0400
X-IronPort-AV: i="3.96,93,1122868800"; 
   d="scan'208"; a="1408166990:sNHT17906736"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17145.1417.329260.524528@smtp.charter.net>
Date: Tue, 9 Aug 2005 15:35:37 -0400
From: "John Stoffel" <john@stoffel.org>
To: Linus Torvalds <torvalds@osdl.org>, James.Bottomley@SteelEye.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..
In-Reply-To: <200508081954.52638.jesper.juhl@gmail.com>
References: <Pine.LNX.4.58.0508071136020.3258@g5.osdl.org>
	<200508081954.52638.jesper.juhl@gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus & James,

I've still got problems under 2.6.13-rc6 with my DLT7000 drive on an
AIC7880 builtin controller.  Here's the message I got in dmesg.  My
system is a heavily upgraded Debian/unstable with dual 550mhz Xeon
processors and 768mb of RAM, dual SCSI busses.  The annoying problem
is that I have to (sometimes) power cycle the DLT 7000 tape drive to
get it back onto the bus.  So I guess it could be a tape drive
problem, esp since I've got my root disk on /dev/sda, which is also a
builtin AIC7890 controller.  Sometimes I'm able to do a 'scsiadd -r 1
0 6 0' and then a 'scsiadd -a 1 0 6 0' to get it working again.
Details about my system:

> cat /proc/version 
Linux version 2.6.13-rc6 (john@jfsnew) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #73 SMP Mon Aug 8 09:58:30 EDT 2005

> lspci
0000:00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
0000:00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge
0000:00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT302 (rev 01)
0000:00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
0000:00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
0000:00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)
0000:02:06.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
0000:02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
0000:02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
0000:03:08.0 USB Controller: NEC Corporation USB (rev 41)
0000:03:08.1 USB Controller: NEC Corporation USB (rev 41)
0000:03:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
0000:03:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)

> cat /proc/scsi/scsi 
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: COMPAQ   Model: HC01841729       Rev: 3208
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: COMPAQ   Model: BD018222CA       Rev: B016
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 06 Lun: 00
  Vendor: SUN      Model: DLT7000          Rev: 1E48
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: EPSON    Model: Stylus Storage   Rev: 1.00
  Type:   Direct-Access                    ANSI SCSI revision: 02


> cat /proc/scsi/aic7xxx/0 
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7890/91 Ultra2 SCSI adapter
aic7890/91: Ultra2 Wide Channel A, SCSI Id=7, 32/253 SCBs
Allocated SCBs: 36, SG List Length: 128

Serial EEPROM:
0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 
0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 0x03bb 
0x18a6 0x1c5c 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x98be 

Target 0 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
        Channel A Target 0 Lun 0 Settings
                Commands Queued 74229
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
Target 1 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
        Goal: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
        Curr: 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
        Channel A Target 1 Lun 0 Settings
                Commands Queued 29
                Commands Active 0
                Command Openings 32
                Max Tagged Openings 32
                Device Queue Frozen Count 0
Target 2 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 3 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 4 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
Target 5 Negotiation Settings
        User: 80.000MB/s transfers (40.000MHz, offset 127, 16bit)
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

> cat /proc/scsi/aic7xxx/1
Adaptec AIC7xxx driver version: 6.2.36
Adaptec aic7880 Ultra SCSI adapter
aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
Allocated SCBs: 4, SG List Length: 128

Serial EEPROM:
0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 
0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 0x0378 
0x10a6 0x1c5e 0x2807 0x0010 0xffff 0xffff 0xffff 0xffff 
0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0xffff 0x8c90 

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
        Goal: 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
        Curr: 3.300MB/s transfers
        Channel A Target 6 Lun 0 Settings
                Commands Queued 1065
                Commands Active 0
                Command Openings 1
                Max Tagged Openings 0
                Device Queue Frozen Count 0
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

---------------------------------------------------------------------------
- scsi crash
---------------------------------------------------------------------------



scsi1:0:6:0: Attempting to queue an ABORT message
CDB: 0x11 0x1 0x7f 0xff 0xff 0x0
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
Kernel NEXTQSCB = 2
Card NEXTQSCB = 2
QINFIFO entries: 
Waiting Queue entries: 
Disconnected Queue entries: 
QOUTFIFO entries: 
Sequencer Free SCB List: 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 
Sequencer SCB Info: 
  0 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
SCB_TAG[0x3] 
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
  3 SCB_CONTROL[0x40]:(DISCENB) SCB_SCSIID[0x67] SCB_LUN[0x0] 
Kernel Free SCB list: 1 0 
Untagged Q(6): 3 

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi1:0:6:0: Device is active, asserting ATN
Recovery code sleeping
Recovery code awake
Timer Expired
aic7xxx_abort returns 0x2003
scsi1:0:6:0: Attempting to queue a TARGET RESET message
CDB: 0x11 0x1 0x7f 0xff 0xff 0x0
aic7xxx_dev_reset returns 0x2003
Recovery SCB completes
scsi: Device offlined - not ready after error recovery: host 1 channel 0 id 6 lun 0
st0: Error 80000 (sugg. bt 0x0, driver bt 0x0, host bt 0x8).
scsi1 (6:0): rejecting I/O to offline device
