Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755967AbWKQWR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbWKQWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755968AbWKQWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:17:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41170 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1755967AbWKQWR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:17:28 -0500
Date: Fri, 17 Nov 2006 17:16:14 -0500
From: Alan Cox <alan@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@redhat.com>
Subject: Re: [-mm patch] remove drivers/pci/search.c:pci_find_device_reverse()
Message-ID: <20061117221614.GD20362@devserv.devel.redhat.com>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117142145.GX31879@stusta.de> <20061117115404.4bc87cf9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117115404.4bc87cf9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 11:54:04AM -0800, Andrew Morton wrote:
> On Fri, 17 Nov 2006 15:21:45 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > This patch removes the no longer used pci_find_device_reverse().
> 
> But it is exported to modules.
> 
> This is what we created EXPORT_UNUSED_SYMBOL() for.

Normally - but for the fact pci_find_device{_reverse} is unsafe on
any box with any kind of pci hotplug events.

It really needs to die. It is not hotplug safe. The alternative would be
to export it only with !CONFIG_HOTPLUG (which is what my test kernel
does for both this and pci_find_device()). If we do that then to all
intents and purposes it vanishes from most standard builds

The conversion is also trivial

Alan
