Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137189AbREKRmP>; Fri, 11 May 2001 13:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137195AbREKRmG>; Fri, 11 May 2001 13:42:06 -0400
Received: from mta1.snfc21.pbi.net ([206.13.28.122]:55691 "EHLO
	mta1.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S137189AbREKRlo>; Fri, 11 May 2001 13:41:44 -0400
Date: Fri, 11 May 2001 10:37:41 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: pci_pool_free from IRQ
To: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com, rmk@arm.linux.org.uk
Message-id: <02e301c0da41$15739680$6800000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu>
 <E14xFD5-0000hh-00@the-village.bc.nu>
 <15096.27479.707679.544048@pizda.ninka.net>
 <050701c0d80f$8f876ca0$6800000a@brownell.org>
 <15096.38109.228916.621891@pizda.ninka.net>
 <20010509143020.A22522@devserv.devel.redhat.com>
 <15097.39445.646189.834699@pizda.ninka.net>
 <20010510160550.A32083@devserv.devel.redhat.com>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about this (with documentation fixes by David-B):

Actually I'd be just as happy to call the ARM pci_free_consistent()
behavior (BUG in_interrupt) the problem.  Particularly if that ARM
patch works OK!  I've gotten success reports with pci_pool from
folk using about half the architectures in linux/arch, and only ARM
showed this particular problem.  It appears there's no real need
to update the interface spec to accomodate ARM.

That means the doc fixes are simpler:  in DMA-mapping.txt just clarify
that some routines may be called in_interrupt (currently unspecified),
and the pci.txt change about pci_device.remove() (agreed to by
both Alan and DaveM, appended).

- Dave


> diff -ur -X dontdiff linux-2.4.4/Documentation/pci.txt linux-2.4.4-niph/Documentation/pci.txt
> --- linux-2.4.4/Documentation/pci.txt Sun Sep 17 09:45:06 2000
> +++ linux-2.4.4-niph/Documentation/pci.txt Thu May 10 12:33:03 2001
> @@ -60,8 +60,8 @@
>   remove Pointer to a function which gets called whenever a device
>   being handled by this driver is removed (either during
>   deregistration of the driver or when it's manually pulled
> - out of a hot-pluggable slot). This function can be called
> - from interrupt context.
> + out of a hot-pluggable slot). This function always gets
> + called from process context, so it can sleep.
>   suspend, Power management hooks -- called when the device goes to
>   resume sleep or is resumed.
>  


