Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbUENRmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbUENRmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbUENRmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:42:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:33688 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261937AbUENRmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:42:17 -0400
Subject: Re: [PATCH] capabilites, take 2
From: Albert Cahalan <albert@users.sf.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       luto@myrealbox.com, Chris Wright <chrisw@osdl.org>,
       olaf+list.linux-kernel@olafdietsche.de, Valdis.Kletnieks@vt.edu
In-Reply-To: <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
References: <1084536213.951.615.camel@cube>
	 <1084548061.17741.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Organization: 
Message-Id: <1084547976.952.644.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2004 11:19:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 11:21, Stephen Smalley wrote:
> On Fri, 2004-05-14 at 08:03, Albert Cahalan wrote:
> > This would be an excellent time to reconsider how capabilities
> > are assigned to bits. You're breaking things anyway; you might
> > as well do all the breaking at once. I want local-use bits so
> > that the print queue management access isn't by magic UID/GID.
> > We haven't escaped UID-as-priv if server apps and setuid apps
> > are still making UID-based access control decisions.
> 
> Capabilities are a broken model for privilege management; try RBAC/TE
> instead.  http://www.securecomputing.com/pdf/secureos.pdf has notes
> about the history and comparison of capabilities vs. TE.

I just read that. It's a very unfair marketing document.
Among other things, it suggests that a capability system
is stuck with about 40 bits while their own version of
capabilities (a duck is a duck...) has 80 bits. Lovely,
but not exactly groundbreaking. There is the bit about
a 3-argument security call, but a careful reading will
reveal that one argument is unused (NULL?) when dealing
with abilities like "can set the clock".

About the only thing of interest is that capability
transitions can be arbitrary. You're not limited to
an obscure set of equations that nobody can agree on.
The cost: complicated site-specific config files and
the inability to support capability-aware apps that
set+clear their own bits.

There is some value in unifying the handling of
capability bits with the handling of actor-to-actee
security controls. This simplifies the documentation,
and thus reduces the likelyhood of admin mistakes.

> Instead of adding new capability bits, replace capable()
> calls with LSM hook calls that offer you finer granularity
> both in operation and in object-based decisions, and then
> use a security module like SELinux to map that to actual
> permission checks.

Eh, why? That's mostly a search-and-replace on the name,
since capable() makes a perfectly fine LSM hook.

> SELinux provides a framework for
> defining security classes and permissions, including both definitions
> used by the kernel and definitions used by userspace policy enforcers
> (ala security-enhanced X).

Nice.

So what about the old-Oracle problem? You have a
server that needs the ability to hog and lock memory.
Is there an almost-empty SELinux policy that would
provide this while leaving the rest of the system
acting as UNIX-like systems have always acted?
If so, we have a winner.

One still does need to provide apps with a way to
answer "can I do FOO, BAR, and BAZ?" and "am I
running with elevated privileges?". Some way to
dispose of unneeded privileges would be good too.
Hopefully extra libraries wouldn't be needed.




