Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUAGW6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbUAGW6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:58:52 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:60324 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262015AbUAGW6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:58:51 -0500
Date: Wed, 7 Jan 2004 14:58:38 -0800
To: Matthew Wilcox <willy@debian.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107225838.GA6837@sgi.com>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	jeremy@sgi.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 07:02:06PM +0000, Matthew Wilcox wrote:
> So we want a pci_set_relaxed() macro / function() to set this bit
> (otherwise dozens of drivers will start to try to set the bit themselves,
> badly).  If this bit *isn't* set, setting the bit in the transaction will have
> no effect, right?

Right, we'd want that call too.  And actually, if the bit in the command
word isn't set, we're not allowed to set it in individual transactions.

> How about always setting the bit in readb() and having a readb_ordered()
> which doesn't set the bit in the transaction?  That way, drivers which
> call pci_set_relaxed() have the responsibility to verify they're not
> relying on these semantics and use readb_ordered() in any places that
> they are.

Yep, that would work too.

Jesse
