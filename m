Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263207AbTCWU45>; Sun, 23 Mar 2003 15:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263210AbTCWU44>; Sun, 23 Mar 2003 15:56:56 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:27135 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S263207AbTCWU44>; Sun, 23 Mar 2003 15:56:56 -0500
Message-ID: <3E7E2219.5090501@quark.didntduck.org>
Date: Sun, 23 Mar 2003 16:07:37 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Anton Blanchard <anton@samba.org>, Brian Gerst <bgerst@didntduck.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] slab.c cleanup
References: <3E7E204C.2040700@colorfullife.com>
In-Reply-To: <3E7E204C.2040700@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Anton wrote:
> 
>>> - Don't create caches that are not multiples of L1_CACHE_BYTES.
>>
>>
>> Nice idea, I often see the list walk (of the cache sizes) in kmalloc 
>> in kernel
>> profiles. eg a bunch of kmalloc(2k) for network drivers.
>>
>> Since we have a 128byte cacheline on ppc64 this patch should reduce that.
>>  
>>
> No, the patch is a bad thing: It means that everyone who does 
> kmalloc(32,) now allocates 128 bytes, i.e. 3/4 wasted. IMHO not acceptable.

Perhaps, but it currently is already allocating 128 bytes for smaller 
caches, because the cache is created with SLAB_HWCACHE_ALIGN.  So we 
ended up with redundantly sized caches.

--
				Brian Gerst

