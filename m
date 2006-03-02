Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWCBSMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWCBSMu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 13:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbWCBSMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 13:12:50 -0500
Received: from mail.dvmed.net ([216.237.124.58]:26821 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751655AbWCBSMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 13:12:49 -0500
Message-ID: <44073593.60703@pobox.com>
Date: Thu, 02 Mar 2006 13:12:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302180025.GC28895@flint.arm.linux.org.uk>
In-Reply-To: <20060302180025.GC28895@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> It's not really "I/O port resource allocation" though - the resources
> have already been allocated and potentially programmed into the BARs
> well before the driver gets anywhere near the device.
[...]
> Are you implying that somehow resources are allocated at pci_enable_device
> time?  If so, shouldn't we be thinking of moving completely to that model
> rather than having yet-another-pci-setup-model.

Actually, that's has been the rule ever since the cardbus days: 
resources -- bars and irqs -- should not be considered allocated until 
after pci_enable_device().

Documentation/pci.txt reflects this reality as well:

> 3. Enabling and disabling devices
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    Before you do anything with the device you've found, you need to enable
> it by calling pci_enable_device() which enables I/O and memory regions of
> the device, allocates an IRQ if necessary, assigns missing resources if
> needed and wakes up the device if it was in suspended state. Please note
> that this function can fail.

Any PCI driver that presumes -anything- about resources before calling 
pci_enable_device() is buggy, and that's been the case for many years. 
Some platform-specific PCI drivers violate this with special knowledge, 
but overall that's the rule.

Regards,

	Jeff


