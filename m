Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWGHKS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWGHKS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWGHKS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:18:26 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:28679 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932321AbWGHKSZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:18:25 -0400
Message-ID: <44AF8668.2070306@argo.co.il>
Date: Sat, 08 Jul 2006 13:18:16 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linus Torvalds <torvalds@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <1152352309.3120.15.camel@laptopd505.fenrus.org>
In-Reply-To: <1152352309.3120.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jul 2006 10:18:23.0542 (UTC) FILETIME=[D8017560:01C6A277]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>
> >
> > > with PCI, and the PCI posting rules, there is no "one" serializing
> > > instruction, you need to know the specifics of the device in 
> question to
> > > cause the flush. So at least there is no universal possible
> > > implementation of volatile as you suggest ;-)
> > >
> >
> > A serializing volatile makes it possible to write portable code to
> > access pci mmio.  You'd just follow a write with a read or whatever the
> > rules say.
>
> yeah except that the compiler cannot know what to read; reading back the
> same memory location is NOT correct nor safe. It's device specific, for
> some devices it'll be safe, for others you have to read some OTHER
> location.
>

I didn't suggest the compiler could or should do it, just that it would 
be possible (for the _user_) to write portable ISO C code to access PCI 
mmio registers, if volatile's implementation serialized access.

With the current implementation of volatile in gcc, it is impossible - 
you need to resort to inline assembly for some architectures, which is 
not an ISO C feature.

And I'm not suggesting that it would be a good idea to use volatile even 
if it was corrected - it would have to take a worst-case approach and 
thus would generate very bad code.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

