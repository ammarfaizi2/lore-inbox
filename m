Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTESXqP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTESXqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:46:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42593 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262165AbTESXqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:46:14 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>
	<Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>
	<babhik$sbd$1@cesium.transmeta.com>
	<m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com>
	<m18yt235cf.fsf@frodo.biederman.org> <3EC9660D.2000203@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 May 2003 17:55:06 -0600
In-Reply-To: <3EC9660D.2000203@zytor.com>
Message-ID: <m14r3q331h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Yes.  And guess what?  Bugs happen.  Sometimes you can't fix them either
> because the "new" usage has gotten established.  However, that's not the
> point.
> 
> Your message assumes that the ABI remains fixed.  This is totally and
> utterly and undeniably WRONG. 

It is correct by definition, the existing part of an ABI may not change.

> There are rules for how it may evolve,
> but it very much does evolve.  No amount of handwaving or putting
> underscores in weird places will change that.

Sure you can add new functionality in a defined way.  You can add to
the ABI.  You may not modify an existing definition.  But that has
no implications for existing working code.

> > But there is no reason not to write documentation today about what the
> > kernel interfaces are and convert glibc and the kernel later when
> > it is convenient to their development cycles.  
> > 
> > What I do not is see the necessity of using automation to follow the
> > documentation.
> > 
> 
> Otherwise you have three places to manually make your changes (usually
> more) -- the documentation, the kernel, and glibc... and really you also
> have klibc, uclibc, dietlibc, and God knows what else.

But since the older interface still remains you don't have to change
klibc, uclibc, dietlibc, and whatever else does not care.  Making
it easy to change an existing ABI is simply wrong.

If you were to increment the syscall numbers by one no amount of automation
in the world would make that a kernel that would be usable on a production
box.  The only way it could even work is if you were to declare that
kernel uses a new ABI.

> Automation is the way to maintain these together and in concert, to
> avoid your "B_ U_ G_ S_."  This isn't just a Good Thing, this is the
> only sane possibility.

If things must be maintained in concert it is a bug.  

With a fixed ABI people take advantage of new features as they
care for them.  And in general to use new features requires new code.

If people are adding and changing ioctls/sysctls/prctls left and right,
and that is what is causing the maintenance problem, then that is the
problem.  And that is where the problem needs to be reigned in at.

> Does that mean C source code is the only possible format?  It most
> certainly *doesn't* -- in fact one could argue it's not even a very good
> format -- as long as C source code is one of the possible productions.

Agreed.

Calling it documentation simply makes it clear what the headers are,
and suggest that the machine readable for does not need to be C source
code.

Eric
