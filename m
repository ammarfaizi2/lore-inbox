Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284205AbRLKXcP>; Tue, 11 Dec 2001 18:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284198AbRLKXb5>; Tue, 11 Dec 2001 18:31:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40532 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S284197AbRLKXbh>; Tue, 11 Dec 2001 18:31:37 -0500
Date: Tue, 11 Dec 2001 23:33:32 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linus Torvalds <torvalds@transmeta.com>, axboe@suse.de,
        Big Fish <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
In-Reply-To: <20011211162639.F6878@redhat.com>
Message-ID: <Pine.LNX.4.21.0112112324280.981-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Benjamin LaHaise wrote:
> 
> Since the big block melee has started pretty quickly, I'd like to try 
> to start reeling things in so that they aren't off on a tangent that 
> completely excludes the requirements of aio and the revamped kiobufs 
> that were discussed earlier.  To that end, I'm offering up the below 
> patch that adds the kvec structure and helpers so that we can begin 
> converting kiobuf users, as well as networking and the newly introduced 
> bio_vecs into a unified set of primatives.  Comments?

Looks nice, but I think you need to update from atomic_inc(&map->count)
and __free_page(map) to page_cache_get(map) and page_cache_release(map)?
I haven't checked a 2.5.1-pre9 tree, but we had to change that in 2.4,
to avoid PageLRU BUGs.  page_cache_get end just tidiness, of course.

Hugh

