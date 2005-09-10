Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVIJVNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVIJVNF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 17:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbVIJVNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 17:13:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932311AbVIJVNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 17:13:04 -0400
Date: Sat, 10 Sep 2005 14:12:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
Message-ID: <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Alan Stern wrote:

> On Fri, 9 Sep 2005, Linus Torvalds wrote:
> > 
> > In other words, there's nothing you can or should do about it. Testing the 
> > return value is pointless. And thus adding a "must_check" is really really 
> > wrong: it might make people do
> > 
> > 	if (pci_set_power_state(pdev, 0))
> > 		return -ENODEV
> > 
> > which is actually actively the _wrong_ thing to do, and would just cause 
> > old revisions of the chip that might not support PM capabilities to no 
> > longer work.
> 
> Funny you should say this -- exactly that problem _did_ arise.  See
> 
> http://marc.theaimsgroup.com/?l=linux-pci&m=112621842604724&w=2
> 
> pci_enable_device_bars() would an error when trying to initialize 
> devices without PM support, because it started checking the return value
> from pci_set_power_state().

Case closed. 

Bogus warnings are a _bad_ thing. They cause people to write buggy code.

That drivers/pci/pci.c code should be simplified to not look at the error
return from pci_set_power_state() at all. Special-casing EIO is just
another bug waiting to happen.

			Linus
