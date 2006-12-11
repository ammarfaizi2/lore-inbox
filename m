Return-Path: <linux-kernel-owner+w=401wt.eu-S1760333AbWLKEDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760333AbWLKEDp (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760625AbWLKEDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:03:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42097 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760324AbWLKEDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:03:43 -0500
Date: Mon, 11 Dec 2006 05:03:34 +0100
From: Nick Piggin <npiggin@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][rfc] rwsem: generic rwsem
Message-ID: <20061211040334.GA11246@wotan.suse.de>
References: <20061208022259.GB11551@wotan.suse.de> <20061204144634.GA14383@wotan.suse.de> <20061204100607.GA20529@wotan.suse.de> <29183.1165236916@redhat.com> <25001.1165350982@redhat.com> <4548.1165586322@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4548.1165586322@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 01:58:42PM +0000, David Howells wrote:
> Nick Piggin <npiggin@suse.de> wrote:
> 
> > > Look at how the counter works in the XADD-based version.  That's the way
> > > it is *because* I'm using XADD.  That's quite limiting.
> > 
> > Not really. ll/sc architectures "emulate" xadd the same as they would
> > emulate a spinlock. There is nothing suboptimal about it.
> 
> Yes, really.  You've missed the point entirely.  Look at *how* the counter
> *works*.

OK, I've looked but I can't see how you would make it more optimal on
an ll/sc architecture. The atomic_add_return variant has no more atomic
or barrier operations than the spinlock one, and it has less loads and
branches.
