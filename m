Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265013AbSJWOM2>; Wed, 23 Oct 2002 10:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265011AbSJWOM1>; Wed, 23 Oct 2002 10:12:27 -0400
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:28312 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S265016AbSJWOM0> convert rfc822-to-8bit; Wed, 23 Oct 2002 10:12:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Mike Touloumtzis <miket@bluemug.com>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Date: Wed, 23 Oct 2002 09:17:47 -0500
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <200210221513.41729.pollard@admin.navo.hpc.mil> <20021022203038.GB19367@bluemug.com>
In-Reply-To: <20021022203038.GB19367@bluemug.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210230917.47204.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 October 2002 03:30 pm, Mike Touloumtzis wrote:
> On Tue, Oct 22, 2002 at 03:13:41PM -0500, Jesse Pollard wrote:
> > On Tuesday 22 October 2002 02:45 pm, Mike Touloumtzis wrote:
> > > Large CVS hosting operations like GNU Savannah have historically used
> > > patches to increase NGROUPS.  Using one group per project in CVS is the
> > > sanest way to manage a big repository with complex permissions.
> >
> > OK, I'll bite..
> >
> > Why is this?
>
> I only learned about this by reading the docs on Savannah; the admins can
> provide better information.  But my understanding is simply that they have
> M users and N projects, and they want the system to support any number of
> permission pairs from M x N, i.e. they want each user to be able to commit
> to an arbitrary number of projects.  And CVS relies on OS permissions.

Thats what I thought. Essentially, all projects are world rw if all users
have access to all projects.

> > I saw the post about having to have access to a lock directory by a
> > cvsuser, but how is that different than having that directory with an
> > ACL entry that includes the cvsuser? Or an ACL that includes the
> > group that the cvsuser is a member of?
>
> I guess they prefer to use traditional Unix permissions rather than ACLs.
> I have the same preference.  Unix groups are well supported by tools and
> the kind of permission setup I described above is nicely transparent
> to administer.  Granting a user write access to a project is simply
> 'adduser username projectname', and a project can easily support a large
> number of writers without big ACLs.
>
> The issue is not just lock directories, but the right to change any
> file in a project, i.e. full CVS commit access to the project rather
> than anonymous access.

As soon as everyone is in every group you get anonymous access.
You would also have the same result by putting all of the CVS files in
one group.

Or by just making the directories/files world rwx/rw.

>                                So they would need an ACL on each file in the
> repository, and they would need new files to inherit ACLs from their
> parent directories (I've never used ACLs on Linux but I assume this kind
> of thing is supported).

Actually it depends on the implementation. I believe some of the ACL
specs on a directory can be specified to be inherited (I'll have to check
the POSIX ACL definitions, but I remember a number of capabilities
available on directories that didn't exist for files-- yup - It's called
a "default ACL" and can be used to set UGO access, protection
masking and user acess controls).

In the scenario above, I would most likey specify an ACL to
include specific groups of users. That way it wouldn't necessarily
be equivalent to a world rw access.
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
