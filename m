Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUAHSo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUAHSo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:44:56 -0500
Received: from colo.lackof.org ([198.49.126.79]:14742 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S265939AbUAHSoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:44:08 -0500
Date: Thu, 8 Jan 2004 11:44:06 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com,
       linux-pci@atrey.karlin.mff.cuni.cz, James.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108184406.GA29210@colo.lackof.org>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108173655.GA11168@sgi.com>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 09:36:55AM -0800, Jesse Barnes wrote:
> > BTW, Jesse, did you look at part II of Documentation/DMA-ABI.txt?
> 
> I remember seeing discussion of the new API, but haven't read that doc
> yet.  Since most drivers still use the pci_* API, we'd have to add a
> call there, but we may as well make the two APIs as similar as possible
> right?

That would be my preference too.

I haven't studied "part II" closely enough to figure out if adding
pci_sync_consistent() would outright replace much of the DMA-API
interface. The main issue is cacheline ownership.

pci_sync_consistent() needs to indicate CPU wants ownership of outstanding
cachelines vs IO device wanting to own them.
SN2 doesn't care about the latter case since it's "mostly coherent".
SN2 just needs to flush in-flight DMA and it's coherent again.
But older non-coherent platforms do care.

I trust James understands this better than I given the fun
he's had with old parisc HW (715/50).

grant
