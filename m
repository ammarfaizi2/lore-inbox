Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVA0WAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVA0WAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbVA0WAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:00:38 -0500
Received: from alog0106.analogic.com ([208.224.220.121]:53120 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261214AbVA0WAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:00:31 -0500
Date: Thu, 27 Jan 2005 16:58:40 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Rik van Riel <riel@redhat.com>, Russell King <rmk+lkml@arm.linux.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       James Antill <james.antill@redhat.com>,
       Bryn Reeves <breeves@redhat.com>
Subject: Re: don't let mmap allocate down to zero
In-Reply-To: <20050127211319.GN10843@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0501271650320.23676@chaos.analogic.com>
References: <Pine.LNX.4.61.0501261116140.5677@chimarrao.boston.redhat.com>
 <20050126172538.GN10843@holomorphy.com> <20050127050927.GR10843@holomorphy.com>
 <16888.46184.52179.812873@alkaid.it.uu.se> <20050127125254.GZ10843@holomorphy.com>
 <20050127142500.A775@flint.arm.linux.org.uk> <20050127151211.GB10843@holomorphy.com>
 <Pine.LNX.4.61.0501271420070.13927@chimarrao.boston.redhat.com>
 <20050127204455.GM10843@holomorphy.com> <Pine.LNX.4.61.0501271557300.13927@chimarrao.boston.redhat.com>
 <20050127211319.GN10843@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, William Lee Irwin III wrote:

> On Thu, 27 Jan 2005, William Lee Irwin III wrote:
>>> (b) sys_mremap() isn't covered.
>
> On Thu, Jan 27, 2005 at 03:58:12PM -0500, Rik van Riel wrote:
>> AFAICS it is covered.
>>> --- mm1-2.6.11-rc2.orig/mm/mremap.c	2005-01-26 00:26:43.000000000 -0800
>>> +++ mm1-2.6.11-rc2/mm/mremap.c	2005-01-27 12:34:34.000000000 -0800
>>> @@ -297,6 +297,8 @@
>>> 	if (flags & MREMAP_FIXED) {
>>> 		if (new_addr & ~PAGE_MASK)
>>> 			goto out;
>>> +		if (!new_addr)
>>> +			goto out;
>>
>> This looks broken, look at the MREMAP_FIXED part...
>
> The only way I can make sense of this is if you're trying to say that
> because the user is trying to pass in a fixed address, that 0 should
> then be permitted.
>
> The intention was to disallow vmas starting at 0 categorically. i.e. it
> is very intentional to deny the MREMAP_FIXED to 0 case of mremap().
> It was also the intention to deny the MAP_FIXED to 0 case of mmap(),
> though I didn't actually sweep that much (if at all).
>
>
> -- wli

No! Then you can't make a tool that will be able to look at
the entire x86 address-space! You end up with an offset that will
eventually wrap to zero which you are denying. You must leave
MAP_FIXED alone. Ignore the 'C' pedants, a pointer is properly
initialized if it points to a mapped address. It would be absurd
to have to make the CPU calculate the address at run-time just
because you thew some rocks in the way.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
