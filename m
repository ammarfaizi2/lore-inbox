Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265939AbUFTUJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUFTUJP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 16:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUFTUJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 16:09:15 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:61881 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S265939AbUFTUJM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 16:09:12 -0400
Message-ID: <40D5EE99.1050300@pacbell.net>
Date: Sun, 20 Jun 2004 13:07:53 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Ian Molton <spyro@f2s.com>, rmk+lkml@arm.linux.org.uk,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
References: <1087584769.2134.119.camel@mulgrave>	<20040618195721.0cf43ec2.spyro@f2s.co <40D34078.5060909@pacbell.net>	<20040618204438.35278560.spyro@f2s.com> <1087588627.2134.155.camel@mulgrave	<40D359BB.3090106@pacbell.net> <1087593282.2135.176.camel@mulgrave>	<40D36EDE.2080803@pacbell.net> <1087600052.2135.197.camel@mulgrave>	<40D4849B.3070001@pacbell.net>	<20040619214126.C8063@flint.arm.linux.org.uk>	<1087681604.2121.96.camel@mulgrave> <20040619234933.214b810b.spyro@f2s.com>	<1087738680.10858.5.camel@mulgrave>  <20040620165042.393f2756.spyro@f2s.com> <1087750024.11222.81.camel@mulgrave>
In-Reply-To: <1087750024.11222.81.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> The DMA API is about allowing devices to transact directly with memory
> behind the memory controller, ...

Nope, that's certainly not in the API spec.  Never has been,
and I'd have objected if it had been ... because I knew this
was one of the types of hardware the API needed to support as
Linux ran on more systems.  The call syntax just returns two
addresses, usable by host and by device:

     void *
     dma_alloc_coherent(struct device *dev, size_t size,
                 dma_addr_t *dma_handle, int flag);

That doesn't say ANYTHING about where that memory lives, or
who may or may not have set up a "struct page" (or what the
page size is for that component).  It certainly doesn't make
assumptions about which busses are used by CPU or device for
memory or control access, or how they're linked.

- Dave


