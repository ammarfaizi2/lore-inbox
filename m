Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267354AbSLLABz>; Wed, 11 Dec 2002 19:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267360AbSLLABz>; Wed, 11 Dec 2002 19:01:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:14056 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267354AbSLLABy>;
	Wed, 11 Dec 2002 19:01:54 -0500
Message-ID: <3DF7D3BE.59F4B212@digeo.com>
Date: Wed, 11 Dec 2002 16:09:34 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Patrick R. McManus" <mcmanus@ducksong.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Memory Measurements and Lots of Files and Inodes
References: <20021211235258.GA10857@ducksong.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 00:09:34.0739 (UTC) FILETIME=[C07A7630:01C2A172]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Patrick R. McManus" wrote:
> 
> ...
> Just sitting back and watching vmstat while this runs my 'free' memory
> drops from ~600MB to about ~16MB.. the buffers and cache remain roughly
> constant.. at 16MB some sort of garbage collection kicks in - there is
> a notable system pause and ~70MB moves from the used to the 'free'
> column... this process repeats more or less in a steady state.

Probably `negative dentries' - cached directory entries which say
"this file isn't there" so we don't need to go into the fs to
find that out.

If you could share your test apps that would help a lot.
 
> If, while this is going on, I run another little app that does
> {x= malloc(300MB), memset (x,0,300MB), free (x)}.. suddenly I can move
> 300MB from the used to the 'free' state...

The slab cache (general kernel memory allocator+cache) has mechanisms
for freeing cached objects when memory gets tight.  That will recycle
all those negative dentries.  If that's what you're seeing.
 
> ...
> Can anybody provide a better metric for "ram free for userspace
> allocations"?

On your machine it'll be "all of swap plus all of physical memory
minus whatever malloc'ed memory you're using now minus 8-12 megabytes".
There isn't much memory which cannot be reclaimed unless you have a
huge machine or you're doing odd things.
