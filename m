Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265753AbSJTDnW>; Sat, 19 Oct 2002 23:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265755AbSJTDnW>; Sat, 19 Oct 2002 23:43:22 -0400
Received: from ns.suse.de ([213.95.15.193]:20490 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265753AbSJTDnV>;
	Sat, 19 Oct 2002 23:43:21 -0400
Date: Sun, 20 Oct 2002 05:49:25 +0200
From: Andi Kleen <ak@suse.de>
To: Jim Houston <jim.houston@attbi.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: POSIX clocks & timers - more choices
Message-ID: <20021020054924.A30135@wotan.suse.de>
References: <200210190252.g9J2quf16153@linux.local.suse.lists.linux.kernel> <p73r8ennltj.fsf@oldwotan.suse.de> <3DB0FE5B.5BAA2BDB@attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB0FE5B.5BAA2BDB@attbi.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 02:40:27AM -0400, Jim Houston wrote:
> > > +{
> > > +     if (p->ary[bit] && p->ary[bit]->bitmap == (typeof(p->bitmap))-1)
> > 
> > Without bitfield this would look much less weird.
> > 
> > I would recommend using the bitops.h primitives for such stuff anyways.
> 
> I will.  This does look wierd, is this my code?

The typeof() cast looks weird. I had to think twice to make sense of it.

> Good point.  It looks like  find_task_by_pid() needs to be protected
> by a read_lock(&tasklist_lock).  The timers are linked into
> a list so they will be removed when the process exits.  
> Any sugestions on a code example that does this right are
> welcome:-) 

/proc does it by increasing the count in the struct page of the stack
page of the process. exit() knows about that. Example is somewhere in fs/proc/
The increase has to be done inside the lock. As always one has to be careful
with lock ordering.

The standard way is to just hold the read lock of the tasklist.


-Andi
