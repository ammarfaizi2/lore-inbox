Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUAITv5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbUAITv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:51:57 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:40357 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263453AbUAITv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:51:56 -0500
Date: Fri, 9 Jan 2004 11:51:47 -0800
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Grant Grundler <grundler@parisc-linux.org>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, James.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040109195147.GA32690@sgi.com>
Mail-Followup-To: Jeremy Higdon <jeremy@sgi.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
	James.Bottomley@steeleye.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> <20040108184406.GA29210@colo.lackof.org> <20040109071347.GB343099@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109071347.GB343099@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 11:13:47PM -0800, Jeremy Higdon wrote:
> In theory, such a distinction would be useful for any platform that
> uses separate paths for PIO read responses and DMA writes.  Perhaps
> there is only one platform that has that feature?

Well, the big MIPS boxes behave this way too.  Ralf and Christoph, what
do you think?  The current PCI DMA mapping API is insufficient for
Origin and other Bridge/Hub boxes, although I don't think there's any
way to implement pci_sync_consistent() on Origin unless there happens to
be an extra interrupt line available for each PCI slot.  That would
allow the arch code to generate a DMA write barrier (by forcing an
interrupt as we do on sn2) that would force previous DMA into the
coherence domain before it completed.

Jesse
