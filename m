Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135616AbREFAik>; Sat, 5 May 2001 20:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135613AbREFAia>; Sat, 5 May 2001 20:38:30 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:60514 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S135611AbREFAiQ>;
	Sat, 5 May 2001 20:38:16 -0400
Message-ID: <20010506023813.A5041@win.tue.nl>
Date: Sun, 6 May 2001 02:38:13 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: andy.piper@freeuk.com
Cc: linux-kernel@vger.kernel.org, aeb@cwi.nl
Subject: Re: Dane-Elec PhotoMate Combo
In-Reply-To: <3AF18F40.BD741542@ukgateway.net> <20010503205929.A4187@win.tue.nl> <3AF42A82.C05A2F51@ukgateway.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3AF42A82.C05A2F51@ukgateway.net>; from Andy Piper on Sat, May 05, 2001 at 05:29:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 05:29:54PM +0100, Andy Piper wrote:

> > For me the Dane-Elec is working and stable.
> 
> You are using the Compact Flash reader part of the device, right?

Yes.

> I don't think it is working with SmartMedia.

I cannot test that part - don't think I have any SmartMedia.

> I've tried the latest
> kernel 2.4.5-pre1, which incorporates your patch to allow the device
> to be recognised. The Dane-Elec / SCM eUSB adapter can be seen in
> /proc/bus/usb/devices, but I cannot mount a SmartMedia card (which I'm
> assuming I should be able to mount on /dev/sda; mind you,

Probably sdb.

> /proc/scsi/scsi shows it only as a Compact Flash device, and doesn't
> mention SmartMedia...)
> 
> This part looks good:
> 
> castor kernel:   Vendor: eUSB      Model: Compact Flash     Rev:     
> castor kernel:   Type:   Direct-Access                      ANSI SCSI
> 
> ... this bit doesn't look good ...
> 
> castor kernel: Detected scsi removable disk sda at scsi1, channel 0,
> castor kernel: sda : READ CAPACITY failed.
> 
> I've also tried another hack I found in a news posting, advising that
> CONFIG_USB_STORAGE_SDDR09 support should be added to the Config.in for
> /usr/src/linux/drivers/usb and enabled; it hasn't helped.

Yes. If I do that, I see:

 <4>  Vendor: eUSB      Model: Compact Flash     Rev:
 <4>  Type:   Direct-Access                      ANSI SCSI revision: 02
 <4>  Vendor: SCM Micr  Model: eUSB SmartMedia   Rev: 0207
 <4>  Type:   Direct-Access                      ANSI SCSI revision: 02

that is, the enabling of CONFIG_USB_STORAGE_SDDR09 turns this reader
into two devices: a CF reader and a SM reader.

Inserting sd.o yields

 Detected scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
 Detected scsi removable disk sdc at scsi2, channel 0, id 0, lun 1

that is, the two logical units of this device turn into sdb (the CF reader)
and sdc (the SM reader). The CF reader contains a card, and reading
capacity is successful:

 SCSI device sdb: 15872 512-byte hdwr sectors (8 MB)

If one makes the MODE SENSE command read the vendor page 0, it succeeds, and:

 sdb: Write Protect is off

There is a single partition on sdb:

   sdb1

On the other hand, sdc does not contain anything, so unsurprisingly:

 sdc : READ CAPACITY failed.

> Is this a discussion I should take to the usb-devel mailing list?

Probably, yes. You might cc me, I am not subscribed to that list.

Andries - aeb@cwi.nl
