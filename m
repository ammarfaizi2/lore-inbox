Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVLTPQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVLTPQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVLTPQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:16:40 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:62185 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751091AbVLTPQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:16:39 -0500
Date: Tue, 20 Dec 2005 10:16:23 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-rt2 slowness
In-Reply-To: <20051220150711.GA5505@elte.hu>
Message-ID: <Pine.LNX.4.58.0512201014130.25734@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain>
 <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu>
 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu>
 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135089221.13138.269.camel@localhost.localdomain> <20051220150711.GA5505@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > As you see, the new SLOB code runs almost as fast as the SLAB code.
> > With some more improvements, I'm sure it can get even faster.
>
> cool, the numbers are really impressive! I'm wondering where the biggest
> hit comes from - perhaps the SLOB does linear list walking when
> allocating?
>

Yeah, I think that is the biggest hit. The SLOB does the old K&R memory
management. Basically, right from the book.  But it is slow and can
fragment very easily.

I have a little more to do on this patch, (I don't perform the correct
cleanup on kmem_cache_destroy), but I'll send it to you anyway within
the next couple of minutes.  Just so you can take a look and try it out.

-- Steve
