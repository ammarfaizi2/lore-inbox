Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTESLgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 07:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTESLgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 07:36:19 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:56849 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262423AbTESLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 07:36:16 -0400
Date: Mon, 19 May 2003 12:49:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030519124910.C8868@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
	Ulrich Drepper <drepper@redhat.com>
References: <20030519111028.B8663@infradead.org> <Pine.LNX.4.44.0305191210560.6746-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305191210560.6746-100000@localhost.localdomain>; from mingo@elte.hu on Mon, May 19, 2003 at 12:16:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:16:02PM +0200, Ingo Molnar wrote:
> sure, i'm all for it, but in a different pass, and after syncing up with
> glibc. An API cleanup like this should have been done upon the
> introduction of futexes, why didnt you comment on this then? Splitting off
> FUTEX_REQUEUE in isolation is quite pointless.

Maybe I don't spend all my time watching the futex API? :)  Okay,
let's make a deal, you add a new syscall for this case and I'll fix
up the older ones in a patch that's ontop of yours?

> > > +	case FUTEX_REQUEUE:
> > > +		pos_in_page2 = uaddr2 % PAGE_SIZE;
> > > +
> > > +		/* Must be "naturally" aligned */
> > > +		if (pos_in_page2 % sizeof(u32))
> > > +			return -EINVAL;
> > 
> > Who guarantess that the alignment of u32 is always the same as it's size?
> 
> glibc. We do not want to handle all the misaligned cases for obvious
> reasons. The use of u32 (instead of a native word) is a bit unfortunate on
> 64-bit systems but now a reality.

Sorry if the question wasn't clear, but who guarantess that the alignment
of u32 is the same as it's size?  You test of the size of u32, not it's
alignment even if they usually are the same.

