Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSJCUhO>; Thu, 3 Oct 2002 16:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261303AbSJCUhO>; Thu, 3 Oct 2002 16:37:14 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:65496 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S261284AbSJCUhN>; Thu, 3 Oct 2002 16:37:13 -0400
Date: Thu, 3 Oct 2002 15:41:41 -0500
To: xavier.bestel@free.fr, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003204141.GQ1536@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033633277.27227.2.camel@nomade>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Xavier Bestel]
> > make -f subdir/Makefile
> 
> Could you do instead:
> 
>         include subdir/Makefile
> ?

Unfortunately, no.  Not without changing the entire architecture of
the kernel build system.  The current system depends on each Makefile
maintaining an independent state (think "stack frame") by means of a
lot of local variables.  These variables have standard names and
functions, so you can't flatten the recursion without clobbering them.

> This would avoid recursive make, which isn't really a good idea
> (even if it's used widely).

Yes, we know recursive make is considered harmful - that's why Keith
Owens designed a nonrecursive solution last year.  (And quite a nice
piece of work it was, too.)  But to achieve his solution he basically
redesigned the whole system from scratch.  Pretty much the *only*
thing kbuild2.5 has in common with current kbuild is a minimal set of
functional requirements.

Peter
