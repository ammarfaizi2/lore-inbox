Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265234AbSJWVLW>; Wed, 23 Oct 2002 17:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265238AbSJWVLW>; Wed, 23 Oct 2002 17:11:22 -0400
Received: from cse.ogi.edu ([129.95.20.2]:42205 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265234AbSJWVLV>;
	Wed, 23 Oct 2002 17:11:21 -0400
To: jgmyers@netscape.com (John Myers)
Cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
References: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com>
	<3DB7083E.5030206@netscape.com>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 23 Oct 2002 14:13:58 -0700
In-Reply-To: <3DB7083E.5030206@netscape.com>
Message-ID: <xu4ptu0kgdl.fsf@brittany.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



jgmyers@netscape.com (John Myers) writes:

> If a connection is likely to be idle, one would want to use an async
> read poll instead of an async read in order to avoid having to
> allocate input buffers to idle connections.  (What one really wants
> is a variant of async read that allocates an input buffer to an fd
> at completion time, not submission time).

Right.  This does make sense for a server with thousands of idle
connections.   You could have lots of unused memory in that case.

> Sometimes one wants to use a library which only has a nonblocking
> interface, so when the library says WOULDBLOCK you have to do an
> async write poll.

Right.  I can see this too.  This might be thorny for epoll though,
since it's entirely conceivable that such libraries would be expecting
level style poll semantics.

> Sometimes one wants to use a kernel interface (e.g. sendfile) that
> does not yet have an async equivalent.  Accept/connect are in this
> class--there should be nothing to prevent us from creating async
> versions of accept/connect.

Right.  However in this case, I think using poll is a stop gap
solution.

It would be better to give accept, connect, and sendfile (and
sendfile64) native status in AIO.  Even if the implementations are not
going to be ready for a while, I think their spots in the API should
be reserved now.

That said, the first two points above convince me that there are valid
reasons why poll is also needed in AIO.

-- Buck

