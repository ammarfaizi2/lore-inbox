Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSHBQ3m>; Fri, 2 Aug 2002 12:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315372AbSHBQ3m>; Fri, 2 Aug 2002 12:29:42 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:36860 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315337AbSHBQ3m>; Fri, 2 Aug 2002 12:29:42 -0400
Subject: Re: adjust prefetch in free_one_pgd()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com
In-Reply-To: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208020844000.18265-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Aug 2002 18:49:27 +0100
Message-Id: <1028310567.18635.87.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-02 at 16:46, Linus Torvalds wrote:
> Personally, I would just say that we should disable prefetch on such
> clearly broken hardware, but since it's Alans favourite machine (some
> early AMD Athlon if I remember correctly), I think Alan will disagree ;)

Its an expensive change. I'm also not convinced the AMD is the only
situation this comes up. And however you look at it, fetching memory you
don't need is a bug. You are not just wasting memory bandwidth, which
you may have on ia64 but not so much on real computers, you are pulling
stuff shared on other processors which can be quite expensive.

The guarantee I specced in the original API was specifically that
prefetching a NULL pointer was safe.

> That's true of just about any other architecture too. I think the AMD case
> is an erratum, so even on AMD it is _supposed_ to work.

Nothing guarantees a page adjacent to the user memory is not cachable. I
can't think of anything cachable with nasty side effects we might
encounter right now but one day someone will do it just to be annoying.

