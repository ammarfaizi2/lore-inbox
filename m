Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273123AbRIJDRb>; Sun, 9 Sep 2001 23:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273175AbRIJDRW>; Sun, 9 Sep 2001 23:17:22 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:43017 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273123AbRIJDRM>; Sun, 9 Sep 2001 23:17:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Robert Love <rml@tech9.net>, Arjan Filius <iafilius@xs4all.nl>
Subject: Re: Feedback on preemptible kernel patch
Date: Mon, 10 Sep 2001 05:24:36 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109092317330.16723-100000@sjoerd.sjoerdnet> <1000071474.16805.20.camel@phantasy>
In-Reply-To: <1000071474.16805.20.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910031728Z16177-26183+705@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 11:37 pm, Robert Love wrote:
> On Sun, 2001-09-09 at 17:23, Arjan Filius wrote:
> > After my succes report i _do_ noticed something unusual:
> > 
> > I'm not sure it's preempt related, but you wanted feedback :)
> > 
> > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd last message repeated 93 times
> > Sep  9 23:08:02 sjoerd kernel: cation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd kernel: __alloc_pages: 0-order allocation failed (gfp=0x70/1).
> > Sep  9 23:08:02 sjoerd last message repeated 281 times
> > 
> > This is at the very moment i make a ppp connection to internet, and
> > get/set the time with netdate (for the first time after a reboot).
> > I didn't see this a second time (yet).
> > 
> 
> damn, I was exciting we had solved everything :)
> 
> actually, I am not confident of what could cause these results.  the
> 2.4.10-pre is going through another set of changes it should not, and
> one of them concerns exactly what you are reporting.

This may not be your fault.  It's a GFP_NOFS recursive allocation - this
comes either from grow_buffers or ReiserFS, probably the former.  In
either case, it means we ran completely out of free pages, even though
the caller is willing to wait.  Hmm.  It smells like a loophole in vm
scanning.

--
Daniel
