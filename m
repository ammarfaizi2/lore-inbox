Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273186AbRIJDgq>; Sun, 9 Sep 2001 23:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273185AbRIJDgg>; Sun, 9 Sep 2001 23:36:36 -0400
Received: from family.zawodny.com ([63.174.200.26]:35089 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S273183AbRIJDga>; Sun, 9 Sep 2001 23:36:30 -0400
Date: Sun, 9 Sep 2001 20:37:46 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Robert Love <rml@tech9.net>, Arjan Filius <iafilius@xs4all.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Feedback on preemptible kernel patch
Message-ID: <20010909203746.B640@peach.zawodny.com>
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet> <1000071474.16805.20.camel@phantasy> <20010910031728Z16177-26183+705@humbolt.nl.linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010910031728Z16177-26183+705@humbolt.nl.linux.org>
User-Agent: Mutt/1.3.20i
X-message-flag: Mailbox corrupt.  Please upgrade your mail software.
X-Uptime: 20:36:14 up 42 days, 18:34, 10 users,  load average: 0.00, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2001 at 05:24:36AM +0200, Daniel Phillips wrote:
> On September 9, 2001 11:37 pm, Robert Love wrote:
> > On Sun, 2001-09-09 at 17:23, Arjan Filius wrote:
> > > After my succes report i _do_ noticed something unusual:
> > > 
> > > I'm not sure it's preempt related, but you wanted feedback :)
> > > 
> > > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > > Sep  9 23:08:02 sjoerd last message repeated 93 times
> > > Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
> > > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
>
> 
> This may not be your fault.  It's a GFP_NOFS recursive allocation -
> this comes either from grow_buffers or ReiserFS, probably the
> former.  In either case, it means we ran completely out of free
> pages, even though the caller is willing to wait.  Hmm.  It smells
> like a loophole in vm scanning.

I've seen that error on a couple 2.4.9 systems at work.  It's
certainly VM related, 'cause it doesn't happen when I disable swap on
them.  I've disabled it for performance reasons (the VM system is a
little retarded in 2.4.x IMHO, so I'm just not letting it swap).

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/
