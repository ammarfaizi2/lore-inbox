Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUDJERg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 00:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDJERf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 00:17:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26786 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261375AbUDJER2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 00:17:28 -0400
Message-Id: <200404100417.i3A4HB5c011655@eeyore.valparaiso.cl>
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: Your message of "Fri, 09 Apr 2004 11:25:17 MST."
             <20040409182517.330.qmail@web40508.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 10 Apr 2004 00:17:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> Horst von Brand said:

[...]

> Working version of VXE was developed before SELinux.

Before Flux (the experimental OS that was used to demonstrate the ideas)?
Before the development of the architecture? SELinux is quite old, and the
ideas behind it even more...

In any case, who was first has very little to say about which one is
better.

> So you suggest using competing products, which were
> developed later :-) Are they better and easier to use?
> I'm not sure.

Doesn't matter if the product is completely off-track. I'd take anything
that was developed by some of the top people in the security area over
something by an amateur each day. Unless there is _solid_ evidence for the
amateurs, that is... and if they do completely nonsensical things like LISP
in kernel, that is in my view evidence that they don't even know what a
clue is.

[...]

> VXE is more granular and convenient tool, than chroot
> jail. Here is why:
> 
> 1. It can be a complicated task, to move all needed
> file for chroot.

So?

>                  If it is a big system, like Oracle -
> it can be hard (it's possible, but too complicated).

In that case you can afford to set up a machine (or complete environment)
just for Oracle.

> VXE can protect working subsystems without making any
> changes in their location, nor configuration.

How? It requires _intimate_ knowledge of what the application needs, that
is very much unlikely to be in the hands of the hapless sysadmin in
charge. Who built the package in the first place is in a better position,
and for them it is easier to give directions on setting up a chroot jail
(available with any Unix!) than to fool around with a thinly-used,
experimental "security package" for an operating system that is on itself
(as yet) little used in hardened application needs.

> 2. Many systems have shared information. If we place
> subsystems in different chroot jails - who will
> synchronize this information? Example - sendmail and
> POPD - sendmail places mail into POPDs mailboxes. If
> they are in different chroot jails it is impossible.

No... they can comunicate over the network. Or share files by mounting an
area twice. By shared memory. By other shared resources inherited from a
common ancestor.

Besides, writing secured mail systems _has_ been done. Several times.

> Another example - many subsystems share /etc/passwd
> /etc/shadow information, if they are in different
> chroot jails - who will do synchronisation/data
> exchange between them?

NIS, NIS+, LDAP ring a bell?

> 3. If some file in chroot is read only - in case if
> hacker will get root - he can overwrite this file.
> It's not the case for VXE.

What part of "regular user in chroot jail" didn't you get? If you get root
in a chroot jail, the system is toast anyway.


[...]

> > Plus
> > you make the programmer's/configurator's job a _lot_
> > harder.

> You raised a very good question. It is exactly what
> makes VXE different from other systems. Many security
> systems don’t address this question, but VXE does.

You make the programmer's job essentially impossible. How on earth should I
know how many times my program will legitimately call open(2)? How do I
guarantee it does the same number of open(2)s each time? How do I ensure
all open(2)s are done before the cracker hijacks the program? What if glibc
changes, and now opens extra files behind my back? The only real anwers are
"specific r/w/x acces to <foo> required" and "<foo> is off-limits" (regular
permissions, perhaps ACLs) and "it does need to use it" or "it should never
use it" (something in the line of capabilities).

> That's why it's easy to use. One guy said that VXE is
> a self-learning system (I would not go so far, but
> would say that the process of building VXED (Virtual
> Executing Environment Description) or jail is
> automated. During creation of VXED - it runs in a test
> mode - collects information about resources used by
> the subsystem we want to put in 'jail'. In test mode
> all violations of VXED are registered in log, but
> syscalls are performed. So, administrator usually
> doesn’t add entries to VXED description - he just
> confirms inclusion of discovered resources to be
> included into VXED. Other thing administrator does is
> generalization - if POPD accessed
> /var/spool/mail/user1 - it's obviously should be
> changed to /var/spool/mail/*. In real VXED there are
> only a few entries which need generalization, so it's
> easy enough.

What a few particular test runs access is _not_ what all runs need, and
perhaps has little in common with what is required to do the job... that
requires knowledge of the task at hand, design and care. Just checking what
a particular (perhaps badly written) application does in a few test cases
is of absolutely no use for security.

> If it would not be automated - it would be a nightmare
> (as moving all needed files into chroot jail).

Same nightmare. Only probably much worse.


[...]

> 1. If you admit that chroot helps - VXE helps even
> more - it's superset of chroot features.

What is the cost of that "even more"? What new security risks are involved?

> 2. I didn't get it. POPD can not send e-mails.

It can communitate with whoever called it, if it is your cracker...

>                                                It can
> alter mailboxes in a mailbox directory.

Adding, deleting, changing, rerouting delivered mail, ...

>                                         So, what do
> you say? That some messages can be placed in mailboxes
> of existing users? (new users can't be created - no
> way to alter /etc/passwd).

That is quite enough for havoc.

[...]

> > There are much easier ways to do this. Besides, just
> > catching a problem
> > that might have security implications isn't really
> > enough (it means each
> > time the bug is triggered you get a crash). It would
> > be much better to work
> > on finding and fixing the bug.

> It's not the case in real life, that's why I gave a
> real example - sendmail. There were a lot of problems
> in sendmail for a long time - fixes were published
> continuously. And people were using it. We could give
> advice to sendmail developers to go and fix ALL bugs -
> I can imagine their answer to such suggestion :-)

They are finding and fixing bugs. There have been other architectures for
MTAs proposed, designed specifically for security (sendmail was born
_before_ security became an issue...). Same for other parts of the mail
system.

[...]

> There can be bugs in VXE as well as in chroot
> implementation, but people still use chroot. There are
> two ideas behind that:

There are a few other security mechanisms around...

> 1. VXE adds security mechanisms, without replacing
> existing mechanisms. So, is VXE fails there are two
> possibilities: - subsystem will be terminated (most
> likely - default value returned by small C code in
> case of troubles with the rest of VXE is EACCESS); -
> due to an error VXE will give permission for syscall -
> in such case subsystem will operate as it is without
> VXE, with existing security mechanisms; so - VXE
> increases protection of the system. (main goal is to
> prevent compromising of the system, though service can
> be disrupted in some cases).

Denial of service _is_ a security problem...

> 2. VXE mechanism is very simple enough - it's just
> additional code which checks parameters for sys calls.

In LISP code for each single call? You must be kidding...

[I must be pretty bored to still waste time on this nonsense...]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
