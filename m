Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271857AbRICXQj>; Mon, 3 Sep 2001 19:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271858AbRICXQa>; Mon, 3 Sep 2001 19:16:30 -0400
Received: from gw.xkey.com ([206.86.100.52]:4613 "EHLO happy.xkey.com")
	by vger.kernel.org with ESMTP id <S271857AbRICXQN>;
	Mon, 3 Sep 2001 19:16:13 -0400
Date: Mon, 3 Sep 2001 16:16:31 -0700
Message-Id: <200109032316.QAA12012@happy.xkey.com>
From: David desJardins <david@desjardins.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> For example, let's look at this perfectly natural code:
> 
> static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned
> *hashp)
> {
> if (len <= sizeof(short) || len > sizeof(*sunaddr))
> return -EINVAL;
> ...

> code that is totally correct, and that it would make _no_ sense in
> writing any other way.

The code is correct, but if one is adding explicit types, for clarity
and to avoid introducing bugs, then I think that code like this is
exactly where they most belong:

  if ((size_t) len <= sizeof(short) || (size_t) len > sizeof(*sunaddr))

If that prevents one person from later writing buggy code like:

  if ((size_t) len <= sizeof(short))

then it's a Good Thing.

  -- David desJardins
