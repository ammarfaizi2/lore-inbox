Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWITXXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWITXXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWITXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:23:45 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:31621 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750938AbWITXXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:23:44 -0400
Date: Wed, 20 Sep 2006 17:22:43 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Flushing writes to PCI devices
In-reply-to: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Message-id: <4511CD43.6060507@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> I've heard that to insure proper synchronization it's necessary to flush
> MMIO writes (writel, writew, writeb) to PCI devices by reading from the
> same area.  Is this equally true for I/O-space writes (inl, inw, inb)?  
> What about configuration space writes (pci_write_config_dword etc.)?

Technically, according to the PCI specification, I/O space writes may be 
posted in the host bus bridge (though unlike MMIO space, not at any 
other PCI bridges) and would require a read in order to flush them. 
However, there seem to be few if any chipsets ever made which actually 
do this for I/O writes, and most code in the kernel seems to just assume 
it won't happen, so it's probably safe to assume the same.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

