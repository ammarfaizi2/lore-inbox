Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271110AbTGWGZa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271115AbTGWGZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:25:30 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:2064 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271110AbTGWGZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:25:28 -0400
Date: Wed, 23 Jul 2003 07:40:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, solca@guug.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-ID: <20030723074033.A1687@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, solca@guug.org,
	zaitcev@redhat.com, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, debian-sparc@lists.debian.org
References: <20030722025142.GC25561@guug.org> <20030722080905.A21280@devserv.devel.redhat.com> <20030722182609.GA30174@guug.org> <20030722175400.4fe2aa5d.davem@redhat.com> <20030723070739.A697@infradead.org> <20030722232410.7a37ed4d.davem@redhat.com> <20030723072836.A932@infradead.org> <20030722232911.2e6fda86.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030722232911.2e6fda86.davem@redhat.com>; from davem@redhat.com on Tue, Jul 22, 2003 at 11:29:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 11:29:11PM -0700, David S. Miller wrote:
> And unlike this particular scsi layer usage, such drivers will be
> dependant upon things like CONFIG_PCI and thus won't get compiled
> in unless CONFIG_PCI has been enabled in the kernel configuration.

Umm, no.  The whole idea of the DMA mapping API is that it's independant
of the underlying bus.  Think of usb or ieee1394 drivers doing direct DMA
independant of the bus the underlying host adapter uses.

> And linux/dma-mapping.h is a bad name to use, call it dma-dir.h or
> something, because linux/dma-mapping.h would need to include
> asm/dma-mapping.h which is what we're trying to avoid here.

We don't try to avoid that.  You should at least make them sparc dma
mapping API noops for !CONFIG_PCI because it's assume you always
include the header - whether you can actually use the functionaly
depends on whether your bus supports this API.
