Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbTDRRnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTDRRnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:43:16 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20748 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263180AbTDRRnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:43:15 -0400
Date: Fri, 18 Apr 2003 10:55:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Greg KH <greg@kroah.com>
cc: Andries.Brouwer@cwi.nl, <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct loop_info64
In-Reply-To: <20030418165506.GA6834@kroah.com>
Message-ID: <Pine.LNX.4.44.0304181050430.2950-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Apr 2003, Greg KH wrote:
> On Fri, Apr 18, 2003 at 09:26:08AM -0700, Linus Torvalds wrote:
> > 
> > We should literally have the rule that any user-visible data structures 
> > cannot use _any_ types other than u8/u16/u32/u64 (and _maybe_ the signed 
> > ones, if there is any real reason to).
> 
> I thought we did have such a rule.  Well, it's unwritten I guess...

It's certainly been a suggested rule, but yes it's unwritten. And we've
never had a good rule for user pointers (ie right now everybody just has
"void *", which ends up always requireing explicit conversion).

> Oh, and shouldn't we be using the "__*" style types for crossing the
> user/kernel boundry (__u8, __u16, __u32, etc.)?  I thought that is what
> those versions were for.

Yes, in header files they should always be the __xx versions.

But we really should have a __ptr64 type too. There's just no sane way to
tell gcc about it without requireing casts, which is inconvenient (which
means that right now it you just have to use __u64 for pointers if you
want to be able to share the structure across 32/64-bit architectures).

		Linus

