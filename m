Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVBWXcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVBWXcy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbVBWX3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 18:29:09 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:27823 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261670AbVBWX0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:26:47 -0500
Date: Wed, 23 Feb 2005 17:25:12 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
In-reply-to: <3BdkS-GS-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <421D10D8.4060201@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Bbj7-7lG-17@gated-at.bofh.it> <3BbMe-7FP-39@gated-at.bofh.it>
 <3BdkS-GS-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Kilian wrote:
> 	kernel: SSE: Found a DeCypher card.
> 	kernel: ACPI: PCI interrupt 0000:13:03.0[A] -> GSI 36 (level, low) ->
> IRQ 217
> 
> 	The first message is in my driver after pci_find_device()
> 	The second is from when I do pci_enable_device(dev);
> 
> 	Can you decode the mysterious ACPI message?

Looks like you're requesting the wrong interrupt, 217 is the one your 
device is actually on. You always have to request the interrupt listed 
in the PCI device structure. If you're looking at your PCI device's 
configuration registers to get the IRQ to request, that's wrong, since 
that is configured by the BIOS assuming PIC IRQ routing, but APIC IRQ 
routing is entirely different.
