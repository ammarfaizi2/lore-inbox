Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRAaDLy>; Tue, 30 Jan 2001 22:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAaDLo>; Tue, 30 Jan 2001 22:11:44 -0500
Received: from winds.org ([207.48.83.9]:6409 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S129675AbRAaDLl>;
	Tue, 30 Jan 2001 22:11:41 -0500
Date: Tue, 30 Jan 2001 22:10:42 -0500 (EST)
From: Byron Stanoszek <gandalf@winds.org>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA VT82C686X
In-Reply-To: <Pine.LNX.4.21.0101301847530.3488-100000@ns-01.hislinuxbox.com>
Message-ID: <Pine.LNX.4.21.0101302204570.19724-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, David D.W. Downey wrote:

> 
> Woohoo! Just found out that ATA66 on the VIA aint too great.
> 
> I set the kernel boot options idebus=66 ide0=ata66 enabling ATA66
> according to dmesg. The HDD is a WDC UDMA100 30.5GB drive. I retried the

The 'idebus=xx' parameter doesn't refer to the speed of the IDE drive, but
instead the speed of the PCI bus. On the VIA686, that speed should always be 33
(unless you're overclocking). Setting it to 66 will cause the VIA driver to
believe your PCI bus is running at 66MHz and will program the IDE controller to
run at half the speed to maintain 33MHz. In reality, your controller now runs
at 16.

I believe v3.20 of the via82cxxx.c driver disallows any setting lower than 20
or higher than 50.

AFAIK the driver auto-selects the speed of your drive based on how it is
configured in the BIOS, and whether you have the 40- or 80-wire cable. The
'ide0=ata66' option should not be necessary.

To others, I've been running this driver with both a KX133 and a KT133 (both
via686a) for quite some time now and have never seen any problems. Just make
sure 'idebus=xx' matches the speed of your PCICLK as shown in the bios and
you'll be fine (Default is 33).

Regards,
 Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: bstanoszek@comtime.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
