Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315835AbSEVPlS>; Wed, 22 May 2002 11:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316173AbSEVPlS>; Wed, 22 May 2002 11:41:18 -0400
Received: from [66.105.142.142] ([66.105.142.142]:24079 "EHLO
	exchange1.FalconStor.Net") by vger.kernel.org with ESMTP
	id <S315835AbSEVPlR>; Wed, 22 May 2002 11:41:17 -0400
Message-ID: <E79B8AB303080F4096068F046CD1D89B934EC7@exchange1.FalconStor.Net>
From: Ron Niles <Ron.Niles@falconstor.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: RedHat 7.2 Stock SMP Install
Date: Wed, 22 May 2002 11:41:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Rose, Billy" <wrose@loislaw.com> wrote:

>I have an HP LPr Dual P-III 550 with 2 18G SCSI drives that locked up. No
>response at the console, ssh failed, and ping never answered. 
>How can I find more info on the lockup?

When getting solid lockups like this, nmi_watchdog.txt can sometimes break
you out and give an Oops to work off of.

>Attached devices:
>Host: scsi0 Channel: 00 Id: 00 Lun: 00
>  Vendor: HP       Model: 18.2GB C 80-8C42 Rev:
>  Type:   Direct-Access                    ANSI SCSI revision: 02
>Host: scsi0 Channel: 00 Id: 01 Lun: 00
>  Vendor: HP       Model: 18.2GB C 80-8C42 Rev:
>  Type:   Direct-Access                    ANSI SCSI revision: 02

Multiple SCSI devices on the same bus often have termination problems which
can result in scsi bus lock-up or even data integrity problems. Make sure
you understand the finer points of SCSI device termination. You might want
to try running just one drive off the card and see if the system stabilizes.

>Modules Loaded         ide-scsi nfsd lockd sunrpc tux autofs eepro100
usb-uhci usbcore 
> ext3 jbd sym53c8xx sd_mod scsi_mod

Although it's probably not related to your lockup, I have problems with the
eepro100 drivers, most notably memory leaks. It is worth using the updated
e100 linux driver from the Intel website instead. Note that the driver name
is changed from eepro100 to e100.
