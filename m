Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262474AbVDOX4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbVDOX4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDOX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:56:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:52954 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262474AbVDOX4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:56:34 -0400
Date: Fri, 15 Apr 2005 16:52:50 -0700
From: Greg KH <greg@kroah.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] tpm: Stop taking over the non-unique lpc bus PCI ID, Also timer, stack and enum fixes
Message-ID: <20050415235250.GA24204@kroah.com>
References: <Pine.LNX.4.61.0504151611390.24192@dyn95395164>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504151611390.24192@dyn95395164>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 05:06:06PM -0500, Kylene Hall wrote:
> This patch is against the 2.6.12-rc2 kernel source.  It changes the tpm 
> drivers from defining a pci driver structure to a format similar to the 
> drivers/char/watchdog/i8xx_tco driver.  This is necessary because the 
> lpc_bus only has one PCI ID and claiming that ID in the pci driver probe 
> process prevents other drivers from finding their hardware.

NO!  DO NOT use pci_find_device().  It is broken for systems with pci
hotplug (which means any pci system).  Please use the way the driver
currently works, that is correct.

> This patch 
> also fixes numerous problems that were pointed out with timer 
> manipulations, large stack objects, lack of enums and defined constants.

Why not split these up into the proper individual patches?  Remember,
one patch per "change".

> Still lingering:
> 
> How can I receive Hotplug and ACPI events without being a PCI driver?

You can't, so don't.

thanks,

greg k-h
