Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUD1ULw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUD1ULw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUD1UKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:10:12 -0400
Received: from fw.osdl.org ([65.172.181.6]:52202 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261867AbUD1Ts2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:48:28 -0400
Date: Wed, 28 Apr 2004 12:48:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: busterbcook@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
Message-Id: <20040428124809.418e005d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
	<20040427230203.1e4693ac.akpm@osdl.org>
	<Pine.LNX.4.58.0404280826070.31093@ozma.hauschen>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook <busterbcook@yahoo.com> wrote:
>
> On Tue, 27 Apr 2004, Andrew Morton wrote:
> 
> > Brent Cook <busterbcook@yahoo.com> wrote:
> > >
> > >   Running any kernel from the 2.6.6-rc* series (and a few previous
> > >  -mm*'s),
> >
> > It's a shame this wasn't reported earlier.
> 
> Since it was a pretty big deal on my system, I just assumed it was for
> other people's too, and that someone else would have reported it by
> now. I only got concerned when it persisted between rc's.

I think three people have reported it now.

> > > the pdflush process starts using near 100% CPU indefinitely after
> > >  a few minutes of initial NFS traffic, as far as I can tell.
> >
> > Please confirm that the problem is observed on the NFS client and not the
> > NFS server?  I'll assume the client.
> 
> Yes, both affected machines had the issue when connecting as a client to a
> 2.4.25-based NFS server.
> 
> > What other filesystems are in use on the client?
> 
> One uses Reiser on /, the other uses ext3 on /. Here is the mount table
> for one machine:

Both machines are exhibiting the problem?

> About 10 minutes into the process, pdflush starts taking over:
> 
>   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
>     7 root      25   0     0    0     0 RW   34.4  0.0   3:05   0 pdflush
> 17856 busterb   25   0 69400  65M  5140 R    34.4 26.1   0:31   0 cc1plus
> 19466 busterb   25   0 43732  39M  5140 R    26.3 15.5   0:03   0 cc1plus
> ...
> The network light will flash continually on each machine once pdflush
> gets into this state, which makes me think NFS. Each machine has
> 512-256 MB of ram and a single CPU.

ok..  I spent a couple of hours yesterday trying to get this to happen.  No
joy.  Can't make it happen with your .config either.  I'll set up a 2.4.25
server later on.

What version of gcc are you using?

Could you please capture the contents of /proc/meminfo and /proc/vmstats
when it's happening?

Thanks.
