Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWJROtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWJROtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 10:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWJROtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 10:49:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45349 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1161081AbWJROtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 10:49:04 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=dlVtmgFVbc+7ltVVk+WyMhYyMEphACyqaW6a3eY3f2upgWgCZLJpFNvayrClbbH6y
	ucj+2euGpzPxrTyUF6+Ow==
Message-ID: <45363E66.8010201@google.com>
Date: Wed, 18 Oct 2006 07:47:02 -0700
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Nick Piggin <npiggin@suse.de>
Subject: Re: [RFC] Remove temp_priority
References: <45351423.70804@google.com> <4535160E.2010908@yahoo.com.au> <45351877.9030107@google.com> <45362130.6020804@yahoo.com.au>
In-Reply-To: <45362130.6020804@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Coming from another angle, I am thinking about doing away with direct
> reclaim completely. That means we don't need any GFP_IO or GFP_FS, and
> solves the problem of large numbers of processes stuck in reclaim and
> skewing aging and depleting the memory reserve.

Last time I proposed that, the objection was how to throttle the heavy
dirtiers so they don't fill up RAM with dirty pages?

Also, how do you do atomic allocations? Create a huge memory pool and
pray really hard?

> But that's tricky because we don't have enough kswapds to get maximum
> reclaim throughput on many configurations (only single core opterons
> and UP systems, really).

It's not a question of enough kswapds. It's that we can dirty pages
faster than they can possibly be written to disk.

dd if=/dev/zero of=/tmp/foo

M.


