Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVC1U7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVC1U7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVC1U5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:57:15 -0500
Received: from pcp05167009pcs.wchstr01.pa.comcast.net ([69.139.90.94]:25732
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262060AbVC1UyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:54:16 -0500
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
From: Brandon Hale <brandon@smarterits.com>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <424857B0.4030302@comcast.net>
References: <42484B13.4060408@comcast.net>
	 <1112035059.6003.44.camel@laptopd505.fenrus.org>
	 <4248520E.1070602@comcast.net>
	 <1112036121.6003.46.camel@laptopd505.fenrus.org>
	 <424857B0.4030302@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 28 Mar 2005 15:54:05 -0500
Message-Id: <1112043246.10117.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > actually Linus was really against adding non-related things to this
> > flag. And I think he is right...
> > 

Makes sense to me.

> I'm not interested in altering and hacking up PT_GNU_STACK; PT_PAX_FLAGS
> already supplies enough to do what I want.  My goal is to have
> PT_PAX_FLAGS code in mainline and Exec Shield, so that if it exists in
> the binary it will be used; else PT_GNU_STACK will be fallen back to.
> 
> > Now.. do you have any examples of when you want a binary marked for no-
> > randomisation ?? (eg something the setarch flag won't fix/won't be good
> > enough for)

I also recall a few oddball cases where PaX randomization broke things,
I'll try and dig one up and see if it fails as well on ExecShield.

> What's setarch do for one?  Anyway, ASLR has been known to break some
> things.  Blackdown Java used to break IIRC; also there's the poorly
> designed Oracle and the poorly designed solution of Oracle on a 32 bit
> platform; and of course there's Emacs, which I heard was broken due to
> Exec Shield's randomization.  Temporary work-arounds are sometimes needed.

> Remember also that I'm not just trying to make a more robust setting for
> ES and mainline; I'm trying to find a way to make it so that
> distribution maintainers can set one set of flags and have it assure
> that the program works in Mainline, Exec Shield, and PaX.  Just a little
> less work for the distribution maintainers, which I think would be a
> good thing considering that apparently Ubuntu Linux might support both
> PaX and Exec Shield in the future, if I'm reading this[1] right.
> 
> [1] http://thread.gmane.org/gmane.linux.ubuntu.devel/6130

IMO you have this backwards, John.  Rather than having the majority (ES,
mainline NX stuff) respect your less popular branch, it would make sense
to have PaX work as well as possible with PT_GNU_STACK, and politely
request that any missing functionality be duplicated in ES. PT_GNU_STACK
is the most widely available header, and we should leverage that
ubiquity as much as possible.  Marking our binaries with PT_PAX_FLAGS
and then begging everyone else to support our way of doing things will
never work.

---
Brandon Hale
