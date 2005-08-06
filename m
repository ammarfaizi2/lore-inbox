Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262030AbVHFDfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbVHFDfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 23:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVHFDfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 23:35:01 -0400
Received: from havoc.gtf.org ([69.61.125.42]:25038 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262030AbVHFDe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 23:34:59 -0400
Date: Fri, 5 Aug 2005 23:34:55 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Greg KH <greg@kroah.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       rajesh.shah@intel.com, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 6700/6702PXH quirk
Message-ID: <20050806033455.GA23679@havoc.gtf.org>
References: <1123259263.8917.9.camel@whizzy> <20050805183505.GA32405@kroah.com> <1123279513.4706.7.camel@whizzy> <20050805225712.GD3782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805225712.GD3782@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 03:57:12PM -0700, Greg KH wrote:
> Anyway, Jeff is right, add another bit field.


The updated patch, which adds a new bitfield, looks OK to me.

However...

<pedantic>

FWIW, compilers generate AWFUL code for bitfields.  Bitfields are
really tough to do optimally, whereas bit flags ["unsigned int flags &
bitmask"] are the familiar ints and longs that the compiler is well
tuned to optimize.

Additionally, though it is not the case with struct pci_dev, bitfields
cause endian headaches (see the LITTLE_ENDIAN_BITFIELD ifdefs).

Bit flags are -far- superior in every case.  Avoid bitfields like the plague.

</pedantic>

I wouldn't mind seeing a janitor remove all bitfields from struct pci_dev,
and any other kernel structure that uses the evil constructs.

        Jeff

