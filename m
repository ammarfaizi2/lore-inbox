Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282276AbRLLVYk>; Wed, 12 Dec 2001 16:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282213AbRLLVYa>; Wed, 12 Dec 2001 16:24:30 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:11311 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S282260AbRLLVYR>; Wed, 12 Dec 2001 16:24:17 -0500
Date: Wed, 12 Dec 2001 16:24:12 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Big Fish <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
Message-ID: <20011212162412.A28056@redhat.com>
In-Reply-To: <20011211162639.F6878@redhat.com> <Pine.LNX.4.21.0112112324280.981-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112112324280.981-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Dec 11, 2001 at 11:33:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 11:33:32PM +0000, Hugh Dickins wrote:
> Looks nice, but I think you need to update from atomic_inc(&map->count)
> and __free_page(map) to page_cache_get(map) and page_cache_release(map)?
> I haven't checked a 2.5.1-pre9 tree, but we had to change that in 2.4,
> to avoid PageLRU BUGs.  page_cache_get end just tidiness, of course.

Hrm, the more I look at things, the more I'm convinced that this is wrong: 
right now in the network code and other places we will use put_page() to 
release a reference to a potential page cache page which could cause the 
PageLRU BUG() to hit.  I'm sure there are lots of subtle cases like this 
all over the tree that the change in semantics has introduced bugs in.

		-ben
-- 
Fish.
