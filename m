Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTHRG5l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTHRG5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:57:40 -0400
Received: from [209.195.52.120] ([209.195.52.120]:16552 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S271287AbTHRG5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:57:39 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@osdl.org>,
       tytso@mit.edu, jmorris@intercode.com.au, jamie@shareable.org,
       linux-kernel@vger.kernel.org, davem@redhat.com
Date: Sun, 17 Aug 2003 23:55:24 -0700 (PDT)
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030818004313.T3708@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44.0308172352470.20433-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Andreas Dilger wrote:

> Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
>
> On Aug 15, 2003  23:38 -0500, Matt Mackall wrote:
> > a) extract_entropy (pool->lock)
> >
> >  For nitpickers, there remains a vanishingly small possibility that
> >  two readers could get identical results from the pool by hitting a
> >  window immediately after reseeding, after accounting, _and_ after
> >  feedback mixing.
>
> It wasn't even vanishingly small...  We had a problem in our code where
> two readers got the same 64-bit value calling get_random_bytes(), and
> we were depending on this 64-bit value being unique.  This problem was
> fixed by putting a spinlock around the call to get_random_bytes().

if the number is truely random then there should be a (small but finite)
chance that any two reads will return the same data. counting on a random
number to be unique is not a good idea.

now if you can repeatably get the same number then you probably have a bug
in the random number code, but if you need uniqueness you need something
else.

David Lang
