Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRDLPNR>; Thu, 12 Apr 2001 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135201AbRDLPNH>; Thu, 12 Apr 2001 11:13:07 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39588 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135200AbRDLPM5>;
	Thu, 12 Apr 2001 11:12:57 -0400
Date: Thu, 12 Apr 2001 11:12:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rik van Riel <riel@conectiva.com.br>
cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
In-Reply-To: <Pine.LNX.4.21.0104121154420.18260-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.GSO.4.21.0104121107570.19944-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Apr 2001, Rik van Riel wrote:

> On Thu, 12 Apr 2001, Ed Tomlinson wrote:
> 
> > I have been playing around with patches that fix this problem.  What
> > seems to happen is that the VM code is pretty efficent at avoiding the
> > calls to shrink the caches.  When they do get called its a case of to
> > little to late.  This is espically bad in lightly loaded systems.  
> > The following patch helps here.  I also have a more complex version
> > that uses autotuning, but would rather push the simple code, _if_ it
> > does the job.
> 
> I like this patch. The thing I like most is that it tries to free
> from this cache if there is little activity, not when we are low
> on memory and it is physically impossible to get rid of the cache.
> 
> Remember that evicting early from the inode and dentry cache doesn't
> matter since we can easily rebuild this data from the buffer and page
> cache.

Ahem. Yes, for local block-based filesystems, provided that directories are
small and that indirect blocks will not flush the inode table buffers out of
buffer cache, etc., etc.

Keeping inodes clean when pressure is low is a nice idea. That way you can
easily evict when needed. Evicting early... Not really.

