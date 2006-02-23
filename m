Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbWBWGB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbWBWGB4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBWGBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:01:55 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:3275 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750833AbWBWGBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:01:53 -0500
Message-ID: <43FD4F1B.9000307@jp.fujitsu.com>
Date: Thu, 23 Feb 2006 14:58:51 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, greg@kroah.com, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 0/6] PCI legacy I/O port free driver (take2)
References: <43FAB283.8090206@jp.fujitsu.com> <1140662098.8264.18.camel@localhost.localdomain>
In-Reply-To: <1140662098.8264.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>Here, there are many PCI devices that provide both I/O port and MMIO
>>interface, and some of those devices can be handled without using I/O
>>port interface. The reason why such devices provide I/O port interface
>>is for compatibility to legacy OSs. So this kind of devices should
>>work even if enough I/O port resources are not assigned. The "PCI
>>Local Bus Specification Revision 3.0" also mentions about this topic
>>(Please see p.44, "IMPLEMENTATION NOTE"). On the current linux,
>>unfortunately, this kind of devices don't work if I/O port resources
>>are not assigned, because pci_enable_device() for those devices fails.
> 
> 
> Which is where the real problem is ... I'm afraid you are doing a
> workaround for the wrong issue... do we really need to assign all
> resources to the device at pci_enable_device() time ? Yeah, I know, that
> sounds gross... but think about it... doesn't pci_request_region(s) look
> like a better spot ? Or maybe we should change pci_enable_device()
> itself to take a mask of BARs that are relevant. That would help dealing
> with a couple of other cases of devices where some BARs really need to
> be ignored...
> 
> The later is probably the best approach without breaking everything, by
> having a new pci_enable_resources(mask) that would take a mask of BARs
> to enable, with pci_enable_device() becoming just a call to the former
> for all BARs ....
> 
> Ben.
> 

I guess the existing pci_enable_device_bars() is very similar to
your pci_enable_resources(). We already discussed it at:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114000705026791&w=2

Thanks,
Kenji Kaneshige
