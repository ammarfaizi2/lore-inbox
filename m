Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278266AbRJMEvA>; Sat, 13 Oct 2001 00:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278267AbRJMEut>; Sat, 13 Oct 2001 00:50:49 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:51211 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S278266AbRJMEue>;
	Sat, 13 Oct 2001 00:50:34 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15303.43933.96690.366643@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 12:49:01 +1000 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <Pine.LNX.4.33.0110121903031.8148-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.40.0110121834150.1505-100000@blue1.dev.mcafeelabs.com>
	<Pine.LNX.4.33.0110121903031.8148-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> On Fri, 12 Oct 2001, Davide Libenzi wrote:
> >
> > The problem is that even if cpu1 schedule the load of  p  before the
> > load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
> > even if from cpu2 the invalidation stream exit in order, cpu1 could see
> > the value of  p  before the value of  *p  due a reordering done by the
> > cache controller delivering the stream to cpu1.
> 
> Umm - if that happens, your cache controller isn't honouring the wmb(),
> and you have problems quite regardless of any load ordering on _any_ CPU.

Well yes.  But this is what happens on alpha apparently.

On alpha, it seems that the wmb only has an effect on the cache of the
processor doing the writes, it doesn't affect any other caches.  The
wmb ensures that the invalidates from the two writes go out onto the
bus in the right order, but the wmb itself doesn't go on the bus.
Thus the invalidates can get processed in the reverse order by a
receiving cache.  I presume that an rmb() on alpha must wait for all
outstanding invalidates to be processed by the cache.  But I'm not an
expert on the alpha by any means.

Paul.
