Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318990AbSIIVOn>; Mon, 9 Sep 2002 17:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSIIVOn>; Mon, 9 Sep 2002 17:14:43 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:11436 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S318990AbSIIVOl>;
	Mon, 9 Sep 2002 17:14:41 -0400
Message-ID: <3D7D105D.7050604@colorfullife.com>
Date: Mon, 09 Sep 2002 23:19:25 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: Calculating kernel logical address ..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nobody seems to have come forth to implement a thought-out scatter/gather,
> map-user-pages library infrastructure so I'd be a bit reluctant to
> break stuff without offering a replacement.
> 

We'd need one.

get_user_pages() is broken if a kernel module access the virtual address 
of the page and the cpu caches are not coherent:
Most of the flush functions need the vma pointer, but it's impossible to 
guarantee that it still exists when the get_user_pages() user calls 
page_cache_release().

--
	Manfred

