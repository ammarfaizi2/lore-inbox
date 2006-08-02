Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWHBUT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWHBUT5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHBUT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:19:57 -0400
Received: from xenotime.net ([66.160.160.81]:20142 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932208AbWHBUT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:19:56 -0400
Date: Wed, 2 Aug 2006 13:22:29 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
Subject: ARCH_HAS / HAVE_ARCH
Message-Id: <20060802132229.31bf78e2.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2006 10:13:12 -0700 (PDT) Linus Torvalds wrote:

> On Sun, 2 Jul 2006, Andrew Morton wrote:
> > 
> > The requirement "if you implement this then you must do so as a macro" is a
> > bit regrettable.  The ARCH_HAS_HANDLE_DYNAMIC_TICK approach would eliminate
> > that requirement.
> 
> Btw, this is WRONG.
> 
> The whole "ARCH_HAS_XYZZY" is nothing but crap. It's totally unreadable, 

I agree that ARCH_HAS_* (and HAVE_ARCH_*) are unreadable.  However, the
#define xyzzy	xyzzy

solution isn't much better IMO and it will be confuzing
to people in a few years.


> compared to the _much_ simpler
> 
> 	#ifndef xyzzy
> 	#define zyzzy() /* empty */
> 	#endif
> 
> which is a hell of a lot more obvious to everybody involved, not to 
> mention being a lot easier to "grep" for (try it - "grep xyzzy" ends up 
> showing _exactly_ what is going on for cases like this, unlike the 
> ARCH_HAS_XYZZY crap).
> 
> And no, it does not require implementing xyzzy as a macro AT ALL. 
> 
> You can very easily just do
> 
> 	/*
> 	 * We have a very complex xyzzy, we don't even want to
> 	 * inline it!
> 	 */
> 	extern void xyxxy(...);
> 
> 	/* Tell the rest of the world that we do it! */
> 	#define xyzzy xyzzy
> 
> and you're now all set. No need for a new stupid name like ARCH_HAS_XYZZY, 
> which adds _nothing_ but unnecessary complexity ("What was the condition 
> for using that symbol again?" and ungreppability).
> 
> WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease.

I have about 10 patches ready, but I'm not terribly happy with them.
Using Kconfig symbols for some of them seems more appropriate to me,
i.e., moving the symbol definitions from "random" header files to
Kconfig files.  After all, these are just hidden config settings.

Would that be acceptable?

---
~Randy
