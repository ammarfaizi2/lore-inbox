Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUCOOhX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 09:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUCOOhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 09:37:23 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:12245 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262589AbUCOOhJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 09:37:09 -0500
Message-ID: <4055BF90.5030806@cyberone.com.au>
Date: Tue, 16 Mar 2004 01:37:04 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, j-nomura@ce.jp.nec.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [2.4] heavy-load under swap space shortage
References: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0403150822040.12895-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rik van Riel wrote:

>On Mon, 15 Mar 2004, Andrea Arcangeli wrote:
>
>
>>it is the absolutely worst case since both lru could be of around the same
>>size (800M zone-normal-lru and 1.2G zone-highmem-lru), maximizing the
>>loss of "age" information needed for optimal reclaim decisions.
>>
>
>You only lose age information if you don't put equal aging
>pressure on both zones.  If you make sure the allocation and
>pageout pressure are more or less in line with the zone sizes,
>why would you lose any aging information ?
>
>

I can't see that you would, no. But maybe I've missed something.
We apply pressure equally except when there is a shortage in a
low memory zone, in which case we can scan only the required
zone(s).

This case I think is well worth the unfairness it causes, because it
means your zone's pages can be freed quickly and without freeing pages
from other zones.

