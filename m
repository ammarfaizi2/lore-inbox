Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWABTSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWABTSS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 14:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWABTSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 14:18:18 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38214 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1750971AbWABTSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 14:18:17 -0500
Date: Mon, 02 Jan 2006 13:18:05 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: X86_64 + VIA + 4g problems
In-reply-to: <5qAKf-7n4-19@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Message-id: <43B97C6D.7010902@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <5qvTv-8f-17@gated-at.bofh.it> <5qAKf-7n4-19@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> When you not compile in the SKGE network driver does everything else work?
> skge supports 64bit DMA, so it shouldn't use any IOMMU.

Are you sure this is skge? Anyway, even if the driver does support 
64-bit DMA, I would be surprised if a desktop motherboard had the 
Ethernet chip connected via a 64-bit PCI bus.

This brings up something I've been wondering. It's possible to run most 
64-bit capable PCI devices in a 32-bit slot (i.e. with the 64-bit part 
hanging out of the slot). In this configuration the device will not be 
able to use 64-bit DMA (unless it supports dual address cycle). However, 
who is supposed to detect this and know to not try to use DMA addresses 
above 4GB on that device? Is the driver supposed to know this and use a 
32-bit DMA mask, or is the PCI subsystem able to figure this out 
somehow? What if the driver has no way to detect this? I don't think 
I've seen any code in the kernel that would figure out if the current 
configuration of the card is actually capable of 64-bit DMA or not.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
