Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTJBO3Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 10:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTJBO3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 10:29:25 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:7025 "EHLO
	pd6mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S263355AbTJBO3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 10:29:15 -0400
Date: Thu, 02 Oct 2003 09:30:22 -0500
From: John Lange <john.lange@bighostbox.com>
Subject: Re: A new model for ports and kernel security?
In-reply-to: <03100208222600.20948@tabby>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1065105022.2305.28.camel@mars>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2-3mdk
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com>
 <1065059104.5142.133.camel@mars> <03100208222600.20948@tabby>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-10-02 at 08:22, Jesse Pollard wrote:
> > - patches are not a real solution. As a sysadmin I can't afford the
> > extra headache of applying patches after the fact every time I need to
> > upgrade the kernel. Also, if there is an urgent patch to the kernel then
> > I would have to wait for the external patch to be updated before I could
> > do a kernel compile. So generally external patches are problematic for
> > your standard sysadmin.
> 
> The LSM is part of the kernel. Any/most enhanced security modules may be
> loaded without patching the core. Second, it is possible to alter some
> modules policy on the fly for an additional control.

I admit my knowledge of LSM is very limited. If your saying that the
functionality I'm suggesting can be made into a module that will won't
require a new version every time a new version of the kernel comes out
then fantastic!

My major concern with external kernel patches and or modules is that
they lag (sometimes significantly) kernel versions. If a given kernel
contains a critical fix (say a security issue) and no new version of
your module/patch is immediately available then you are in serious
trouble.

> > - If it is generally agreed that the current behaviour is outdated and
> > creates problems with security then we have to ask "Is there any
> > compelling reason to keep it?" Would linux with the patch not be a
> > better, more secure Linux?
> 
> No. It completely disallows those applications (ie, grid, legion, and any
> other distributed application) from functioning for general users. Since
> these users choice of application is generally unknown, you would also
> have to generate a group of ports dynamically.

I don't see how what I'm suggesting would have the effect you are
describing. The default configuration would mimic the current
functionality so nothing would change for the average user.

People who want to tighten things would implement the port security as
required.

As a parallel, look at when IPTables was added to the kernel. By default
it basically does nothing so for average end user nothing is broken. You
tighten it as required.

> Also, since group membership is controling ACCESS functions, you end up
> sharing more than what you want. Your purpose is to have "group" apply to
> port access, yet "group" also applies to file access. You REALLY don't
> want to mix these.

Perhaps a very good point. I suggested adding it as an extension of the
existing group system for the sake of simplicity. Why should the
user/groups security model be limited to only the file system? And its
already mixed since it effectively controls access to devices (via the
file system).

If I can specify which users and groups can access my floppy drive, why
can't I specify which users can bind to my ports?

> > So, why not?
> 
> Application porting compatabiltiy. Right now all that is necessary is to
> recompile the application. With the patch, you also have to figure out how
> to apply appropriate ports to the application, and you don't know ahead
> of time how many ports to allocate. Grid applications tend to have one
> port for each node they communicate with. If two users generate a 5 way
> connection you have to give two sets of groups... If the user then wants
> a 10 way you have to reallcate again.

I touched on this above. Since the change I'm suggesting would leave the
system configured to act exactly as it does now there would be no
compatibility issues.

Admins who are used to starting everything "important" as root can still
do that if they wish.

Only people who want better security via complete control over their
ports would deviate from the current functionality.

> This is insufficent flexibility. What you want is to tie each port to a
> capability (or tie port allocation to a capability) and then grant the user
> the capability to allocate ports. This really calls for a LSM based module
> that can pass the request to a security daemon to permit/deny port allocation
> based on external rules.
> 
> This would be more flexable, maintainable, and is less intrusive of the
> kernel core.

An LSM based module sounds great to me provided it has the functionality
I'm suggesting and its distributed with the kernel.

I wish I had the skill and time to create one.

Thanks for your insight Jesse. Very informative.

-- 
John Lange


