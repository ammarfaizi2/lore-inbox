Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVJOWCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVJOWCb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJOWCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:02:31 -0400
Received: from rwcrmhc11.comcast.net ([216.148.227.117]:48324 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751238AbVJOWCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:02:30 -0400
Date: Sat, 15 Oct 2005 14:59:12 -0700
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
Message-ID: <20051015215912.GA11321@virtuousgeek.org>
References: <20051015185502.GA9940@plato.virtuousgeek.org> <43515ADA.6050102@s5r6.in-berlin.de> <20051015202944.GA10463@plato.virtuousgeek.org> <43516E78.6040502@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43516E78.6040502@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 15, 2005 at 11:02:48PM +0200, Stefan Richter wrote:
> What about the PCI_CACHE_LINE_SIZE read/write?
> 
> Jody McIntyre wrote on 2005-02-09:
> | Can you try the fix without
> | pci_write_config_word(dev,PCI_CACHE_LINE_SIZE,toshiba_pcls);
> | or pci_read_config_word(dev,PCI_CACHE_LINE_SIZE,&toshiba_pcls);
> | and report if it still works?
> |
> | If it doesn't work, try leaving those lines out but adding
> | pci_clear_mwi(dev);
> | after the mdelay(), on the off chance that the device thinks mwi is on.
> |
> | The correct fix for this, if possible, is actually a pci quirk instead
> | of the dmi-based approach, but if reading PCI_CACHE_LINE_SIZE before
> | pci_enable_device() really is necessary, this will be rather difficult.
> [ http://marc.theaimsgroup.com/?l=linux1394-devel&m=110797909807519 ]

It looks like it is.

I removed the PCI_CACHE_LINE_SIZE read and write, and that didn't work.
I added in a pci_clear_mwi(dev) and that didn't work either.  It looks
like the whole patch that I posted earlier is required.

Thanks,
Jesse
