Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131371AbQLUXrR>; Thu, 21 Dec 2000 18:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbQLUXrH>; Thu, 21 Dec 2000 18:47:07 -0500
Received: from ccs.covici.com ([209.249.181.196]:26116 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S131371AbQLUXrA>;
	Thu, 21 Dec 2000 18:47:00 -0500
Date: Thu, 21 Dec 2000 18:16:23 -0500 (EST)
From: John Covici <covici@ccs.covici.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: strange nfs behavior in 2.2.18 and 2.4.0-test12
In-Reply-To: <14914.32991.480115.210561@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0012211813110.840-100000@ccs.covici.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Neil Brown wrote:

> On Thursday December 21, covici@ccs.covici.com wrote:
> > Hi.  I am having strange nfs problems in both my 2.x and 2.4.0-test12
> > kernels.
> > 
> > What is happening is that when the machine boots up and exports the
> > directories for nfs, it complains that
> > 
> > ccs2:/ invalid argument .
> > 
> > The exports entry is
> > 
> > / ccs2(rw,no_root_squash)
> 
> Is there another export entry that exports another part of the same
> file system to the same client?  If so, that is your problem.

Well I do want to export the mount points under the file system, for
instance I have a partition mounted as /usr and so I have an entry
such as
/usr ccs2(rw,no_root_squash)

in my exports list.  Is there any other way to get this behaviour to
work?

> You cannot export two different directories on the same filesystem to
> the same client if one is an ancestor of the other (because exporting
> a directory is really exporting the directory and all descendants on
> that filesystem, and so exporting a directory and a subdirectory is
> effectively exporting the subdirectory twice with potentially
> different flags).
> 
> NeilBrown
> 
> > 
> > Now in Kernel 2.2.18, if I stop and restart the nfs daemons, all is
> > OK, the invalid argument goes away, but in 2.4.0 I cannot get this to
> > work at all and so I cannot mount nfs from a client on the ccs2 box.
> > I am using the utilities 0.2.1-4 from the Debian distribution if that
> > makes any difference.  I did an strace once on exportfs and it was
> > having trouble with the call to nfsservctl which returns invalid argument.
> > 
> > 
> > Any assistance would be appreciated.
> > 
> > -- 
> >          John Covici
> >          covici@ccs.covici.com
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
         John Covici
         covici@ccs.covici.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
