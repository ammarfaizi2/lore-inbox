Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWB0WXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWB0WXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWB0WXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:23:12 -0500
Received: from mail.dvmed.net ([216.237.124.58]:63450 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964840AbWB0WXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:23:12 -0500
Message-ID: <44037BC6.30003@pobox.com>
Date: Mon, 27 Feb 2006 17:23:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andi Kleen <ak@suse.de>,
       benh@kernel.crashing.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take 3)
References: <44028502.4000108@soft.fujitsu.com> <44033A2D.9000902@pobox.com> <20060227214244.GA9008@colo.lackof.org>
In-Reply-To: <20060227214244.GA9008@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Mon, Feb 27, 2006 at 12:43:09PM -0500, Jeff Garzik wrote:
> 
>>This series still leaves a lot to be desired, and creates unnecessary
>>driver churn.
> 
> 
> This is a pretty small change and is not necessary for every driver.

The latter is decidedly false.  The change makes no sense at all unless 
you update every conceivable driver that will be used on the target 
platform.  You will always be patching drivers as users stick new cards 
in the target hardware.


>>  The better solution is:
>>
>>1) pci_enable_device() enables what it can
>>
>>2) Drivers, as they already do, will fail if they cannot map the desired
>>memory or IO resources that are needed.
>>
>>Thus, the PCI layer needs only to do #1, and existing driver code
>>handles the rest of the situation as one currently expects.
> 
> 
> If in #1 pci_enable_device() assigns I/O Port resources even though
> the driver doesn't need it, PCI devices which _only_ support I/O Port
> space will get screwed (depending on config). We are trying to avoid that.
> Or do you have another way of avoiding unused resource allocation?

Fix the [firmware | device load order] to allocate I/O ports first to 
the hardware that only supports IO port accesses.  Problem solved with 
zero kernel mods...

	Jeff


