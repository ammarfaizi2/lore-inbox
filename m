Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVBHUQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVBHUQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbVBHUQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:16:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:12521 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261658AbVBHUQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:16:18 -0500
Date: Tue, 8 Feb 2005 12:08:16 -0800
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050208200816.GA25292@kroah.com>
References: <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston> <1106841228.14787.23.camel@localhost.localdomain> <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com> <41FF9C78.2040100@us.ibm.com> <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk> <41FFBDC9.2010206@us.ibm.com> <20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk> <4200F2B2.3080306@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4200F2B2.3080306@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:33:06AM -0600, Brian King wrote:
> Matthew Wilcox wrote:
> >On Tue, Feb 01, 2005 at 11:35:05AM -0600, Brian King wrote:
> >
> >>>If we've done a write to config space while the adapter was blocked,
> >>>shouldn't we replay those accesses at this point?
> >>
> >>I did not think that was necessary.
> >
> >
> >We have to do *something*.  We can't just throw away writes.
> >
> >I see a few options:
> >
> > - Log all pending writes to config space and replay the log when the
> >   device is unblocked.
> > - Fail writes to config space while the device is blocked.
> > - Write to the saved config space and then blat the saved config space
> >   back to the device upon unblocking.
> 
> Here is an updated patch which will now fail writes to config space 
> while the device is blocked. I have also fixed up the caching to return 
> the correct data and tested it on both little endian and big endian 
> machines.

Applied, thanks.

greg k-h
