Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314514AbSEXREf>; Fri, 24 May 2002 13:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314583AbSEXREe>; Fri, 24 May 2002 13:04:34 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30126 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S314514AbSEXREe>;
	Fri, 24 May 2002 13:04:34 -0400
Date: Fri, 24 May 2002 13:04:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <20020524163942.GB15703@dualathlon.random>
Message-ID: <Pine.GSO.4.21.0205241300480.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Andrea Arcangeli wrote:

> > Note that this will have to touch the FS anyway, since the O_CREAT thing
> > forces a call down to the FS to actually create the file.
> 
> yep. the only case where it could provide some in-core "caching"
> positive effect is:
> 
> 	unlink
> 	open(w/o creat)
> 
> but I don't see it as a common case.

	Guys, how about tracing the damn thing and checking what actually
happens?  Or, at least, checking the prototypes and noticing that ->create()
takes (hashed) dentry as an argument, so if unlinked on had been freed we _must_
call ->lookup().


