Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVHHKvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVHHKvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHHKvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:51:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47242 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750820AbVHHKvl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:51:41 -0400
Date: Mon, 8 Aug 2005 18:56:13 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050808105613.GE13951@redhat.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080223445375c907@mail.gmail.com> <20050808095747.GD13951@redhat.com> <courier.42F73185.00006260@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42F73185.00006260@courier.cs.helsinki.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 01:18:45PM +0300, Pekka J Enberg wrote:

> gfs2-02.patch:+ RETRY_MALLOC(ip = kmem_cache_alloc(gfs2_inode_cachep, 
> -> GFP_NOFAIL. 

Already gone, inode_create() can return an error.

if (create) {
        RETRY_MALLOC(page = grab_cache_page(aspace->i_mapping, index),
                     page);
} else {
        page = find_lock_page(aspace->i_mapping, index);
        if (!page)
                return NULL;
}

> I think you can set aspace->flags to GFP_NOFAIL 

will try that

> but why can't you return NULL here on failure like you do for
> find_lock_page()? 

because create is set

> gfs2-02.patch:+ RETRY_MALLOC(bd = kmem_cache_alloc(gfs2_bufdata_cachep, 
>                                                    GFP_KERNEL),
> -> GFP_NOFAIL 

It looks to me like NOFAIL does nothing for kmem_cache_alloc().
Am I seeing that wrong?

> gfs2-10.patch:+         RETRY_MALLOC(new_gh = gfs2_holder_get(gl, state,
> gfs2_holder_get uses kmalloc which can use GFP_NOFAIL. 

Which means adding a new gfp_flags parameter... fine.

Dave

