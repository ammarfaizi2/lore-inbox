Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312457AbSDCWra>; Wed, 3 Apr 2002 17:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312459AbSDCWrK>; Wed, 3 Apr 2002 17:47:10 -0500
Received: from quark.didntduck.org ([216.43.55.190]:62469 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S312458AbSDCWrH>; Wed, 3 Apr 2002 17:47:07 -0500
Message-ID: <3CAB8554.1A94C077@didntduck.org>
Date: Wed, 03 Apr 2002 17:42:28 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>
CC: Eric Sandeen <sandeen@sgi.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, marcelo@conectiva.com.br
Subject: Re: [PATCH] kmem_cache_zalloc()
In-Reply-To: <1017871982.25556.7.camel@stout.americas.sgi.com> <20020403162810.2c24ba60.reynolds@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds wrote:
> 
> Uttered "Eric Sandeen" <sandeen@sgi.com>, spoke thus:
> 
> >  In short, we're using a kmem_cache_zalloc() function in XFS which just
> >  does kmem_cache_alloc + memset.
> >
> >  We'd like to incorporate this into the kernel proper, and several others
> >  chimed in that it would be useful, so here's the patch.  If it's a no-go
> >  with you, we can roll this functionality back under fs/xfs to reduce our
> >  changes in the mainline kernel.
> 
> Why not use the constructor function interface to kmem_cache_create that is
> _already_ in the kernel API?

Constructors are only called once when the slab is allocated.  It is
expected that objects are returned to the slab in the same state.

I think a better idea would be to add a flag to the cache that tells
kmem_cache_alloc() to zero out the object it allocates instead of
creating another interface.

--

				Brian Gerst
