Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135416AbRDXKdj>; Tue, 24 Apr 2001 06:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbRDXKda>; Tue, 24 Apr 2001 06:33:30 -0400
Received: from t2.redhat.com ([199.183.24.243]:30447 "EHLO
	warthog.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135325AbRDXKdT>; Tue, 24 Apr 2001 06:33:19 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rwsem benchmark [was Re: [PATCH] rw_semaphores, optimisations try #3] 
In-Reply-To: Your message of "Tue, 24 Apr 2001 12:17:47 +0200."
             <20010424121747.A1682@athlon.random> 
Date: Tue, 24 Apr 2001 11:33:13 +0100
Message-ID: <6252.988108393@warthog.cambridge.redhat.com>
From: David Howells <dhowells@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I see what you meant here and no, I'm not lucky, I thought about that. gcc x
> 2.95.* seems smart enough to produce (%%eax) that you hardcoded when the
> sem is not a constant (I'm not clobbering another register, if it does it's
> stupid and I consider this a compiler mistake).

It is a compiler mistake... the compiler clobbers another register for
you. The compiler does not, however, know about timing issues with the
contents of the inline assembly... otherwise it'd stick a delay in front of
the XADD in my stuff.

> I tried with a variable pointer and gcc as I expected generated the (%%eax)
> but instead when it's a constant like in the bench my way it avoids to stall
> the pipeline by using the constant address for the locked incl, exactly as
> you said and that's probably why I beat you on the down read fast path too.
> (I also benchmarked with a variable semaphore and it was running a little
> slower)

*grin* Fun ain't it... Try it on a dual athlon or P4 and the answer may come
out differently.

David
