Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSDTVi4>; Sat, 20 Apr 2002 17:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312334AbSDTViz>; Sat, 20 Apr 2002 17:38:55 -0400
Received: from [195.223.140.120] ([195.223.140.120]:11896 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312332AbSDTViy>; Sat, 20 Apr 2002 17:38:54 -0400
Date: Sat, 20 Apr 2002 23:38:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre7aa1
Message-ID: <20020420233841.O1291@dualathlon.random>
In-Reply-To: <20020420194213.K1291@dualathlon.random> <3CC1C38F.37D1F8C2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 12:37:51PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > Only in 2.4.19pre6aa1: 00_prepare-write-fixes-2
> > Only in 2.4.19pre7aa1: 00_prepare-write-fixes-3
> > 
> >         Add a missing flush_dcache_page() to the prepare write corruption
> >         fixes. Noticed by Andrew Morton.
> > 
> 
> Why do we perform those "flushes"[1] at all?  The memsets should
> never occur when the page is mapped into any process tables.

The dcache flushes are necessary before the page is mapped, to keep
track which pages we need to flush from the kernel address space
during the page fault right before we map them into userspace (i.e.
during flush_icache_page). We're not really flushing the cache there, we
only keeps track of it through the arch bitflag.

Andrea
