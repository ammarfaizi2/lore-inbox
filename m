Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264622AbSIREfM>; Wed, 18 Sep 2002 00:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSIREfM>; Wed, 18 Sep 2002 00:35:12 -0400
Received: from dp.samba.org ([66.70.73.150]:63449 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264622AbSIREfL>;
	Wed, 18 Sep 2002 00:35:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Experimental IDE oops dumper v0.1 
In-reply-to: Your message of "Tue, 17 Sep 2002 00:42:56 MST."
             <Pine.LNX.4.10.10209170028370.11597-100000@master.linux-ide.org> 
Date: Wed, 18 Sep 2002 14:19:53 +1000
Message-Id: <20020918044012.C77212C075@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.10.10209170028370.11597-100000@master.linux-ide.org> you
 write:
> > 	if (!(hdid.capability & (1 << 1))) {
> > 		fprintf(stderr, "Drive does not support LBA\n");
> > 		exit(1);
> > 	}
> 
> Wrong answer, you do CHS.

I can't test that, so safe answer is to refuse to arm the oopser.
Since LBA is most common, that's my first priority.

> > The code always does a read sector then a write: if the sector doesn't
> > contain the right magic, it stops.  But the more robust the better.
> 
> You need a read-modify-write caller.
> You need to remember setfeatures need to be hammered on flushcache and
> writecache disabled.
> You need to be able to walk your buffer and best only if you do single
> sector transactions and not multimode.
> 
> > Patches appreciated 8)
> 
> I'll try, but time is tight for me.

Me too 8(.  The oopser is allowed to (a) refuse to arm at arming time,
or (b) refuse to dump at dumping time, but it'd be nice if it worked
on the widest range of stuff possible (ie. CHS and LBA48 at least).
Of course, it can't use any external routines, and must be small too.

The IDE layer does a great job (on my hardware) from recovering after
we rudely steal the device from it, but no doubt the oopser could be
nicer about it.

Thanks for reading,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
