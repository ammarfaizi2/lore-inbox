Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbVJ3XE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVJ3XE7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVJ3XE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:04:59 -0500
Received: from terminus.zytor.com ([192.83.249.54]:45776 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932398AbVJ3XE6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:04:58 -0500
Message-ID: <43655188.3000808@zytor.com>
Date: Sun, 30 Oct 2005 15:04:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Deepak Saxena <dsaxena@plexity.net>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tony@atomide.com
Subject: Re: [patch 0/5] HW RNG cleanup & new drivers
References: <20051029191229.562454000@omelas> <4363F31F.2040303@pobox.com> <20051030200219.GB4794@plexity.net> <Pine.LNX.4.64.0510301433070.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301433070.27915@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 30 Oct 2005, Deepak Saxena wrote:
> 
>>I think moving it to user space will add more complexity for
>>the case where the HW unit is shared with an in in-kernel driver.
> 
> 
> Moving it to user space is just generally stupid.
> 
> Often, the random stuff comes from chipsets, not the CPU itself. Not 
> user-accessible at all, and even if it were, it would be a bad idea to 
> have user space do things the kernel does normally ("what northbridge do I 
> have").
> 
> There may be use for a user-level library that handles the native CPU 
> instructions for high performance, but that in no way negates the reason 
> why /dev/random and friends exist in the first place.
> 

We're not talking about /dev/random, we're talking about /dev/hw_random 
which is read by rndg and then fed by userspace back into /dev/[u]random.

Clearly, there are cases (e.g. VIA) where rndg or a library called from 
rngd could just as easily have done the extraction in userspace, and for 
that, it makes no sense to force it to do it in the kernel.  For some, 
it could be done either way, and for others a kernel driver is clearly 
needed.  Integrating them all into /dev/hw_random was probably a 
mistake, though.

	-hpa
