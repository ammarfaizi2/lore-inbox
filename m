Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUH2VDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUH2VDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 17:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUH2VDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 17:03:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:44506 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268323AbUH2VDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 17:03:15 -0400
Date: Sun, 29 Aug 2004 14:01:20 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hans Reiser <reiser@namesys.com>
cc: Helge Hafting <helgehaf@aitel.hist.no>, Rik van Riel <riel@redhat.com>,
       Spam <spam@tnonline.net>, Jamie Lokier <jamie@shareable.org>,
       David Masover <ninja@slaphack.com>, Diego Calleja <diegocg@teleline.es>,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de, linux-fsdevel@vger.kernel.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, flx@namesys.com,
       reiserfs-list@namesys.com,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <41323436.80007@namesys.com>
Message-ID: <Pine.LNX.4.58.0408291346330.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no>
 <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com>
 <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org> <4131A3B2.30203@namesys.com>
 <Pine.LNX.4.58.0408291055140.2295@ppc970.osdl.org> <41323436.80007@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Aug 2004, Hans Reiser wrote:
>
> The difference is that cat uses open() not openat().

Hans. Step back a bit. Stop this idiocy about thinking that this is all 
about you, and all about your reiser4 "metas" etc.

This is about VFS interfaces, and about being generic and _useful_.

Quite frankly, there is absolutely _zero_ point to make attributes just 
because reiser4 can implement them. Zero. Nada. Zilch. It just won't 
matter, because people are NOT GOING TO SWITCH TO REISER4 IN MASS.

So in order to make this useful, it has to be:
 - stable. This means that if Al Viro asks about locking and aliasing
   issues, you don't ignore it, you ask "how high?"
 - portable. Preferably across operating systems, but at the very _least_ 
   across filesystems. See the NFSv4 thing, for example.
 - useful to the people who would actually use it. Right now that's samba, 
   and not a whole lot else.  For everybody else, the pain of not having 
   _all_ major filesystems support it is probably so insurmountable that
   it's just not going to happen.

Do you get it? If you can't get your mind out of your little current 
reiser4 issues, don't even bother talking about it.

Look through the thread on "possible design issues for hybrids" for me
actually talking with Al on how to handle problem #1. That's one important
thing, and in fact, that one is important whether we expose it to a normal
"open()" call or not, since all the same aliasing issues exist
_regardless_ of interfaces.

"openat()" happens to be _one_ solution to #2 and #3. You haven't given 
any constructive input to _any_ of the problems, and you keep on raising 
totally irrelevant issues. Face the music, Hans. If you can't solve those 
three problems, whatever you do simply DOES NOT MATTER.

In particular, in the two last emails to you, I tried to show that
"openat()" is _independent_ of streams/attributes. That it has semantics
that have absolutely _nothing_ to do with metas. And in BOTH CASES you
could not wrap your brain around that fact, and kept on harping about
meta's.

There are bigger issues here. I'm perfectly happy to _also_ expose the
streams as regular filenames, but I've tried to explain that that doesn't
work for directories, for example, so YOU CANNOT -JUST- talk about the
filename-only thing. You do need to have a different namespace.  Full
stop. What's so hard to understand about that?

So stop ignoring the issues. Stop ignoring the fact that not everything 
revolves around how you happened to implement something. Get with the 
program. 

		Linus
