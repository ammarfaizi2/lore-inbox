Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVBXALm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVBXALm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 19:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVBXAKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 19:10:39 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:40817 "EHLO
	pd4mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261665AbVBWXxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 18:53:34 -0500
Date: Wed, 23 Feb 2005 17:52:25 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Help enabling PCI interrupts on Dell/SMP and Sun/SMP systems.
In-reply-to: <3Be7p-1pY-43@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <421D1739.9090500@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3Bbj7-7lG-17@gated-at.bofh.it> <3BbMe-7FP-39@gated-at.bofh.it>
 <3BdkS-GS-21@gated-at.bofh.it> <3BdNW-1bH-29@gated-at.bofh.it>
 <3Be7p-1pY-43@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Kilian wrote:
> 	Maybe that's it.
> 
> 	I ask the card which interrupt line it was given at boot-time:
> 
> 	pci_read_config_byte(dev, PCI_INTERRUPT_LINE,
> 	                     &softp->interrupt_line);
> 
> 	Then I request an IRQ:
> 
> 	request_irq(softp->interrupt_line, sseintr, 
>                     SA_INTERRUPT, "sse", softp);

Yeah, that's wrong. Should be request_irq(dev->irq, ... )

PCI_INTERRUPT_LINE is assigned by the BIOS and has nothing to do with 
the routing used in APIC mode. That's why it works with noapic mode 
since then the routing is the same as the BIOS assumed.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


