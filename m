Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262781AbUCOWG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbUCOWG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:06:58 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:7823 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262781AbUCOWFj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:05:39 -0500
Message-ID: <405628AC.4030609@cyberone.com.au>
Date: Tue, 16 Mar 2004 09:05:32 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com> <4055BF90.5030806@cyberone.com.au> <20040315145020.GC30940@dualathlon.random>
In-Reply-To: <20040315145020.GC30940@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrea Arcangeli wrote:

>On Tue, Mar 16, 2004 at 01:37:04AM +1100, Nick Piggin wrote:
>
>>This case I think is well worth the unfairness it causes, because it
>>means your zone's pages can be freed quickly and without freeing pages
>>from other zones.
>>
>
>freeing pages from other zones is perfectly fine, the classzone design
>gets it right, you have to free memory from the other zones too or you
>have no way to work on a 1G machine. you call the thing "unfair" when it
>has nothing to do with fariness, your unfariness is the slowdown I
>pointed out, it's all about being able to maintain a more reliable cache
>information from the point of view of the pagecache users (the pagecache
>users cares at the _classzone_, they can't care about the zones
>themself), it has nothing to do with fairness.
>
>

What I meant by unfairness is that low zone scanning in response
to low zone pressure will not put any pressure on higher zones.
Thus pages in higher zones have an advantage.

We do scan lowmem in response to highmem pressure.

