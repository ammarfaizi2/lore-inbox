Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286254AbRLTOGB>; Thu, 20 Dec 2001 09:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286259AbRLTOFv>; Thu, 20 Dec 2001 09:05:51 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:55813 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S286258AbRLTOFi>; Thu, 20 Dec 2001 09:05:38 -0500
Date: Thu, 20 Dec 2001 06:05:44 -0800 (PST)
From: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
To: christian e <cej@ti.com>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: minimizing swap usage
In-Reply-To: <3C21E7F1.3040406@ti.com>
Message-ID: <Pine.LNX.4.33.0112200559350.8883-100000@shell1.aracnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2001, christian e wrote:

> Hi,all
>
> Can someone give me a pointer to how I can avoid somethign like this:
>
> foo@bar]$ free -m
> 	    total       used       free     shared    buffers     cached
> Mem:           249        245          4          0          6       136
> -/+ buffers/cache:        102        147
> Swap:          243         89        153
>
> What's with all the caching when my apps crawl because it's swapping so
> much ? I've tried to adjust /proc/vm/kswapd parameters but that doesn't
> seem to help..I'd like to postpone the swapping until its almost out of
> physical memory..

This may seem counterintuitive, but postponing swapping / cache flushing
to disk till the last possible moment is counterproductive. It's a
little like procrastination in the time management world -- when the
time finally comes when you *have* to flush stuff out to disk, your poor
daemons / kernel threads go catatonic trying to keep up, and you end up
both CPU-bound and I/O bound. It is far better to have enough free
memory available to satisfy the demand for pages, even if that means
*raising* the watermarks, *more* swapping and smaller page caches.
--
M. Edward Borasky

znmeb@borasky-research.net
http://www.borasky-research.net

When puns are outlawed, only inlaws will have gnus.

