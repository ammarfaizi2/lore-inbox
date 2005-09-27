Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965230AbVI0XHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbVI0XHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbVI0XHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:07:44 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:25311 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965230AbVI0XHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:07:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] vm - swap_prefetch-11
Date: Wed, 28 Sep 2005 09:10:46 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050927185635.8023.qmail@lwn.net>
In-Reply-To: <20050927185635.8023.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509280910.46526.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005 04:56 am, Jonathan Corbet wrote:
> Hi, Con,
>
> > This patch implements swap prefetching when the vm is relatively idle and
> > there is free ram available.
>
> I'm having a look at it now (better late than never...), and a couple of
> questions come to mind...

Hey thanks for looking. It can be quite hard for people to find time to review 
patches and I appreciate the effort.

> The more general of the two is: would it make sense to somehow merge
> your swapped_entry data structure with Rik's page-remembering scheme for
> CLOCK-PRO?  Assumed that both are someday destined for inclusion, it
> seems it would make sense to add just one "remember info about swapped
> pages" data structure, rather than two.

Indeed it would. I was hoping the time frame for inclusion of swap prefetching 
would be much shorter than clock pro given the relatively intrusive nature of 
clock pro. It would make sense to update the accounting to that of clock pro 
if/when clock pro was pushed. One of the features of the current accounting 
is it is extremely cheap and slightly sloppy on purpose since there is no 
point to being perfectly accurate and incur the extra overhead. Once that 
overhead is considered worthwhile for clock pro algorithms we can just use 
that data.

> Second question:
> It looks like you are adding these fields to every address_space
> structure in the system - and there can be a fair number of those.  But
>
> further down, when it comes time to remember a swapped page:

> You're only actually remembering pages associated with a single address
> space.
>
> Do you anticipate adding prefetching from other address spaces as well?
> If not, it might be worth putting these structures somewhere else to
> avoid bloating the address_space structure.
>
> ...or am I missing something again...?

Nope you're definitely not missing something. As you're well aware code ends 
up often being far from the original attempt. It's the legacy of the code 
evolution and it was something I would hopefully have thought about myself 
without being prompted by someone else. I'll have to get onto that with the 
next version.

Just as a data point there is still a workload that is inappopriately causing 
out-of-memory conditions when it shouldn't and only once I nail all known 
issues from the -ck users will I push it to -mm.

Thanks again

Cheers,
Con
