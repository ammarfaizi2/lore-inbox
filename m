Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281365AbRKEVpR>; Mon, 5 Nov 2001 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281362AbRKEVo5>; Mon, 5 Nov 2001 16:44:57 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27662 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281361AbRKEVox>; Mon, 5 Nov 2001 16:44:53 -0500
Message-ID: <3BE70717.54F3084A@zip.com.au>
Date: Mon, 05 Nov 2001 13:39:35 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: m@mo.optusnet.com.au
CC: Andreas Dilger <adilger@turbolabs.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <200111050554.fA55swt273156@saturn.cs.uml.edu> <3BE647F4.AD576FF2@zip.com.au> <20011105131636.C3957@lynx.no>,
		Andreas Dilger's message of "Mon, 5 Nov 2001 13:16:37 -0700" <m1wv15ufn1.fsf@mo.optusnet.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m@mo.optusnet.com.au wrote:
> 
> Andreas Dilger <adilger@turbolabs.com> writes:
> > On Nov 05, 2001  00:04 -0800, Andrew Morton wrote:
> [..]
> > > With the ialloc.c change, plus the other changes I mentioned
> > > the time to create all these directories and files and then run
> > > /bin/sync fell from 1:53 to 0:28.  Fourfold.
> >
> > In the end, though, while the old heuristic has a good theory, it _may_
> > be that in practise, you are _always_ seeking to get data from different
> > groups, rather than _theoretically_ seeking because of fragmented files.
> > I don't know what the answer is - probably depends on finding "valid"
> > benchmarks (cough).
> 
> Another heuristic to try make be to only use a different blockgroup
> for when the mkdir()s are seperate in time. i.e. rather than
> doing
>         if ( 0 && ..
> use something like
>         if ((last_time + 100) < jiffes && ...
>                 last_time = jiffies;
> which would in theory use the old behaviour for sparodic mkdirs
> and the new behaviour for things like 'untar' et al.
> 

I agree - that's a pretty sane heuristic.

It would allow us to preserve the existing semantics for the
slowly-accreting case.  If they're still valid.
