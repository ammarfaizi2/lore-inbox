Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318830AbSHESuQ>; Mon, 5 Aug 2002 14:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318833AbSHESuQ>; Mon, 5 Aug 2002 14:50:16 -0400
Received: from 216-42-72-141.ppp.netsville.net ([216.42.72.141]:19881 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S318830AbSHESuP>;
	Mon, 5 Aug 2002 14:50:15 -0400
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
From: Chris Mason <mason@suse.com>
To: Oleg Drokin <green@namesys.com>
Cc: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020805223016.A14603@namesys.com>
References: <20020805150436.A1176@namesys.com>
	<Pine.LNX.4.44.0208052014220.31879-100000@pc40.e18.physik.tu-muenchen.de> 
	<20020805223016.A14603@namesys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 14:54:58 -0400
Message-Id: <1028573698.1759.284.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 14:30, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Aug 05, 2002 at 08:19:05PM +0200, Roland Kuhn wrote:
> > > > > ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> > >From there I get 'permission denied', but I got it somewhere else (google 
> > is great).
> > However, it does not apply cleanly to 2.4.19. It is already partly in, as 
> > it seems, but there are some rejects that are not obvious to fix for me. 
> > If this patch still makes sense, it would be great if someone with more 
> > knowledge/experience than me could have a look...

The stack traces you sent earlier show a few procs stuck waiting for the
transaction to begin, but they don't show which process is currently in
a transaction (this is who they are waiting on).

Oleg is right, they are probably waiting on kupdated, since the FS might
get marked dirty faster than it can clear it.

Another possibility is ctime/mtime updates during write.

So, on ftp.suse.com/pub/people/mason/patches/data-logging

Apply:
01-relocation-4.diff
02-commit_super-8.diff # this is the one you want, but it depends on 01.

And try again.  If that doesn't do it, try 04-write_times.diff (which
doesn't depend on anything).

Or, send a few fully decoded sysrq-t outputs during the run, so we can
see what all the procs are up to.

-chris


