Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287816AbSAAMpm>; Tue, 1 Jan 2002 07:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286248AbSAAMpW>; Tue, 1 Jan 2002 07:45:22 -0500
Received: from ns.suse.de ([213.95.15.193]:61961 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287819AbSAAMpR>;
	Tue, 1 Jan 2002 07:45:17 -0500
Date: Tue, 1 Jan 2002 13:45:16 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Manfred Spraul <manfred@colorfullife.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Prefetching file_read_actor()
In-Reply-To: <E16LMAa-0008DU-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0201011342350.23436-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2002, Alan Cox wrote:

> > My initial guess is that some of the callers of copy_to_user are
> > doing something that is harmed the prefetching.
> > (Maybe they are doing additional prefetch() calls)
>
> Most callers are dealing with cached data, and unless you checked the
> length in advance to make a sensible decision it will just make things ugly.
> If you aren't copying 512 bytes+ its probably not worth it.

It didn't make an iota of difference what sizes I played with
(and I tried quite a few different ones)

I've come up with a preload_cache() function (for want of a better name)
and plonked that in prefetch.h for now. Having this #define to nothing
on other arch's would mean we could use this in places like we currently
do prefetch().  I'm still not happy with it, but its cleaner than my
original hack.

It's in -dj10 for the curious.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

