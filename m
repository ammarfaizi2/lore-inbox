Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbTEQSaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 14:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTEQSaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 14:30:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:1450
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261754AbTEQSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 14:30:14 -0400
Date: Sat, 17 May 2003 20:42:49 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, dmccr@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
       linux-mm@kvack.org, mika.penttila@kolumbus.fi
Subject: Re: Race between vmtruncate and mapped areas?
Message-ID: <20030517184249.GV1429@dualathlon.random>
References: <OF9AB7161F.A333DD8B-ON88256D29.0064AB5F-88256D29.0064AD44@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF9AB7161F.A333DD8B-ON88256D29.0064AB5F-88256D29.0064AD44@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 17, 2003 at 11:19:39AM -0700, Paul McKenney wrote:
> 
> 
> 
> 
> > On Thu, May 15, 2003 at 02:20:00AM -0700, Andrew Morton wrote:
> > > Andrea Arcangeli <andrea@suse.de> wrote:
> > > >
> > > > and it's still racy
> > >
> > > damn, and it just booted ;)
> > >
> > > I'm just a little bit concerned over the ever-expanding inode.  Do you
> > > think the dual sequence numbers can be replaced by a single generation
> > > counter?
> >
> > yes, I wrote it as a single counter first, but was unreadable and it had
> > more branches, so I added the other sequence number to make it cleaner.
> > I don't mind another 4 bytes, that cacheline should be hot anyways.
> >
> > > I do think that we should push the revalidate operation over into the
> vm_ops.
> > > That'll require an extra arg to ->nopage, but it has a spare one anyway
> (!).
> >
> > not sure why you need a callback, the lowlevel if needed can serialize
> > using the same locking in the address space that vmtruncate uses. I
> > would wait a real case need before adding a callback.
> 
> FYI, we verified that the revalidate callback could also do the same
> job that the proposed nopagedone callback does -- permitting filesystems
> that provide their on vm_operations_struct to avoid the race between
> page faults and invalidating a page from a mapped file.

don't you need two callbacks to avoid the race? (really I mean, to call
two times a callback, the callback can be also the same)

Andrea
