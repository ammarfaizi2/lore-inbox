Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbUA2JC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 04:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263526AbUA2JC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 04:02:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1034 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263462AbUA2JC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 04:02:26 -0500
Date: Thu, 29 Jan 2004 09:02:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PC300 update
Message-ID: <20040129090222.A20867@flint.arm.linux.org.uk>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Christoph Hellwig <hch@infradead.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58L.0401281741120.2088@logos.cnet> <20040128212115.A2027@infradead.org> <Pine.LNX.4.58L.0401282203170.2163@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58L.0401282203170.2163@logos.cnet>; from marcelo.tosatti@cyclades.com on Wed, Jan 28, 2004 at 10:06:25PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:06:25PM -0200, Marcelo Tosatti wrote:
> On Wed, 28 Jan 2004, Christoph Hellwig wrote:
> > > - Mark pci_device_id list with __devinitdata
> >
> > This is bogus and can crash the kernel if you're unlucky.
> 
> Other wan drivers are doing the same:
> 
> [marcelo@logos wan]$ grep __devinitdata *
> farsync.c:static char *type_strings[] __devinitdata = {
> wanxl.c:static struct pci_device_id wanxl_pci_tbl[] __devinitdata = {
> 
> I believe a handful of others are using "__devinitdata". How can the
> kernel crash because of this? Who will try to touch the data?

It is particularly notable when someone inserts a Cardbus device.  A
new PCI device is added, and we scan all drivers looking for a match
using the PCI ID tables.

If _any_ PCI ID table which is part registered as part of a driver is
marked using __devinitdata or __initdata, this will either cause the
kernel to read invalid data (possibly entering a long loop) or oops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
