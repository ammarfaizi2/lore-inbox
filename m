Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSJaVsd>; Thu, 31 Oct 2002 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265384AbSJaVsd>; Thu, 31 Oct 2002 16:48:33 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:58555 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265380AbSJaVs3> convert rfc822-to-8bit; Thu, 31 Oct 2002 16:48:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: The ACL debate (was: Re: What's left over.)
Date: Thu, 31 Oct 2002 15:53:18 -0600
User-Agent: KMail/1.4.1
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1036061965.2425.20.camel@aurora.localdomain> <200210311047.07774.pollard@admin.navo.hpc.mil> <1036096120.1510.5.camel@aurora.localdomain>
In-Reply-To: <1036096120.1510.5.camel@aurora.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210311553.18628.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 02:28 pm, Trever L. Adams wrote:
> On Thu, 2002-10-31 at 11:47, Jesse Pollard wrote:

> > >Why ACLs are bad:
> >
> > ACLs alone are not enough. ACLs alone allow a user to grant
> > access to any other user/group. For situations that require a fence
> > between users (ie. accounting/parts inventory) only a mandatory
> > access control (MAC) would be able to prevent such improper
> > data sharing. It is also a problem in government use. At least on
> > large, shared resource systems.
>
> I see your point here too.  I usually see things from a perspective of
> companies not needing this.   I mean "a house divided..." and all that.
> But I guess companies would rather force unity than let the one person
> screw them over.  Point to you on the debate for sure.  I know there
> have been MAC implementations for Linux... is one in 2.5?

It is planned - The SELinux module is working under the LSM additions
and does define MAC controls. Policy is defined in an external file
and compiled and supplied to a kernel module for interpretation/enforcement.
...

> > The normal UNIX solution is to have multiple systems, each dedicated
> > to a relatively small population where any user is authorized to access
> > data on that system (this is where limited groups come in), but owners
> > of the data may provide a more restricted access.
>
> Hardware is getting more powerful, why segment it through such physical
> means?

It was just a historical note of how MAC was implementd, and still is for
the government. It is not currently allowed to mix data of differing security
levels or compartments on one system (even on large and very EXPENSIVE
ones).

> > A large resource usually has to be shared (wind tunnel simulations,
> > finite element analysis of different structures, large inventory
> > management...). And sharing doesn't necessarily involve sharing
> > data.
>
> Understood.  You had many good points.  I still don't see it as a user
> space problem though.  These are all things that go in the kernel...
> Yes, policy doesn't belong in the kernel, but the ability to create
> policy and enforce it does (where user-space may not be the right place,
> such as here).

Most of the problem isn't. I do believe ACLs should be present for
discretionary controls. Without MAC controls though, you do end up
with possible global/unregulated access without a real visible clue.
AND no way to restrict it.

We have an 8 million inode file system, and if we search the entire
thing, even for world read trees, would take hours to scan.

> I guess I agree with you, but I still think ACLs are necessary and
> wanted, even if there needs to be additional functionality for those who
> are totally paranoid (some corps, governments, etc.)

I do think they need to be there. There are some significant uses for it:

1. restricting access to devices (a users should not be able to access
	 audio/tape/floppy/CDwriter unless an ACL on the device permits it.)
2. access to special system owned applications
3. protecting system files  (consider an ACL on the /etc/shadow file; vmlinux,
	all files in /bin /usr/bin)
4. delegating update capability (ACL on /usr/local allows an applications
	group to supply updates, instead of root).

Some/most of this is already done by changing group/owner access to
the files.

The advantage of MAC labels over ACLs for the above are that if root IS
compromised (or the an application group...), it will be next to impossible
to modify these files because the penetration (by definition) is bypassing
standard authentication rules. Since these rules are not satisfied, the label
assigned to the process will not be granted.

Without that security lable to match against the files, the files will still
be protected. Even from a root break in. Yes, some damage could occur.
but the system should still be safe.

It doesn't protect against stupidity, or highjacking an already existing
communication channel that has already been authorized. It does protect
against hacking most service daemons, since these daemons should not
be using an all powerful security label. That would be just as bad as running
them as root is now.

And that appears to be the goal of most of the MAC implementations.
Minimize the capability of processes to only what is needed to perform
the job.

> Trever Adams
>
> P.S.  I removed Linus from direct in the email because he has said he is
> going to add it already.

Just building a case for MAC later on  :-)

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
