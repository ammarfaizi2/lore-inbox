Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTJBBMo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTJBBMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:12:44 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:1728 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263069AbTJBBMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:12:05 -0400
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
From: Albert Cahalan <albert@users.sf.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       perfctr-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0310011717180.6077-100000@home.osdl.org>
References: <Pine.LNX.4.44.0310011717180.6077-100000@home.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065056278.735.55.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 01 Oct 2003 20:57:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 20:38, Linus Torvalds wrote:
> On 1 Oct 2003, Albert Cahalan wrote:
> > 
> > It certainly seems to me that the intent of /proc/self is
> > to point to a "process", which is a tgid in kernel terms.
> 
> My argument against that is that it actually loses information. Now there 
> is no way to easily look up the current thread stuff.

This maybe?

/proc/task -> 42/task/84

> If /proc/self points to a thread, it's easy to look up the process with a 
> "/proc/self/../..".

That wouldn't have worked with /proc/self pointing to
an invisible directory like it did. It could certainly
be made to work, like this:

/proc/self -> 42/task/84

Had the /proc/self code not been modified, you'd get
a nasty link like this:

/proc/self -> 84   (and "84" isn't listed in /proc)

So using "/proc/self/../.." would just go up to "/".
That's not too useful.


