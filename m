Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265629AbUAGX4p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 18:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbUAGX4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 18:56:45 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:57614 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265629AbUAGX4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:56:44 -0500
Date: Wed, 7 Jan 2004 15:56:33 -0800
To: Greg KH <greg@kroah.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107235633.GA7312@sgi.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Matthew Wilcox <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	jeremy@sgi.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040107232754.GA2807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232754.GA2807@kroah.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:27:54PM -0800, Greg KH wrote:
> On Wed, Jan 07, 2004 at 03:07:12PM -0800, Jesse Barnes wrote:
> > 
> >   1) add pcix_enable_relaxed() and read_relaxed() (read() would always be
> >      ordered)
> 
> This probably preserves the current situation best, enabling driver
> writers to be explicit in knowing what is happening.

That's what I figured too.  It also seems like it has the lowest
probability of introducing PIO vs. DMA races, since you have to
explicitly change a read() call.

What about compatibility though?  How should the interface behave if
it's accessing a PCI-X device that happens to be in PCI mode?  Ideally,
we could add these calls in and introduce no penalty for platforms that
don't support it...

Thanks,
Jesse
