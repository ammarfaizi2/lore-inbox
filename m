Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbUAHAJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbUAHAJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:09:05 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1578 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264283AbUAHAJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:09:01 -0500
Date: Wed, 7 Jan 2004 16:08:51 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108000850.GA339772@sgi.com>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040107232754.GA2807@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107232754.GA2807@kroah.com>
User-Agent: Mutt/1.4.1i
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
> 
> thanks,
> 
> greg k-h

I like this best too.  That way, a driver can enable a relaxed read
in the performance path and not have to audit the other reads.

So in a generic PCI driver, you'd call pcix_enable_relaxed() and
then use read() for initialization, error recovery, etc., and
use read_relaxed() in the main execution path where it is determined
to be safe.

The default would be the standard behavior that we have.

One question I have is what the need for pcix_enable_relaxed() is.
Are we thinking that this sets some bit in one or more registers?
What happens if you use read_relaxed() and you didn't call
pcix_enable_relaxed() previously?

jeremy
