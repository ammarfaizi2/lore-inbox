Return-Path: <linux-kernel-owner+w=401wt.eu-S1161015AbWLTXaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWLTXaz (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161016AbWLTXaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:30:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43790 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161015AbWLTXay (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:30:54 -0500
From: Junio C Hamano <junkio@cox.net>
To: merlyn@stonehenge.com (Randal L. Schwartz)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
Date: Wed, 20 Dec 2006 15:30:50 -0800
In-Reply-To: <86wt4mximh.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 15:17:10 -0800")
Message-ID: <7v64c65emt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> But yes, _XOPEN_SOURCE_EXTENDED definitely does some damage to
> curses.h.  However, I don't see how that's relevant to strings.h
> or the others I need.  There's no "config" for "compatibility".
> Welcome to Linux vs Unix. :)
>
> What I do know is (a) it worked before the header changes and (b)
> the patch I just gave you works.  If the patch doesn't break others,
> can we just leave it in?

That would lead to maintenance nightmare in the longer term.  We
cannot do that unless we know more or less what is going on.
Including only some system headers in a random order before
feature macros are defined, and doing so in only some source
files randomly until it starts compiling, is not a solution
maintainable in the longer term.

The _EXTENDED stuff is minimally commented that AIX wants it;
otherwise we would have been tempted to say, "remove it, if it
breaks OSX" without thinking, and would have ended up breaking
AIX.

No matter what we do, I would really want a clear description of
in what way OSX headers are broken and what needs to be done to
avoid the breakage in git-compat-util.h where it sets up feature
macros and includes system headers.


