Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWJXQKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWJXQKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 12:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbWJXQKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 12:10:25 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:61577 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1030411AbWJXQKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 12:10:25 -0400
Message-ID: <453E3AAC.9040403@freescale.com>
Date: Tue, 24 Oct 2006 11:09:16 -0500
From: Scott Wood <scottwood@freescale.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, Greg KH <greg@kroah.com>
Subject: Re: pci_set_power_state() failure and breaking suspend
References: <1161672898.10524.596.camel@localhost.localdomain> <200610241400.06047.rjw@sisk.pl>
In-Reply-To: <200610241400.06047.rjw@sisk.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 24 October 2006 08:54, Benjamin Herrenschmidt wrote:
>>However, this raises the question of do we actually want to prevent
>>machines to suspend when they have a PCI device that don't have the PCI
>>PM capability ? I'm asking that because I can easily imagine that sort
>>of construct growing into more drivers (sounds logical if you don't
>>think) and I can even imagine somebody thinking it's a good idea to slap
>>a __must_check on pci_set_power_state() ... 
> 
> 
> As far as the suspend to RAM is concerned, I don't know.
> 
> For the suspend to disk we can ignore the error if we know that the device
> in question won't do anything like a DMA transfer into memory while we're
> creating the suspend image.

I think it should be ignored for suspend-to-RAM as well; even if a 
device or two is consuming unnecessary power, it's better than not being 
able to suspend at all, causing more things to consume unnecessary power.

At most, a warning should be issued so the user knows what's going on, 
and can choose whether to suspend to disk instead (or choose to complain 
to the device manufacturer).

-Scott
