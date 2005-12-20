Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751122AbVLTQay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbVLTQay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVLTQay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:30:54 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:23948 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751122AbVLTQax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:30:53 -0500
Date: Tue, 20 Dec 2005 11:29:30 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <20051220161337.GA10343@elte.hu>
Message-ID: <Pine.LNX.4.58.0512201123580.26851@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org> <1134790400.13138.160.camel@localhost.localdomain>
 <1134860251.13138.193.camel@localhost.localdomain> <20051220133230.GC24408@elte.hu>
 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com> <20051220135725.GA29392@elte.hu>
 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220161337.GA10343@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Dec 2005, Ingo Molnar wrote:
> > Tests:
> > =====
>
> could you also post the output of 'size mm/slob.o', with and without
> these patches, with CONFIG_EMBEDDED and CONFIG_CC_OPTIMIZE_FOR_SIZE
> enabled? (and with all debugging options disabled) Both the UP and the
> SMP overhead would be interesting to see.
>

Well, there is definitely a hit there:

rt (slob new):
size mm/slob.o
   text    data     bss     dec     hex filename
   2051     112     233    2396     95c mm/slob.o

without
size mm/slob.o
   text    data     bss     dec     hex filename
   1331     120       8    1459     5b3 mm/slob.o

rt smp (slob new)
size mm/slob.o
   text    data     bss     dec     hex filename
   2297     120     233    2650     a5a mm/slob.o

without
size mm/slob.o
   text    data     bss     dec     hex filename
   1573     140       8    1721     6b9 mm/slob.o


So, should this be a third memory managment system?  A fast_slob?


Just for kicks here's slab.o:

rt:
size mm/slab.o
   text    data     bss     dec     hex filename
   8896     556     144    9596    257c mm/slab.o

rt smp:
size mm/slab.o
   text    data     bss     dec     hex filename
   9679     640      84   10403    28a3 mm/slab.o

So there's still a great improvement on that (maybe not the bss though).

-- Steve

