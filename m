Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271018AbRIFOso>; Thu, 6 Sep 2001 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271095AbRIFOse>; Thu, 6 Sep 2001 10:48:34 -0400
Received: from geos.coastside.net ([207.213.212.4]:10911 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S271018AbRIFOs1>; Thu, 6 Sep 2001 10:48:27 -0400
Mime-Version: 1.0
Message-Id: <p05100300b7bd3bf9bf7a@[10.128.7.49]>
In-Reply-To: <591984348.999786074@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.33L.0109061003320.31200-100000@imladris.rielhome.con ectiva>
 <591984348.999786074@[10.132.112.53]>
Date: Thu, 6 Sep 2001 07:47:50 -0700
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Rik van Riel <riel@conectiva.com.br>,
        Stephan von Krawczynski <skraw@ithnet.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: page pre-swapping + moving it on cache-list
Cc: _deepfire@mail.ru, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:21 PM +0100 2001-09-06, Alex Bligh - linux-kernel wrote:
>It's not keeping it two lists that prevents proper
>defragmentation. It's having it allocated all around
>memory, and never freeing the pages which prevent
>coalescence of areas, and thus either
>throwing away the data, or garbage collecting, that
>prevents defragmentation. We never free these pages
>either because they sit in an idle system (with
>no memory pressure) in places like
>inactive_dirty, or in caches, or, in an active
>system, because they are direct_reclaim'd out
>of inactive_clean etc., so never get freed [1].
>
>As this kind of garbage collection requires memcpy()
>etc., it might be harmless when the system is
>idle, but isn't going to be an attractive option when
>the system is busy thrashing away (though it might be
>possible to hueristically evict awkward pages
>preferentially, by aging them more harshly).

The problem with thrashing, is it not, is that we're not making 
forward progress because we're waiting for swap--that is to say, 
thrashing *is* an idle state of sorts, and so might be an ideal 
opportunity for gc methods that require heavy CPU involvement. It's 
not as if there's anything better to do....
-- 
/Jonathan Lundell.
