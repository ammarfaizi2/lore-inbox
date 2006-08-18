Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWHRA1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWHRA1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 20:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWHRA1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 20:27:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19596 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750858AbWHRA07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 20:26:59 -0400
Message-ID: <44E508C7.1080907@redhat.com>
Date: Thu, 17 Aug 2006 20:24:39 -0400
From: Rik van Riel <riel@redhat.com>
Organization: Red Hat, Inc
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, tgraf@suug.ch, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [RFC][PATCH 2/9] deadlock prevention core
References: <20060808211731.GR14627@postel.suug.ch>	<44DBED4C.6040604@redhat.com>	<44DFA225.1020508@google.com>	<20060813.165540.56347790.davem@davemloft.net>	<44DFD262.5060106@google.com>	<20060813185309.928472f9.akpm@osdl.org>	<1155530453.5696.98.camel@twins>	<20060813215853.0ed0e973.akpm@osdl.org>	<44E3E964.8010602@google.com> <20060816225726.3622cab1.akpm@osdl.org> <44E5015D.80606@google.com>
In-Reply-To: <44E5015D.80606@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Andrew Morton wrote:
>> Daniel Phillips <phillips@google.com> wrote:
>>> What happened to the case where we just fill memory full of dirty file
>>> pages backed by a remote disk?
>>
>> Processes which are dirtying those pages throttle at
>> /proc/sys/vm/dirty_ratio% of memory dirty.  So it is not possible to 
>> "fill"
>> memory with dirty pages.  If the amount of physical memory which is dirty
>> exceeds 40%: bug.

> So we make 400 MB of a 1 GB system unavailable for write caching just to
> get around the network receive starvation issue?
> 
> What happens if some in kernel user grabs 68% of kernel memory to do some
> very important thing, does this starvation avoidance scheme still work?

Also think about eg. scientific calculations, or anonymous memory.

People want to be able to use a larger percentage of their memory
for dirty data, without swapping...

-- 
What is important?  What you want to be true, or what is true?
