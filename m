Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUASWHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 17:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUASWHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 17:07:15 -0500
Received: from mail.kroah.org ([65.200.24.183]:65256 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263607AbUASWFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 17:05:34 -0500
Date: Mon, 19 Jan 2004 13:41:38 -0800
From: Greg KH <greg@kroah.com>
To: linas@austin.ibm.com
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: calling pci_find_device in interrupt ?
Message-ID: <20040119214138.GF4407@kroah.com>
References: <20040119151531.C22416@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040119151531.C22416@forte.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 19, 2004 at 03:15:31PM -0600, linas@austin.ibm.com wrote:
> 
> Greg,

Hm, this isn't really a hotplug question.  This is better asked on
linux-kernel.

> I was calling pci_find_device() from an interrupt, when I discovered
> that it has a WARN_ON(in_interrupt()); in it.
> 
> Why?  If spin_lock(&pci_bus_lock); was changed to spin_lock_irqsave(),
> it seems like it would be interrupt-safe.  

Because you should not call such a function from an interrupt.  It is a
waste of time.  Just save off your pci device structure properly in your
setup functions.

Also, don't use the pci_find_* functions.  Use the pci_get_* functions
instead, as the pci_find_* functions will be going away in a future
kernel version (probably 2.7).

thanks,

greg k-h
