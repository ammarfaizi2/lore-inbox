Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUFRViy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUFRViy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbUFRVhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:37:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26753 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263962AbUFRVIV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:08:21 -0400
Message-ID: <40D359B3.6080400@pobox.com>
Date: Fri, 18 Jun 2004 17:08:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Molton <spyro@f2s.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: DMA API issues
References: <20040618175902.778e616a.spyro@f2s.com>
In-Reply-To: <20040618175902.778e616a.spyro@f2s.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> Hi.
> 
> This may have come up previously but I havent seen it, so...
> 
> My colleagues and I are encountering a number of difficulties with the
> DMA API, to which a generic solution is required (or risk multiple
> architectures, busses, and devices going their own way...)
> 
> Here is an example system that illustrates these problems:
> 
> I have a System On Chip device which, among other functions, contains an
> OHCI controller and 32K of SRAM.
> 
> heres the catch:- The OHCI controller has a different address space than
> the host bus, and worse, can *only* DMA data from its internal SRAM.

Unfortunately, I tend to think that you should not be using the DMA API 
for this, since it's not host RAM.

There are loads of devices with on-board SRAM/DRAM/... you really have 
to manage your own resources at that point.

I know that sucks, WRT driver re-use.  Maybe you can wrap it inside the 
OHCI driver, ohci_dma_alloc_xxx() etc.  For the normal case, the wrapper 
resolves directly to the DMA API.  For the embedded case, the wrapper 
does SRAM-specific stuff.

You _might_ convince the kernel DMA gurus that this could be done by 
creating a driver-specific bus, and pointing struct device to that 
internal bus, but that seems like an awful lot of work as opposed to the 
wrappers.

	Jeff


