Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265721AbSJYBBk>; Thu, 24 Oct 2002 21:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSJYBBk>; Thu, 24 Oct 2002 21:01:40 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28421
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S265721AbSJYBBk>; Thu, 24 Oct 2002 21:01:40 -0400
Subject: Re: [Lse-tech] Re: [PATCH]updated ipc lock patch
From: Robert Love <rml@tech9.net>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, Hugh Dickins <hugh@veritas.com>,
       cmm@us.ibm.com, manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, lse-tech@lists.sourceforge.net
In-Reply-To: <200210250035.g9P0ZQD11398@eng4.beaverton.ibm.com>
References: <200210250035.g9P0ZQD11398@eng4.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 24 Oct 2002 21:07:50 -0400
Message-Id: <1035508071.735.366.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-24 at 20:35, Rick Lindsley wrote:

> There was a time when "inline" was a very cool tool because it had been
> judged that the overhead of actually calling a function was just too
> heinous to contemplate.  From comments in this and other discussions,
> is it safe to say that the pendulum has now swung the other way?  I see
> a lot of people concerned about code size and apparently returning to
> the axiom of "if you use it more than once, make it a function."  Are
> we as a community coming around to using inlining only on very tight,
> very critical functions?

I think so, at least Andrew is championing us in that direction.  But I
agree.

It somewhere became the notion if the function is small, it
automatically should be inlined.  I suspect Andrew has even stricter
criteria than me (I think super small functions should be inlined) but
the general "its only a couple of lines" or "it could be a macro" are
not sufficient criterion for inlining.

So, my thoughts on suitable criteria would be:

	- used only once and only ever in that one spot (i.e.
	  it really could be part of the caller, but it was pulled
	  out for cleanliness.  Keep it inline to not have the
	  cleanliness cause a performance degradation (however
	  small)).

	- small functions, where small is so small the function
	  overhead is nearly the same size.  Stuff that might not
	  even do anything but return a permutation of an argument,
	  etc.

	- very very time critical functions in time critical places

So that removes the previous criteria of "the function is N lines or
smaller" where N is some number less than 100 :)

	Robert Love

