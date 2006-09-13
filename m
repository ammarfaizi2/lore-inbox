Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWIMEEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWIMEEW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 00:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWIMEEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 00:04:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:648 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751533AbWIMEET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 00:04:19 -0400
Message-ID: <4507833A.30504@garzik.org>
Date: Wed, 13 Sep 2006 00:04:10 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@gmail.com>
CC: Roland Dreier <rdreier@cisco.com>, neilb@suse.de,
       linux-raid@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       christopher.leech@intel.com, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH 08/19] dmaengine: enable multiple clients and operations
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>	 <20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>	 <4505F4D0.7010901@garzik.org>	 <e9c3a7c20609111714h1b88f8cbid99c567d7f3e997c@mail.gmail.com>	 <adairjt3nz4.fsf@cisco.com> <e9c3a7c20609112318o7febe296he6162ddd494499fd@mail.gmail.com>
In-Reply-To: <e9c3a7c20609112318o7febe296he6162ddd494499fd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> On 9/11/06, Roland Dreier <rdreier@cisco.com> wrote:
>>     Jeff> Are we really going to add a set of hooks for each DMA
>>     Jeff> engine whizbang feature?
> ...ok, but at some level we are going to need a file that has:
> EXPORT_SYMBOL_GPL(dma_whizbang_op1)
> . . .
> EXPORT_SYMBOL_GPL(dma_whizbang_opX)
> correct?

If properly modularized, you'll have multiple files with such exports.

Or perhaps you won't have such exports at all, if it is hidden inside a 
module-specific struct-of-hooks.


> I understand what you are saying Jeff, the implementation can be made
> better, but something I think is valuable is the ability to write
> clients once like NET_DMA and RAID5_DMA and have them run without
> modification on any platform that can provide the engine interface
> rather than needing a client per architecture
> IOP_RAID5_DMA...FOO_X_RAID5_DMA.

It depends on the situation.

The hardware capabilities exported by each platform[or device] vary 
greatly, not only in the raw capabilities provided, but also in the 
level of offload.

In general, we don't want to see hardware-specific stuff in generic 
code, though...


> Or is this an example of the where "Do What You Must, And No More"
> comes in, i.e. don't worry about making a generic RAID5_DMA while
> there is only one implementation existence?

> I also want to pose the question of whether the dmaengine interface
> should handle cryptographic transforms?  We already have Acrypto:
> http://tservice.net.ru/~s0mbre/blog/devel/acrypto/index.html.  At the
> same time since IOPs can do Galois Field multiplication and XOR it
> would be nice to take advantage of that for crypto acceleration, but
> this does not fit the model of a device that Acrypto supports.

It would be quite interesting to see where the synergies are between the 
two, at the very least.  "async [transform|sum]" is a superset of "async 
crypto" after all.

	Jeff


