Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268864AbTBZRV2>; Wed, 26 Feb 2003 12:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbTBZRV1>; Wed, 26 Feb 2003 12:21:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60938 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268864AbTBZRV0>; Wed, 26 Feb 2003 12:21:26 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Invalid compilation without -fno-strict-aliasing
Date: Wed, 26 Feb 2003 17:26:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <b3itcd$2bi$1@penguin.transmeta.com>
References: <20030225234646.GB30611@bougret.hpl.hp.com>
X-Trace: palladium.transmeta.com 1046280675 3769 127.0.0.1 (26 Feb 2003 17:31:15 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 26 Feb 2003 17:31:15 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030225234646.GB30611@bougret.hpl.hp.com>,
Jean Tourrilhes  <jt@bougret.hpl.hp.com> wrote:
>
>	It looks like a compiler bug to me...

Why do you think the kernel uses "-fno-strict-aliasing"?

The gcc people are more interested in trying to find out what can be
allowed by the c99 specs than about making things actually _work_. The
aliasing code in particular is not even worth enabling, it's just not
possible to sanely tell gcc when some things can alias.

>	Some users have complained that when the following code is
>compiled without the -fno-strict-aliasing, the order of the write and
>memcpy is inverted (which mean a bogus len is mem-copied into the
>stream).

The "problem" is that we inline the memcpy(), at which point gcc won't
care about the fact that it can alias, so they'll just re-order
everything and claim it's out own fault.  Even though there is no sane
way for us to even tell gcc about it. 

I tried to get a sane way a few years ago, and the gcc developers really
didn't care about the real world in this area. I'd be surprised if that
had changed, judging by the replies I have already seen.

I'm not going to bother to fight it. 

			Linus
