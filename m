Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318169AbSGQBF3>; Tue, 16 Jul 2002 21:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318170AbSGQBF2>; Tue, 16 Jul 2002 21:05:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37900 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318169AbSGQBF1>; Tue, 16 Jul 2002 21:05:27 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: close return value
Date: Wed, 17 Jul 2002 01:05:00 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ah2frs$164$1@penguin.transmeta.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716.165241.123987278.davem@redhat.com> <1026869741.2119.112.camel@irongate.swansea.linux.org.uk> <20020716.172026.55847426.davem@redhat.com>
X-Trace: palladium.transmeta.com 1026868088 28922 127.0.0.1 (17 Jul 2002 01:08:08 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 17 Jul 2002 01:08:08 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020716.172026.55847426.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>   Date: 17 Jul 2002 02:35:41 +0100
>
>   Our NFS can return errors from close().
>
>Better tell Linus.

Oh, Linus knows.  In fact, Linus wrote some of the code in question. 

But the thing is, Linus doesn't want to have people have the same issues
with local filesystems.  I _know_ there are broken applications that do
not test the error return from close(), and I think it is a politeness
issue to return error codes that you can know about as soon as humanly
possible. 

For NFS, you simply cannot do any reasonable performance without doing
deferred error reporting.  The same isn't true of other filesystems. 
Even in the presense of delayed block allocation, a local filesystem can
_reserve_ the blocks early, and has no excuse for giving errors late
(except, of course, for actual IO errors). 

			Linus
