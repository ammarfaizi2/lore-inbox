Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262669AbREOIGo>; Tue, 15 May 2001 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262670AbREOIGe>; Tue, 15 May 2001 04:06:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:55812 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262669AbREOIGZ>; Tue, 15 May 2001 04:06:25 -0400
Date: Tue, 15 May 2001 01:06:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wedgwood <cw@f00f.org>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Getting FS access events
In-Reply-To: <20010515195607.A13722@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.31.0105150058370.22938-100000@p4.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, Chris Wedgwood wrote:
>
> On Tue, May 15, 2001 at 12:13:13AM -0700, Linus Torvalds wrote:
>
>     We should not create crap code just because we _can_.
>
> How about removing code?

Absolutely. It's not all that often that we can do it, but when we can,
it's the best thing in the world.

> In 2.5.x is we move fs metadata into the pagecache, do we even need a
> buffer cache anymore? Can't we just ditch it completely and make all
> device access raw?

Yes and no.

Yes, it would be nice.

But no, I doubt we'll move _all_ metadata into the page-cache. I doubt,
for example, that we'll find people re-doing all the other filesystems. So
even if ext2 was page-cache only, what about all the 35 other filesystems
out there in the standard sources, never mind others that haven't been
integrated (XFS, ext3 etc..).

Yeah, I know. Some of them already do not use the buffer cache at all (the
network filesystems come to mind ;), but even so..

Looks like there are 19 filesystems that use the buffer cache right now:

	grep -l bread fs/*/*.c | cut -d/ -f2 | sort -u | wc

So quite a bit of work involved.

But on the whole I'm definitely hoping that yes, we'll relegate the
"buffer_head" to be mainly just for IO, and not be a first-class caching
entity at all. It's just that I think it will take a _loooong_ time until
we actually reach that noble goal completely.

		Linus

