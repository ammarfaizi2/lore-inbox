Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWJQW1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWJQW1a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWJQW1a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:27:30 -0400
Received: from solarneutrino.net ([66.199.224.43]:18958 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1750809AbWJQW13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:27:29 -0400
Date: Tue, 17 Oct 2006 18:27:27 -0400
To: Aleksey Gorelov <dared1st@yahoo.com>
Cc: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org,
       auke-jan.h.kok@intel.com
Subject: Re: Machine restart doesn't work - Intel 965G, 2.6.19-rc2
Message-ID: <20061017222727.GB24891@tau.solarneutrino.net>
References: <20061017180003.GB24789@tau.solarneutrino.net> <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20061017205316.25914.qmail@web83109.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 01:53:15PM -0700, Aleksey Gorelov wrote:
> 
> 
> --- Ryan Richter <ryan@tau.solarneutrino.net> wrote:
> > 
> > 2.6.19-rc1-git9 doesn't work any better for me.  I haven't tried
> > unloading the e1000 module yet.  Since I run the machine off an nfsroot,
> > it will require some creativity to test that.
> > 
> > -ryan
> 
> You may try the following patch instead if it's easier for you. It'll
> likely break suspend stuff,
> but you won't need to play around with modules.
> 
> Aleks.
> 
> --- linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c.orig	2006-10-17 13:36:06.000000000 -0700
> +++ linux-2.6.19-rc2/drivers/net/e1000/e1000_main.c	2006-10-17 13:36:50.000000000 -0700
> @@ -4847,6 +4847,7 @@
>  static void e1000_shutdown(struct pci_dev *pdev)
>  {
>  	e1000_suspend(pdev, PMSG_SUSPEND);
> +	pci_set_power_state(pdev, PCI_D0);
>  }
>  
>  #ifdef CONFIG_NET_POLL_CONTROLLER


This patch allows the machine to reboot normally.

Thanks,
-ryan
