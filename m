Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264953AbSJPICi>; Wed, 16 Oct 2002 04:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264955AbSJPICd>; Wed, 16 Oct 2002 04:02:33 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:21151 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264953AbSJPICb>; Wed, 16 Oct 2002 04:02:31 -0400
Date: Wed, 16 Oct 2002 04:07:54 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap-speedup-2.5.42-C3
Message-ID: <20021016040754.C5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <m3bs5vl79h.fsf@averell.firstfloor.org> <Pine.LNX.4.44.0210160957150.4018-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210160957150.4018-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Oct 16, 2002 at 10:03:52AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 10:03:52AM +0200, Ingo Molnar wrote:
> 
> On 15 Oct 2002, Andi Kleen wrote:
> 
> > When you oprofile KDE startup you notice that a lot of time is spent in
> > get_unmapped_area too. The reason is that every KDE process links with
> > 10-20 libraries and ends up with a 40-50 entry /proc/<pid>/maps.
> 
> actually, library mappings alone should not cause a slowdown, since we
> start the search at MAP_UNMAPPED_BASE and most library mappings are below
> 1GB. But if those libraries use mmap()-ed anonymous RAM that has different
> protections then the anonymous areas do not get merged and the scanning
> overhead goes up.

Libraries mapped by dynamic linker are mapped without MAP_FIXED and unless
you use prelinking, with 0 virtual address, ie. they all end up above 1GB.
And 99% of libraries uses different protections, for the read-only and
read-write segment.

	Jakub
