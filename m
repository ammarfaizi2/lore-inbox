Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVDEQjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVDEQjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDEQjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:39:15 -0400
Received: from wproxy.gmail.com ([64.233.184.195]:29010 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261806AbVDEQhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:37:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=H9QoMFRcvyBvO3iIwNhlZ2pYmtIe5pIkksXrAF59WLi34D+NJn6EZZknUi4SjwTuJ2qdQ5yVWkI/2E40n95SOHXbHHrUysqayrxs/rYk+TBd4nmtMBHlLw+lYgthKqCnc1N/mN4j/yMv78YaojaKQ2azz2rYkVhyrYhq8GIHsNQ=
Message-ID: <58cb370e05040509377d1313cc@mail.gmail.com>
Date: Tue, 5 Apr 2005 18:37:34 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: jwilliams@itee.uq.edu.au
Subject: Re: [SATA] non-PCI SATA devices and libata
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423E0522.8050600@itee.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <423E0522.8050600@itee.uq.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mar 21, 2005 1:20 AM, John Williams <jwilliams@itee.uq.edu.au> wrote:
> Hello,
> 
> I am looking into developing a driver for a custom, non-PCI SATA
> controller.  The target arch is Microblaze, an FPGA-based NOMMU target
> on a 2.4.29-uc0 kernel.
> 
> It seems that Jeff Garzik's libata is the way to go for SATA, however
> there seems to be some degree of coupling between libata and PCI support.
> 
> Some comments/observations, please correct me if I am wrong:
> 
>   - include/linux/libata.h appears to recognise that CONFIG_PCI may not
> be set, however libata-compat.h is entirely PCI-specific.  Indeed, it

This is because generic DMA API and generic driver model 
are not present in 2.4.x kernels.

> effectively maps generic bus/dma operations onto their pci-specific
> equivalents.  Also, libata.h unconditionally includes pci.h.
> 
>   - All of the drivers/scsi/sata_XXX drivers target PCI devices only.
> 
> It seems I have a few choices here.
> 
> Option 1 is to just hack together stubbed PCI support for my arch,
> making our on-chip bus pretend to be PCI for the purposes of libata (and
> indeed many other bus subsystems, like USB).  This is pretty unclean,
> particularly since it is entirely likely that someone will build a
> microblaze system with a true PCI bridge and bus, meaning that this
> temporary hack would certainly come back to haunt me[1].
> 
> Option 2 is to try to decouple libata from PCI support.  This may be as
> simple as a conditional inclusion of libata-compat.h from libata.h,
> however I am not yet familiar enough with libata to be sure.

Option 2 is better then Option 1.  You may need to add 
#ifdefs for DMA support on your arch to libata-compat.h
(kind of hack which shouldn't be needed in 2.6.x).

> For now this will be staying in the NOMMU 2.4 kernel (uClinux), but if I
> choose option (2) I would like to work with libata, not against it.  It
> may well be that non-PCI SATA support is a Good Thing in a broader
> sense, so perhaps this is a good discussion to have anyway.
> 
> All input, suggestions and comments welcome.
> 
> Thanks,
> 
> John
> 
> [1] There is a bigger picture here, that with FPGA-based CPUs like
> Microblaze, we can build systems with arbitrary CPU/memory/IO bus
> topologies.  Indeed, we do so on a daily basis.  In the back of my mind
> I am envisioning some kind of generic bus abstraction API, of which PCI,
> USB etc would be mere instances.

Use 2.6.x :)

Bartlomiej
