Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbUKLMSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUKLMSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 07:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262519AbUKLMSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 07:18:15 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:56253 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262515AbUKLMSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 07:18:11 -0500
Message-ID: <4194A9F9.7060901@yahoo.com.au>
Date: Fri, 12 Nov 2004 23:18:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Non-e1000, 2.6.9 page allocation failures with OSS/audio.
References: <Pine.LNX.4.61.0411120658490.19273@p500>
In-Reply-To: <Pine.LNX.4.61.0411120658490.19273@p500>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> The other page allocation failures were due to the e1000+TSO 
> segmentation offload issue.
> 
> I use OSS sound drivers with 2.6.9.
> 
> Here are the options I use and have been using for quite some time 
> without error:
> 
> 1] <*> Open Sound System (DEPRECATED)
> 2] <*>   OSS sound modules
> 3] [*]     Verbose initialisation
> 4] [*]     Persistent DMA buffers
> 5] <*>     Crystal CS4232 based (PnP) cards
> 
> My LILO append line as is follows:
> append="cs4232=0x530,5,1,0,388,5 mce video=atyfb:1600x1200-16@60"
> 
> What happened to the page allocation / memory subsystem in 2.6.9?
> I do not recall getting these with 2.6.4, 2.6.5, 2.6.6, 2.6.7, 2.6.8 or 
> 2.6.8.1.
> 

These failures are actually harmless and not entirely unexpected.
That path should tell the allocator not to produce warnings on
failure.

The issue is being actively worked on in the -mm kernels, and the
important stuff should get into 2.6.10.

However, earlier kernels had a bug that prevented a large amount
of ZONE_DMA memory from being allocated by GFP_KERNEL allocations
which is probably why this particular path hasn't been a problem
before. This actually won't be completely reverted in 2.6.10, however
the correct way to get this behaviour is with "lower zone protection"
which Andrea had been working on... so things may happen soon.
