Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRKEJxP>; Mon, 5 Nov 2001 04:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280429AbRKEJxF>; Mon, 5 Nov 2001 04:53:05 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:31409 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280426AbRKEJwt>; Mon, 5 Nov 2001 04:52:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Ville Herva <vherva@niksula.hut.fi>
Subject: Re: Ext2 directory index, updated
Date: Mon, 5 Nov 2001 10:53:55 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011104022659Z16995-4784+750@humbolt.nl.linux.org> <20011105014225Z17055-18972+38@humbolt.nl.linux.org> <20011105094816.E26218@niksula.cs.hut.fi>
In-Reply-To: <20011105094816.E26218@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105095243Z16495-18972+84@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 08:48 am, Ville Herva wrote:
> On Mon, Nov 05, 2001 at 02:43:28AM +0100, you [Daniel Phillips] claimed:
> >
> > Which kernel are you using?  From 2.4.10 on ext2 has an accelerator in 
> > ext2_find_entry - it caches the last lookup position.  I'm wondering how that 
> > affects this case.
> 
> Is that the same optimization Ted T'so implemented for ext3 around 0.9.10? I
> thought it hadn't been ported the ext2...

Yes, Ted did it, earlier this year.

> BTW, I assume the ext2 dir index patch is roughly equivalent to FreeBSD
> dirhash and the the other patch resembles theFreeBSD dirperf patch?
> Have you looked at them? [http://www.osnews.com/story.php?news_id=153]

I *think* the performance of my dir index patch is roughly in line with BSD's
dirhash patch, for common cases.  The big difference is that the BSD dirhash
is not persistent - the cache goes away when the directory is closed.  So
there are loads that can break it badly, such as accessing files in large
directories randomly over a large disk.  This forces the entire directory to
be read into cache, in the worst case, on every access.  Another bad case is
first-time access.  A million file directory is around 30 meg - it takes a
long time to read and hash all those blocks, just to open the first file.

They will have to implement a persistent index at some point.  For common
cases though, the BSD approach is good.  

I'll go into the gory details next week at ALS if people are insterested.

--
Daniel
