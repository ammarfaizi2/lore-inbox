Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318368AbSGYHSC>; Thu, 25 Jul 2002 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSGYHSC>; Thu, 25 Jul 2002 03:18:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:19357 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318368AbSGYHSB>;
	Thu, 25 Jul 2002 03:18:01 -0400
Date: Thu, 25 Jul 2002 16:32:39 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lk@tantalophile.demon.co.uk, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Message-Id: <20020725163239.6c6e5ed6.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
References: <20020724144433.B7192@kushida.apsleyroad.org>
	<Pine.LNX.4.33.0207241142320.2117-100000@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 11:48:10 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:

> The thing is, we cannot change existing select semantics, and the
> question is whether what most soft-realtime wants is actually select, or
> whether people really want a "waittimeofday()".

NOT waittimeofday.  You need a *new* measure which can't be set forwards
or back if you want this to be sane.  pthreads has absolute timeouts (eg.
pthread_cond_timedwait), but they suck IRL for this reason.

Of course, doesn't need any correlation with absolute time, it could be a
"microseconds since boot" kind of thing.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
