Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbWCMV5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbWCMV5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWCMV5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 16:57:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21691 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932469AbWCMV5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 16:57:45 -0500
Date: Mon, 13 Mar 2006 21:57:40 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc6
Message-ID: <20060313215740.GA30457@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060312090305.GA18134@infradead.org> <200603131254.53838.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131254.53838.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 12:54:53PM -0700, Bjorn Helgaas wrote:
> On Sunday 12 March 2006 02:03, Christoph Hellwig wrote:
> > On Sat, Mar 11, 2006 at 03:58:12PM -0800, Linus Torvalds wrote:
> > > Bjorn Helgaas:
> > >       [IA64] don't report !sn2 or !summit hardware as an error
> > >       [IA64] SGI SN drivers: don't report !sn2 hardware as an error
> > 
> > These should be reverted.  They return success from initcalls when they
> > should report failure.  In the mmtimer case this is a real bug as it can
> > be modular, in others it's just cosmetic but provides people wrong examples
> > to cut & paste from.
> 
> Do you want all the drivers that just return pci_register_driver(&foo)
> to be changed as well?  I haven't heard a compelling argument either way,
> but there are certainly many drivers that return 0 when they successfully
> register a driver that didn't find any devices, e.g., 

That's different.  The pci drivers support hotplug.  The ia64-specific
drivers only driver onboard devices that can't appear at runtime.

