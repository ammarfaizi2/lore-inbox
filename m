Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbSJPIR0>; Wed, 16 Oct 2002 04:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264960AbSJPIR0>; Wed, 16 Oct 2002 04:17:26 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:58530 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264959AbSJPIRY>; Wed, 16 Oct 2002 04:17:24 -0400
Date: Wed, 16 Oct 2002 04:22:09 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] mmap-speedup-2.5.42-C3
Message-ID: <20021016042209.D5659@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20021016040754.C5659@devserv.devel.redhat.com> <Pine.LNX.4.44.0210161023530.4906-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0210161023530.4906-100000@localhost.localdomain>; from mingo@elte.hu on Wed, Oct 16, 2002 at 10:27:07AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 10:27:07AM +0200, Ingo Molnar wrote:
> 
> On Wed, 16 Oct 2002, Jakub Jelinek wrote:
> 
> > Libraries mapped by dynamic linker are mapped without MAP_FIXED and
> > unless you use prelinking, with 0 virtual address, ie. they all end up
> > above 1GB. And 99% of libraries uses different protections, for the
> > read-only and read-write segment.
> 
> right - only the bss (brk-allocated) ones are below 1GB it appears. I did
> a quick check on a KDE app and 3 mappings were below 1GB, and 116(!)  
> mappings were above 1GB. And even if it wasnt for the different
> protections, they use different files to map to so they have to be in
> different vmas, no matter what.
> 
> i'm wondering about prelinking though - wont that reduce the number of
> mappings radically?

It won't, the number of mappings will be exactly the same. It still needs
to mmap all the libraries and honour the protections.
But you might have holes in between the mappings if prelinking, while
you usually don't have many if not prelinking.
That's because prelink assigns a separate VA slot for each library (well,
with --conserve-memory two libraries might get the same VA slot if they
never appear together in any program).

	Jakub
