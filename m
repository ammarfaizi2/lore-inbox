Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318755AbSHLRY1>; Mon, 12 Aug 2002 13:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318756AbSHLRY1>; Mon, 12 Aug 2002 13:24:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19730 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318755AbSHLRY1>; Mon, 12 Aug 2002 13:24:27 -0400
Date: Mon, 12 Aug 2002 10:30:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: akpm@zip.com.au, <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <20020812174530.398156a1.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.44.0208121029060.2274-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Rusty Russell wrote:
> On Fri, 9 Aug 2002 18:33:09 -0700 (PDT)
> Linus Torvalds <torvalds@transmeta.com> wrote:
> 
> > 	repeat:
> > 		kmap_atomic(..); // this increments preempt count
> > 		nr = copy_from_user(..);
> 
> Please please please use a different name for "I know I'm not preemptible but
> I can handle it" or a flag or something.
> 
> That leaves us with the possibility of a BUG() in the "normal" copy_to/from_user
> for all those "I'm holding a spinlock while copying to userspace wheeee!" bugs.
> Very common mistake for new kernel authors.

Agreed. 

Maybe the right thing to do is to just have a 

	atomic_copy_from_user()

which can then be used to explicitly not check if we have a kernel 
debugging option.

		Linus

