Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271129AbTGWGRe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 02:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271126AbTGWGR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 02:17:26 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59278 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271123AbTGWGQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 02:16:22 -0400
Date: Tue, 22 Jul 2003 23:29:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@infradead.org, solca@guug.org, zaitcev@redhat.com,
       linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
       debian-sparc@lists.debian.org
Subject: Re: sparc scsi esp depends on pci & hangs on boot
Message-Id: <20030722232911.2e6fda86.davem@redhat.com>
In-Reply-To: <20030723072836.A932@infradead.org>
References: <20030722025142.GC25561@guug.org>
	<20030722080905.A21280@devserv.devel.redhat.com>
	<20030722182609.GA30174@guug.org>
	<20030722175400.4fe2aa5d.davem@redhat.com>
	<20030723070739.A697@infradead.org>
	<20030722232410.7a37ed4d.davem@redhat.com>
	<20030723072836.A932@infradead.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003 07:28:36 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> Putting it into linux/dma-mapping.h is fine with me, but I expect to
> see more users of the dma-mapping API soon..

And unlike this particular scsi layer usage, such drivers will be
dependant upon things like CONFIG_PCI and thus won't get compiled
in unless CONFIG_PCI has been enabled in the kernel configuration.

The enumeration can go into some common area that doesn't care about
the dma-mapping.h actual implementation.

And linux/dma-mapping.h is a bad name to use, call it dma-dir.h or
something, because linux/dma-mapping.h would need to include
asm/dma-mapping.h which is what we're trying to avoid here.
