Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbUCJFcX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 00:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUCJFcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 00:32:23 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:26333 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261432AbUCJFcV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 00:32:21 -0500
Message-ID: <404EA353.7080507@cyberone.com.au>
Date: Wed, 10 Mar 2004 16:10:43 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/4] VM split active lists
References: <404D56D8.2000008@cyberone.com.au>
In-Reply-To: <404D56D8.2000008@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nick Piggin wrote:

>
> OK, the theory is that mapped pagecache pages are worth more than
> unmapped pages. This is a good theory because mapped pages will
> usually have far more random access patterns, so pagein *and* pageout
> will be much less efficient. Also, applications are probably coded to
> be more suited to blocking in read() than a random code / anon memory
> page. So a factor of >= 16 wouldn't be out of the question.
>

Just a followup - there is a small but significant bug in patch
#4/4. In shrink_zone, mapped_ratio should be divided by
nr_active_unmapped. I have this fixed, hugepage compile problems
fixed, and a mapped_page_cost tunable in place of swappiness. So
anyone interested in testing should please ask me for my latest
patch.

I'm getting some preliminary numbers now. They're pretty good,
looks like they should be similar to dont-rotate-active-list
which isn't too surprising.

Interestingly, mapped_page_cost of 8 is close to optimal for
swapping-kbuild throughput. Values of 4 and 16 are both worse.
mapped_page_cost is in units of unmapped page cost. Maybe it is
just me, but I find this scheme is more meaningful and provides
more control than swappiness.

