Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273145AbRIPBrx>; Sat, 15 Sep 2001 21:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273143AbRIPBrn>; Sat, 15 Sep 2001 21:47:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:28169 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273136AbRIPBrd>; Sat, 15 Sep 2001 21:47:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>
Subject: Re: Feedback on preemptible kernel patch
Date: Sun, 16 Sep 2001 03:54:57 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Chris Mason <mason@suse.com>
In-Reply-To: <1000581501.32705.46.camel@phantasy> <20010916012129Z16244-2758+66@humbolt.nl.linux.org>
In-Reply-To: <20010916012129Z16244-2758+66@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010916014743Z16121-2757+259@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 16, 2001 03:28 am, Daniel Phillips wrote:
> On September 15, 2001 09:18 pm, Robert Love wrote:
> > On Sun, 2001-09-09 at 23:24, Daniel Phillips wrote:
> > > This may not be your fault.  It's a GFP_NOFS recursive allocation - this
> > > comes either from grow_buffers or ReiserFS, probably the former.  In
> > > either case, it means we ran completely out of free pages, even though
> > > the caller is willing to wait.  Hmm.  It smells like a loophole in vm
> > > scanning.

Oh, wait, I was working off 2.4.9 source, and your user had the problem with
2.4.9-pre4, where we have GFP_NOHIGHIO.  So - reinterpreting the bits - all
those failures are bounce buffer allocations.  People are also getting these
failures without your patch, so relax ;-)

Maybe allowing preemption inside page_launder makes it happen more often.

--
Daniel
