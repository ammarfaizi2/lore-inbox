Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312988AbSDYImB>; Thu, 25 Apr 2002 04:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312996AbSDYImA>; Thu, 25 Apr 2002 04:42:00 -0400
Received: from imladris.infradead.org ([194.205.184.45]:20486 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312988AbSDYIl7>; Thu, 25 Apr 2002 04:41:59 -0400
Date: Thu, 25 Apr 2002 09:41:43 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] (repost) kmem_cache_zalloc
Message-ID: <20020425094143.A17406@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Sandeen <sandeen@sgi.com>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com, marcelo@conectiva.com.br
In-Reply-To: <1019682472.15455.33.camel@stout.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2002 at 04:07:52PM -0500, Eric Sandeen wrote:
> (reposting)
> 
> There was a brief thread on this patch a while ago, please see 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.3/0601.html
> 
> In short, XFS is using a kmem_cache_zalloc() function which just
> does kmem_cache_alloc + memset.

Hi Eric,

I don't think kmem_cache_zalloc is a good idea. The idea behind the slab
cache is to allow object reuse by storing constructed objects in the
caches, and a memset directly after the alloc destroys the object state.
A kmen_zalloc/kzalloc might make more sense.

