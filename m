Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJ1PFG>; Mon, 28 Oct 2002 10:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261297AbSJ1PFF>; Mon, 28 Oct 2002 10:05:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53145 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261293AbSJ1PFF>;
	Mon, 28 Oct 2002 10:05:05 -0500
Date: Mon, 28 Oct 2002 16:08:32 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [patch][cft] zero-copy dma cd writing and ripping
Message-ID: <20021028150832.GF2937@suse.de>
References: <20021018155650.GJ15494@suse.de> <20021028.043507.104714061.davem@redhat.com> <20021028124240.GC872@suse.de> <1035816048.8970.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035816048.8970.1.camel@rth.ninka.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28 2002, David S. Miller wrote:
> On Mon, 2002-10-28 at 04:42, Jens Axboe wrote:
> > > This work reminds me that get_user_pages() (or it's callers)
> > > need to be doing some flush_dcache_page()
> > 
> > Was wondering about that. Can you tell me what it needs? And what about
> > bio_unmap_user(), surely that needs to flush cache as well for reads?
> 
> Documentation/cachetlb.txt describes where flush_dcache_page is needed.
> If that doesn't describe it enough for you, that is a bug and please
> tell me what part is confusing so I may make the document better.

Ok what I make of this is that from bio_map_user() (which does a
get_user_pages() I need to do a

	if (write_to_vm)
		flush_dcache_page(page);

and in bio_unmap_user() I do

	if (!write_to_vm)
		flush_dcache_page(page);

is that correct?

-- 
Jens Axboe

