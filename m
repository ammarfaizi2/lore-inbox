Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbVHHLfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbVHHLfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVHHLfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:35:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32685 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750824AbVHHLfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:35:42 -0400
Date: Mon, 8 Aug 2005 19:39:10 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050808113910.GF13951@redhat.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080223445375c907@mail.gmail.com> <20050808095747.GD13951@redhat.com> <courier.42F73185.00006260@courier.cs.helsinki.fi> <20050808105613.GE13951@redhat.com> <courier.42F73AB3.00006AEE@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42F73AB3.00006AEE@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 01:57:55PM +0300, Pekka J Enberg wrote:
> David Teigland writes:
> >> but why can't you return NULL here on failure like you do for
> >> find_lock_page()?  
> >
> >because create is set
> 
> Yes, but looking at (some of the) top-level callers, there's no real reason 
> why create must not fail. Am I missing something here?

I'll trace the callers back farther and see about dealing with errors.

> >> gfs2-02.patch:+ RETRY_MALLOC(bd = kmem_cache_alloc(gfs2_bufdata_cachep, 
> 
> It is passed to the page allocator just like with kmalloc() which uses 
> __cache_alloc() too. 

Yes, I read it wrongly, looks like NOFAIL should work fine.  I think we
can get rid of the RETRY macro entirely.
Thanks,
Dave

