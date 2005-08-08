Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVHHQcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVHHQcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 12:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbVHHQcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 12:32:42 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:58752 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932099AbVHHQcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 12:32:42 -0400
Message-ID: <42F788F8.1000001@colorfullife.com>
Date: Mon, 08 Aug 2005 18:31:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.10) Gecko/20050719 Fedora/1.7.10-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Andrew Morton <akpm@osdl.org>, hugh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: two 2.6.13-rc3-mm3 oddities
References: <20050803095644.78b58cb4.akpm@osdl.org> <20050808140536.GC4558@in.ibm.com>
In-Reply-To: <20050808140536.GC4558@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>Hugh, could you please try this with the experimental patch below ?
>Manfred, is it safe to decrement nr_files in file_free()
>instead of the destructor ? I can't see any problem.
>
>  
>
The ctor/dtor are only called when new objects are created, not on every 
kmem_cache_alloc/kmem_cache_free. Thus I would expect that the counter 
becomes negative on builds without CONFIG_DEBUG_SLAB.
Thus increase in the ctor and decrease in file_free() is the wrong 
thing. If you want to move the decrease from the dtor to file_free, then 
you must move the increase, too.
But: IIRC the counters were moved to the ctor/dtor for performance 
reasons, I'd guess mbligh ran into cache line trashing on the 
filp_count_lock spinlock with reaim or something like that.

--
    Manfred
