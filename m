Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288258AbSACV3P>; Thu, 3 Jan 2002 16:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSACV3H>; Thu, 3 Jan 2002 16:29:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17926 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288258AbSACV2r>; Thu, 3 Jan 2002 16:28:47 -0500
Message-ID: <3C34CC02.31848E01@zip.com.au>
Date: Thu, 03 Jan 2002 13:24:18 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-1?Q?Jos=E9?= Luis Domingo =?iso-8859-1?Q?L=F3pez?= 
	<jdomingo@internautas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug in shrink_caches()
In-Reply-To: <200201030538.g035ceM31957@mysql.sashanet.com>,
		<200201030538.g035ceM31957@mysql.sashanet.com> <20020103184609.GA3890@localhost>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Luis Domingo López wrote:
> 
> On Wednesday, 02 January 2002, at 22:38:40 -0700,
> Sasha Pachev wrote:
> 
> > I am quite sure there is still a bug in shrink_caches(), at least there was
> > one in 2.4.17-rc2. I have not tried later releases, but there is nothing in
> > the changelog about the fixes anywhere near that area of the code, so I have
> > to assume the problem is still there.
> > [...]
> > When we get to the point where free memory starts running low, even though we
> > may have something like 100 MB of cache, shrink_caches() fails to free up
> > enough memory, which triggers the evil oom killer. Obviously, in the above
> > situation the correct behaviour is to go on cache diet before considering the
> > murders.
> >
> I can confirm this behaviour in my own machine. 128 MB of RAM, swap
> space turned off, machine running KDE 2.2.x, Konqueror, rxvt's, gkrellm,
> xmms and some daemons, and mighty Mozilla :). At this point there are
> still a couple of MB free, a couple buffered and aproximately 40 MB
> in caches.

The current VM gets really unhappy when you push it hard if there's no
swap available.

> ...
> 
> Maybe unrelated, maybe not, is the fact that in 2.4.17 I still see short
> "freezes" in interactive response after doing intensive disk access
> (untarring something, finishing some dd'ing, rebuilding Debian package
> database, etc.). Both on medium-end hardware (128 MB RAM, PIII 600) and
> low-end hardware (64 MB RAM, P166). Vanilla 2.4.17 on both, with ext2 as
> the only filesystem used in mounted partitions.

Please test
http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre1/read-latency2.patch

-
