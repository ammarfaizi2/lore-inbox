Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317159AbSEXOxx>; Fri, 24 May 2002 10:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317158AbSEXOxw>; Fri, 24 May 2002 10:53:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34558 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S317149AbSEXOxu>; Fri, 24 May 2002 10:53:50 -0400
Date: Fri, 24 May 2002 10:53:48 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: negative dentries wasting ram
Message-ID: <20020524105348.T13411@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20020524071657.GI21164@dualathlon.random> <Pine.LNX.4.44.0205240737400.26171-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 07:43:32AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 24 May 2002, Andrea Arcangeli wrote:
> >
> > Negative dentries should be only temporary entities, for example between
> > the allocation of the dentry and the create of the inode, they shouldn't
> > be left around waiting the vm to collect them.
> 
> Wrong. Negative dentries are very useful for caching negative lookups:
> look at the average startup sequence of any program linked with glibc, and
> depending on your setup you will notice how it tries to open a _lot_ of a
> files that do not exist (the "depending on your setup" comes from the fact
> that it depends on things like how quickly it finds your "locale" setup
> from its locale path - you may have one of the setups that puts it in the
> first location glibc searches etc).

In glibc 2.3 this will be open("/usr/lib/locale/locale-archive", ), so
negative dentries won't be useful for glibc locale handling (that
doesn't mean negative dentries won't be useful for other things, including
exec?p or searching libraries if $LD_LIBRARY_PATH is used).

	Jakub
