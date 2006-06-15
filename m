Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWFOJQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWFOJQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWFOJQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:16:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31665 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932384AbWFOJQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:16:46 -0400
Date: Thu, 15 Jun 2006 11:15:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Jeff Garzik <jeff@garzik.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       Alex Tomas <alex@clusterfs.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060615091539.GF9423@elf.ucw.cz>
References: <m3irnacohp.fsf@bzzz.home.net> <44899A1C.7000207@garzik.org> <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060612220605.GD4950@ucw.cz> <986ed62e0606140731u4c42a2adv42c072bf270e4874@mail.gmail.com> <20060614213431.GF4950@ucw.cz> <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0606141728m6e5b6dbbw7cfb5bd4b82052c1@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Passes 8 hours of me trying to intentionally break it with weird,
> >artifical disk corruption.
> >
> >I even have script somewhere.
> 
> Ok, thanks for clarifying.

You can get a copy, it would be interesting to know how JFS/XFS does.

> >> Unless I'm misunderstanding something, JFS also has a
> >> working fsck
> >> (which has actually performed successful repair of
> >> real-world
> >> filesystem corruption for me, although I haven't used it
> >> as much as
> >> e2fsck or xfs_repair).
> >
> >...like, if it repaired 100 different, non-trivial corruptions, that
> >would be argument.
> 
> In the case of XFS, I've repaired maybe two dozen (or so) corruptions
> that might be non-trivial (in most of the cases, the filesystem
> wouldn't even mount before the repair).
> 
> >fsck.ext2 survives my torture (in some versions). fsck.vfat never
> >worked for me (likes to segfault), fsck.reiser never worked for me.
> 
> BTW, I actually have a test filesystem here (an e2image from an actual
> filesystem I encountered once) that used to cause e2fsck 1.36/1.37 to
> segfault. Strangely, more ancient versions (like what ships in Red Hat
> 7.2) were able to repair it without segfaulting. In a few days, once
> other stuff calms down for me, I need to revisit that and see if the
> bug still exists with 1.39.

It varies a bit bitween versions, but at least e2fsck has regression
test suite... I had nasty e2 corruption in past (suspend wrote 0 onto
strategic place in bitmaps) where it put filesystem in self-destruct
mode. e2fsck reported fixing the corruption, but did not really fix
it... e2fsck was fixed in the meantime.

(I also have way to corrupt ext2 in a way that basically can't be
repaired automatically. Deallocating free block bitmap and putting
data in freed space is an evil way to corrupt filesystem).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
