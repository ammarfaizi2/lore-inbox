Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWJNFgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWJNFgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 01:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWJNFgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 01:36:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:38595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932100AbWJNFgj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 01:36:39 -0400
Date: Fri, 13 Oct 2006 22:34:48 -0700
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Bug in PCI core
Message-ID: <20061014053448.GA8105@kroah.com>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:41:22PM -0400, Alan Stern wrote:
> When a PCI device is suspended, its driver calls pci_save_state() so that
> the config space can be restored when the device is resumed.  Then the
> driver calls pci_set_power_state().
> 
> However pci_set_power_state() calls pci_block_user_cfg_access(), and that 
> routine calls pci_save_state() again.  This overwrites the saved state 
> with data in which memory, I/O, and bus master accesses are disabled.  As 
> a result, when the device is resumed it doesn't work.
> 
> Obviously pci_block_user_cfg_access() needs to be fixed.  I don't know the 
> right way to fix it; hopefully somebody else does.

Yeah, I'm just going to drop the patch from Matthew that added this.
Andrew also noted that it causes bad things to happen on his laptop.

Thanks for pointing it out.

I gotta get suspend working on a machine here so I can test these things
better...

thanks,

greg k-h
