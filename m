Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTJWW7L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJWW7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:59:11 -0400
Received: from thunk.org ([140.239.227.29]:13549 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261862AbTJWW7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:59:08 -0400
Date: Thu, 23 Oct 2003 18:59:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Michael Glasgow <glasgow@beer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: posix capabilities inheritance
Message-ID: <20031023225903.GB3719@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Michael Glasgow <glasgow@beer.net>, linux-kernel@vger.kernel.org
References: <fa.f4bs2b4.fhub0m@ifi.uio.no> <200310232205.h9NM5eOc004400@dark.beer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310232205.h9NM5eOc004400@dark.beer.net>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 05:05:40PM -0500, Michael Glasgow wrote:
> Even with selective capability inheritance enabled in this fashion,
> it is still possible to avoid using it and modify programs directly,
> if you think that's more secure.  Personally, I think that in some
> cases it's slightly more secure to have a very small (statically
> linked) setuid wrapper program which sets up capabilities properly
> than to make a very large program setuid-root (when it was not
> designed to run as root), only to add one capability.
> 
> Yes, you can do the capability-setup first thing in main()... but
> this is occasionally insufficient.  Also, it makes it a pain to
> have, for instance, a backup user with CAP_DAC_READ_SEARCH who is
> able to run several apps, e.g. dump, tar, cpio, rsync, etc.  from
> a restricted shell.
> 
> The code to drop privs is not hard, but it's also not trivial.
> Those without a clue are just as likely to screw it up as they are
> a wrapper; and anyway since when did it become a design goal for
> the kernel to cater to the ineptitude of the clueless?  That sounds
> more like a Redmond, Washington philosophy than one fit for Linux. :-)

Modifying source code requires programming capabilities, which means
that the most clueless won't do it at all.  It's something that needs
to be done by the upstream authors, or perhaps by the distributions,
at which point the clueless will get it when they upgrade.

It's not matter of catering to the ineptitude of the clueless but
pursueing a design which doesn't leave an open manhole cover where a
clueless system administrator can screw up and put their entire system
at risk.  Consider that even if the distributions ship a package using
your system, there will be a config file which will be an opportunity
for a system administrator to screw up.  In general, for any
particular system program, there is only one acceptable setting in
terms of what capabilities it will need.  So why make it be something
which can be screwed up in a config file?  

Fix it once, by a programmer who knows what he/she is doing, and the
problem is fixed for everyone.  Furthermore, it will be more efficient
since it avoids an exec and requirement for a program to parse a
config file.

						- Ted
