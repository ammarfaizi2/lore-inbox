Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbVLJVTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbVLJVTM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbVLJVTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 16:19:12 -0500
Received: from vsmtp3alice.tin.it ([212.216.176.143]:22192 "EHLO vsmtp3.tin.it")
	by vger.kernel.org with ESMTP id S1161057AbVLJVTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 16:19:11 -0500
From: ldonesty <jorge78_REMOVE_ME_@inwind.it>
Subject: Re: 2.6.15-rc5 - nonfatal libata assertion (qc->n_elem > 0)
Date: Sat, 10 Dec 2005 22:19:07 +0100
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Message-Id: <pan.2005.12.10.21.19.06.576183@inwind.it>
References: <5ijw5-12q-9@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sat, 10 Dec 2005 21:30:09 +0100, Alessandro Suardi ha scritto:

> This one is just for the record, as it doesn't appear to have had
>  any side effects...
> 
> Dell Latitude D610, uptodate FC4, kernel 2.6.15-rc5, booted with
>  libata.atapi_enabled=1.
> Dec 10 19:33:26 sandman kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Dec 10 19:35:21 sandman kernel: Assertion failed! qc->n_elem >
> 0,drivers/scsi/libata-core.c,ata_fill_sg,line=2482 Dec 10 19:35:35
> sandman last message repeated 18 times
> 
> This happened presumably when I earlier burned a CD-R
>  with .wav audio tracks; the burning was successful.
> 

Here I've a new Dell Inspiron 6000 with Debian Sid and I see similar
messages in dmesg (2.6.14) when I start k3b.
I've to say that libata.atapi_enabled=1 trick doesn't work for me (neither
modprobe.conf option) and I need to change that value directly in
libata-core.c.
Few days ago, I've tried a newer 2.6.15-rc4 with Jeff libata1 patch, and I
see tons of these in the log:

Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:56 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:56 Chiba kernel: sr: Current [descriptor]: sense key=0x3
Dec  1 13:14:56 Chiba kernel:     ASC=0x11 ASCQ=0x4
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for status: 0x51
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for error 0x20
Dec  1 13:14:58 Chiba kernel: ata2: no sense translation for status: 0x51

and kde hangs in one of the steps of ksplash before showing desktop ( I
think, trying to discover media, such as cdrom, usb pen drive and so on).  


> Drive is detected as follows:
> 
> ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15 ata2:
> dev 0 cfg 49:0b00 82:0210 83:1000 84:0000 85:0000 86:0000 87:0000
> 88:0407 ata2: dev 0 ATAPI, max UDMA/33 ata2: dev 0 configured for
> UDMA/33
> scsi1 : ata_piix
>   Vendor: SONY      Model: DVD+-RW DW-Q58A   Rev: UDS1 Type:   CD-ROM
>                            ANSI SCSI revision: 05

ata2: SATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xBFA8 irq 15
ata2: dev 0 cfg 49:0f00 82:4218 83:5000 84:4000 85:4218 86:1000 87:4000 
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2(0): applying bridge limits
ata2: dev 0 configured for UDMA/33
scsi1 : ata_piix
  Vendor: TSSTcorp  Model: DVD+-RW TS-L532B  Rev: DE03
  Type:   CD-ROM                             ANSI SCSI revision: 05
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0

Thanks in advance!


PS: To Jeff Garzik: I try to sent you two mails about this bug but I
think they were not correctly delivered... sigh!

-- 
Il reggiseno e' uno strumento democratico perche' separa la destra dalla
sinistra, solleva le masse e attira i popoli.

www.debianizzati.org | Founder Member
Mario "Ldonesty" Di Nitto --- [Linux Registered User #334335]

