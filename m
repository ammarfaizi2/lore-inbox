Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750848AbWB0Vc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbWB0Vc0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWB0Vc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:32:26 -0500
Received: from colo.lackof.org ([198.49.126.79]:10949 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1750848AbWB0VcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:32:25 -0500
Date: Mon, 27 Feb 2006 14:42:44 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
Message-ID: <20060227214244.GA9008@colo.lackof.org>
References: <44028502.4000108@soft.fujitsu.com> <44033A2D.9000902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44033A2D.9000902@pobox.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 12:43:09PM -0500, Jeff Garzik wrote:
> This series still leaves a lot to be desired, and creates unnecessary
> driver churn.

This is a pretty small change and is not necessary for every driver.
What do you still desire that this patch set doesn't provide?

>   The better solution is:
> 
> 1) pci_enable_device() enables what it can
> 
> 2) Drivers, as they already do, will fail if they cannot map the desired
> memory or IO resources that are needed.
> 
> Thus, the PCI layer needs only to do #1, and existing driver code
> handles the rest of the situation as one currently expects.

If in #1 pci_enable_device() assigns I/O Port resources even though
the driver doesn't need it, PCI devices which _only_ support I/O Port
space will get screwed (depending on config). We are trying to avoid that.
Or do you have another way of avoiding unused resource allocation?

thanks,
grant
