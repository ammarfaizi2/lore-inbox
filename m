Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVDTVfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDTVfL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 17:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDTVfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 17:35:10 -0400
Received: from THUNK.ORG ([69.25.196.29]:8581 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261819AbVDTVef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 17:34:35 -0400
Date: Wed, 20 Apr 2005 03:06:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fortuna
Message-ID: <20050420070630.GB7997@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Wagner <daw-usenet@taverner.cs.berkeley.edu>,
	linux-kernel@vger.kernel.org
References: <20050414141538.3651.qmail@science.horizon.com> <20050418191316.GL21897@waste.org> <d419gl$qvq$2@abraham.cs.berkeley.edu> <20050419040116.GA6517@thunk.org> <d421jj$vi$1@abraham.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d421jj$vi$1@abraham.cs.berkeley.edu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 04:31:47AM +0000, David Wagner wrote:
> Theodore Ts'o  wrote:
> >For one, /dev/urandom and /dev/random don't use the same pool
> >(anymore).  They used to, a long time ago, but certainly as of the
> >writing of the paper this was no longer true.  This invalidates the
> >entire last paragraph of Section 5.3.
> 
> Ok, you're right, this is a serious flaw, and one that I overlooked.
> Thanks for elaborating.  (By the way, has anyone contacted to let them
> know about these two errors?  Should I?)

I don't know of anyone who has contacted the authors yet.  I haven't
had the time, since I'm currently travelling at the moment.

> I see three remaining criticisms from their Section 5.3:
> 1) Due to the way the documentation describes /dev/random, many
>    programmers will choose /dev/random by default.  This default
>    seems inappropriate and unfortunate.
> 2) There is a widespread perception that /dev/urandom's security is
>    unproven and /dev/random's is proven.  This perception is wrong.
>    On a related topic, it is "not at all clear" that /dev/random provides
>    information-theoretic security.
> 3) Other designs place less stress on the entropy estimator, and
>    thus are more tolerant to failures of entropy estimation.  A failure
>    in the entropy estimator seems more likely than a failure in the
>    cryptographic algorithms.
> These three criticisms look right to me.

/dev/urandom is a cryptographic RNG, which is seeded from RNG.
/dev/random uses a very similar cryptographic RNG, but it uses large
pool to collect entropy, and uses an entropy estimator to limit the
amount of data that can be extracted from the rng.  

If the entropy estimator fails, /dev/random degrades to a
cryptographic RNG.  So it is not a disaster, whereas the approach
described in this paper (which uses a non-cryptographic extractor)
would seem to me to be *more* prone to catastrophically failure if the
entropy estimator fails than /dev/random.

As to whether or not applications should be using /dev/random or
/dev/urandom, /dev/random is no worse than /dev/urandom, as long as
the application doesn't mind blocking when the entropy levels are too
low.  In practice, most of the time this situation doesn't arise since
the appropriate way of using /dev/random is only to extract a small
amount of entropy when needed to generate long-term keys, or when
seeding a userspace cryptographic RNG for session keys.

						- Ted
