Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313401AbSDYUdp>; Thu, 25 Apr 2002 16:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDYUdp>; Thu, 25 Apr 2002 16:33:45 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:42442 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S313401AbSDYUdo>;
	Thu, 25 Apr 2002 16:33:44 -0400
Subject: Re: [PATCH] (repost) kmem_cache_zalloc
From: Eric Sandeen <sandeen@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
In-Reply-To: <20020425094143.A17406@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 25 Apr 2002 15:33:21 -0500
Message-Id: <1019766801.1939.68.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph - 

On Thu, 2002-04-25 at 03:41, Christoph Hellwig wrote:

> I don't think kmem_cache_zalloc is a good idea. The idea behind the slab
> cache is to allow object reuse by storing constructed objects in the
> caches, and a memset directly after the alloc destroys the object state.
> A kmen_zalloc/kzalloc might make more sense.

The constructor is one part of it, but what about more efficient memory
use?  If we let things fall into the default power-of-two caches, we'd
waste quite a lot of memory.

See http://oss.sgi.com/~sandeen/slabinfo.html for example.

On this machine we'd use 30% more memory by using kmem_alloc vs
kmem_cache_alloc.

-Eric

-- 
Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
sandeen@sgi.com   SGI, Inc.

