Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291857AbSBNUHB>; Thu, 14 Feb 2002 15:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291859AbSBNUGw>; Thu, 14 Feb 2002 15:06:52 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:6927 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S291857AbSBNUGs>; Thu, 14 Feb 2002 15:06:48 -0500
X-mailer: xrn 8.03-beta-26
From: Paul Menage <pmenage@ensim.com>
Subject: Re: [RFC][PATCH 2.4.17] Your suggestions for fast path walk
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
X-Newsgroups: 
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D2173A3@nasdaq.ms.ensim.com>
Message-Id: <E16bS9Q-0000Bd-00@pmenage-dt.ensim.com>
Date: Thu, 14 Feb 2002 12:06:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have also combined path_init and path_walk in places where 
>they are always called together.

This is nice from a code simplification point of view, and is mostly
orthogonal to the fast path walking.

I'd be inclined to call this combined function something like
path_lookup(), rather than path_init_walk() - the callers don't need to
know that it's an init followed by a walk, they just need to know that
it does a lookup.

Also, to avoid code duplication, is there any reason why path_lookup()
can't be implemented (possibly inlined) just as:

static int path_lookup(const char *name, struct nameidata *nd, int flags)
{

    if(!path_init(name, flags, nd))
	return 0;

    return path_walk(name, nd);

}

Paul
