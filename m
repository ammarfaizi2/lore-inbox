Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271140AbTGWGoa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271107AbTGWGoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:44:30 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14735 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271101AbTGWGo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:44:28 -0400
Date: Tue, 22 Jul 2003 23:57:14 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, solca@guug.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030722235714.5e2b285d.davem@redhat.com>
In-Reply-To: <20030723074033.A1687@infradead.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
	<20030722175400.4fe2aa5d.davem@redhat.com>
	<20030723070739.A697@infradead.org>
	<20030722232410.7a37ed4d.davem@redhat.com>
	<20030723072836.A932@infradead.org>
	<20030722232911.2e6fda86.davem@redhat.com>
	<20030723074033.A1687@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 07:40:33 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jul 22, 2003 at 11:29:11PM -0700, David S. Miller wrote:
> > And unlike this particular scsi layer usage, such drivers will be
> > dependant upon things like CONFIG_PCI and thus won't get compiled
> > in unless CONFIG_PCI has been enabled in the kernel configuration.
> 
> Umm, no.  The whole idea of the DMA mapping API is that it's independant
> of the underlying bus.  Think of usb or ieee1394 drivers doing direct DMA
> independant of the bus the underlying host adapter uses.

No USB or IEEE1394 on SBUS sparcs, so again no problem.

My point still holds, please put this enumeration into a truly generic
place that doesn't depend upon the actual implementation.

linux/dma-dir.h or even linux/device.h seem the most logical place (we
put the PCI ones in pci.h, and pci.h can be included cleanly even when
CONFIG_PCI is disabled, consider that), then we make
linux/dma-mapping.h and scsi/scsi_{cmnd,request}.h include this
linux/{device,dma-dir}.h file.

I don't see why this is a problem.  Either do this, or fix
asm-generic/dma-mapping.h which is not GENERIC because it
depends upon something SPECIFIC, specifically PCI.
