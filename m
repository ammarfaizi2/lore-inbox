Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTJAPLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbTJAPLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 11:11:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:51161 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbTJAPLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 11:11:43 -0400
Date: Wed, 1 Oct 2003 08:11:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <perfctr-devel@lists.sourceforge.net>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
In-Reply-To: <16250.38688.152166.875893@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0310010803530.23860-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Mikael Pettersson wrote:
>
> Linus' 2.6.0-test6 announcement doesn't seem to mention the
> fact that 2.6.0-test5-bk9 fundamentally changed the semantics
> of /proc/self and the /proc/<pid> name space.

Well, that's because the semantics weren't _supposed_ to change. The new 
semantics were meant to be a superset of the old behaviour, with just the 
added "task" subdirectory that lists the actual threads.

However, you're right that "/proc/self" should likely point into the
_thread_, and not into the task. But it's debatable. You are very likely 
the only one who could ever care ;)

> I don't actually disagree with the change, but it took me by
> surprise since neither the 2.6.0-test6 annoucement nor the
> diff between the t5-bk8 and t5-bk9 logs seem to mention it.

Well, the changelog mentions "fix for hidden task problem", since the diff 
really is mainly to _add_ threads to the /proc layout. The fact that it 
changed /proc/self is actually a bit surprising. Albert?

> (It broke the perfctr driver, but I'm handling that by making
> an already planned API switch now instead of later.)

I think /proc/self most likely _should_ point into the thread, not the 
task. 

		Linus

