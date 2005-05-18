Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbVERXLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbVERXLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbVERXLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 19:11:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:38832 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262392AbVERXLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 19:11:01 -0400
Date: Wed, 18 May 2005 16:13:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Timur Tabi <timur.tabi@ammasso.com>, linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net question: mapping cset to kernel version?
In-Reply-To: <20050518165148.GC17307@kroah.com>
Message-ID: <Pine.LNX.4.58.0505181544360.18337@ppc970.osdl.org>
References: <428B4D14.2030104@ammasso.com> <20050518160930.GA16756@kroah.com>
 <428B6BF8.2010303@ammasso.com> <20050518165148.GC17307@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 May 2005, Greg KH wrote:
> > What does he do now?
> 
> Uses git, which will have the same issues as you are facing :)

Both git and BK can do this.

Once you know which commit you want to check, the way to find out what the
first release was that contained that commit is perfectly straightforward:  
you take each release, and see if the commit is reachable from that
release. You don't need to actually look at the patches, it's enough to
look at the revision tree.

In Git, you can basically do something like

	for i in $releases
	do
		j=$(git-merge-base $commit $i)
		if [ "$j" == "$commit" ]; then
			echo $commit was in $i
		fi
	done

where "releases" is the list of SHA1 names for the commits of the releases
you're interested in, and "commit" is the SHA1 name of the commit you're 
looking at.

In BK, you can do similar things with "bk cset" (and there's some other
helper things for it too), but I don't have the docs available any more,
so..

In all fairness, usually it _is_ easier to just do a grep for it if you 
already have the release patches available. It's what I usually did 
myself.

		Linus
