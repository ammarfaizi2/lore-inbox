Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUAHAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbUAHAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:34:59 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:10600 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262767AbUAHAe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:34:57 -0500
Date: Wed, 7 Jan 2004 16:34:49 -0800
To: Greg KH <greg@kroah.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108003449.GA7586@sgi.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Grant Grundler <grundler@parisc-linux.org>,
	Matthew Wilcox <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	jeremy@sgi.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040107232754.GA2807@kroah.com> <20040107235633.GA7312@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107235633.GA7312@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 03:56:33PM -0800, Jesse Barnes wrote:
> On Wed, Jan 07, 2004 at 03:27:54PM -0800, Greg KH wrote:
> > On Wed, Jan 07, 2004 at 03:07:12PM -0800, Jesse Barnes wrote:
> > > 
> > >   1) add pcix_enable_relaxed() and read_relaxed() (read() would always be
> > >      ordered)
> > 
> > This probably preserves the current situation best, enabling driver
> > writers to be explicit in knowing what is happening.

This is also the easiest solution to implement for the sn2 platform.
Honestly, I haven't used any PCI-X chipsets (nor do I know of any) that
exploit this new relaxed ordering feature, so I'm only guessing at how
it might be usefully exported to the driver API.

The sn2 platform actually _always_ behaves as though relaxed ordering
were enabled, so all we really need to implement this correctly is a
read_relaxed(), which will be a read() but without the software
workaround we put in place to conform to the PCI PIO/DMA semantics.

Maybe we can just add read_relaxed() for now and deal with other
chipsets that allow relaxed ordering as they appear?

Thanks,
Jesse
