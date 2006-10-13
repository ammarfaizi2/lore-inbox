Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751581AbWJMR5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWJMR5w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbWJMR5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:57:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56592 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751581AbWJMR5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:57:51 -0400
Date: Fri, 13 Oct 2006 13:57:48 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Matthew Wilcox <matthew@wil.cx>, Adam Belay <abelay@MIT.EDU>,
       Arjan van de Ven <arjan@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
In-Reply-To: <1160760867.25218.77.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L0.0610131355550.6612-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006, Alan Cox wrote:

> Ar Gwe, 2006-10-13 am 10:49 -0600, ysgrifennodd Matthew Wilcox:
> > No it didn't.  It's undefined behaviour to perform *any* PCI config
> > access to the device while it's doing a D-state transition.  It may have
> 
> I think you missed the earlier parts of the story - the kernel caches
> the base config register state.
> 
> > happened to work with the chips you tried it with, but more likely you
> > never hit that window because X simply didn't try to do that.
> 
> Which is why the kernel caches the register state. This all came up long
> ago and the solution we currently have was the one chosen after
> considerable debate and analysis about things like locking. We preserved
> the historical reliable interface going back to the early Linux PCI
> support and used by all the apps.

Would it be okay for pci_block_user_cfg_access() to use its own cache, so 
it doesn't interfere with data previously cached by pci_save_state()?

Alan Stern

