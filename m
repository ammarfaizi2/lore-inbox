Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263748AbRGIWKI>; Mon, 9 Jul 2001 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRGIWJt>; Mon, 9 Jul 2001 18:09:49 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:6636 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S263748AbRGIWJo>;
	Mon, 9 Jul 2001 18:09:44 -0400
Date: Mon, 9 Jul 2001 18:09:39 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: jrs@world.std.com, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <15178.3722.86802.671534@charged.uio.no>
Message-ID: <Pine.LNX.3.96L.1010709175623.16113S-100000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2001, Trond Myklebust wrote:
> If the client discovers that the cache is invalid, it clears it, and
> refills the cache. We then start off at the next cookie after the last
> read cookie. Test it on an ordinary filesystem and you'll see the
> exact same behaviour. The act of creating or deleting files is *not*
> supposed invalidate the readdir offset.

I would say that assuming that the readdir cookie is an offset is a break
in the spec.  In fact, there are a few things in the spec which I'd like
to point out.  First of all, "All of the procedures in the NFS protocol
are assumed to be synchronous."  Which means that you should not even be
making asynchronous remove calls.  Second, the server is meant to be
"as stateless as possible."  I would argue that this means that you should
not make assumptions about the cookie's state if another operation is
interposed between two readdir() operations.  As an aside, by adding a
translation layer to the cookies (as suggested by an earlier post) would
break this, as the server would have to store that state in the event of a
server crash, thus breaking the spec.

> You are confusing the act of detecting whether or not the cache is
> invalid with that of recovering after a cache invalidation. In the
> former case we do have room for improvement: see for instance

It may be that my solution is imperfect for the problem I would like
fixed, however, I do not believe that your current recovery mechanism is
correct.

Craig

