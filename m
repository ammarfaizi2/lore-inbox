Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbSJVU0f>; Tue, 22 Oct 2002 16:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265006AbSJVUZT>; Tue, 22 Oct 2002 16:25:19 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:17681 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S265003AbSJVUYe>; Tue, 22 Oct 2002 16:24:34 -0400
Date: Tue, 22 Oct 2002 13:30:38 -0700
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Message-ID: <20021022203038.GB19367@bluemug.com>
Mail-Followup-To: Jesse Pollard <pollard@admin.navo.hpc.mil>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil> <20021022194512.GA18955@bluemug.com> <200210221513.41729.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210221513.41729.pollard@admin.navo.hpc.mil>
X-PGP-Key: http://web.bluemug.com/~miket/OpenPGP/5C09BB33.asc
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 03:13:41PM -0500, Jesse Pollard wrote:
> On Tuesday 22 October 2002 02:45 pm, Mike Touloumtzis wrote:
> >
> > Large CVS hosting operations like GNU Savannah have historically used
> > patches to increase NGROUPS.  Using one group per project in CVS is the
> > sanest way to manage a big repository with complex permissions.
> 
> OK, I'll bite..
> 
> Why is this?

I only learned about this by reading the docs on Savannah; the admins can
provide better information.  But my understanding is simply that they have
M users and N projects, and they want the system to support any number of
permission pairs from M x N, i.e. they want each user to be able to commit
to an arbitrary number of projects.  And CVS relies on OS permissions.

> I saw the post about having to have access to a lock directory by a
> cvsuser, but how is that different than having that directory with an
> ACL entry that includes the cvsuser? Or an ACL that includes the
> group that the cvsuser is a member of?

I guess they prefer to use traditional Unix permissions rather than ACLs.
I have the same preference.  Unix groups are well supported by tools and
the kind of permission setup I described above is nicely transparent
to administer.  Granting a user write access to a project is simply
'adduser username projectname', and a project can easily support a large
number of writers without big ACLs.

The issue is not just lock directories, but the right to change any
file in a project, i.e. full CVS commit access to the project rather
than anonymous access.  So they would need an ACL on each file in the
repository, and they would need new files to inherit ACLs from their
parent directories (I've never used ACLs on Linux but I assume this kind
of thing is supported).

miket
