Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSGIBoA>; Mon, 8 Jul 2002 21:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGIBn7>; Mon, 8 Jul 2002 21:43:59 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:53128 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316614AbSGIBn6>;
	Mon, 8 Jul 2002 21:43:58 -0400
Message-Id: <200207090146.g691kD429646@eng4.beaverton.ibm.com>
To: Greg KH <greg@kroah.com>
cc: Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal 
In-reply-to: Your message of "Sun, 07 Jul 2002 19:12:29 PDT."
             <20020708021228.GA19336@kroah.com> 
Date: Mon, 08 Jul 2002 18:46:12 -0700
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    So you agree with me?  Good.  I know you think the code is better
    than it was before, but beauty is in the eye of the beholder, or in
    this case, the eye of the people that fully understand the code :)

The problem is, of course, that to responsibly use the BKL, you must
fully understand ALL the code that utilizes it, so that you know your
new use of it doesn't conflict or interfere with existing code and
usage.  That's the same problem we have when it DOES show contention --
is the problem in the functions which can't grab it (for trying
unnecessarily), or in the functions that can (for holding it
unnecessarily)?

If you are the person who understands the BKL in all its usages
throughout the kernel, then thankfully, our search is over.  We've been
looking for you to help resolve some of these discussions.  If you
aren't that person, though, then you can't accurately say your use of
it doesn't affect anybody else adversely.  All you can assert is that
in your corner of the kernel, *you* use it for X, Y, and Z and they
don't interact poorly with each other.

With a narrowly defined and used lock, it is much less difficult to
determine who uses it, what it is guarding, and what impact yet another
use of it will have.  With the BKL (and a few other poorly documented
locks which have recently been cleaned up) nobody has had a hope of
understanding the interactions.

    If nothing else, I hope you will think twice before sending off
    your next BKL removel patch in a subsystem that you haven't fully
    tested or understood.  That's the point I keep trying to get across
    here.

So can you define for me under what conditions the BKL is appropriate
to use?  Removing it from legitimate uses would be bad, of course, but
part of the problem here is that it's currently used for a variety of
unrelated purposes.

Rick
