Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSGIEip>; Tue, 9 Jul 2002 00:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGIEip>; Tue, 9 Jul 2002 00:38:45 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:39185 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317192AbSGIEio>;
	Tue, 9 Jul 2002 00:38:44 -0400
Date: Mon, 8 Jul 2002 21:38:58 -0700
From: Greg KH <greg@kroah.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020709043857.GA24418@kroah.com>
References: <20020708021228.GA19336@kroah.com> <200207090146.g691kD429646@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207090146.g691kD429646@eng4.beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 11 Jun 2002 03:05:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2002 at 06:46:12PM -0700, Rick Lindsley wrote:
>     So you agree with me?  Good.  I know you think the code is better
>     than it was before, but beauty is in the eye of the beholder, or in
>     this case, the eye of the people that fully understand the code :)
> 
> The problem is, of course, that to responsibly use the BKL, you must
> fully understand ALL the code that utilizes it, so that you know your
> new use of it doesn't conflict or interfere with existing code and
> usage.  That's the same problem we have when it DOES show contention --
> is the problem in the functions which can't grab it (for trying
> unnecessarily), or in the functions that can (for holding it
> unnecessarily)?

{Sigh}

But the driverfs and USB code do _not_ show contention.  Or if they do
(as Dave pointed out in the driverfs code) it's in a non-critical
point in the kernel's life (boot time, USB device removal, etc.)

> If you are the person who understands the BKL in all its usages
> throughout the kernel, then thankfully, our search is over.  We've been
> looking for you to help resolve some of these discussions.  If you
> aren't that person, though, then you can't accurately say your use of
> it doesn't affect anybody else adversely.  All you can assert is that
> in your corner of the kernel, *you* use it for X, Y, and Z and they
> don't interact poorly with each other.

Yes, that's what I am asserting, _and_ that when my "corner" of the
kernel uses it, it doesn't really matter if ext3, ext2, or even the
entire VFS layer grinds to a halt.  No one will care, or even notice.

> So can you define for me under what conditions the BKL is appropriate
> to use?  Removing it from legitimate uses would be bad, of course, but
> part of the problem here is that it's currently used for a variety of
> unrelated purposes.

Wait!  You're still not getting it.  I'm not against removing the BKL.
I'm not saying we should add it to more places.  What I am complaining
about (and I'm not the only one) is the method that people who are
trying to remove the BKL from various kernel subsystems are using.  I
think Oliver said it best in this quote from this thread:

	So you do the greps and question locking usage on the
	right lists.  It's quite important, you might uncover
	bugs and speed up the kernel.  And you need to be
	persistent about it. Take your time to find out why
	the lock is used. Or why it makes no sense.


So please, no more "hit and run" BKL patches that break things.  Please
come offering to help, with detailed reasons why BKL usage is wrong in
the specific portions of the code, and how possibly it might be cleaned
up, with patches that have _actually been tested_.  And then
flames^Wdiscussions like this one will not happen at all.

thanks,

greg k-h
