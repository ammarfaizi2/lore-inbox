Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262402AbUJ0MRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbUJ0MRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0MRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:17:22 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:54533 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262402AbUJ0MQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:16:03 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: grove@fsr.ku.dk (Henrik Christian Grove)
Subject: Re: /proc/net/tcp not updated fast enough?
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <7gekjkpilo.fsf@serena.fsr.ku.dk>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CMmht-0000vK-00@gondolin.me.apana.org.au>
Date: Wed, 27 Oct 2004 22:15:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Christian Grove <grove@fsr.ku.dk> wrote:
 
> I have it running on 11[1] machines and since midnight (it's 11:47 here
> now) I have 2397 succesfull connections, but in 31 cases (that's 1,29%
> of the connections - and thus not totally ignorable) I had to read
> through /proc/net/tcp twice to find the uid. Does that sound plausible,
> or more like I'm doing something wrong?

/proc/net/tcp in 2.4 is inherently unreliable since it doesn't use
the seqfile interface.  Your best bet is to use the tcp_diag interface
instead.  You can either do that by using the ss command from the
iproute2 suite, or you can query tcp_diag directly from C through
netlink.

The latter should be 100% reliable if you do a get instead of a dump.

> If it's plausible, how long can it take for /proc/net/tcp to get the
> info? I'm asking because I see one connection (again since midnight)
> where I don't find any uid in the 5 attempts I do as a max.

It's not that it takes a long time to update /proc/net/tcp, it's
the fact that you have to read /proc/net/tcp in pieces, and when
the underlying data is changing, the 2.4 code is much more prone to
returning things twice or missing entries altogether.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
