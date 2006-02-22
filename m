Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWBVXp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWBVXp6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 18:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWBVXp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 18:45:58 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:65425 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751553AbWBVXp5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 18:45:57 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 00:45:58 +0100
User-Agent: KMail/1.9.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602221949.31933.rjw@sisk.pl> <200602230841.10227.ncunningham@cyclades.com>
In-Reply-To: <200602230841.10227.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602230045.59238.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 22 February 2006 23:41, Nigel Cunningham wrote:
> On Thursday 23 February 2006 04:49, Rafael J. Wysocki wrote:
> > > > Frankly, I didn't think of dropping PBEs right now, but in the long run
> > > > that's worth considering, IMO.  The advantage of PBEs is that they are
> > > > easy to handle in the assembly parts, but apart from this they are a
> > > > bit wasteful (not very much, though).
> > >
> > > Fully agree. That's why I've sought to keep the copying in c - it makes
> > > it simpler to read and maintain (although at the expense of a little bit
> > > of ugliness with that if in the stack page allocation
> >
> > Well, that's a bit too much ugliness for me, sorry.
> >
> > > or (old way) working hard to make the C not use stack).
> >
> > I'd rather not get rid of the assembly parts.  Instead, I'd modify them to
> > handle bitmaps.  I'm not going to drop them.
> 
> Well, if you do this, and I can, I will start using the code too. I don't know 
> x86/x86_64/ppc/... assembly enough that I could help, but I would be willing 
> to drop the current code if yours was usable. Come to that, (as I already 
> said), I'm willing to work on switching to pbes prior to that and seeing if 
> we can share that code earlier, if you want me to and I can find the time.

Yes, it would be nice if we could share some code earlier.  However I think
the freezer is a better target short-term.  If you could have a look at the
-mm freezer and tell us what you'd like to add to that, we'd probably be able
to get closer in that area.

> > > > The fact that we use page flags to store some suspend/resume-related
> > > > information is a big disadvantage in my view, and I'd like to get rid
> > > > of that in the future.  In principle we could use a bitmap, or rather
> > > > two of them, to store the same information independently of the page
> > > > flags, and if we use bitmaps for this purpose, we can use them also
> > > > instead of PBEs.
> > >
> > > If you use the 'dynamically allocated pageflags' code (sure, pick a
> > > better name if you want), these changes will be pretty trivial - you can
> > > #define macros that could make the transition just a matter of switching
> > > PageNosave (eg) to PageSomethingElse. (Ditto for setting and clearing
> > > flags).
> >
> > I think it could be done without that code and I'd prefer to do so.  In
> > fact, we only need to remember:
> > (a) saveable pages
> > (b) pages used to store the data from (a)
> > (c) pages allocated by us that we should release eventually
> > (generally that may be a broader set than just (b)).
> > That's 3 bitmaps total and no need for using any more sophisticated stuff,
> > if I remember everything correctly.
> 
> Maybe I have tunnel vision, but I'd be surprised if you didn't end up with 
> something similar - I've tried to make it as simple as possible, and am 
> basically doing the same thing (even if I'm using different terms for some of 
> the concepts). I'd certainly be willing to interact on "Why did you do it 
> this way?" questions and make changes if a better way is shown to me.

OK

Greetings,
Rafael
 
