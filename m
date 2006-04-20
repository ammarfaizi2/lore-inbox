Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWDTP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWDTP0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWDTP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:26:30 -0400
Received: from xenotime.net ([66.160.160.81]:1254 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751012AbWDTP03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:26:29 -0400
Date: Thu, 20 Apr 2006 08:28:52 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [libata] atapi_enabled problem
Message-Id: <20060420082852.f679a376.rdunlap@xenotime.net>
In-Reply-To: <44477D93.50501@labri.fr>
References: <44477D93.50501@labri.fr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006 14:24:51 +0200 Emmanuel Fleury wrote:

> Hi,
> 
> I'm a bit puzzled, I have a Fujistu-Siemens P7120 (see: 
> http://www.labri.fr/perso/fleury/index.php?page=p7120) and the DVD-ROM 
> wasn't detected at all at boot time.
> 
> After googling a bit I found this page: 
> http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux
> 
> So, I tried to compile the kernel with built-in ATAPI and S-ATA support 
> (not as modules but embedded in the kernel) and I tried to pass 
> libata.atapi_enabled=1 at boot time through kernel options. The 
> DVD-drive was recognized at boot but generate tons of errors:
> 
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
> sr: Current [descriptor]: sense key: Medium Error
>      Additional sense: Unrecovered read error - auto reallocate failed
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
> ata1: no sense translation for error 0x20
> ata1: no sense translation for status: 0x51
> 
> Then I decided to just modify drivers/scsi/libata-core.c changing the 
> line "atapi_enabled = 0" into "atapi_enabled = 1". Then everything 
> worked as a charm.
> 
> I have no explanation yet for this behaviour (passing kernel options 
> should behave the same than changing the code the way I did I suppose).

Yes, it should and it has worked for quite a few people in the past.
I suspect something more like a typo.  Anyway, recent kernels
(after 2.6.16, so 2.6.17-rc*) already have atapi_enabled set to 1.

> Does anyone has an idea ?

---
~Randy
