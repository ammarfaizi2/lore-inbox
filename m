Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbVHHK55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbVHHK55 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHHK55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:57:57 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:6025 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750821AbVHHK54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:57:56 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
            <courier.42F73185.00006260@courier.cs.helsinki.fi>
            <20050808105613.GE13951@redhat.com>
In-Reply-To: <20050808105613.GE13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Mon, 08 Aug 2005 13:57:55 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F73AB3.00006AEE@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> > but why can't you return NULL here on failure like you do for
> > find_lock_page()?  
> 
> because create is set

Yes, but looking at (some of the) top-level callers, there's no real reason 
why create must not fail. Am I missing something here? 

> > gfs2-02.patch:+ RETRY_MALLOC(bd = kmem_cache_alloc(gfs2_bufdata_cachep, 
> >                                                    GFP_KERNEL),
> > -> GFP_NOFAIL  
> 
> It looks to me like NOFAIL does nothing for kmem_cache_alloc().
> Am I seeing that wrong?

It is passed to the page allocator just like with kmalloc() which uses 
__cache_alloc() too. 

                Pekka 
