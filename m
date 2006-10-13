Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWJMBBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWJMBBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 21:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWJMBBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 21:01:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:34723 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751432AbWJMBBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 21:01:22 -0400
Subject: Re: [linux-pm] Bug in PCI core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0610111632240.6353-100000@iolanthe.rowland.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 11:01:03 +1000
Message-Id: <1160701263.4792.179.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 16:41 -0400, Alan Stern wrote:
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

Well, blocking user cfg access snapshots the config space to be able to
respond to user space while the device is offline. Maybe it should be
done from a separate config space image buffer ? ugh....

Ben.


