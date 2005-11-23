Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVKWWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVKWWGr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 17:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVKWWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 17:06:47 -0500
Received: from mail.dvmed.net ([216.237.124.58]:9350 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932565AbVKWWGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 17:06:46 -0500
Message-ID: <4384E7F2.2030508@pobox.com>
Date: Wed, 23 Nov 2005 17:06:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Grover <andrew.grover@intel.com>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       john.ronciak@intel.com, christopher.leech@intel.com
Subject: Re: [RFC] [PATCH 0/3] ioat: DMA engine support
References: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
In-Reply-To: <Pine.LNX.4.44.0511231143380.32487-100000@isotope.jf.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Andrew Grover wrote: > As presented in our talk at this
	year's OLS, the Bensley platform, which > will be out in early 2006,
	will have an asyncronous DMA engine. It can be > used to offload copies
	from the CPU, such as the kernel copies of received > packets into the
	user buffer. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Grover wrote:
> As presented in our talk at this year's OLS, the Bensley platform, which 
> will be out in early 2006, will have an asyncronous DMA engine. It can be 
> used to offload copies from the CPU, such as the kernel copies of received 
> packets into the user buffer.

IOAT is super-neat stuff.

In addition to helping speed up network RX, I would like to see how 
possible it is to experiment with IOAT uses outside of networking. 
Sample ideas:  VM page pre-zeroing.  ATA PIO data xfers (async copy to 
static buffer, to dramatically shorten length of kmap+irqsave time). 
Extremely large memcpy() calls.

Additionally, current IOAT is memory->memory.  I would love to be able 
to convince Intel to add transforms and checksums, to enable offload of 
memory->transform->memory and memory->checksum->result operations like 
sha-{1,256} hashing[1], crc32*, aes crypto, and other highly common 
operations.  All of that could be made async.

	Jeff



