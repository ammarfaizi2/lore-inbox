Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSFPX5P>; Sun, 16 Jun 2002 19:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSFPX5O>; Sun, 16 Jun 2002 19:57:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22251 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316617AbSFPX5O>;
	Sun, 16 Jun 2002 19:57:14 -0400
Date: Sun, 16 Jun 2002 19:57:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <UTC200206162205.g5GM5eJ05123.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0206161951160.5807-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002 Andries.Brouwer@cwi.nl wrote:

> >> The result of Step One is that the loop no longer touches all
> >> filesystems but lives entirely in namei.c. So, the second patch,
> >> that only changes namei.c can change the recursion into iteration.
> >> Maybe tomorrow or the day after.
> 
> > Obvious breakage: nd->flags can be clobbered by __vfs_follow_link(),
> > so your do_follow_link() and friends are broken.
> 
> Yes, I know. No doubt you are able to fix that by reading that bit
> before calling __vfs_follow_link(). It will be repaired fully
> automatically tomorrow or the day after when __vfs_follow_link()
> disappears altogether.
> 
> But that is the microscopic criticism. I was more interested in
> hearing comments on the global setup.

I don't see global setup here - just a (rather messy) change of API.
The really interesting question is how you'll handle namei.c code.
Bringing the call of __vfs_follow_link() into do_follow_link() is
not interesting in itself - you still have recursion to eliminate and
that's where the hell will begin.  Change of ->follow_link() prototype
per se doesn't buy anything and is as you admit kludgy.  If you need
it for really interesting stuff - please do show that stuff.

