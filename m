Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264259AbTEJO22 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTEJO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 10:28:28 -0400
Received: from host132.googgun.cust.cyberus.ca ([209.195.125.132]:9901 "EHLO
	marauder.googgun.com") by vger.kernel.org with ESMTP
	id S264259AbTEJO20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 10:28:26 -0400
Date: Sat, 10 May 2003 10:38:56 -0400 (EDT)
From: Ahmed Masud <masud@googgun.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052407341.10038.69.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0305100957100.23680-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello every one:

This isn't really a reply to Alan Cox, i am just adding my own two bits
worth to the debate.

I would like to say that sys_call_table export should not disappear, as
overriding system calls on-the-fly through loadable modules does have some
very practical applications.  This is despite the fact that one has to
write a slightly "ugly cpu-specific glue" to make it happen :-)

Case in point, I wrote a security module for Linux that overrides _all_
237 systemcalls to audit and control the use of the system calls on a per
uid basis.  (i.e. if the user was actually allowed to make the system call
or not) and return -EPERM or jump to system call proper.

Not sure whether anyone would be interested in details of my
implementation, so i won't get into it but there are a few things
which may be of interest from the perspective of the esthetical issues:

1. All 237 system calls are succesfully overriden audited and controlled
through precisely one overriding function (there aren't 237 calls
replacing originals in my implementation).

2. The parameters passed to the calls are analysable.

3. The return values from system call proper as well as any
values returned on stace are analysable.

4. The module can be safely loaded and unloaded, as well as functionality
restored because it is (believe it or not :-) possible to track usage.

Now as to why do it as a module, rather than patching the kernel? Well
there are several good reasons, but the most obvious is the reason why
modules were created in the first place: Namely, that new functionality
can be added to a system without having to shut it down, reboot it, or for
that matter interrupt services.

Specifically this module saved a number of systems from ptrace denial of
service attack by simply disallowing ptrace to "untrusted" users on the
systems without any fuss or muss.  (There are other more interesting and
exotic uses).

I would also like to say that Linux modules should not be limited to just
device drivers, even though the module infrastructure may have been
originally conceived that way.  The beauty of Linux modules, combined with
the monolithic kernel approach is their ability to expand the kernel on
the fly. Heck, who knows, there may be a day when we can simply swap an
entirely brand new kernel into place and simply continue from where the
previous kernel left off.

IMHO, the question really boils down to this:  "What is a good reason to
elimnate this ability, when it obviously, provides useful functionality
with some care?"

Saying that kernel programmers are not careful enough to "use it
correctly" is a bit condesending. Removing it for esthetics or for an
obscure notion of "good programming practices" is not a reasonable enough
argument either since we've definitely used a monolithic kernel design at
the largest scale of the spectrum and gotos at the smallest end, because
we favour practicality vs. beauty, hands down, so what gives here?

Now, if the maintainers (esp. Linus or Alan) simply wanna do it "just
'cause", who can really argue with them? (well, I might a bit :-).

Cheers,

Ahmed Masud.


