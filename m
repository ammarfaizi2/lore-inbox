Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUD1WyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUD1WyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUD1WyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:54:07 -0400
Received: from mail.kroah.org ([65.200.24.183]:43411 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261654AbUD1Ww5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:52:57 -0400
Date: Wed, 28 Apr 2004 15:52:36 -0700
From: Greg KH <greg@kroah.com>
To: Brian King <brking@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: userspace pci config space accesses
Message-ID: <20040428225236.GA27250@kroah.com>
References: <409026CE.8050905@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <409026CE.8050905@us.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2004 at 04:49:02PM -0500, Brian King wrote:
> I recently ran into a problem where lspci was trying to read pci config 
> space
> of a pci adapter while the device driver for that adapter was running BIST
> on it. On ppc64, this resulted in a PCI error and puts the slot into an 
> error state making it unusable for the remainder of that system boot.
> Should there be some blocking in place so that userspace pci config
> reads will not occur in these windows or is using tools like lspci
> user beware?

There already is a pci_config_lock that should be grabbed when accessing
pci config space.  It sounds like the driver needs to play a bit nicer
when it's running a self test :)

What driver is doing this?

thanks,

greg k-h
