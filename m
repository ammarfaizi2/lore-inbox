Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTESQNy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTESQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 12:13:54 -0400
Received: from palrel10.hp.com ([156.153.255.245]:34455 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261326AbTESQNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 12:13:53 -0400
Date: Mon, 19 May 2003 09:26:48 -0700
From: Grant Grundler <iod00d@hp.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, "David S. Miller" <davem@redhat.com>,
       Jes Sorensen <jes@wildopensource.com>, torvalds@transmeta.com,
       cngam@sgi.com, jeremy@sgi.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ia64@linuxia64.org,
       wildos@sgi.com
Subject: Re: [Linux-ia64] Re: [patch] support 64 bit pci_alloc_consistent
Message-ID: <20030519162648.GC21356@cup.hp.com>
References: <16071.1892.811622.257847@trained-monkey.org> <1053250142.1300.8.camel@laptop.fenrus.com> <20030518.023533.98888328.davem@redhat.com> <20030518094341.A1709@devserv.devel.redhat.com> <20030518172203.GA13855@cup.hp.com> <1053280195.10810.61.camel@mulgrave> <20030518201718.GB13855@cup.hp.com> <1053293187.10811.70.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053293187.10811.70.camel@mulgrave>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 04:26:22PM -0500, James Bottomley wrote:
> A full bit u64 mask should never fail...

OK. "never fail" in the sense that the driver has advertised a mask
which equals or exceeds the platform capabilities. 

Bottom line is the driver has to check the platform DMA support
likes the proposed mask and adjust it's behavior accordingly.
Existing API and Arjen's proposal both require that.

> Also, knowing the effective mask (and it would have to be set properly
> on return) would be extremely useful for drivers that have weird width
> modes (like aic with 64 vs 39 vs 32 bit addressing in the
> descriptors)

aic driver could try all three in order of preference?
"extremely useful" seems like a stretch to me.

> ...it would allow me to eliminate the memory size checks in
> those drivers.

I expect DMA support to determine how many bits are needed to
address all of physical RAM and accept/reject the 64/39/32-bit DMA
mask as appropriate. I haven't studied x86 DMA support recently.
There might be valid reasons it doesn't work that way.

grant
