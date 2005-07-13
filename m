Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbVGMAUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbVGMAUz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGMAUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:20:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:1988 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262258AbVGMAUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:20:48 -0400
Subject: Re: [PATCH 2.6.13-rc1 03/10] IOCHK interface for I/O error
	handling/detecting
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <20050712195120.GE26607@austin.ibm.com>
References: <42CB63B2.6000505@jp.fujitsu.com>
	 <42CB664E.1050003@jp.fujitsu.com>  <20050712195120.GE26607@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 10:18:57 +1000
Message-Id: <1121213938.31924.406.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you assuming that a device driver will use an iochk_read() for
> every DMA operation? for every MMIO to the card?  
> 
> For high performance devices, it seems to me that this will cause
> a rather large performance burden, especially if its envisioned that
> all architectures will do something similar.
> 
> My concern is that (at least on ppc64) the call pci_read_config_word()
> requires a call into "firmware" aka "BIOS", which takes thousands upon
> thousands of cpu cycles.  There are hundreds of cycles of gratuitous
> crud just to get into the firmware, and then lord-knows-what the
> firmware does while its in there; probably doing all sorts of crazy
> math to compute bus addresses and other arcane things.  I would imagine
> that most architectures, includig ia64, are similar.
> 
> Thus, one wouldn't want to perform an iochk_read() in this way unless
> one was already pretty sure that an error had already occured ... 
> 
> Am I misunderstanding something?

I would expect pSeries not to use the "default" error checking (that
tests the status register) but rather use EEH.

Ben.


