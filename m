Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262635AbSJBWac>; Wed, 2 Oct 2002 18:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262638AbSJBWac>; Wed, 2 Oct 2002 18:30:32 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:18872 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262635AbSJBWaa>; Wed, 2 Oct 2002 18:30:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: EVMS Submission for 2.5
Date: Wed, 2 Oct 2002 17:03:19 -0500
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
References: <Pine.GSO.4.21.0210021812590.9782-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0210021812590.9782-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <02100217031903.18102@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 October 2002 17:14, Alexander Viro wrote:
> On Wed, 2 Oct 2002, Kevin Corry wrote:
> > On behalf of the EVMS team, I'd like to submit the Enterprise Volume
> > Management System for inclusion in the 2.5 Linux kernel tree.
> >
> > To make this as simple as possible for you, there is a Bitkeeper
> > tree available with the latest EVMS source code, located at:
> > http://evms.bkbits.net/linux-2.5
> > This tree is sync'd with the linux-2.5 tree on linux.bkbits.net
> > as of about noon today (Oct 2).
> >
> > - Add a function, walk_gendisk(), to drivers/block/genhd.c to allow
> >   EVMS to get information about the disks on the system from the
> >   gendisk list in a safe manner.
>
> Consider that one vetoed.  Linus, please do _not_ apply until that
> stuff is resolved - it conflicts with a bunch of cleanups we'll
> need.

Yeah, I figured you wouldn't like that part, especially based on your 
discussion with Mark yesterday about the upcoming gendisk changes.

EVMS has traditionally used the gendisk list to get information about what 
disks are available in the system. The walk_gendisk() function in genhd.c was 
suggested last year by Christoph as a method for safely accessing the list, 
and even made it into the 2.4 kernel. Thus we just ported it forward to 2.5 
in our tree. It worked just fine in its original form until 2.5.40. Based on 
your comments in genhd.c about the gendisks array, I assumed further changes 
would be coming. But we had to come up with an interim solution to work on 
2.5.40, and thus we have the version in the submitted patch, which I did not 
intend to be a permanent solution.

So the question is, will there be a method to simply get a list of registered 
disks on the system, or an API to call to run a function for each disk? If 
so, we'll gladly switch to using that. If not, do you have any suggestions 
for how this kind of functionality can be achieved with your upcoming changes?

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
