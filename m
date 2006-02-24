Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWBXHgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWBXHgi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWBXHgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:36:38 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:9091 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750830AbWBXHgh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:36:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C6lHjz42sMTzRVGSZOVAZSnoXT1XZaA0r48/ltdGSwbIart6zhOJpMDXVp8b6wCSMeSjRrev611akn9x+k60PGxK58lqLR8+KX+x8O1A9R8Hpr7buDb0MtunPQp1w4pj73DJqpYeL2n3HpjUWTc9r3y+9o1ybHCNMXnHIPMuE3w=
Message-ID: <84144f020602232336l480f6a4el9f7f708f9c3a61e1@mail.gmail.com>
Date: Fri, 24 Feb 2006 09:36:36 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Christoph Lameter" <clameter@engr.sgi.com>
Subject: Re: slab: Remove SLAB_NO_REAP option
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Alok Kataria" <alok.kataria@calsoftinc.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0602231502380.7798@localhost.localdomain>
	 <20060223020957.478d4cc1.akpm@osdl.org>
	 <Pine.LNX.4.58.0602231331530.15716@sbz-30.cs.Helsinki.FI>
	 <Pine.LNX.4.64.0602230917540.1796@schroedinger.engr.sgi.com>
	 <1140719812.11455.1.camel@localhost>
	 <Pine.LNX.4.64.0602231044210.13228@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> There is a loop but its broken by
>
>                         p = l3->slabs_free.next;
>                         if (p == &(l3->slabs_free))
>                                 break;
>
> One cache_reap() may scan the free list but once its free the code is
> skipped.

Which is _totally_ redundant for cache_cache.

On 2/23/06, Christoph Lameter <clameter@engr.sgi.com> wrote:
> There are potentially large amounts of other caches around that are also
> basically static and which also would need any bypass that we may
> implement.

I don't think its worth it. It doesn't make much sense to create a
separate object cache if you're not using it, we're better off
converting those to kmalloc(). cache_cache is there to make
bootstrapping easier, it is very unlikely that you ever have more than
one page allocated for that cache which is why scanning the freelist
_at all_ is silly. I think SLAB_NO_REAP should go away but we also
must ensure we don't introduce a performance regression while doing
that.

                                 Pekka
