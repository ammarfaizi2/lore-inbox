Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424890AbWKQBeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424890AbWKQBeH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424888AbWKQBeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:34:07 -0500
Received: from nz-out-0102.google.com ([64.233.162.192]:51913 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1424890AbWKQBeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:34:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ad7KxvKJlenSxulok/VTeZ8NI9UX6EWq8KIpvsHB8MI1dE9XTvDuqQZLBrVxgDnIYfZxdt8rD4kR0tQtbFPhUrr6d6uLhoZDJ0kmsA1mPHlIx4mw6iR5HJOaE2ug+W+gnQyMBnX4AVCUEDQvTAv2uxM6ZroSwNXIcfG6dnYcWKc=
Message-ID: <df47b87a0611161734h818fc4dneaad5eeaa7e3c392@mail.gmail.com>
Date: Thu, 16 Nov 2006 20:34:03 -0500
From: "Ioan Ionita" <opslynx@gmail.com>
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.19-rc5 libata PATA ATAPI CDROM SiS 5513 NOT WORKING
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, htejun@gmail.com,
       alan@redhat.com
In-Reply-To: <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <df47b87a0611161522o3ad007f5i8804c876c50e591c@mail.gmail.com>
	 <20061116235048.3cd91beb@localhost.localdomain>
	 <df47b87a0611161730p70e1dd41iad7d27a0bf9283ff@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/06, Ioan Ionita <opslynx@gmail.com> wrote:
> On 11/16/06, Alan <alan@lxorguk.ukuu.org.uk> wrote:
> > On Thu, 16 Nov 2006 18:22:47 -0500
> > "Ioan Ionita" <opslynx@gmail.com> wrote:
> >
> > > I gave libata a shot. Hardisk works fine. However the CDROM doesn't.
> > > It would seem that the CDROM is detected, but the device node is not
> > > created.
> > >
> > > I do have libata.atapi_enabled=1 as a kernel parameter. This is a Vaio
> > > laptop, with SiS 5513, PATA only, no SATA ports.
> > >
> > > Did I miss anything?
> >
> > From the trace looks like the SCSI CD-ROM Driver is not compiled in
> > and/or loaded.
>
> Yes. I'm sorry I missed that. I enabled it, but it still doesn't work.
> Some timeouts are occurring when I try to mount the CD-ROM. The CD-ROM
> works fine with the old IDE framework. Here's the dmesg errors that
> occur with libata and scsi cdrom support:
>
> ata2.00: qc timeout (cmd 0xa0)
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x20)
> ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
> ata2: soft resetting port
> ata2.00: configured for UDMA/33
> ata2: EH complete
> ata2.00: qc timeout (cmd 0xa0)
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x20)
> ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
> ata2: soft resetting port
> ata2.00: configured for UDMA/33
> ata2: EH complete
> ata2.00: qc timeout (cmd 0xa0)
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x20)
> ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
> ata2: port is slow to respond, please be patient (Status 0xd0)
> ata2: port failed to respond (30 secs, Status 0xd0)
> ata2: soft resetting port
> ata2.00: configured for UDMA/33
> ata2: EH complete
> ata2.00: qc timeout (cmd 0xa0)
> ata2.00: limiting speed to UDMA/25
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata2.00: (BMDMA stat 0x20)
> ata2.00: tag 0 cmd 0xa0 Emask 0x5 stat 0x51 err 0x51 (timeout)
>

Oh, forgot to include the CD-ROM detection part. Are those abnormal
status errors a red flag?

eth0: SiS 900 PCI Fast Ethernet at 0x2000, IRQ 18, 08:00:46:a9:50:21.
libata version 2.00 loaded.
pata_sis 0000:00:02.5: version 0.4.4
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x1000 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0x1008 irq 15
scsi0 : pata_sis
ATA: abnormal status 0x7F on port 0x1F7
ATA: abnormal status 0x7F on port 0x1F7
ata1.00: ATA-5, max UDMA/100, 78140160 sectors: LBA
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : pata_sis
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      HITACHI_DK23EA-4 00K3 PQ: 0 ANSI: 5
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA740 DVD/CDRW 1.00 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
Yenta: CardBus bridge found at 0000:00:0a.0 [104d:814e]
