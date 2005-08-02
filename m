Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVHBAHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVHBAHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVHBAG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:06:59 -0400
Received: from mail.dvmed.net ([216.237.124.58]:50147 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261374AbVHBAFl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:05:41 -0400
Message-ID: <42EEB8CE.3030300@pobox.com>
Date: Mon, 01 Aug 2005 20:05:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: pci cacheline size / latency oddness.
References: <20050801233517.GA23172@redhat.com>
In-Reply-To: <20050801233517.GA23172@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> During boot of todays -git, I noticed this..
> 
> PCI: Setting latency timer of device 0000:00:1d.7 to 64
> 
> after boot, lspci shows..
> 
> 00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02) (prog-if 20 [EHCI])
> Subsystem: Dell: Unknown device 0169
> Flags: bus master, medium devsel, latency 0, IRQ 201
>                                           ^^						

Probably the hardware doesn't want you to set it, similar to what I 
describe in the following:


> It also complains about..
> 
> PCI: cache line size of 128 is not supported by device 0000:00:1d.7

This message means that it couldn't set the cacheline size at all.  Most 
likely it is either zero, or hardcoded in the silicon.  Has very little 
to do with the platform, and more to do with the device.


> x86-64 doesn't have an arch override for pci_cache_line_size, so
> it ends up at L1_CACHE_BYTES >> 2, which is 128 if you build
> x86-64 kernels with CONFIG_GENERIC_CPU or CONFIG_MPSC
> This means we will do the wrong thing on AMD machines which have
> 64 byte cachelines.   I saw this problem however on an em64t box.
> Would it make sense to shift >> once more if it fails, and retry
> with a smaller size perhaps ?

Too big is far better than too small.

	Jeff



