Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUJ1Obl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUJ1Obl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbUJ1Obk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:31:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:34229 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261693AbUJ1Oaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:30:39 -0400
Date: Thu, 28 Oct 2004 09:29:56 -0500
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due to pci_save_state change)
Message-ID: <20041028142956.GA9400@kroah.com>
References: <20041028025536.5d9b1067.akpm@osdl.org> <41810066.5000705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41810066.5000705@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 10:21:26AM -0400, Jeff Garzik wrote:
> Andrew Morton wrote:
> >
> >Begin forwarded message:
> >
> >Date: Thu, 28 Oct 2004 17:34:19 +0800 (CST)
> >From: "Zhu, Yi" <yi.zhu@intel.com>
> >To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List 
> ><linux-kernel@vger.kernel.org>
> >Subject: [PATCH] Fix e100 suspend/resume w/ 2.6.10-rc1 and above (due to 
> >pci_save_state change)
> >
> >
> >
> >Hi,
> >
> >Recent 2.6.10-rc1 merged the pci_save_state change. This prevents some
> >drivers from working with suspend/resume. The reason is the
> >pci_save_state() called in driver's ->suspend doesn't take effect any more,
> >since pci bus ->suspend will override it. And the two states might be
> >different in some drivers, i.e. e100. I don't know if there are other
> >drivers also suffer from it.
> >
> >Thanks,
> >-yi
> >
> >
> >Signed-off-by: Zhu Yi <yi.zhu@intel.com>
> >
> >--- /tmp/e100.c	2004-10-28 16:31:41.000000000 +0800
> >+++ drivers/net/e100.c	2004-10-28 16:33:14.000000000 +0800
> >@@ -2309,9 +2309,7 @@ static int e100_suspend(struct pci_dev *
> > 
> >-	pci_save_state(pdev);
> > 	pci_enable_wake(pdev, state, nic->flags & (wol_magic | 
> > 	e100_asf(nic)));
> >-	pci_disable_device(pdev);
> > 	pci_set_power_state(pdev, state);
> 
> 
> I'm waiting for Greg to respond to the serious concerns raised by 
> BenH[1] and me[2].
> 
> AFAICS, Greg has broken the standard Linux "driver knows it, driver does 
> it" model.

Huh?  How did changing the pci_save_state() api change anything?  I
didn't change the pci core any, just made it easier to not have to
specify the storage location of the memory to save everything off on.

> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=109867742404637&w=2
> [2] http://marc.theaimsgroup.com/?l=linux-kernel&m=109868495426108&w=2

I'm still on the road (all week long) and will try to get to the above
messages soon...

thanks,

greg k-h
