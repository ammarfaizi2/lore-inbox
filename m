Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVKWXDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVKWXDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbVKWXDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:03:06 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48262 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030478AbVKWXDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:03:02 -0500
Message-ID: <4384F520.3060502@pobox.com>
Date: Wed, 23 Nov 2005 18:02:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Grover <andrew.grover@intel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, john.ronciak@intel.com,
       christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com> <4384E7F2.2030508@pobox.com> <20051123223007.GA5921@wotan.suse.de>
In-Reply-To: <20051123223007.GA5921@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andi Kleen wrote: > Longer term the right way to handle
	this would be likely to use > POSIX AIO on sockets. With that interface
	it would be easier > to keep long queues of data in flight, which would
	be best for > the DMA engine. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Longer term the right way to handle this would be likely to use
> POSIX AIO on sockets. With that interface it would be easier
> to keep long queues of data in flight, which would be best for
> the DMA engine.

Agreed.

For my own userland projects, I'm starting to feel the need for network 
AIO, since it is more natural:  the hardware operations themselves are 
asynchronous.


>>In addition to helping speed up network RX, I would like to see how 
>>possible it is to experiment with IOAT uses outside of networking. 
>>Sample ideas:  VM page pre-zeroing.  ATA PIO data xfers (async copy to 
>>static buffer, to dramatically shorten length of kmap+irqsave time). 
>>Extremely large memcpy() calls.
> 
> 
> Another proposal was swiotlb.

That's an interesting thought.


> But it's not clear it's a good idea: a lot of these applications prefer to 
> have the target in cache. And IOAT will force it out of cache.
> 
> 
>>Additionally, current IOAT is memory->memory.  I would love to be able 
>>to convince Intel to add transforms and checksums, to enable offload of 
>>memory->transform->memory and memory->checksum->result operations like 
>>sha-{1,256} hashing[1], crc32*, aes crypto, and other highly common 
>>operations.  All of that could be made async.
> 
> 
> I remember the registers in the Amiga Blitter for this and I'm
> still scared... Maybe it's better to keep it simple.

We're talking about CISC here!  ;-) ;-)

[note: I'm the type of person who would stuff the kernel + glibc onto an 
FPGA, if I could]

I would love to see Intel, AMD, VIA (others?) compete by adding selected 
transforms/checksums/hashs to their chips, though this method.  Just 
provide a method to enumerate what transforms are supported on <this> 
chip...

	Jeff


