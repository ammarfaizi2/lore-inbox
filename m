Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTESKHG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbTESKHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:07:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27324 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id S262193AbTESKHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:07:05 -0400
Date: Mon, 19 May 2003 12:16:02 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
In-Reply-To: <20030519111028.B8663@infradead.org>
Message-ID: <Pine.LNX.4.44.0305191210560.6746-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 May 2003, Christoph Hellwig wrote:

> [...] Could you please split all these totally different cases into
> separate syscalls instead?

sure, i'm all for it, but in a different pass, and after syncing up with
glibc. An API cleanup like this should have been done upon the
introduction of futexes, why didnt you comment on this then? Splitting off
FUTEX_REQUEUE in isolation is quite pointless.

> > +	case FUTEX_REQUEUE:
> > +		pos_in_page2 = uaddr2 % PAGE_SIZE;
> > +
> > +		/* Must be "naturally" aligned */
> > +		if (pos_in_page2 % sizeof(u32))
> > +			return -EINVAL;
> 
> Who guarantess that the alignment of u32 is always the same as it's size?

glibc. We do not want to handle all the misaligned cases for obvious
reasons. The use of u32 (instead of a native word) is a bit unfortunate on
64-bit systems but now a reality.

	Ingo

