Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTJBNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJBNW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 09:22:58 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:1533 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263337AbTJBNWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 09:22:55 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: John Lange <john.lange@bighostbox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: A new model for ports and kernel security?
Date: Thu, 2 Oct 2003 08:22:26 -0500
X-Mailer: KMail [version 1.2]
Cc: Valdis.Kletnieks@vt.edu, mcmanus@ducksong.com, jmorris@redhat.com
References: <Pine.LNX.4.44.0310011523510.14121-100000@thoron.boston.redhat.com> <1065059104.5142.133.camel@mars>
In-Reply-To: <1065059104.5142.133.camel@mars>
MIME-Version: 1.0
Message-Id: <03100208222600.20948@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 October 2003 20:45, John Lange wrote:
> A few people suggested various patches which implement a similar
> functionality to what I was suggesting and I thank them for that.
>
> I think this clearly demonstrates that there is a demand for such a
> feature.

Not really - that is why they have been external for several years.

> > We should keep the standard behavior as default in the core kernel. 
> > Other security models can be implemented via LSM, Netfilter, config
> > options etc.
>
> I believe there are several compelling reasons why the standard
> behaviour should be changed.
>
> - patches are not a real solution. As a sysadmin I can't afford the
> extra headache of applying patches after the fact every time I need to
> upgrade the kernel. Also, if there is an urgent patch to the kernel then
> I would have to wait for the external patch to be updated before I could
> do a kernel compile. So generally external patches are problematic for
> your standard sysadmin.

The LSM is part of the kernel. Any/most enhanced security modules may be
loaded without patching the core. Second, it is possible to alter some
modules policy on the fly for an additional control.

> - If the functionality is not built into the standard behaviour then no
> one will code for it.

Not directly relevent, though it is for maintenance.

> - If it is generally agreed that the current behaviour is outdated and
> creates problems with security then we have to ask "Is there any
> compelling reason to keep it?" Would linux with the patch not be a
> better, more secure Linux?

No. It completely disallows those applications (ie, grid, legion, and any
other distributed application) from functioning for general users. Since
these users choice of application is generally unknown, you would also
have to generate a group of ports dynamically.

Also, since group membership is controling ACCESS functions, you end up
sharing more than what you want. Your purpose is to have "group" apply to
port access, yet "group" also applies to file access. You REALLY don't
want to mix these.

> Backward compatibility would not be a problem because most programs just
> try and grab the port and error if they can't get it. They would work
> fine under the /etc/ports idea.
>
> Any other programs that might have problems (for example any which check
> to see if they are root before starting) can still be started as root.
> Again, no problem.
>
> So, why not?

Application porting compatabiltiy. Right now all that is necessary is to
recompile the application. With the patch, you also have to figure out how
to apply appropriate ports to the application, and you don't know ahead
of time how many ports to allocate. Grid applications tend to have one
port for each node they communicate with. If two users generate a 5 way
connection you have to give two sets of groups... If the user then wants
a 10 way you have to reallcate again.

This is insufficent flexibility. What you want is to tie each port to a
capability (or tie port allocation to a capability) and then grant the user
the capability to allocate ports. This really calls for a LSM based module
that can pass the request to a security daemon to permit/deny port allocation
based on external rules.

This would be more flexable, maintainable, and is less intrusive of the
kernel core.
