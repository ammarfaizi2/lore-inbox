Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSLIWRf>; Mon, 9 Dec 2002 17:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266256AbSLIWRf>; Mon, 9 Dec 2002 17:17:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:18062 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266250AbSLIWRe>;
	Mon, 9 Dec 2002 17:17:34 -0500
Message-ID: <3DF4EEC8.716AF196@digeo.com>
Date: Mon, 09 Dec 2002 11:28:08 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.50 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
CC: dipankar@in.ibm.com, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <3DEFB0EB.9893DB9@digeo.com> <20021209110029.F17375@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2002 19:28:08.0554 (UTC) FILETIME=[1AB39CA0:01C29FB9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> 
> ...
> As for the object sizes
> 1. We are assuming 32 bytes cachelines in this thread I suppose
> But ppc64 has a 128 byte cacheline and s390 a 256 byte Jumbo cacheline.
> I guess with larger cacheline sizes you have lesser no of cachelines --
> makes cachelines all the more precious.  (Right now, I am speaking
> in ignorance of the ppc64 and s390 cache architectures .. I
> can just see L1_CACHE_SHIFT in the kernel sources).  So wouldn't
> interlaced allocations help these archs .. even when you have 64
> bytes big objects?

You're assuming that the slab allocator always returns cachesize-padded
objects.  It does not have to do that.  It can return 4-byte-sized and
-aligned objects if you ask it to.

> ...
> Does this make a reasonable case for interlaced allocator now?
> (Of course, blklist init in the patch has to be modified to create
> blklists for objects of size 4, 8 .... SMP_CACHE_BYTES/2)

Oh I can see the benefits, but they appear to be rather theoretical.

I'm just applying some pressure here against adding another allocator
unless it is really needed.  On principle.

A slab cache of 4-byte objects will tend to give you what you want
anyway, due to the batch filling and freeing of the head arrays.
If that is proven to be insufficient then it would be better to
put development effort into strengthening slab, rather than competely
bypassing it.

(And a really simple solution would be to create a separate slab cache
per cpu...)
