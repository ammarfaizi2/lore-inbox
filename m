Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261304AbSIZOfn>; Thu, 26 Sep 2002 10:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSIZOfn>; Thu, 26 Sep 2002 10:35:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19724 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261304AbSIZOfm>; Thu, 26 Sep 2002 10:35:42 -0400
Date: Thu, 26 Sep 2002 07:41:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/4] prepare_to_wait/finish_wait sleep/wakeup API
In-Reply-To: <3D929A06.8D8C8AE0@digeo.com>
Message-ID: <Pine.LNX.4.44.0209260740100.1769-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Sep 2002, Andrew Morton wrote:
> 
> I expect a decent win would come from using this technique in
> select/poll, but that code relies on the remains-on-the-waitqueue
> semantics, and would need some fiddling.

Actually, I think that select/poll is exactly the kind of thing that would 
_not_ improve noticeably, since usually it's only one (out of possibly 
hundreds) or wait-queues that gets woken up. 

So even if that one were to be made faster, the _real_ cost when it comes
to the wait-queues will be all the other 99 waitqueues that select/poll
has to remove itself from the old way anyway.

			Linus

