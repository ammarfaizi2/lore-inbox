Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266921AbRHFGbl>; Mon, 6 Aug 2001 02:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbRHFGbb>; Mon, 6 Aug 2001 02:31:31 -0400
Received: from [63.209.4.196] ([63.209.4.196]:36870 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266921AbRHFGbP>; Mon, 6 Aug 2001 02:31:15 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: /proc/<n>/maps getting _VERY_ long
Date: 5 Aug 2001 23:30:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9kldik$nap$1@cesium.transmeta.com>
In-Reply-To: <20010805171202.A20716@weta.f00f.org> <9kkq9k$829$1@penguin.transmeta.com> <9kkr7r$mov$1@cesium.transmeta.com> <9kl6aa$87l$1@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <9kl6aa$87l$1@penguin.transmeta.com>
By author:    torvalds@transmeta.com (Linus Torvalds)
In newsgroup: linux.dev.kernel
>
> In article <9kkr7r$mov$1@cesium.transmeta.com>,
> H. Peter Anvin <hpa@zytor.com> wrote:
> >
> >Do you count applications which selectively mprotect()'s memory (to
> >trap SIGSEGV and maintain coherency with on-disk data structures) as
> >"broken applications"?
> >
> >Such applications *can* use large amounts of mprotect()'s.
> 
> Note that such applications tend to not get any advantage from merging -
> it does in fact only slow things down (because then the next mprotect
> just has to split the thing again).
> 

Unless you're doing a sequential access in the data space, for example
while accessing a large object.  If a single large object (usually
called a BLOB) covers N pages, and is accessed in its entirety, you
will typically have N pagefaults, each of which bring/unprotect the
page and then mprotect() it accordingly.  Those could all be merged
back into a single vma.

Now, I don't know how frequently this actually happens, but I do think
it is at least a possibility.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
