Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSKRDgf>; Sun, 17 Nov 2002 22:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSKRDgf>; Sun, 17 Nov 2002 22:36:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261401AbSKRDge>; Sun, 17 Nov 2002 22:36:34 -0500
Date: Sun, 17 Nov 2002 19:43:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Ingo Molnar <mingo@elte.hu>, Luca Barbieri <ldb@ldb.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] threading fix, tid-2.5.47-A3
In-Reply-To: <3DD85F93.1000909@redhat.com>
Message-ID: <Pine.LNX.4.44.0211171938250.8451-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 17 Nov 2002, Ulrich Drepper wrote:
> > 
> > And the point of this is? The child has to re-initialize it's pthread 
> > structures anyway after a fork,
> 
> No, that's the whole point.  The thread descriptor for the one thread in
> the new process is fine with the one exception: the TID.  There is not
> one change to the thread descriptor in the fork code left if this change
> is available.

Oh, I realized that, but I was talking about the _other_ thread 
descriptors. The ones that exist in the parent (because the parent 
potentially has multiple threads before the fork()), but that will be 
invalid in the child. 

So when the child eventually creates a new thread, it needs to know to 
ignore the other thread slots, even though they _look_ valid. They were 
valid in the parent, they aren't valid in the child.

No?

I follow your argument, and I don't dislike it per se. I just think that 
you end up having to do other setup for pthreads-after-fork _anyway_, no?

I still want to have those flags make _sense_ rather than just adding a 
new flag without reason. For example, I've seen no real reason to 
introduce a second pointer - as far as I can tell it makes sense in none 
of the cases anybody has ever mentioned so far.

Basically, I don't see the patch and bits making sense. I see it
potentially _working_. But that's a different issue - and "working" to me
is sometimes a much less potent argument than "makes sense".

		Linus

