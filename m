Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUDQXwU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 19:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDQXwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 19:52:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:42144 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264076AbUDQXwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 19:52:18 -0400
Date: Sat, 17 Apr 2004 16:51:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marc Singer <elf@buici.com>
Cc: elf@buici.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-Id: <20040417165151.24b1fed5.akpm@osdl.org>
In-Reply-To: <20040417233037.GA15576@flea>
References: <20040417193855.GP743@holomorphy.com>
	<20040417212958.GA8722@flea>
	<20040417162125.3296430a.akpm@osdl.org>
	<20040417233037.GA15576@flea>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Singer <elf@buici.com> wrote:
>
> On Sat, Apr 17, 2004 at 04:21:25PM -0700, Andrew Morton wrote:
> > Marc Singer <elf@buici.com> wrote:
> > >
> > >  I'd say that there is no statistically significant difference between
> > >  these sets of times.  However, after I've run the test program, I run
> > >  the command "ls -l /proc"
> > > 
> > >  				 swappiness
> > >  			60 (default)		0
> > >  			------------		--------
> > >  elapsed time(s)		18			1
> > >  			30			1
> > >  			33			1
> > 
> > How on earth can it take half a minute to list /proc?
> 
> I've watched the vmscan code at work.  The memory pressure is so high
> that it reclaims mapped pages zealously.  The program's code pages are
> being evicted frequently.

Which tends to imply that the VM is not reclaiming any of that nfs-backed
pagecache.

> I've been wondering if the swappiness isn't a red herring.  Is it
> reasonable that the distress value (in refill_inactive_zones ()) be
> 50?

I'd assume that setting swappiness to zero simply means that you still have
all of your libc in pagecache when running ls.

What happens if you do the big file copy, then run `sync', then do the ls?

Have you experimented with the NFS mount options?  v2? UDP?
