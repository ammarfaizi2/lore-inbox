Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272776AbTHKQHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 12:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272790AbTHKQHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 12:07:39 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:58048 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S272776AbTHKQFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 12:05:47 -0400
Message-ID: <3F37BED1.405@colorfullife.com>
Date: Mon, 11 Aug 2003 18:05:37 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
References: <3F361F5E.10106@colorfullife.com> <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain> <3F37B4B7.9010108@colorfullife.com> <Pine.LNX.4.56.0308111723040.11173@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0308111723040.11173@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> Exactly that happens.
>
>>I'm running with CONFIG_PAGE_DEBUG, i.e. unallocated pages are marked as 
>>non-present in the linear mapping.
>>    
>>
>
>this is not a bug technically, unless the mount options are in the last
>linearly mapped page. It is a bug to copy those unallocated bytes, but
>they do not get to relied upon. Note that the non-4G code copies them just
>as much.
>  
>
Or unless there are holes in the memory map, or unless pages were 
unmapped from the kernel linear mapping for GART.
IMHO the currect code is unacceptable.
It is possible to use direct_copy_ instead of memcpy for fs==KERNEL_DS 
in mm/usercopy.c?

--
    Manfred

