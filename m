Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261825AbTJWWFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTJWWFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 18:05:47 -0400
Received: from dark.beer.net ([204.145.225.20]:3347 "EHLO dark.beer.net")
	by vger.kernel.org with ESMTP id S261825AbTJWWFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 18:05:44 -0400
Date: Thu, 23 Oct 2003 17:05:40 -0500 (CDT)
Message-Id: <200310232205.h9NM5eOc004400@dark.beer.net>
From: "Michael Glasgow" <glasgowNOSPAM@beer.net>
To: "Theodore Ts'o" <tytso@mit.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: posix capabilities inheritance
In-reply-to: <fa.f4bs2b4.fhub0m@ifi.uio.no>
References: <fa.f4bs2b4.fhub0m@ifi.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> I agree this is safe, and allows the use of your setuid wrapper
> script.  The one reason why I think it's better to modify programs is
> that it's too easy for individual system administrators to screw up
> the configuration used by your wrapper script, and accidentally
> introduce a security vulnerability into their system.  It's dangerous
> to give a program some capability (or reduce the capability given to a
> program designed to be setuid) without examining the source code and
> being clueful.  So by making the program setuid and editing the source
> code to add an explicit capability drop in the program is much, much
> safer compared to having a random system administrator to edit a
> config file and trust that he or she does so correctly.

I can see your point, but I guess we'll have to agree to disagree.

Even with selective capability inheritance enabled in this fashion,
it is still possible to avoid using it and modify programs directly,
if you think that's more secure.  Personally, I think that in some
cases it's slightly more secure to have a very small (statically
linked) setuid wrapper program which sets up capabilities properly
than to make a very large program setuid-root (when it was not
designed to run as root), only to add one capability.

Yes, you can do the capability-setup first thing in main()... but
this is occasionally insufficient.  Also, it makes it a pain to
have, for instance, a backup user with CAP_DAC_READ_SEARCH who is
able to run several apps, e.g. dump, tar, cpio, rsync, etc.  from
a restricted shell.

The code to drop privs is not hard, but it's also not trivial.
Those without a clue are just as likely to screw it up as they are
a wrapper; and anyway since when did it become a design goal for
the kernel to cater to the ineptitude of the clueless?  That sounds
more like a Redmond, Washington philosophy than one fit for Linux. :-)

--
Michael Glasgow < glasgow at beer dot net >
