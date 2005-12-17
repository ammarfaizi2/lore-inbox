Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbVLQS1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbVLQS1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 13:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVLQS1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 13:27:00 -0500
Received: from mx.fr.bfs.de ([194.95.226.137]:37861 "EHLO mail.fr.bfs.de")
	by vger.kernel.org with ESMTP id S932652AbVLQS07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 13:26:59 -0500
Message-ID: <43A45866.4080902@bfs.de>
Date: Sat, 17 Dec 2005 19:26:46 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: problem with aic7902 at boot time
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,
perhaps i have a problem with aic7902 (see the dmesg output below).
I have found a thread in the LKML around 2 month old that seem to be 
compareable to this problem (Subject	Re: Infinite interrupt loop, 
INTSTAT = 0). Is there anything new ?

I am willing to help testing since i am trying to find why this board 
sometimes suddenly stops working (ping works but no kbd).

board: tyan tomcat
CPU:  Pentium(R) 4  3.20GHz
3 scsi drives (only 1 ide dvd)
(the problem is with the first drive (the boot driver of cause)

Linux version 2.6.13-15-smp (its a suse i know, the problem seem to 
occur with the vanilla also).


re,
  walter


ps:
i am not member of the ML you can contact me directly at wharms ( at )
bfs <dot> de.



scsi2 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 1.3.11
         <Adaptec 39320A Ultra320 SCSI adapter>
         aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI 33 or 66Mhz, 
512 SCBs

   Vendor: FUJITSU   Model: MAP3735NC         Rev: 0105
   Type:   Direct-Access                      ANSI SCSI revision: 03
  target2:0:0: asynchronous.
scsi2:A:0:0: Tagged Queuing enabled.  Depth 32
  target2:0:0: Beginning Domain Validation
  target2:0:0: wide asynchronous.
  target2:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI PCOMP (6.25 
ns, offset 127)
scsi2:0:0:0: Attempting to queue an ABORT message:CDB: 0x3c 0xa 0x0 0x0 
0x0 0x0 0x0 0x1 0xfc 0x0
scsi2: At time of recovery, card was not paused
 >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi2: Dumping Card State at program address 0x26 Mode 0x11
Card was paused
HS_MAILBOX[0x0] INTCTL[0x80]:(SWTMINTMASK) SEQINTSTAT[0x0]
SAVED_MODE[0x11] DFFSTAT[0x24]:(CURRFIFO_0|FIFO1FREE)
SCSISIGI[0x66]:(P_DATAIN_DT|REQI|BSYI) SCSIPHASE[0x0]
SCSIBUS[0x0] LASTPHASE[0x1]:(P_DATAOUT|P_BUSFREE)
SCSISEQ0[0x0] SCSISEQ1[0x12]:(ENAUTOATNP|ENRSELI)
SEQCTL0[0x0] SEQINTCTL[0x0] SEQ_FLAGS[0x0] SEQ_FLAGS2[0x0]
SSTAT0[0x0] SSTAT1[0x8]:(BUSFREE) SSTAT2[0x0] SSTAT3[0x0]
PERRDIAG[0x0] SIMODE1[0xac]:(ENSCSIPERR|ENBUSFREE|ENSCSIRST|ENSELTIMO)
LQISTAT0[0x0] LQISTAT1[0x0] LQISTAT2[0x80]:(PACKETIZED)
LQOSTAT0[0x0] LQOSTAT1[0x0] LQOSTAT2[0xe1]:(LQOSTOP0|LQOPKT)

SCB Count = 4 CMDS_PENDING = 1 LASTSCB 0xffff CURRSCB 0x3 NEXTSCB 0xff00
qinstart = 18 qinfifonext = 18
QINFIFO:
WAITING_TID_QUEUES:
Pending list:
   3 FIFO_USE[0x1] SCB_CONTROL[0x60]:(TAG_ENB|DISCENB) SCB_SCSIID[0x7]
Total 1
Kernel Free SCB list: 2 1 0
Sequencer Complete DMA-inprog list:
Sequencer Complete list:
Sequencer DMA-Up and Complete list:

<removed a lot of noise>

<after some time the drive is found>
<please note that the speed seems now 160 instead of 320>
<perhaps this is the solution ??>

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi2:0:0:0: Unable to deliver message
aic79xx_dev_reset returns 0x2003
scsi: Device offlined - not ready after error recovery: host 2 channel 0 
id 0 lun 0
  target2:0:0: Domain Validation Disabing Information Units
  target2:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT QAS (12.5 ns, offset 127)
  target2:0:0: Write Buffer failure 8000002
  target2:0:0: Domain Validation Disabing Quick Arbitration and Selection
  target2:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 127)
  target2:0:0: Ending Domain Validation
SCSI device sda: 143571316 512-byte hdwr sectors (73509 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 143571316 512-byte hdwr sectors (73509 MB)
SCSI device sda: drive cache: write back

<the next drives have no problem (here only one of them)>

scsi2:A:1:0: Tagged Queuing enabled.  Depth 32
  target2:0:1: Beginning Domain Validation
Attached scsi generic sg0 at scsi2, channel 0, id 0, lun 0,  type 0
  target2:0:1: wide asynchronous.
  target2:0:1: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RDSTRM RTI WRFLOW 
PCOMP (6.25 ns, offset 127)
  target2:0:1: Ending Domain Validation
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 585937500 512-byte hdwr sectors (300000 MB)
SCSI device sdb: drive cache: write back




