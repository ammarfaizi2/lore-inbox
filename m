Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130380AbRCBJEm>; Fri, 2 Mar 2001 04:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130381AbRCBJEW>; Fri, 2 Mar 2001 04:04:22 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16403 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S130380AbRCBJEQ>; Fri, 2 Mar 2001 04:04:16 -0500
Date: Fri, 2 Mar 2001 10:04:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
Message-ID: <20010302100410.I15061@atrey.karlin.mff.cuni.cz>
In-Reply-To: <3A9EB984.C1F7E499@transmeta.com> <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0103011608360.11577-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Mar 01, 2001 at 04:13:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >         * userland issues (what, you thought that limits on the
> > > command size will go away?)
> > 
> > Last I checked, the command line size limit wasn't a userland issue, but
> > rather a limit of the kernel exec().  This might have changed.
> 
> I _really_ don't want to trust the ability of shell to deal with long
> command lines. I also don't like the failure modes with history expansion
> causing OOM, etc.
> 
> AFAICS right now we hit the kernel limit first, but I really doubt that
> raising said limit is a good idea.

I am running with 2MB limit right now. I doubt 2MB will lead to OOM.

> xargs is there for purpose...

xargs is very ugly. I want to rm 12*. Just plain "rm 12*". *Not* "find
. -name "12*" | xargs rm, which has terrible issues with files names

"xyzzy"
"bla"
"xyzzy bla"
"12 xyzzy bla"

!

I do not want to deal with xargs. Xargs was made to workaround
limitation at command line size (and is broken in itself). Now we have
hardware that can handle bigger commandlines just fine, xargs should
be killed.
								Pavel
-- 
The best software in life is free (not shareware)!		Pavel
GCM d? s-: !g p?:+ au- a--@ w+ v- C++@ UL+++ L++ N++ E++ W--- M- Y- R+
