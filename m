Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTKGXpn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTKGWQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:16:02 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:12050 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264046AbTKGK0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 05:26:07 -0500
Date: Fri, 7 Nov 2003 10:25:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updating our sn code in 2.6
Message-ID: <20031107102514.A2437@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pat Gefre <pfg@sgi.com>, akpm@osdl.org, davidm@napali.hpl.hp.com,
	linux-kernel@vger.kernel.org
References: <200311062331.hA6NVvN5023023@fsgi900.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200311062331.hA6NVvN5023023@fsgi900.americas.sgi.com>; from pfg@sgi.com on Thu, Nov 06, 2003 at 05:31:56PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 05:31:56PM -0600, Pat Gefre wrote:
> I have a patch for 2.6 that will update our sn I/O. This patch includes
> initial support for new h/w, some code reorganization to accomodate the
> new h/w, fixes to our code since the last bulk update earlier this year
> and code clean-up. The diffstat follows at the end of this email.

Well, it would be nice again to give credit for people who did this.
In fact that SGI let code slip in that clearly wasn't theirs I think you should
really identidy who changed what instead of a hude 1.4MB patch.

Comments to the patch:
	- don't reintroduce pciba, it's a broken driver and I removed it
	for a reason.  Use the generic pci procfs and sysfs infrastructure.
	- please handle OOM situation instead of BUG()ing.
	- please don't introduce empty functions just for the sake of it
	(e.g. per_ice_init)
	- the ioc4 driver is a mess, please rewrite it as a proper linux
	driver using serial_core, etc.. instead of glueing an irix driver
	through a midlyer directly to the tty interface.
	- please don't kill xbridge support from pcibr, we want to reuse
	it for the ip27 port soon
	- please kill the crap under PCI_HOTPLUG - that wants implementing
	as a proper linux hotplug pci driver instead.
	- msi support should go into generic code, not sn2-specific.  See
	the patches in Andrew's tree.
	- please use the generic pci-to-pci bridge code instead of reiplenting
	it.  Guy you drive me nuts with your silly hack it up on irix and
	glue it into linux strategy!
	- __HAVE_NEW_SCHEDULER is always true for 2.6, but you don't appear
	to actually use it..
	- the ifdefs in the tio code are broken, you dma mapping has zero
	chance to work for generic kernels
	- snia_if adds back the snia_pciio interface that were killed for
	a reason, don't do that!
	- you back out all changes to xswitch.c in 2.6, why?

all in all this patch is a big mess and it looks like you just took the
code from your tree and diffed vs what's in 2.6.  Please provide a patch
per thing, properly explained and reviewd.

