Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVHHRQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVHHRQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVHHRQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:16:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:24222 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932120AbVHHRQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:16:27 -0400
Date: Mon, 8 Aug 2005 07:44:40 -0700
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linville@redhat.com, torvalds@osdl.org
Subject: Re: pci_update_resource() getting called on sparc64
Message-ID: <20050808144439.GA6478@kroah.com>
References: <20050808.071211.74753610.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808.071211.74753610.davem@davemloft.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 07:12:11AM -0700, David S. Miller wrote:
> 
> Some recent change last week causes pci_update_resource()
> to be invoked on sparc64 now, and this is why my workstation
> couldn't cleanly boot into current 2.6.13 when I tried to
> remotely try out some new kernels while I was in the UK.
> 
> This thing is supposed to only be invoked if you support
> power management, and therefore we made it just BUG() on
> sparc64.
> 
> But some change last week causes it to be invoked when
> the radeonfb driver registers a device, and that's why
> my workstation failed to boot up current 2.6.13 kernels.
> 
> pci_restore_bars() is the only invoker of pci_update_resource()
> and that should only be invoked by pci_set_power_state() if
> the local variable "need_restore" is set, which occurs if
> 
> 	if (dev->current_state >= PCI_D3hot) {
> 		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> 			need_restore = 1;
> 
> and I don't see how that can happen to my radeon which is
> fully operational when the kernel boots and the radeon device
> is registered.
> 
> I'm tempted to just make pci_update_resource() not BUG() any
> longer, but that definitely feels like the wrong way to fix
> this.  And in any event, I'd like to get this fixed before
> 2.6.13 goes out the door.
> 
> Does anyone have a clue what change made last week could have
> made this start happening?

Perhaps this patch:
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43c34735524d5b1c9b9e5d63b49dd4c1b394bde4

Although in glancing at it, it might not be the reason...

thanks,

greg k-h
