Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315762AbSGXBBy>; Tue, 23 Jul 2002 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGXBBy>; Tue, 23 Jul 2002 21:01:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5646 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315762AbSGXBBy>; Tue, 23 Jul 2002 21:01:54 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
Date: Wed, 24 Jul 2002 01:04:53 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ahkufl$25v$1@penguin.transmeta.com>
References: <200207240051.CAA16434@harpo.it.uu.se>
X-Trace: palladium.transmeta.com 1027472686 16755 127.0.0.1 (24 Jul 2002 01:04:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Jul 2002 01:04:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200207240051.CAA16434@harpo.it.uu.se>,
Mikael Pettersson  <mikpe@csd.uu.se> wrote:
>On Tue, 23 Jul 2002 18:58:52 -0400, Kevin O'Connor wrote:
>>#define BackPtr(ptr, type, member) ({                                         \
>>        typeof( ((type *)0)->member ) *__mptr = (ptr);                        \
>>        ((type *)( (char *)__mptr - (unsigned long)(&((type *)0)->member) ));})
>
>I've seen this sort of code several times now in the Linux kernel,
>and I've never liked it. Is there some reason why you guys avoid
>offsetof() like the plague?

Trivial answer: offsetof() does not exist when you don't have system
header files. 

So it's not that it's getting avoided, it _has_ to be re-implemented
anyway.  And once you do that, you might as well do it right (ie what
the kernel wants is not offsetof, but a new pointer.

		Linus
