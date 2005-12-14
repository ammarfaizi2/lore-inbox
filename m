Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbVLNW2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVLNW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLNW2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:28:16 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:53611 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965006AbVLNW2O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:28:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OX1f36lIA+7YCrYDetxyQgVh1hKEaqOsO4YrEjguzavkFE9+ckI0WzcqS+9qycOIxzvnh7CiO1P4YILctq8NG168xYHhPzmtlpk31H3/V87YRNUvpZvyDl73M2bXWsoWQGq9z34oE0OKGx3Uv+nyoF2vmk96nliH8svppO/7/cU=
Message-ID: <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com>
Date: Wed, 14 Dec 2005 23:28:13 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051214191006.GC23349@stusta.de>
	 <20051214140531.7614152d.akpm@osdl.org>
	 <20051214221304.GE23349@stusta.de>
	 <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/14/05, Adrian Bunk <bunk@stusta.de> wrote:
> > On Wed, Dec 14, 2005 at 02:05:31PM -0800, Andrew Morton wrote:
> > > Adrian Bunk <bunk@stusta.de> wrote:
> > > >
> > > > Hi Linus,
> > > >
> > > > your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken
> > > > the EMBEDDED menu.
> > >
> > > It looks like that patch needs to be reverted or altered anyway.  sparc64
> > > machines are failing all over the place, possibly due to newly-exposed
> > > compiler bugs.
> > >
> > > Whether it's the compiler or it's genuine kernel bugs, the same problems
> > > are likely to bite other architectures.
> >
> > The help text already contains a bold warning.
> >
> > What about marking it as EXPERIMENTAL?
> > That is not that heavy as EMBEDDED but expresses this.
> >
>
> I, for one, definately think this is a good idea.
> Actually, it boggles my mind what this is doing outside of EMBEDDED -
> I just noticed it had moved when I build -git4 and oldconfig promted
> me about it.
>
I should probably back this up with *why* it boggles my mind.

-Os has been in EMBEDDED for ages, so it's not been tested by the
majority of users with the wide range of compilers etc that people
use. Putting it in as prominent a location as it occupies now means a
*lot* of people are going to enable it and potentially get breakage -
not good.

If it's generally an improvement to use -Os over -O2 then I'm all for
making it more prominent after a while, but it should spend some time
in -mm first, not mainline, or at least, as Adrian suggests, be marked
EXPERIMENTAL for a while.

Let's keep it EXPERIMENTAL or in -mm only for a while, get the bug
reports flowing from people who *know* they've enabled an experimental
option or who know they are running a development tree (-mm), not from
ordinary users who use the mainline kernel and think they are safe as
long as EXPERIMENTAL, BROKEN & EMBEDDED are not enabled.

Let's care about the average user and give it some proper testing in
the tree that exists for exactely that purpose first or at least mark
it explicitly as an experimental option so that only people who are
willing to risk breakage (and who are probably also more inclined to
send bugreports) will use it for now.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
